USE AIRBRANCH
GO

CREATE OR ALTER PROCEDURE etl.TriggerDataUpdateAtEPA
    @AirsNumber varchar(max)
AS

/**************************************************************************************************

Author:       Doug Waldron
Overview:     Triggers a push of all APB data to EPA's ICIS-Air

Input Parameters:
    @AirsNumber - The facility AIRS number

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-09-16  DWaldron            Migrated to SQL Server
2026-01-16  DWaldron            Updated for new Air Web app (epa-dx#2)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    declare @FormattedAirs varchar(9) = iaip_facility.FormatAirsNumber(@AirsNumber)

    BEGIN TRANSACTION;

    UPDATE dbo.APBFACILITYINFORMATION SET ICIS_STATUSIND = 'U' WHERE STRAIRSNUMBER = @AirsNumber;

    UPDATE dbo.APBHEADERDATA SET ICIS_STATUSIND = 'U' WHERE STRAIRSNUMBER = @AirsNumber;

    UPDATE dbo.APBSUPPLAMENTALDATA SET ICIS_STATUSIND = 'U' WHERE STRAIRSNUMBER = @AirsNumber;

    update AirWeb.dbo.ComplianceWork
    set DataExchangeStatus = 'U'
    where FacilityId = @FormattedAirs
      and IsComplianceEvent = 1;

    update AirWeb.dbo.Fces set DataExchangeStatus = 'U' where FacilityId = @FormattedAirs;

    update AirWeb.dbo.CaseFiles set DataExchangeStatus = 'U' where FacilityId = @FormattedAirs;

    update e
    set DataExchangeStatus = 'U'
    from AirWeb.dbo.EnforcementActions e
        inner join AirWeb.dbo.CaseFiles c
            on c.Id = e.CaseFileId
    where c.FacilityId = @FormattedAirs
      and e.IsReportableAction = 1;

    COMMIT TRANSACTION;

    RETURN 0;
END TRY
BEGIN CATCH
    IF @@trancount > 0
        ROLLBACK TRANSACTION;
    DECLARE
        @ErrorMessage nvarchar(4000) = ERROR_MESSAGE(),
        @ErrorSeverity int = ERROR_SEVERITY();
    RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
    RETURN -1;
END CATCH
GO
