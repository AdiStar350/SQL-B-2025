USE Northwind;
GO

CREATE TABLE Test (
    VINT INT,
    VDT DATETIME
);
GO
  
CREATE OR ALTER PROCEDURE sp_random_insert
AS
BEGIN
    DECLARE @i INT = 30000

    SET NOCOUNT ON

    WHILE @i > 0 BEGIN
        INSERT INTO dbo.Test 
        VALUES (CAST(RAND() * 100000 AS INT), GETDATE() + CAST(RAND() * 100000 AS INT));
        SET @i = @i - 1;
    END
    SET NOCOUNT OFF
END;
GO

EXECUTE dbo.sp_random_insert;
GO
  
SET SHOWPLAN_ALL ON;
GO

SET STATISTICS TIME ON;
GO

-- HEAP | 14ms | PLAN -> HEAP.csv
SELECT * FROM dbo.Test t
WHERE
    t.VINT > 97000 AND
    t.VDT >= '2026-01-01';
GO

  
CREATE CLUSTERED INDEX idx_test_clustered_vint
ON Test(VINT);
GO

-- CLUSTERED VINT | 9ms | PLAN -> CLUSTERED.csv
SELECT * FROM dbo.Test t
WITH (INDEX(idx_test_clustered_vint))
WHERE
    t.VINT > 97000 AND
    t.VDT >= '2026-01-01';
GO
  
DROP INDEX Test.idx_test_clustered_vint;
GO

CREATE NONCLUSTERED INDEX idx_test_nonclustered_vdt
ON Test(VDT);
GO
 
-- NONCLUSTERED VDT | 20ms | PLAN -> NONCLUSTERED_VDT.csv
SELECT * FROM dbo.Test t
WITH (INDEX(idx_test_nonclustered_vdt))
WHERE
    t.VINT > 97000 AND
    t.VDT >= '2026-01-01';
GO

DROP INDEX Test.idx_test_nonclustered_vdt;
GO

CREATE NONCLUSTERED INDEX idx_test_nonclustered_vint
ON Test(VINT);
GO

-- NONCLUSTERED VINT | 20ms | PLAN -> NONCLUSTERED_VINT.csv
SELECT * FROM dbo.Test t
WITH (INDEX(idx_test_nonclustered_vint))
WHERE
    t.VINT > 97000 AND
    t.VDT >= '2026-01-01';
GO

DROP INDEX Test.idx_test_nonclustered_vint;
GO

CREATE CLUSTERED INDEX idx_test_clustered_vint_and_vdt
ON Test(VINT, VDT);
GO

-- CLUSTERED VINT + VDT | 7ms | PLAN -> CLUSTERED_VINT_AND_VDT.csv
SELECT * FROM dbo.Test t
WITH (INDEX(idx_test_clustered_vint_and_vdt))
WHERE
    t.VINT > 97000 AND
    t.VDT >= '2026-01-01';
GO

DROP INDEX Test.idx_test_clustered_vint_and_vdt;
GO

CREATE NONCLUSTERED INDEX idx_test_nonclustered_vint_and_vdt_filtered
ON Test(VINT, VDT)
WHERE
    Test.VINT > 97000 AND
    Test.VDT >= '2026-01-01';
GO

-- NONCLUSTERED VINT + VDT FILTERED | 10ms | PLAN -> NONCLUSTERED_VINT_AND_VDT_FILTERED.csv
SELECT * FROM dbo.Test 
WITH (INDEX(idx_test_nonclustered_vint_and_vdt_filtered))
WHERE
    t.VINT > 97000 AND
    t.VDT >= '2026-01-01';
GO

DROP INDEX Test.idx_test_nonclustered_vint_and_vdt_filtered;
GO

ALTER TABLE dbo.Test
ADD VDT_YEAR AS YEAR(VDT) PERSISTED;
GO

CREATE NONCLUSTERED INDEX idx_test_year_check
ON Test(VDT_YEAR);
GO

-- CLUSTERED VINT, NONCLUSTERED VDT_YEAR | 10ms | PLAN -> CLUSTERED_VINT_NONCLUSTERED_VDT_YEAR.csv
SELECT * FROM dbo.Test t
WHERE
    t.VINT > 97000 AND
    t.VDT_YEAR >= 2026;
GO

DROP INDEX Test.idx_test_year_check;
GO

ALTER TABLE dbo.Test
DROP COLUMN VDT_YEAR;
GO

SET SHOWPLAN_ALL OFF;
GO

SET STATISTICS TIME ON;
GO