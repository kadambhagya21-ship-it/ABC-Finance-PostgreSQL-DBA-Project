
/*
==========================================================
Project      : ABCFinanceDB
File Name    : 04_trg_PreventNegativeBalance.sql
Object Type  : Trigger

Description:
This trigger prevents withdrawal transactions when the
account does not have sufficient balance.

Trigger Event:
INSTEAD OF INSERT on Transactions

Business Rule:
Account balance cannot become negative.

==========================================================
*/

CREATE TRIGGER trg_PreventNegativeBalance
ON Transactions
INSTEAD OF INSERT
AS
BEGIN

    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        INNER JOIN Accounts a
            ON i.AccountID = a.AccountID
        WHERE i.TransactionType = 'Withdrawal'
        AND a.Balance < i.Amount
    )
    BEGIN
        RAISERROR
        (
            'Transaction failed: Insufficient account balance.',
            16,
            1
        );

        RETURN;
    END;


    INSERT INTO Transactions
    (
        AccountID,
        TransactionType,
        Amount,
        TransactionDate
    )
    SELECT
        AccountID,
        TransactionType,
        Amount,
        TransactionDate
    FROM inserted;

END;
========================================================================================================
  test data
===========================================================================================================
  INSERT INTO Transactions
(
    AccountID,
    TransactionType,
    Amount,
    TransactionDate
)
VALUES
(
    10001,
    'Withdrawal',
    999999,
    GETDATE()
);
GO
