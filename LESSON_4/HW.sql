SELECT *
INTO TEST_IMP.dbo.Orders
FROM Northwind.dbo.Orders
WHERE 1 = 0;
GO

SELECT *
INTO TEST_IMP.dbo.Products
FROM Northwind.dbo.Products
WHERE 1 = 0;
GO

USE TEST_IMP;
GO

USE TEST_IMP;
GO

BULK INSERT dbo.Orders
FROM 'C:\data\orders_export.txt'
WITH (
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\r\n'
);
GO