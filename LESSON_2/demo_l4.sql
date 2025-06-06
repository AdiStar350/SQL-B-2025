USE [master]
GO

GO
ALTER DATABASE [YacovDB] ADD FILEGROUP [FG2]
GO
ALTER DATABASE [YacovDB] ADD FILE 
  ( NAME = N'YacovDB2', FILENAME = N'C:\SQLDATA\YacovDB2.ndf' ,
    SIZE = 20480KB , MAXSIZE = 10240000KB , FILEGROWTH = 20%) 
	TO FILEGROUP [FG2]
GO
USE [YacovDB]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'FG2')
   ALTER DATABASE [YacovDB] MODIFY FILEGROUP [FG2] DEFAULT
GO
-- check the DB
DBCC CHECKDB
-- SHRINK A FILE IN DB
USE [YacovDB]
GO
DBCC SHRINKFILE (N'YacovDB2' , 20)
GO

exec sp_spaceUsed
