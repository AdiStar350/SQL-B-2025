SELECT (total_physical_memory_kb/1024) AS Total_OS_Memory_MB,
(available_physical_memory_kb/1024) AS Available_OS_Memory_MB
FROM sys.dm_os_sys_memory;
GO

-- A 1
EXECUTE sp_configure 'max server memory (MB)', 1310;
RECONFIGURE;
GO

-- A 2
EXECUTE sp_configure 'user connections', 1500;
RECONFIGURE;
GO

-- A 3
EXECUTE sp_configure 'fill factor (%)', 80;
RECONFIGURE;
GO



EXECUTE sp_configure;
GO