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

### Example

```sql
SELECT * FROM vw_CustomerAccountSummary;
```

This script is part of **Module 2 – Views, Stored Procedures, Triggers & Indexes** of the ABCFinanceDB SQL Server project.
