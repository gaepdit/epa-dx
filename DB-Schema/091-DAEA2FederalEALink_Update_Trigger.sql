-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2FederalEALink_Update_Trigger] 
   ON  [dbo].[DAEA2FederalEALink] 
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
        i.TransactionID,'DAEA2FederalEALink', i.EnforcementActionId, i.LinkedEAId, 'updete'
    FROM 
        inserted i


END
;

