04_views.sql

/*
==========================================
Project : ABC Finance Banking Database
Module 1 : Create Database
Author  : Bhagyashree Kadam
Database: SQL Server 2022
==========================================
*/
## Description

The `views.sql` script creates SQL Server views for the ABCFinanceDB project.

Views are used to simplify complex SQL queries by combining data from multiple tables into reusable virtual tables. They provide a consistent way to retrieve business information without repeatedly writing JOIN statements.

The views in this project support common banking operations such as customer account summaries, transaction history, loan details, branch information, and employee reporting.

### Prerequisites
- ABCFinanceDB database must already exist.
- All tables and relationships must be created.
- Sample data should be imported before executing this script.

### Included Views
- Customer Account Summary
- Customer Transaction Summary
- Branch Account Summary
- Loan Details
- Employee Branch Details
- Credit Card Details
- Account Balance Summary

### Benefits
- Simplifies complex queries
- Improves code reusability
- Provides consistent reporting
- Makes application development easier
- Enhances data readability
************************************************************
### Example
***************************************************************
 - Customer Account Summary
*************************************************************
CREATE VIEW vw_CustomerAccountSummary
AS
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    a.AccountID,
    a.AccountNumber,
    a.AccountType,
    a.Balance,
    b.BranchName
FROM Customers c
JOIN Accounts a
    ON c.CustomerID = a.CustomerID
JOIN Branches b
    ON a.BranchID = b.BranchID;
GO
  
SELECT * FROM vw_CustomerAccountSummary;

*****************************************************************
  - Customer Transaction Summary
****************************************************************
CREATE VIEW vw_CustomerTransactionSummary
AS
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    
    t.TransactionID,
    t.TransactionType,
    t.Amount,
    t.TransactionDate
FROM Customers c
JOIN Accounts a
    ON c.CustomerID = a.CustomerID
JOIN Transactions t
    ON a.AccountID = t.AccountID;
GO
  
SELECT * FROM vw_CustomerTransactionSummary;
*****************************************************************
- Branch Account Summary
******************************************************************
  CREATE VIEW vw_BranchAccountSummary
AS
SELECT
    b.BranchID,
    b.BranchName,
    COUNT(a.AccountID) AS TotalAccounts,
    SUM(a.Balance) AS TotalBalance
FROM Branches b
LEFT JOIN Accounts a
    ON b.BranchID = a.BranchID
GROUP BY
    b.BranchID,
    b.BranchName;
GO
  
select * from vw_BranchAccountSummary;
****************************************************************
  - Loan Details
************************************************************
CREATE VIEW vw_LoanDetails
AS
SELECT
    l.LoanID,
    c.CustomerID,
    c.FirstName,
    c.LastName,
    l.LoanType,
    l.LoanAmount,
    l.InterestRate,
    l.LoanStatus
FROM Loans l
JOIN Customers c
    ON l.CustomerID = c.CustomerID;
GO
  
SELECT * FROM vw_LoanDetails;
**********************************************************8
- Employee Branch Details
**********************************************************
CREATE VIEW vw_EmployeeBranchDetails
AS
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.JobTitle,
    b.BranchName,
    b.City
FROM Employees e
JOIN Branches b
    ON e.BranchID = b.BranchID;
GO
SELECT * FROM vw_EmployeeBranchDetails;
*******************************************************
  - Credit Card Details
*********************************************************
CREATE VIEW vw_CreditCardDetails
AS
SELECT
    cc.CardID,
    cc.CardNumber,
   
    cc.ExpiryDate,
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM CreditCards cc
JOIN Customers c
    ON cc.CustomerID = c.CustomerID;
GO
  
SELECT * FROM vw_CreditCardDetails;
*************************************************
  - Account Balance Summary
**************************************************
CREATE VIEW vw_AccountBalanceSummary
AS
SELECT
    AccountType,
    COUNT(AccountID) AS TotalAccounts,
    SUM(Balance) AS TotalBalance,
    AVG(Balance) AS AverageBalance,
    MIN(Balance) AS MinimumBalance,
    MAX(Balance) AS MaximumBalance
FROM Accounts
GROUP BY AccountType;
GO
SELECT * FROM vw_AccountBalanceSummary;
**************************************************  
This script is part of **Module 2 – Views, Stored Procedures, Triggers & Indexes** of the ABCFinanceDB SQL Server project.
