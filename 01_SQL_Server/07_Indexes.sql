/*
==========================================================
Project Name : ABC Finance Banking Database
Module       : SQL Server Database Administration
File Name    : 07_Indexes.sql
Purpose      : Database Indexing and Query Performance
Database     : ABCFinanceDB
Author       : Bhagyashree Kadam
==========================================================

DESCRIPTION
-----------
This script creates non-clustered indexes on frequently
searched, filtered, joined, and sorted columns.

The objective is to improve query performance and reduce
the amount of data SQL Server needs to scan when executing
common banking queries.

INDEXING STRATEGY
-----------------
The indexes are created based on expected query patterns
within the ABC Finance banking database.

Indexes included:

1. Accounts - AccountType
2. Accounts - Balance
3. Loans - LoanType
4. Transactions - TransactionDate
5. Transactions - AccountID
6. Loans - CustomerID
7. Accounts - CustomerID
8. Employees - BranchID

PRIMARY KEY and UNIQUE CONSTRAINTS
----------------------------------
Primary key columns already have indexes created by SQL
Server automatically.

Columns with UNIQUE constraints also have unique indexes
automatically created by SQL Server.

Therefore, duplicate indexes are intentionally avoided.

PERFORMANCE CONSIDERATIONS
--------------------------
Indexes can significantly improve SELECT query performance,
but they also require additional storage and can increase
the cost of INSERT, UPDATE, and DELETE operations.

Indexes should therefore be created based on actual query
patterns and performance requirements.

==========================================================
*/


USE ABCFinanceDB;
GO


/*==========================================================
1. Index on Account Type
------------------------------------------------------------
Purpose:
Improves queries that filter accounts by Savings or Current
account type.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Accounts_AccountType
ON Accounts(AccountType);
GO


/*==========================================================
2. Index on Account Balance
------------------------------------------------------------
Purpose:
Improves queries that search or filter accounts based on
their balance.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Accounts_Balance
ON Accounts(Balance);
GO


/*==========================================================
3. Index on Loan Type
------------------------------------------------------------
Purpose:
Improves queries that filter loans by Home Loan,
Car Loan, or Personal Loan.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Loans_LoanType
ON Loans(LoanType);
GO


/*==========================================================
4. Index on Transaction Date
------------------------------------------------------------
Purpose:
Improves date-range queries and transaction reporting.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Transactions_TransactionDate
ON Transactions(TransactionDate);
GO


/*==========================================================
5. Index on Transaction AccountID
------------------------------------------------------------
Purpose:
Improves queries that retrieve transactions belonging
to a specific bank account.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Transactions_AccountID
ON Transactions(AccountID);
GO


/*==========================================================
6. Index on Loan CustomerID
------------------------------------------------------------
Purpose:
Improves queries that retrieve loans belonging to a
specific customer.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Loans_CustomerID
ON Loans(CustomerID);
GO


/*==========================================================
7. Index on Account CustomerID
------------------------------------------------------------
Purpose:
Improves queries that retrieve accounts belonging to
a specific customer.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Accounts_CustomerID
ON Accounts(CustomerID);
GO


/*==========================================================
8. Index on Employee BranchID
------------------------------------------------------------
Purpose:
Improves queries that retrieve employees belonging to
a specific branch.
==========================================================*/

CREATE NONCLUSTERED INDEX IX_Employees_BranchID
ON Employees(BranchID);
GO


/*==========================================================
VERIFY INDEXES
==========================================================*/

EXEC sp_helpindex 'Accounts';
GO

EXEC sp_helpindex 'Transactions';
GO

EXEC sp_helpindex 'Loans';
GO

EXEC sp_helpindex 'Employees';
GO


PRINT 'All performance indexes created and verified successfully.';
GO
  
Customers
   │
   └── Email/Phone → UNIQUE constraint
                     ↓
                 Index already exists

Accounts
   │
   ├── CustomerID → Index
   └── AccountType → Index

Transactions
   │
   ├── AccountID → Index
   └── TransactionDate → Index

Loans
   │
   ├── CustomerID → Index
   └── LoanType → Index
