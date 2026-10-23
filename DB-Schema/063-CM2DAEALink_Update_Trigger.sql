-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2DAEALink_Update_Trigger] 
   ON  [dbo].[CM2DAEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2DAEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'update'
    FROM 
        inserted i


END
;

