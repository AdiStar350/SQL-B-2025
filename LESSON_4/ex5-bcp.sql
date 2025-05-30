### Example 1: Exporting Data from a Table to a File

bcp Northwind.dbo.Products out "C:\Data\ProductsData.txt" -c -T -S localhost

This command exports data from `Products` in `Northwind` to a text file.

### Example 2: Importing Data from a File into a Table

bcp Northwind.dbo.Products in "C:\Data\ProductsData.txt" -c -T -S localhost

This command imports data from a text file into `Products` in `Northwind`.

### Example 3: Exporting Data with a Query

bcp "SELECT * FROM Northwind.dbo.Products WHERE CategoryId = 1" queryout "C:\Data\FilteredData.txt" -c -T -S localhost

This command exports data from a query result to a text file.

### Example 4: Exporting Data in Native Format

bcp Northwind.dbo.Products out "C:\Data\ProductsData.dat" -n -T -S localhost

This command exports data from `Products` in native format.

