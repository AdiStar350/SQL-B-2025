SELECT CAST(
	CAST((
		SELECT cntr_value
		FROM sys.dm_os_performance_counters
		WHERE counter_name = 'Buffer cache hit ratio'
		AND object_name LIKE '%:Buffer Manager%'
	) AS FLOAT)
	/
	(
		SELECT cntr_value
		FROM sys.dm_os_performance_counters
		WHERE counter_name = 'Buffer cache hit ratio base'
		AND object_name LIKE '%:Buffer Manager%'
	) * 100 AS INT
) AS [Buffer Cache Hit Ratio %];
GO
