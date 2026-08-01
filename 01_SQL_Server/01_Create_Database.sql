01_Create_Database.sql
/*
==========================================
Project : ABC Finance Banking Database
Module 1 : Create Database
Author  : Bhagyashree Kadam
Database: SQL Server 2022
==========================================
*/

-- Check if database already exists
IF DB_ID('ABCFinanceDB') IS NOT NULL
BEGIN
    DROP DATABASE ABCFinanceDB;
END;
GO

-- Create Database
CREATE DATABASE ABCFinanceDB;
GO

-- Use Database
USE ABCFinanceDB;
GO

PRINT 'ABCFinanceDB database created successfully.';
