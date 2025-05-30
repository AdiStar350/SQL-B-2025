SELECT 
    s.session_id,
    s.login_name,
    r.status,
    r.command,
    r.cpu_time,
    r.total_elapsed_time
FROM sys.dm_exec_sessions s
JOIN sys.dm_exec_requests r
ON s.session_id = r.session_id;
GO
