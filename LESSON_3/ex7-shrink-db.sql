
1. **Shrink the entire database**:
  
   DBCC SHRINKDATABASE (Northwind);
  

2. **Shrink a specific file in the database**:
  
   DBCC SHRINKFILE (Northwind, 10);
  

3. **Shrink the log file**:
  
   DBCC SHRINKFILE (Northwind_log, 10);
  

4. **Shrink the database and release unused space to the operating system**:
  
   DBCC SHRINKDATABASE (Northwind, TRUNCATEONLY);
  

5. **Shrink a specific file and release unused space to the operating system**:
  
   DBCC SHRINKFILE (Northwind, TRUNCATEONLY);
  

6. **Shrink the database to a specific size**:
  
   DBCC SHRINKDATABASE (Northwind, 10);
  

7. **Shrink the log file to a specific size and release unused space**:
  
   DBCC SHRINKFILE (Northwind_log, 20, TRUNCATEONLY);
  
