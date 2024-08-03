DECLARE @SourceDB NVARCHAR(50) = 'SourceDatabase'
DECLARE @TargetDB NVARCHAR(50) = 'TargetDatabase'

-- Copying selective columns from Table1
EXEC('
    SELECT col1, col2 INTO ' + @TargetDB + '.dbo.Table1 
    FROM ' + @SourceDB + '.dbo.Table1
')

-- Copying selective columns from Table2
EXEC('
    SELECT col3, col4 INTO ' + @TargetDB + '.dbo.Table2 
    FROM ' + @SourceDB + '.dbo.Table2
')
