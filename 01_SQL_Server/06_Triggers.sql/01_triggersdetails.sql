
01_triggersdetails.sql
  
==========================================================
Project      : ABCFinanceDB
File Name    : triggers.sql
Database     : Microsoft SQL Server

Description:
This script creates database triggers and audit tables for
the ABCFinanceDB project. Triggers automatically execute
in response to database events such as INSERT, UPDATE, or
DELETE operations.

The purpose of these triggers is to:
- Maintain an audit trail of important transactions.
- Improve data integrity.
- Automatically record database activities.
- Support monitoring and compliance requirements.

Prerequisites:
- ABCFinanceDB database must exist.
- All required tables must be created.
- Foreign key relationships should be configured.


 Triggers
1. Create_Audit_Table.sql
   - Creates audit table for tracking database changes.

2. trg_AuditTransaction.sql
   - Automatically records new transactions.

3. trg_UpdateAccountBalance.sql
   - Updates account balance after transactions.

4. trg_PreventNegativeBalance.sql
   - Prevents invalid account balances.
    
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
