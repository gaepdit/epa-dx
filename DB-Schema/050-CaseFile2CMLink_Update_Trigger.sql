-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[CaseFile2CMLink_Update_Trigger] 
   ON  [dbo].[CaseFile2CMLink] 
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
        i.TransactionID,'CaseFile2CMLink', i.CaseFileId, i.ComplianceMonitoringId, 'update'
    FROM 
        inserted i


END
;

