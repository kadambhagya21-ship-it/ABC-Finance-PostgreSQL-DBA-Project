====================================================================================================
1. Create Transaction Audit Table
=====================================================================================================

CREATE TABLE TransactionAudit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID INT,
    ActionPerformed VARCHAR(50),
    ActionDate DATETIME DEFAULT GETDATE()
);
GO

  Description:
Stores a record of every transaction inserted into the
Transactions table, including the transaction ID,
action performed, and timestamp.
=======================================================================================================

