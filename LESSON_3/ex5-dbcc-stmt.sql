--DBCC CHECKDB STATEMENTS--

--1. Basic Integrity Check:
   DBCC CHECKDB ('Northwind');
This command checks the logical and physical integrity of all objects in the specified database.
--2. Check Current Database:
   USE Northwind;
   DBCC CHECKDB;
--This command runs DBCC CHECKDB on the current database.
--3. Exclude Nonclustered Indexes:
   DBCC CHECKDB ('Northwind') WITH NOINDEX;
--This command skips the intensive checks of nonclustered indexes, reducing the overall execution time.
--4. Repair with Data Loss:
   DBCC CHECKDB ('Northwind', REPAIR_ALLOW_DATA_LOSS);
--This command attempts to repair errors found, but it may result in data loss. Use this option as a last resort.
--5. Repair Fast:
   DBCC CHECKDB ('Northwind', REPAIR_FAST);
--This command performs minor, non-time-consuming repairs.
--6. Repair Rebuild:
   DBCC CHECKDB ('Northwind', REPAIR_REBUILD);
--This command performs repairs that do not involve data loss, such as rebuilding indexes.
--7. Suppress Informational Messages:
   DBCC CHECKDB ('Northwind') WITH NO_INFOMSGS;
--This command suppresses all informational messages, displaying only errors.
--8. Extended Logical Checks:
   DBCC CHECKDB ('Northwind') WITH EXTENDED_LOGICAL_CHECKS;
--This command performs additional logical checks on indexed views, XML indexes, and spatial indexes.
--9. Physical-Only Check:
   DBCC CHECKDB ('Northwind') WITH PHYSICAL_ONLY;
--This command performs a physical-only check, which is faster and useful for frequent checks.
--10. Estimate TempDB Space: 
   DBCC CHECKDB ('Northwind') WITH ESTIMATEONLY; 
--This command estimates the amount of tempdb space required to run DBCC CHECKDB.

