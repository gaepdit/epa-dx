USE AIRBRANCH
GO

CREATE OR ALTER PROCEDURE etl.ICIS_Stage_All
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Process all ICIS-Air data staging

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2016-12-08  DWaldron            Init
2026-02-04  DWaldron            Update with changes for the new Air Web App (epa-dx#2)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    print 'executing etl.ICIS_FACILITY_UPDATE';
    EXEC etl.ICIS_FACILITY_UPDATE;

    print 'executing etl.ICIS_CMS_UPDATE';
    EXEC etl.ICIS_CMS_UPDATE;

    print 'executing AirWeb.etl.ICIS_ComplianceMonitoring_Update';
    EXEC AirWeb.etl.ICIS_ComplianceMonitoring_Update;

    print 'executing AirWeb.etl.ICIS_ComplianceMonitoring_Delete';
    EXEC AirWeb.etl.ICIS_ComplianceMonitoring_Delete;

    print 'executing AirWeb.etl.ICIS_CaseFile_Update';
    EXEC AirWeb.etl.ICIS_CaseFile_Update;

    print 'executing AirWeb.etl.ICIS_CaseFile_Delete';
    EXEC AirWeb.etl.ICIS_CaseFile_Delete;

    print 'executing etl.ICIS_CMS_DELETE';
    EXEC etl.ICIS_CMS_DELETE;

    print 'executing etl.ICIS_POLLUTANT_DELETE';
    EXEC etl.ICIS_POLLUTANT_DELETE;

    print 'executing etl.ICIS_AIRPROGRAM_DELETE';
    EXEC etl.ICIS_AIRPROGRAM_DELETE;

    print 'executing etl.ICIS_FACILITY_DELETE';
    EXEC etl.ICIS_FACILITY_DELETE;

    print 'finished';

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
