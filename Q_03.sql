DECLARE @SourceDB NVARCHAR(50) = 'SourceDatabase'
DECLARE @TargetDB NVARCHAR(50) = 'TargetDatabase'

DECLARE @TableName NVARCHAR(255)

DECLARE TableCursor CURSOR FOR
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' 
  AND TABLE_CATALOG = @SourceDB

OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('
        SELECT * INTO ' + @TargetDB + '.dbo.' + @TableName + ' 
        FROM ' + @SourceDB + '.dbo.' + @TableName
    )

    FETCH NEXT FROM TableCursor INTO @TableName
END

CLOSE TableCursor
DEALLOCATE TableCursor