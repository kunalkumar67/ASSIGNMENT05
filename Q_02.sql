USE msdb;
GO

-- Create a new job
EXEC sp_add_job
    @job_name = N'CopyDataToCSV';

-- Add a step to the job
EXEC sp_add_jobstep
    @job_name = N'CopyDataToCSV',
    @step_name = N'ExportDataToCSV',
    @subsystem = N'TSQL',
    @command = N'
        DECLARE @sqlCommand NVARCHAR(1000)
        DECLARE @filePath NVARCHAR(1000) = ''C:\path\to\output\your_table.csv''
        DECLARE @query NVARCHAR(1000) = ''SELECT * FROM your_table''

        SET @sqlCommand = ''bcp "'' + @query + ''" queryout "'' + @filePath + ''" -c -t, -T -S '' + @@SERVERNAME

        EXEC xp_cmdshell @sqlCommand
    ';

-- Schedule the job to run daily at 2 AM
EXEC sp_add_jobschedule
    @job_name = N'CopyDataToCSV',
    @name = N'DailySchedule',
    @freq_type = 4, -- Daily
    @freq_interval = 1, -- Every day
    @active_start_time = 020000; -- 2 AM

-- Enable the job
EXEC sp_add_jobserver
    @job_name = N'CopyDataToCSV';
GO
