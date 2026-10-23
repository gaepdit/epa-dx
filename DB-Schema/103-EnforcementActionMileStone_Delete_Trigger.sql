-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementActionMileStone_Delete_Trigger] 
   ON  [dbo].[EnforcementActionMilestone] 
   AFTER DELETE
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
        i.TransactionID,'EnforcementActionMileStone', i.EnforcementActionId + i.Type, 'delete'
    FROM 
        deleted i
END
;

