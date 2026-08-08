
/*
==========================================================
Project Name : ABC Finance Banking Database
Module       : SQL Server Security
File Name    : 08_Users_Roles.sql
Purpose      : Users, Logins, Roles and Permissions
Database     : ABCFinanceDB
Author       : Bhagyashree Kadam
==========================================================

DESCRIPTION
-----------
This script implements Role-Based Access Control (RBAC)
for the ABC Finance banking database.

It creates:
    1. SQL Server Logins
    2. Database Users
    3. Database Roles
    4. Role Memberships
    5. Permissions

SECURITY MODEL
--------------
DBA:
    Full control over ABCFinanceDB.

Developer:
    SELECT, INSERT, UPDATE and DELETE permissions.

ReadOnly:
    SELECT permission only.

SECURITY PRINCIPLE
------------------
The implementation follows the Principle of Least
Privilege by assigning users only the permissions
required for their responsibilities.

IMPORTANT
---------
These passwords are for local development/project
demonstration only.

Production environments should use strong passwords,
secure credential management and appropriate
authentication policies.

==========================================================
*/


/*==========================================================
PART 1 - CREATE SQL SERVER LOGINS
==========================================================

A Login provides access to the SQL Server instance.
==========================================================*/

USE master;
GO


CREATE LOGIN DBAUser
WITH PASSWORD = 'Password@123';
GO


CREATE LOGIN DeveloperUser
WITH PASSWORD = 'Developer@123';
GO


CREATE LOGIN ReadOnlyUser
WITH PASSWORD = 'Readonly@123';
GO


/*==========================================================
PART 2 - CREATE DATABASE USERS
==========================================================

A database User maps a SQL Server Login to a specific
database.
==========================================================*/

USE ABCFinanceDB;
GO


CREATE USER DBAUser
FOR LOGIN DBAUser;
GO


CREATE USER DeveloperUser
FOR LOGIN DeveloperUser;
GO


CREATE USER ReadOnlyUser
FOR LOGIN ReadOnlyUser;
GO


/*==========================================================
PART 3 - CREATE DATABASE ROLES
==========================================================*/

CREATE ROLE BankDBA;
GO


CREATE ROLE BankDeveloper;
GO


CREATE ROLE BankReadOnly;
GO


/*==========================================================
PART 4 - ADD USERS TO ROLES
==========================================================*/

ALTER ROLE BankDBA
ADD MEMBER DBAUser;
GO


ALTER ROLE BankDeveloper
ADD MEMBER DeveloperUser;
GO


ALTER ROLE BankReadOnly
ADD MEMBER ReadOnlyUser;
GO


/*==========================================================
PART 5 - GRANT PERMISSIONS
==========================================================*/


/*----------------------------------------------------------
DBA ROLE
Full control over the ABCFinanceDB database.
----------------------------------------------------------*/

GRANT CONTROL
ON DATABASE::ABCFinanceDB
TO BankDBA;
GO


/*----------------------------------------------------------
DEVELOPER ROLE
Can read and modify data in the dbo schema.
----------------------------------------------------------*/

GRANT SELECT, INSERT, UPDATE, DELETE
ON SCHEMA::dbo
TO BankDeveloper;
GO


/*----------------------------------------------------------
READ-ONLY ROLE
Can only read data from the dbo schema.
----------------------------------------------------------*/

GRANT SELECT
ON SCHEMA::dbo
TO BankReadOnly;
GO


/*==========================================================
PART 6 - VERIFY DATABASE USERS
==========================================================*/

SELECT
    name AS UserName,
    type_desc AS UserType
FROM sys.database_principals
WHERE name IN
(
    'DBAUser',
    'DeveloperUser',
    'ReadOnlyUser'
);
GO


/*==========================================================
PART 7 - VERIFY DATABASE ROLES
==========================================================*/

SELECT
    name AS RoleName,
    type_desc AS RoleType
FROM sys.database_principals
WHERE name IN
(
    'BankDBA',
    'BankDeveloper',
    'BankReadOnly'
);
GO


/*==========================================================
PART 8 - VERIFY ROLE MEMBERS
==========================================================*/

SELECT
    RoleName = r.name,
    UserName = m.name
FROM sys.database_role_members rm
JOIN sys.database_principals r
    ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m
    ON rm.member_principal_id = m.principal_id
WHERE r.name IN
(
    'BankDBA',
    'BankDeveloper',
    'BankReadOnly'
)
ORDER BY r.name, m.name;
GO


/*==========================================================
PART 9 - CHECK DATABASE PERMISSIONS
==========================================================*/

SELECT
    grantee.name AS PrincipalName,
    dp.permission_name,
    dp.state_desc
FROM sys.database_permissions dp
JOIN sys.database_principals grantee
    ON dp.grantee_principal_id = grantee.principal_id
WHERE grantee.name IN
(
    'BankDBA',
    'BankDeveloper',
    'BankReadOnly'
)
ORDER BY grantee.name;
GO


PRINT 'Users, roles and permissions configured successfully.';
GO
