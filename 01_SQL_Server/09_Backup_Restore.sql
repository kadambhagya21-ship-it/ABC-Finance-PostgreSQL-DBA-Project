/*
==========================================================
Project Name : ABC Finance Banking Database
Module       : SQL Server Backup & Recovery
File Name    : 09_Backup_Restore.sql
Purpose      : Database Backup, Restore and Recovery
Database     : ABCFinanceDB
Author       : Bhagyashree Kadam
==========================================================

DESCRIPTION
-----------
This script demonstrates backup and restore operations
for the ABC Finance banking database.

BACKUP TYPES
------------
1. Full Database Backup
   - Backs up the complete database.

2. Differential Backup
   - Backs up changes made since the last full backup.

3. Transaction Log Backup
   - Backs up transaction log records.
   - Supports point-in-time recovery.

RECOVERY OBJECTIVES
-------------------
The backup strategy is designed to support:

- Data protection
- Disaster recovery
- Database restoration
- Minimizing data loss
- Business continuity

IMPORTANT
---------
The backup directory must exist on the SQL Server machine.

Example:
C:\SQLBackups\

The SQL Server service account must have permission
to write to this directory.

==========================================================
*/


/*==========================================================
PART 1 - SELECT DATABASE
==========================================================*/

USE master;
GO


/*==========================================================
PART 2 - FULL DATABASE BACKUP
==========================================================*/

BACKUP DATABASE ABCFinanceDB
TO DISK = 'C:\SQLBackups\ABCFinanceDB_Full.bak'
WITH
    FORMAT,
    INIT,
    COMPRESSION,
    STATS = 10;
GO


/*==========================================================
PART 3 - VERIFY FULL BACKUP
==========================================================*/

RESTORE VERIFYONLY
FROM DISK = 'C:\SQLBackups\ABCFinanceDB_Full.bak';
GO


/*==========================================================
PART 4 - DIFFERENTIAL BACKUP
==========================================================*/

BACKUP DATABASE ABCFinanceDB
TO DISK = 'C:\SQLBackups\ABCFinanceDB_Differential.bak'
WITH
    DIFFERENTIAL,
    INIT,
    COMPRESSION,
    STATS = 10;
GO


/*==========================================================
PART 5 - TRANSACTION LOG BACKUP
==========================================================

NOTE:
Transaction log backups require the database to use
FULL or BULK_LOGGED recovery model.
==========================================================*/

ALTER DATABASE ABCFinanceDB
SET RECOVERY FULL;
GO


BACKUP LOG ABCFinanceDB
TO DISK = 'C:\SQLBackups\ABCFinanceDB_Log.trn'
WITH
    INIT,
    COMPRESSION,
    STATS = 10;
GO


/*==========================================================
PART 6 - CHECK DATABASE RECOVERY MODEL
==========================================================*/

SELECT
    name AS DatabaseName,
    recovery_model_desc AS RecoveryModel
FROM sys.databases
WHERE name = 'ABCFinanceDB';
GO


/*==========================================================
PART 7 - VIEW BACKUP HISTORY
==========================================================*/

SELECT
    database_name,
    backup_start_date,
    backup_finish_date,
    type,
    backup_size,
    physical_device_name
FROM msdb.dbo.backupset bs
JOIN msdb.dbo.backupmediafamily bmf
    ON bs.media_set_id = bmf.media_set_id
WHERE database_name = 'ABCFinanceDB'
ORDER BY backup_start_date DESC;
GO


/*
==========================================================
RESTORE EXAMPLE
==========================================================

IMPORTANT:
Do NOT run the following restore commands while you are
actively using ABCFinanceDB unless you intentionally want
to restore/replace the database.

The restore sequence is:

1. Full Backup
2. Differential Backup
3. Transaction Log Backup

Example restore commands are provided below for
documentation and disaster recovery testing.
==========================================================
*/


/*
----------------------------------------------------------
PART 8 - RESTORE FULL BACKUP
----------------------------------------------------------

RESTORE DATABASE ABCFinanceDB
FROM DISK = 'C:\SQLBackups\ABCFinanceDB_Full.bak'
WITH
    NORECOVERY,
    REPLACE,
    STATS = 10;
GO
*/


/*
----------------------------------------------------------
PART 9 - RESTORE DIFFERENTIAL BACKUP
----------------------------------------------------------

RESTORE DATABASE ABCFinanceDB
FROM DISK = 'C:\SQLBackups\ABCFinanceDB_Differential.bak'
WITH
    NORECOVERY,
    STATS = 10;
GO
*/


/*
----------------------------------------------------------
PART 10 - RESTORE TRANSACTION LOG
----------------------------------------------------------

RESTORE LOG ABCFinanceDB
FROM DISK = 'C:\SQLBackups\ABCFinanceDB_Log.trn'
WITH
    RECOVERY,
    STATS = 10;
GO
*/


/*
==========================================================
BACKUP STRATEGY
==========================================================

Full Backup
     |
     +---- Differential Backup
     |
     +---- Transaction Log Backup
     |
     +---- Disaster Recovery
==========================================================
*/


PRINT 'Backup and restore configuration completed.';
GO
