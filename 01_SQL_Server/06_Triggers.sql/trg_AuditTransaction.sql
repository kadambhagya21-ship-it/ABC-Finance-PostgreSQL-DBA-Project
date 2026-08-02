
==========================================================
Project      : ABCFinanceDB
File Name    : 02_trg_AuditTransaction.sql
Object Type  : Trigger

Description:
Creates an audit trigger that automatically records
new transactions inserted into the Transactions table.

Trigger Event:
AFTER INSERT

Purpose:
- Maintain transaction audit history
- Track database activities
- Improve monitoring and compliance

==========================================================


CREATE TRIGGER trg_AuditTransaction
ON Transactions
AFTER INSERT
AS
BEGIN

    INSERT INTO TransactionAudit
    (
        TransactionID,
        ActionPerformed
    )
    SELECT
        TransactionID,
        'New Transaction'
    FROM inserted;

END;
GO
