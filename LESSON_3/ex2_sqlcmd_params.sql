
sqlcmd -S localhost -E -Q "SELECT * FROM Northwind.dbo.Products WHERE productId = $(prod) OR unitprice = $(price)" -v prod="5" price="10"


In this example:
- `$(param1)` and `$(param2)` are placeholders for the parameters.
- `-v param1="value1" param2="value2"` assigns values to these parameters.

