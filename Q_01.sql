-- Ensure you have the necessary permissions to write to the file system

-- Exporting data to CSV using BCP
DECLARE @sqlCommand NVARCHAR(1000)
DECLARE @filePath NVARCHAR(1000) = 'C:\path\to\output\your_table.csv'
DECLARE @query NVARCHAR(1000) = 'SELECT * FROM your_table'

SET @sqlCommand = 'bcp "' + @query + '" queryout "' + @filePath + '" -c -t, -T -S ' + @@SERVERNAME

EXEC xp_cmdshell @sqlCommand