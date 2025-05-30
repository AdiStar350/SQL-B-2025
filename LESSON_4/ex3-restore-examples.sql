
-- 1 DEVICES
-- 2 set the recovery model
-- 3 BACKUP TYPES : full , differential , log, compress backup
-- 4 RESTORE scenarios (from full, from full & differential , from full + log)
-- 5 enforcing recovery
-- 5 excersize - 
--       1 - create a device for full db backup and log db backup
--      2 - backup to full device
--	 3 - restore from full device
--	 4 - in full recovery model , backup a gain to full device,  do some changes , backup to log 
--	    and restore from full and log.
--------------------------------------------------------------------

/*---------------------------------------------------------*/
-- Example 4 -- Backup methods -- adding devices
--By Eli L.
/*---------------------------------------------------------*/
USE master
GO
-- ADDING DEVICES
exec sp_addumpdevice 'disk', 'NWBACKUP_DEV',  'c:\backup\northwnd.bak'
EXEC sp_addumpdevice 'disk', 'NWBACKUP_DEV_DIFF', 'c:\backup\northwnd_diff.bak'
EXEC sp_addumpdevice 'disk', 'NWBACKUP_DEV_LOG', 'c:\backup\northwnd_log.bak'

/*---------------------------------------------------------*/
-- Example 5 -- CHANGING a DATABASE RECOVERY MODEL
--By Eli L.
/*---------------------------------------------------------*/
ALTER DATABASE NORTHWIND SET RECOVERY FULL
go
ALTER DATABASE NORTHWIND SET RECOVERY SIMPLE
go

-- setting truncate log on chkpt. option
--By Eli L.
/*---------------------------------------------------------*/
exec sp_dbOption 'northwind', 'trunc. log on chkpt','true'
-- note that this option changes database recovery model to 
--simple mode implicitly.



/*---------------------------------------------------------*/
-- Example 6 -- Backup Commands with AND without devices
--By Eli L.
/*---------------------------------------------------------*/
--8.1 full backup to device
BACKUP DATABASE NORTHWIND TO NWBACKUP_DEV
--8.2 differential backup to device
BACKUP DATABASE NORTHWIND TO NWBACKUP_DEV_DIFF WITH DIFFERENTIAL
--8.3 BACKUP THE LOG
BACKUP LOG NORTHWIND TO NWBACKUP_DEV_LOG
--8.4 full backup without device
BACKUP DATABASE Northwind  TO DISK = 'c:\Northbck.bak'

--8.5 backup a specific file within group
alter database northwind set recovery full
backup database Northwind file = 'Northwind',filegroup = 'PRIMARY'
to disk ='c:\SQL\nwPrimary.dat'

--8.6 backup a whole file group
backup database Northwind filegroup = 'PRIMARY' to disk ='c:\SQL\nwPrimary.dat'


/*---------------------------------------------------------*/
--Example 7- Restore examples 
--By Eli L.
--Date: 03/04/05
/*---------------------------------------------------------*/
--7.1 VERIFYING a BACKUP CONTENT
RESTORE filelistonly FROM NWBACKUP_DEV 
RESTORE DATABASE northwind  FROM NWBACKUP_DEV

/*---------------------------------------------------------*/
--7.2
-- Restore a full database and a differential backup
-- This example restores a full database backup followed
-- by a differential backup. 
/*---------------------------------------------------------*/
RESTORE DATABASE northwind  FROM NWBACKUP_DEV WITH NORECOVERY
RESTORE DATABASE northwind  FROM NWBACKUP_DEV_DIFf with recovery
   
/*---------------------------------------------------------*/
--7.3 Restore a database and move files
--This example restores a full database and transaction log and moves 
--the restored database into the C:\MSSQL\Data directory.
/*---------------------------------------------------------*/
RESTORE DATABASE northwind  
   FROM NWBACKUP_DEV
   WITH NORECOVERY, 
      MOVE 'northwind' TO 'c:\mssql\Data\NewNwind.mdf', 
      MOVE 'northwind_log' TO 'c:\MSSQL\Data\NewNwind.ldf'

RESTORE DATABASE northwind  FROM NWBACKUP_DEV_DIFf with NOrecovery

RESTORE LOG northwind  FROM NWBACKUP_DEV_LOG WITH RECOVERY

/*---------------------------------------------------------*/
-- 7.4
-- Make a copy of a database using BACKUP and RESTORE
-- This example uses both the BACKUP and RESTORE statements to make 
-- a copy of the Northwind database. The MOVE statement causes the data and 
-- log file to be restored to the specified locations. 
-- The RESTORE FILELISTONLY statement is used to determine 
-- the number and names of the files in the database being restored.
-- The new copy of the database is named TestDB. 
/*---------------------------------------------------------*/
BACKUP DATABASE Northwind  TO DISK = 'c:\Northwind.bak'
RESTORE FILELISTONLY  FROM DISK = 'c:\Northwind.bak'
RESTORE DATABASE TestDB  FROM DISK = 'c:\Northwind.bak'
   WITH MOVE 'Northwind' TO 'c:\mssql\data\testdb.mdf',
   MOVE 'Northwind_log' TO  'c:\mssql\data\testdb.ldf'
GO

/*---------------------------------------------------------*/
--7.5.
--Restore to a point-in-time using STOPAT syntax 
/*---------------------------------------------------------*/
--backup database northwind to NWBACKUP_DEV
RESTORE DATABASE northwind
   FROM NWBACKUP_DEV  WITH NORECOVERY
RESTORE LOG NORTHWIND FROM NWBACKUP_DEV_LOG
   WITH RECOVERY, STOPAT = 'Feb 7, 2002 19:30 PM'

6. 
Restore using FILE and FILEGROUP syntax
This example restores a database with two files, 
one filegroup, and one transaction log.

RESTORE DATABASE northwind
   FILE = 'northwind',
   FILEGROUP = 'PRIMARY'
   FROM NWBACKUP_DEV
   WITH NORECOVERY

-- restore differential  
RESTORE DATABASE northwind  FROM NWBACKUP_DEV_DIFF with NORECOVERY

-- Restore the log backup.
RESTORE LOG northwind FROM NWBACKUP_DEV_LOG with RECOVERY

7.
-- using stop marks to recover to a stop mark

USE MASTER 

backup database testdb2 to disk = 'c:\test2.bak'

use testdb2

BEGIN TRANSACTION RoyaltyUpdate  WITH MARK 'RoyaltyUpdate'

UPDATE products set unitprice = 100
     WHERE productid between 10 and 20

COMMIT TRANSACTION RoyaltyUpdate

use master 
go

BACKUP LOG TESTDB2 TO DISK = 'C:\test2log.bak'

RESTORE DATABASE testdb2 FROM disk = 'c:\test2.bak' WITH NORECOVERY

RESTORE LOG testdb2 
    FROM disk = 'c:\test2log.bak' 
    with STOPATMARK = 'RoyaltyUpdate'
RESTORE DATABASE pubs FROM PUBSBACKUP_DEV with NORECOVERY
GO

RESTORE LOG pubs 
  FROM PUBSBACKUP_DEV_LOG 
   with STOPATMARK = 'RoyaltyUpdate'


   