-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[ComplianceMonitoring_Delete_Trigger] 
   ON  [dbo].[ComplianceMonitoring] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,ForeignKey, Operation)
    SELECT 
        i.TransactionID,'ComplianceMonitoring', i.ComplianceMonitoringId,i.MonitoringType, 'delete'
    FROM 
        deleted i
END
;

