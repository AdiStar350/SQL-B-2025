SELECT
	CAST(size AS BIGINT) * 8 / 1024 AS currentSize,
	CAST(max_size AS BIGINT) * 8 / 1024 AS MaxSize,
	growth,
	physical_name
FROM sys.master_files
WHERE database_id = DB_ID('Northwind');
GO

-- 1
ALTER DATABASE Northwind
MODIFY FILE (
	NAME = 'Northwind',
	SIZE = 50MB
);
GO

-- 2
ALTER DATABASE Northwind
MODIFY FILE (
	NAME = 'Northwind_log',
	FILEGROWTH = 25%
);
GO

-- 3
USE master;
GO

ALTER DATABASE Northwind
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

EXEC sp_detach_db @dbname = 'Northwind';
GO

EXEC xp_cmdshell 'md "C:\newData\DBLoc"';
GO

EXEC xp_cmdshell 'move "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\northwnd.mdf" "C:\newData\DBLoc\northwnd.mdf"';
EXEC xp_cmdshell 'move "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\northwnd.ldf" "C:\newData\DBLoc\northwnd.ldf"';
GO

CREATE DATABASE Northwind ON
(FILENAME = 'C:\newData\DBLoc\northwnd.mdf'),
(FILENAME = 'C:\newData\DBLoc\northwnd.ldf')
FOR ATTACH;
GO

ALTER DATABASE Northwind
SET MULTI_USER;
GO

-- 4
EXEC sp_spaceused;
DBCC SHRINKDATABASE ('Northwind', 50);
EXEC sp_spaceused;
GO

-- 5
CREATE PROCEDURE sp_add_tables
AS
BEGIN
    CREATE TABLE students
    (
        studentId    INT         IDENTITY,
        firstName    VARCHAR(20),
        lastName     VARCHAR(20),
        age          INT,
        studySubject VARCHAR(20) PRIMARY KEY NOT NULL
    );

    CREATE TABLE subjects
    (
        sujectId         INT         IDENTITY,
        subjectName      VARCHAR(20) FOREIGN KEY REFERENCES students (studySubject),
        headLecturerName VARCHAR(50) PRIMARY KEY NOT NULL,
        numOfStudents    INT,
        avgGrade         DECIMAL
    );

    CREATE TABLE lecturers
    (
        lecturerId   INT         PRIMARY KEY IDENTITY,
        lecturerName VARCHAR(50) FOREIGN KEY REFERENCES subjects (headLecturerName),
        hireDate     DATE,
        rating       DECIMAL
    );
END;
GO

-- 6
USE Northwind;
SELECT name
FROM sys.tables;
GO

-- 7
DBCC CHECKDB ('Northwind') WITH PHYSICAL_ONLY;

-- 8
CREATE DATABASE Northwind_snap
ON (
	NAME = Northwind,
	FILENAME = 'C:\newData\DBLoc\northwnd_snap.ss'
) AS SNAPSHOT OF Northwind;
GO

USE Northwind;
DROP TABLE dbo.lecturers, dbo.subjects, dbo.students;
GO

SELECT 
	ntb.name AS [original database],
	ntb_snap.name AS [database snapshot]
FROM Northwind.sys.tables AS ntb
FULL OUTER JOIN Northwind_snap.sys.tables AS ntb_snap
ON ntb.name = ntb_snap.name;
GO

-- 9
EXEC sp_addumpdevice 'disk', 'Northwind_back', 'C:\newData\DBLoc\northwnd_back.bak';
GO

-- 10
BACKUP DATABASE Northwind TO Northwind_back
WITH INIT, NAME = 'Full Northwind Backup';
GO

BACKUP LOG Northwind TO Northwind_back
WITH INIT, NAME = 'Log Northwind Backup';
GO
