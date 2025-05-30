USE Northwind;
GO

SELECT *
FROM dbo.[Alphabetical list of products];
GO

SELECT * 
FROM dbo.Invoices;
GO

SELECT *
FROM dbo.[Order Subtotals];
GO

SELECT *
FROM dbo.[Summary of Sales by Year];
GO

EXEC dbo.[Employee Sales by Country] @Beginning_Date = '10-10-2022', @Ending_Date = '05-05-2026';
GO

EXEC dbo.[Ten Most Expensive Products];
GO
