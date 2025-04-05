-- 1
CREATE DATABASE OSHRIDB
ON PRIMARY (
	NAME = OSHRIDB_data,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW2\oshridb.mdf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 128MB
)
LOG ON (
	NAME = OSHRIDB_log,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW2\oshridb.ldf',
	SIZE = 3MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 64MB
)
GO

USE OSHRIDB;
GO

CREATE TABLE OSHRITB (
	id INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(20)
);
GO

INSERT INTO OSHRITB ([name])
VALUES
	('Oshri'),
	('Adam'),
	('Adi'),
	('Guy'),
	('Perly');
GO

ALTER DATABASE OSHRIDB
SET RECOVERY FULL;
GO

-- 2
EXEC sp_addumpdevice 'disk', 'OSHRIDB-DEV-FULL', 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW2\oshridb.bak';
EXEC sp_addumpdevice 'disk', 'OSHRIDB-DEV-LOG', 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW2\oshridblog.bak';
GO

-- 3
BACKUP DATABASE OSHRIDB TO [OSHRIDB-DEV-FULL] WITH COMPRESSION;
BACKUP LOG OSHRIDB TO [OSHRIDB-DEV-LOG] WITH COMPRESSION;
GO

-- 4
USE master;
GO

DROP DATABASE OSHRIDB;
GO

EXECUTE sp_dropdevice [OSHRIDB-DEV-FULL], 'delfile';
EXECUTE sp_dropdevice [OSHRIDB-DEV-LOG], 'delfile';
GO
