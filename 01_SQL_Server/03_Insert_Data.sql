03_Insert_tables.sql

/*
==========================================
Project : ABC Finance Banking Database
Module 1 : Create Database
Author  : Bhagyashree Kadam
Database: SQL Server 2022
==========================================
*/

## Data Import

The `insert_data.sql` script populates the ABCFinanceDB database using SQL Server BULK INSERT commands.

### Prerequisites
- SQL Server installed
- ABCFinanceDB database created
- All database tables created
- TXT data files copied to `C:\SQLData\`

### Supported Data Files
- Branchesnew.txt
- Customersnew.txt
- Employeesnew.txt
- Accountsnew.txt
- Transactionsnew.txt
- Loansnew.txt
- CreditCardsnew1.txt

### File Format
- Tab-delimited (`\t`)
- First row contains column headers
- UTF-8 encoding recommended
- Data must follow the same column order as the destination tables

### Notes
- Parent tables (such as Branches and Customers) should be imported before child tables to satisfy foreign key constraints.
- Ensure unique values for fields such as AccountNumber, IFSCCode, Email, and CardNumber before running the import.

-- Insert Credit Cards
INSERT INTO CreditCards (...);

PRINT 'Sample data inserted successfully.';
GO
