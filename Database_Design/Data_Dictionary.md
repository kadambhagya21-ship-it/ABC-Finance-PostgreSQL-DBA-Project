# Data Dictionary

## Project

Enterprise PostgreSQL Database Administration Project

Company: ABC Finance

---

# Overview

This document describes the database objects used in the ABC Finance Banking Database.

The database stores information about:

- Bank Branches
- Customers
- Employees
- Bank Accounts
- Transactions
- Loans
- Credit Cards

---

# Table: Branches

## Description

Stores bank branch information.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| BranchID | INT | Primary Key | Unique branch identifier |
| BranchName | VARCHAR(100) | NOT NULL | Branch name |
| City | VARCHAR(50) | NOT NULL | Branch city |
| Address | VARCHAR(200) | NOT NULL | Branch address |
| Phone | VARCHAR(20) | NOT NULL | Contact number |

---

# Table: Customers

## Description

Stores customer information.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| CustomerID | INT | Primary Key | Unique customer ID |
| BranchID | INT | Foreign Key | References Branches |
| FirstName | VARCHAR(50) | NOT NULL | Customer first name |
| LastName | VARCHAR(50) | NOT NULL | Customer last name |
| DateOfBirth | DATE | NOT NULL | Date of birth |
| Gender | VARCHAR(10) | CHECK | Male/Female/Other |
| Phone | VARCHAR(20) | UNIQUE | Mobile number |
| Email | VARCHAR(100) | UNIQUE | Email address |
| Address | VARCHAR(200) | NOT NULL | Home address |
| City | VARCHAR(50) | NOT NULL | City |
| CreatedDate | DATETIME | DEFAULT GETDATE() | Customer creation date |

---

# Table: Employees

## Description

Stores employee information.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| EmployeeID | INT | Primary Key | Employee ID |
| BranchID | INT | Foreign Key | Branch |
| FirstName | VARCHAR(50) | NOT NULL | First name |
| LastName | VARCHAR(50) | NOT NULL | Last name |
| JobTitle | VARCHAR(50) | NOT NULL | Job role |
| Salary | DECIMAL(12,2) | CHECK | Monthly salary |
| HireDate | DATE | NOT NULL | Joining date |

---

# Table: Accounts

## Description

Stores customer bank accounts.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| AccountID | INT | Primary Key | Account ID |
| CustomerID | INT | Foreign Key | References Customers |
| AccountNumber | VARCHAR(20) | UNIQUE | Bank account number |
| AccountType | VARCHAR(20) | CHECK | Savings / Current |
| Balance | DECIMAL(15,2) | CHECK | Account balance |
| Status | VARCHAR(20) | DEFAULT | Active |
| OpenDate | DATE | NOT NULL | Account opening date |

---

# Table: Transactions

## Description

Stores banking transactions.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| TransactionID | INT | Primary Key | Transaction ID |
| AccountID | INT | Foreign Key | References Accounts |
| TransactionType | VARCHAR(20) | CHECK | Deposit/Withdrawal/Transfer |
| Amount | DECIMAL(15,2) | CHECK | Transaction amount |
| TransactionDate | DATETIME | NOT NULL | Transaction date |
| Description | VARCHAR(200) | NULL | Remarks |

---

# Table: Loans

## Description

Stores customer loan details.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| LoanID | INT | Primary Key | Loan ID |
| CustomerID | INT | Foreign Key | References Customers |
| LoanType | VARCHAR(30) | NOT NULL | Home/Car/Personal |
| LoanAmount | DECIMAL(15,2) | CHECK | Loan amount |
| InterestRate | DECIMAL(5,2) | CHECK | Interest rate |
| LoanTermMonths | INT | NOT NULL | Loan duration |
| LoanStatus | VARCHAR(20) | DEFAULT | Running |

---

# Table: CreditCards

## Description

Stores customer credit card information.

| Column | Data Type | Constraint | Description |
|---------|-----------|------------|-------------|
| CardID | INT | Primary Key | Credit card ID |
| CustomerID | INT | Foreign Key | References Customers |
| CardNumber | VARCHAR(20) | UNIQUE | Card number |
| CardType | VARCHAR(20) | NOT NULL | Visa/MasterCard |
| CreditLimit | DECIMAL(15,2) | CHECK | Credit limit |
| ExpiryDate | DATE | NOT NULL | Expiry date |
| CardStatus | VARCHAR(20) | DEFAULT | Active |

---

# Relationships

Branches (1) → Customers (Many)

Customers (1) → Accounts (Many)

Accounts (1) → Transactions (Many)

Customers (1) → Loans (Many)

Customers (1) → CreditCards (Many)

Branches (1) → Employees (Many)

---

# Naming Standards

Primary Key

TableNameID

Example

CustomerID
**************
Foreign Key

ParentTableID

Example

BranchID
**************
Table Names Plural

Examples

1]Customers

2]Accounts

3]Transactions
*****************
Stored Procedures
usp_

Example

usp_GetCustomerAccounts
***************
Views

vw_

Example

vw_AccountSummary

Indexes

IX_

Example

IX_Customers_Email

Triggers

trg_

Example

trg_UpdateBalance

---

# Version

Version: 1.0

Database: SQL Server 2022

Migration Target: PostgreSQL 15

Author: Bhagyashree Kadam

Last Updated: August 2026
