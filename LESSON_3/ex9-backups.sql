
### Creating a Backup Device

You can create a logical backup device using SQL Server Management Studio (SSMS) or Transact-SQL (T-SQL).

#### Using SQL Server Management Studio (SSMS)
1. Connect to the appropriate instance of the SQL Server Database Engine.
2. In Object Explorer, expand the server tree.
3. Expand **Server Objects**, right-click **Backup Devices**, and select **New Backup Device**.
4. In the **Backup Device** dialog box, enter a device name.
5. For the destination, click **File** and specify the full path of the file.
6. Click **OK** to create the new device.

#### Using Transact-SQL (T-SQL)
-- ---------------------------------------- --sql
USE Northwind;
GO
EXEC sp_addumpdevice 'disk', 'mydiskdump', 'C:\dump\dump1.bak';
GO
-- ---------------------------------------- --
This example creates a logical backup device named `mydiskdump` that points to the physical file `C:\dump\dump1.bak`[1](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/define-a-logical-backup-device-for-a-disk-file-sql-server?view=sql-server-ver16).

### Types of SQL Database Backups

#### Full Backup
A full backup captures the entire database at the time the backup is taken.
-- ---------------------------------------- --sql
BACKUP DATABASE Northwind
TO DISK = 'C:\backups\Northwind_full.bak';
GO
-- ---------------------------------------- --

#### Differential Backup
A differential backup captures only the data that has changed since the last full backup.
-- ---------------------------------------- --sql
BACKUP DATABASE Northwind
TO DISK = 'C:\backups\Northwind_diff.bak'
WITH DIFFERENTIAL;
GO
-- ---------------------------------------- --

#### Transaction Log Backup
A transaction log backup captures all the transaction log records that have been generated since the last log backup.
-- ---------------------------------------- --sql
BACKUP LOG Northwind
TO DISK = 'C:\backups\Northwind_log.bak';
GO
-- ---------------------------------------- --

#### Copy-Only Backup
A copy-only backup is a special-use backup that is independent of the regular sequence of SQL Server backups.
-- ---------------------------------------- --sql
BACKUP DATABASE Northwind
TO DISK = 'C:\backups\Northwind_copyonly.bak'
WITH COPY_ONLY;
GO
-- ---------------------------------------- --

#### File Backup
A file backup captures one or more files or filegroups.
-- ---------------------------------------- --sql
BACKUP DATABASE Northwind
FILE = 'Northwind_Data'
TO DISK = 'C:\backups\Northwind_file.bak';
GO
-- ---------------------------------------- --

#### Partial Backup
A partial backup captures only the primary filegroup and any read-write filegroups.
-- ---------------------------------------- --sql
BACKUP DATABASE Northwind
READ_WRITE_FILEGROUPS
TO DISK = 'C:\backups\Northwind_partial.bak';
GO
-- ---------------------------------------- --
