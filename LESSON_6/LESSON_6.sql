SELECT *
FROM Northwind.dbo.Categories;
GO

SELECT 
	shit.Textdata, 
	shit.applicationName,
	shit.NTUserName,
	shit.[Duration]
FROM Northwind.dbo.Adi AS shit
WHERE shit.TextData IS NOT NULL 
ORDER BY duration  DESC;
GO