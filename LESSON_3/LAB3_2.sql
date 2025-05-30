EXEC sp_configure 'show advanced oprions', 1;
EXEC sp_configure 'xp_cmdshell', 1;
GO

-- 1
EXEC xp_cmdshell 'md "C:\data\DB\"';
EXEC xp_cmdshell 'md "C:\data\LOG\"';
GO

CREATE DATABASE NEWDB
ON PRIMARY (
	NAME = NEWDB_data,
	FILENAME = 'C:\data\DB\NEWDB.mdf',
	SIZE = 20MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 20%
)
LOG ON (
	NAME = NEDB_log,
	FILENAME = 'C:\data\LOG\NEWDB.ldf',
	SIZE = 5MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10%
);
GO

-- 2
USE NEWDB;
GO

CREATE TABLE NUMS (
	ID INT PRIMARY KEY IDENTITY,
	NUM INT NOT NULL DEFAULT 0
);
GO

INSERT INTO NUMS (NUM)
VALUES
	(12),
	(3),
	(65),
	(99),
	(123);
GO

-- 3
ALTER DATABASE NEWDB
SET RECOVERY FULL;
GO

SELECT recovery_model_desc
FROM sys.databases
WHERE database_id = DB_ID('NEWDB');
GO

-- 4
EXEC xp_cmdshell 'md "C:\sql\backup\"';
EXEC sp_addumpdevice 'disk', 'Backup_dev_full', 'C:\sql\backup\NEWDB.bak';
EXEC sp_addumpdevice 'disk', 'Backup_dev_log', 'C:\sql\backup\NEWlog.bak';
GO

-- 5
BACKUP DATABASE NEWDB TO Backup_dev_full;
GO

-- 6
INSERT INTO NUMS (NUM)
VALUES
	(38),
	(0),
	(184),
	(61);
GO

-- 7
BACKUP LOG NEWDB TO Backup_dev_log;
GO

-- 8
USE master;
GO

ALTER DATABASE NEWDB
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE NEWDB;
GO

-- 9
RESTORE DATABASE NEWDB
FROM Backup_dev_full
WITH RECOVERY;
GO

USE NEWDB;
GO

SELECT *
FROM dbo.NUMS;
GO

-- 10
USE master;
GO

ALTER DATABASE NEWDB
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE NEWDB;
GO

RESTORE DATABASE NEWDB
FROM Backup_dev_full
WITH NORECOVERY;
GO

RESTORE LOG NEWDB
FROM Backup_dev_log
WITH RECOVERY;
GO

USE NEWDB;
GO

SELECT *
FROM dbo.NUMS;
GO