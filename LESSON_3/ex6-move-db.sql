--Detach Database:

USE master;
GO
ALTER DATABASE [NorthwindTestMove] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
EXEC sp_detach_db @dbname = N'NorthwindTestMove';
GO
--Attach Database:

USE master;
GO
CREATE DATABASE [NorthwindTestMove] ON 
(FILENAME = N'C:\Path\To\YourDatabase.mdf'), 
(FILENAME = N'C:\Path\To\YourDatabase_log.ldf') 
FOR ATTACH;
GO