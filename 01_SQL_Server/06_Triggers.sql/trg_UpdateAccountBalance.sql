
==========================================================
Project      : ABCFinanceDB
File Name    : 03_trg_UpdateAccountBalance.sql
Object Type  : Trigger

Description:
This trigger automatically updates the account balance
when a new deposit or withdrawal transaction is inserted.

Trigger Event:
AFTER INSERT on Transactions

Business Rules:
- Deposit increases account balance
- Withdrawal decreases account balance

==========================================================

CREATE TRIGGER trg_UpdateAccountBalance
ON Transactions
AFTER INSERT
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE a
    SET 
        a.Balance =
        CASE 
            WHEN i.TransactionType = 'Deposit'
            THEN a.Balance + i.Amount

            WHEN i.TransactionType = 'Withdrawal'
            THEN a.Balance - i.Amount

            ELSE a.Balance
        END
    FROM Accounts a
    INNER JOIN inserted i
        ON a.AccountID = i.AccountID;

END;
GO
================================================================================
test data
======================================================================================
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
    'Deposit',
    500,
    GETDATE()
);


SELECT 
AccountID,
Balance
FROM Accounts
WHERE AccountID = 10001;

