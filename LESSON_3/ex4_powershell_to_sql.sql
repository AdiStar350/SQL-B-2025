-- executing database statements from --powershell using `Invoke-Sqlcmd`:

1. **Connect to a SQL Server and execute a simple query:**
   --powershell
   Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products"
   

2. **Execute a SQL script file:**
   --powershell
   Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -InputFile "C:\path\to\script.sql"
   

3. **Execute a query with parameters:**
   --powershell
   $param1 = "value1"
   $param2 = "value2"
   Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products WHERE column1 = @param1 AND column2 = @param2" -Variable param1=$param1, param2=$param2
   

4. **Output query results to a CSV file:**
   --powershell
   Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products" | Export-Csv -Path "C:\path\to\output.csv" -NoTypeInformation
   

5. **Execute a query and handle errors:**
   --powershell
   try {
       Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products"
   } catch {
       Write-Host "An error occurred: $_"
   }
   

6. **Execute a query with Windows Authentication:**
   --powershell
   Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products" -Credential (Get-Credential)
   

7. **Execute a query and store results in a variable:**
   --powershell
   $results = Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products"
   

8. **Execute a query with a timeout:**
   --powershell
   Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products" -QueryTimeout 30
   

9. **Execute a query and format the output:**
   --powershell
   $results = Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products"
   $results | Format-Table -AutoSize
   

10. **Execute a query and filter results in --powershell:**
    --powershell
    $results = Invoke-Sqlcmd -ServerInstance localhost -Database "Northwind" -Query "SELECT * FROM dbo.Products"
    $filteredResults = $results | Where-Object { $_.column_name -eq "value" }
    
