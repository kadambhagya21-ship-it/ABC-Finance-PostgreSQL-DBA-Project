06_Triggers.sql
  
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


==========================================================

=========================================================
Audit Table: TransactionAudit

Description:
Stores a record of every transaction inserted into the
Transactions table, including the transaction ID,
action performed, and timestamp.
=========================================================
