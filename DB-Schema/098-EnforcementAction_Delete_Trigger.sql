-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementAction_Delete_Trigger] 
   ON  [dbo].[EnforcementAction] 
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
        i.TransactionID,'EnforcementAction', i.EnforcementActionId, 'delete'
    FROM 
        deleted i

	-- insert to deleted record
	INSERT [dbo].[DeletedEnforcementAction]
           ([EnforcementActionId],[ReasonDeletingRecord],[Type],[DeletedTimeStamp],[TransactionId])
    SELECT
           i.EnforcementActionId,'Data Entry Error',i.Type,GETDATE(),i.TransactionID
	FROM 
        deleted i

END
;

