05_Stored_Procedures.sql
    
/*
==========================================================
Project : ABC Finance Banking Database
Module  : SQL Server
Task    : Create Tables
Author  : Bhagyashree Kadam
==========================================================
*/


# stored_procedures.sql

## Description

The `stored_procedures.sql` script contains the SQL Server stored procedures used in the **ABCFinanceDB** project. These stored procedures encapsulate business logic within the database, enabling secure, efficient, and reusable execution of common banking operations.

Instead of embedding SQL queries directly into applications, stored procedures centralize data processing, improve maintainability, enhance performance through execution plan reuse, and provide an additional layer of security by controlling direct access to database tables.

## Features

- Retrieve customer and account information
- Check account balances
- Process deposits and withdrawals
- View customer transaction history
- Validate business rules before updating data
- Improve query performance and code reusability


## Included Stored Procedures

- `sp_GetCustomerDetails`
- `sp_CheckAccountBalance`
- `sp_DepositMoney`
- `sp_WithdrawMoney`
- `sp_GetTransactionHistory`

## Benefits

- Encapsulates business logic inside the database
- Reduces repetitive SQL code
- Improves performance using cached execution plans
- Simplifies application development
- Enhances data integrity and security
- Supports consistent and reusable database operations

## Example

**************************************************
EXEC sp_GetCustomerDetails @CustomerID = 1;

CREATE PROCEDURE sp_GetCustomerDetails
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CustomerID,
        FirstName,
        LastName,
        Email,
        Phone
    FROM Customers
    WHERE CustomerID = @CustomerID;
END;
GO
***************************************************
EXEC sp_CheckAccountBalance @AccountID = 10001;

CREATE PROCEDURE sp_CheckAccountBalance
    @AccountID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        AccountID,
       
        Balance
    FROM Accounts
    WHERE AccountID = @AccountID;
END;
GO
*********************************************************
EXEC sp_DepositMoney @AccountID = 10001, @Amount = 5000;

CREATE PROCEDURE sp_DepositMoney
(
    @AccountID INT,
    @Amount DECIMAL(18,2)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Accounts
    SET Balance = Balance + @Amount
    WHERE AccountID = @AccountID;

    SELECT
        AccountID,
        AccountNumber,
        Balance
    FROM Accounts
    WHERE AccountID = @AccountID;
END;
GO
************************************************************
EXEC sp_WithdrawMoney @AccountID = 10001, @Amount = 2000;
CREATE PROCEDURE sp_WithdrawMoney
(
    @AccountID INT,
    @Amount DECIMAL(18,2)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM Accounts
        WHERE AccountID = @AccountID
          AND Balance >= @Amount
    )
    BEGIN
        UPDATE Accounts
        SET Balance = Balance - @Amount
        WHERE AccountID = @AccountID;

        PRINT 'Withdrawal Successful';
    END
    ELSE
    BEGIN
        PRINT 'Insufficient Balance';
    END
END;
GO
*******************************************************************

EXEC sp_GetTransactionHistory @AccountID = 10001;
CREATE PROCEDURE sp_GetTransactionHistory
(
    @AccountID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TransactionID,
        TransactionType,
        Amount,
        TransactionDate
    FROM Transactions
    WHERE AccountID = @AccountID
    ORDER BY TransactionDate DESC;
END;
GO
*******************************************************************

