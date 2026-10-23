-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementActionMilestone_Insert_Trigger] 
   ON  [dbo].[EnforcementActionMilestone] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementActionMilestone', i.EnforcementActionId + i.Type, 'insert'
    FROM 
        inserted i


END
;

