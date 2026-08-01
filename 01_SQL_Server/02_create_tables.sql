
/*
==========================================================
Project : ABC Finance Banking Database
Module  : SQL Server
Task    : Create Tables
Author  : Bhagyashree Kadam
==========================================================
*/

USE ABCFinanceDB;
GO

-- =====================================================
-- Table: Branches
-- =====================================================
CREATE TABLE Branches
(
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);
GO

-- =====================================================
-- Table: Customers
-- =====================================================
CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    BranchID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Phone VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(200),
    City VARCHAR(50),

    CONSTRAINT FK_Customers_Branches
        FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID)
);
GO
  /*==========================================================
Table: Employees
==========================================================*/

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    BranchID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(50) NOT NULL,
    Salary DECIMAL(12,2) CHECK (Salary > 0),
    HireDate DATE NOT NULL,

    CONSTRAINT FK_Employees_Branches
        FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID)
);
GO


/*==========================================================
Table: Accounts
==========================================================*/

CREATE TABLE Accounts
(
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountNumber VARCHAR(20) NOT NULL UNIQUE,
    AccountType VARCHAR(20) NOT NULL
        CHECK (AccountType IN ('Savings','Current')),
    Balance DECIMAL(15,2) NOT NULL
        CHECK (Balance >= 0),
    Status VARCHAR(20) NOT NULL
        DEFAULT 'Active',
    OpenDate DATE NOT NULL,

    CONSTRAINT FK_Accounts_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO


/*==========================================================
Table: Transactions
==========================================================*/

CREATE TABLE Transactions
(
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionType VARCHAR(20) NOT NULL
        CHECK (TransactionType IN ('Deposit','Withdrawal','Transfer')),
    Amount DECIMAL(15,2) NOT NULL
        CHECK (Amount > 0),
    TransactionDate DATETIME NOT NULL,
    Description VARCHAR(200),

    CONSTRAINT FK_Transactions_Accounts
        FOREIGN KEY (AccountID)
        REFERENCES Accounts(AccountID)
);
GO


/*==========================================================
Table: Loans
==========================================================*/

CREATE TABLE Loans
(
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    LoanType VARCHAR(30) NOT NULL
        CHECK (LoanType IN ('Home Loan','Car Loan','Personal Loan')),
    LoanAmount DECIMAL(15,2) NOT NULL
        CHECK (LoanAmount > 0),
    InterestRate DECIMAL(5,2) NOT NULL
        CHECK (InterestRate BETWEEN 1 AND 25),
    LoanTermMonths INT NOT NULL,
    LoanStatus VARCHAR(20) NOT NULL
        DEFAULT 'Running',

    CONSTRAINT FK_Loans_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO


/*==========================================================
Table: CreditCards
==========================================================*/

CREATE TABLE CreditCards
(
    CardID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CardNumber VARCHAR(20) NOT NULL UNIQUE,
    CardType VARCHAR(20) NOT NULL
        CHECK (CardType IN ('Visa','MasterCard')),
    CreditLimit DECIMAL(15,2) NOT NULL
        CHECK (CreditLimit > 0),
    ExpiryDate DATE NOT NULL,
    CardStatus VARCHAR(20) NOT NULL
        DEFAULT 'Active',

    CONSTRAINT FK_CreditCards_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO

PRINT 'All tables created successfully.';

PRINT 'Tables created successfully.';
