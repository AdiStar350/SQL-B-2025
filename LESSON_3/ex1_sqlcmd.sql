--1. **Connect to a SQL Server instance:**
   sqlcmd -S server_name -E 
   

2. **Execute a SQL script file:**
   
   sqlcmd -S server_name -E  -i C:\path\to\script.sql
   

3. **Output query results to a file:**
   
   sqlcmd -S server_name -E  -Q "SELECT * FROM database_name.schema_name.table_name" -o C:\path\to\output.txt
   

4. **Execute a query and display results in a specific format (e.g., CSV):**
   
   sqlcmd -S server_name -E  -Q "SELECT * FROM database_name.schema_name.table_name" -s "," -W
   

5. **Execute a query with variables:**
   
   sqlcmd -S localhost -E -Q "SELECT UnitPrice FROM Northwind.dbo.Products WHERE ProductId = $(kodProd)" -v kodProd="10"
   

6. **Connect using Windows Authentication:**
   
   sqlcmd -S server_name -E
   

7. **Execute a query and suppress the output:**
   
   sqlcmd -S server_name -E  -Q "UPDATE database_name.schema_name.table_name SET column_name = 'value'" -h-1
   

8. **Execute a query and handle errors:**
   
   sqlcmd -S server_name -E  -Q "SELECT * FROM database_name.schema_name.table_name" -b
   

9. **Execute a query and specify a database:**
   
   sqlcmd -S server_name -E  -d database_name -Q "SELECT * FROM schema_name.table_name"
   

10. **Execute a query with a timeout:**
    
    sqlcmd -S server_name -E  -Q "SELECT * FROM database_name.schema_name.table_name" -t 30
    
