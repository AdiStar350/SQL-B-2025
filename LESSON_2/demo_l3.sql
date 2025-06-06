CREATE DATABASE [YacovDB]
CONTAINMENT = NONE
ON PRIMARY 
( NAME = N'YacovDB', FILENAME = N'C:\SQLCourse\ADMIN\L1\YacovDB.mdf' , SIZE = 20480KB , MAXSIZE = 10240000KB , FILEGROWTH = 50%)
LOG ON 
( NAME = N'YacovDB_log', FILENAME = N'C:\SQLCourse\ADMIN\L1\YacovDB_log.ldf' ,SIZE = 5120KB , MAXSIZE = 2560000KB , FILEGROWTH = 12%)
WITH LEDGER = OFF
GO
ALTER DATABASE [YacovDB] SET COMPATIBILITY_LEVEL = 160
GO
ALTER DATABASE [YacovDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YacovDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YacovDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YacovDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YacovDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [YacovDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YacovDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YacovDB] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [YacovDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YacovDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YacovDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YacovDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YacovDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YacovDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YacovDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YacovDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YacovDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YacovDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YacovDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YacovDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YacovDB] SET  READ_WRITE 
GO
ALTER DATABASE [YacovDB] SET RECOVERY FULL 
GO
ALTER DATABASE [YacovDB] SET  MULTI_USER 
GO
ALTER DATABASE [YacovDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YacovDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [YacovDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [YacovDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [YacovDB]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [YacovDB] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
