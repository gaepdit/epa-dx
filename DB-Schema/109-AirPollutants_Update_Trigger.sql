-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPollutants_Update_Trigger] 
   ON  [dbo].[AirPollutants] 
   AFTER UPDATE
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
        i.TransactionID,'AirPollutants', i.AirPollutantsCode, i.AirFacilityID, 'update'
    FROM 
        inserted i
END
;

