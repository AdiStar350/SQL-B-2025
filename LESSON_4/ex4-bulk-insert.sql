
### Example 1: Basic Bulk Insert from a Text File

BULK INSERT Northwind.dbo.Prods
FROM 'C:\Data\Prods.CSV'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

This command imports data from a comma-separated text file into `Prods`.


### Example 2: Bulk Insert with Error Handling

BULK INSERT Northwind.dbo.Prods
FROM 'C:\Data\Prods.CSV'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    ERRORFILE = 'C:\Data\ErrorFile.txt',
    MAXERRORS = 10
);

This command specifies an error file and allows up to 10 errors before the operation is stopped.

### Example 3: Bulk Insert with Data File in a Different Code Page

BULK INSERT Northwind.dbo.Prods
FROM 'C:\Data\Prods.CSV'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = 'ACP'
);

This command imports data from a file using the ANSI/Microsoft Windows code page.

### Example 4: Bulk Insert with First Row and Last Row Options

BULK INSERT Northwind.dbo.Prods
FROM 'C:\Data\Prods.CSV'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    LASTROW = 20
);

This command imports data starting from the second row and ending at the 20th row.

 there a specific scenario you're working on with `BULK INSERT`?