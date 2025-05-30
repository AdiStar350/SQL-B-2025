-- 1
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
GO

EXEC xp_cmdshell 'md "C:\data\DB"';
GO

EXEC xp_cmdshell 'md "C:\data\log"';
GO

CREATE DATABASE HRDB
ON PRIMARY (
    NAME = HRDB_data,
    FILENAME = 'C:\data\DB\HRDB_data.mdf',
    SIZE = 20MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB
)
LOG ON (
    NAME = HRDB_log,
    FILENAME = 'C:\data\log\HRDB_log.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 10%
);
GO

-- 2
ALTER DATABASE HRDB
MODIFY FILE (
    NAME = HRDB_data,
    SIZE = 50MB
);
GO

-- 3
ALTER DATABASE HRDB
MODIFY FILE (
    NAME = HRDB_log,
    FILEGROWTH = 25%
);
GO

-- 4
USE master;
GO

ALTER DATABASE HRDB
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

EXEC sp_detach_db @dbname = 'HRDB';
GO

EXEC xp_cmdshell 'md "C:\newData\DBLoc"';
GO

EXEC xp_cmdshell 'move "C:\data\DB\HRDB_data.mdf" "C:\newData\DBLoc\HRDB_data.mdf"';
GO

EXEC xp_cmdshell 'move "C:\data\log\HRDB_log.ldf" "C:\newData\DBLoc\HRDB_log.ldf"';
GO

CREATE DATABASE HRDB ON
(FILENAME = 'C:\newData\DBLoc\HRDB_data.mdf'),
(FILENAME = 'C:\newData\DBLoc\HRDB_log.ldf')
FOR ATTACH;
GO

-- 5 
USE HRDB;
GO

EXEC sp_spaceused;
GO

DBCC SHRINKDATABASE (HRDB, 50);
GO

EXEC sp_spaceused;
GO

-- 6
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

-- 7
DBCC CHECKDB ('HRDB') WITH PHYSICAL_ONLY;
GO

EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE;
GO
