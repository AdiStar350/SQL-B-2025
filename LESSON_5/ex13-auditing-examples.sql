
### Step 1: Create a Server Audit
First, create a server audit object. This object defines where the audit logs will be stored.

-- Create a server audit
CREATE SERVER AUDIT MyServerAudit
TO FILE (FILEPATH = 'C:\SQLServerAuditLogs\MyServerAuditFile')
WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);
GO

### Step 2: Create a Server Audit Specification
Next, create a server audit specification. This specification defines which server-level actions to audit.

-- Create a server audit specification
CREATE SERVER AUDIT SPECIFICATION MyServerAuditSpecification
FOR SERVER AUDIT MyServerAudit
ADD (FAILED_LOGIN_GROUP),
ADD (SUCCESSFUL_LOGIN_GROUP);
GO

### Step 3: Enable the Server Audit and Specification
Enable the server audit and the server audit specification to start capturing the specified events.

-- Enable the server audit
ALTER SERVER AUDIT MyServerAudit
WITH (STATE = ON);
GO

-- Enable the server audit specification
ALTER SERVER AUDIT SPECIFICATION MyServerAuditSpecification
WITH (STATE = ON);
GO


SELECT *
FROM sys.fn_get_audit_file(
    'C:\SQLServerAuditLogs\MyServerAuditFile\MyServerAudit_53E03E0D-2999-4CB4-B930-69676E267684_0_133887505783050000.sqlaudit',
    DEFAULT,
    DEFAULT
);
GO

### Step 4: Create a Database Audit Specification
Create a database audit specification to define which database-level actions to audit.

-- Create a database audit specification
USE Northwind;
GO
CREATE DATABASE AUDIT SPECIFICATION MyDatabaseAuditSpecification
FOR SERVER AUDIT MyServerAudit
ADD (SELECT ON SCHEMA::dbo BY PUBLIC),
ADD (INSERT ON SCHEMA::dbo BY PUBLIC);
GO

### Step 5: Enable the Database Audit Specification
Enable the database audit specification to start capturing the specified events.

-- Enable the database audit specification
ALTER DATABASE AUDIT SPECIFICATION MyDatabaseAuditSpecification
WITH (STATE = ON);
GO

### Explanation of Options:
- **CREATE SERVER AUDIT**: Defines the audit and specifies the file path for storing audit logs.
- **QUEUE_DELAY**: Specifies the delay in milliseconds before audit actions are processed.
- **ON_FAILURE**: Specifies the action to take if the audit fails (e.g., CONTINUE).
- **CREATE SERVER AUDIT SPECIFICATION**: Defines the server-level actions to audit (e.g., login attempts).
- **CREATE DATABASE AUDIT SPECIFICATION**: Defines the database-level actions to audit (e.g., SELECT and INSERT operations).
- **ALTER ... WITH (STATE = ON)**: Enables the audit and audit specifications.
://www.mssqltips.com/sqlservertip/8021/create-custom-audit-specifications-using-sql-server-audit/): [Create Custom Audit Specifications using SQL Server Audit](https://www.mssqltips.com/sqlservertip/8021/create-custom-audit-specifications-using-sql-server-audit/)