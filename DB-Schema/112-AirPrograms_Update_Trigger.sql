-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPrograms_Update_Trigger] 
   ON  [dbo].[AirPrograms] 
   AFTER UPDATE
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
        i.TransactionID,'AirPrograms', i.AirProgramCode, i.AirFacilityID, 'update'
    FROM 
        inserted i
END
;

