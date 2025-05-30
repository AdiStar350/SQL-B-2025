-- 1
CREATE DATABASE MDDB
ON PRIMARY (
	NAME = MDDB_data,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW\MDDB\MDDB_data.mdf',
	SIZE = 10MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 128MB
)
LOG ON (
	NAME = MDDB_log,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW\MDDB\MDDB_log.ldf',
	SIZE = 3MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 64MB
)
GO

-- 2
USE master;
GO

EXECUTE sp_helpdb 'Northwind';
GO

ALTER DATABASE Northwind
MODIFY FILE (
	name = 'Northwind',
	SIZE = 28MB,
	MAXSIZE = 100MB
);
GO

-- 3
CREATE DATABASE TESTDB
ON PRIMARY (
	NAME = TESTDB_data,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW\TESTDB\TESTDB_data.mdf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 70%
),
(
	NAME = TESTDB_sec,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW\TESTDB\TESTDB_sec.ndf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 70%
)
LOG ON (
	NAME = TESTDB_log,
	FILENAME = 'C:\Users\adist\iCloudDrive\Studies\SQL-B-2025\LESSON_2\HW\TESTDB\TESTDB_log.ldf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 70%
);
GO