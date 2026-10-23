-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirComplianceMonitoringStrategy_Update_Trigger] 
   ON  [dbo].[AirComplianceMonitoringStrategy] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,Operation)
    SELECT 
        i.TransactionID,'AirComplianceMonitoringStrategy', i.AirFacilityId, 'update'
    FROM  inserted i
END
;

