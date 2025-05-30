
-- 1
USE master;
GO

ALTER DATABASE Northwind
SET RECOVERY FULL;
GO

-- 2
EXEC sp_addumpdevice 'disk', 'North_dev_bck', 'C:\sql\backup\nw-1.bak';
GO

BACKUP DATABASE Northwind TO North_dev_bck;
GO

-- 3
USE Northwind;
GO

INSERT INTO dbo.[Categories] ([CategoryName], [Description], [Picture])
VALUES
	('Food', 'Banana', NULL),
	('Clothes', 'Hat', NULL)
GO

BACKUP DATABASE Northwind TO North_dev_bck
WITH DIFFERENTIAL;
GO

-- 4A
BACKUP DATABASE Northwind TO North_dev_bck;
GO


-- 4B
USE Northwind;
GO

INSERT INTO dbo.[Employees] ([LastName], [FirstName],
	[BirthDate], [HireDate], [City], [Region], [Country])
VALUES
	('Strasser', 'Adi', '05-03-2000', '04-03-2020', 'Haifa', 'North', 'Israel'),
	('Adlin', 'Adam', '03-10-2007', '04-03-2005', 'Yavne', 'Center', 'Gym');
GO

BACKUP LOG Northwind TO North_dev_bck;
GO

-- 5
USE master;
GO

ALTER DATABASE Northwind
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE Northwind;
GO

RESTORE DATABASE Northwind FROM North_dev_bck
WITH FILE = 1, NOUNLOAD, STATS = 5;
GO

-- 6
RESTORE DATABASE Northwind FROM North_dev_bck
WITH FILE = 1, NOUNLOAD, NORECOVERY, STATS = 5;

RESTORE DATABASE Northwind FROM North_dev_bck
WITH FILE = 2, NOUNLOAD, STATS = 5;
GO

-- 7
RESTORE DATABASE Northwind FROM North_dev_bck
WITH FILE = 3, NOUNLOAD, NORECOVERY, STATS = 5;
GO

RESTORE LOG Northwind FROM North_dev_bck
WITH FILE = 4, RECOVERY, STATS = 5;
GO



