# Updates needed for epa-dx/issues/2 in order

## `airbranch-db` repo

### DROP script

- `drop-obsolete-objects.sql`

### New objects

- `TG_ICIS_ISMPREPORTINFORMATION`
- `VW_GEOS_FACILITY_MOD_DATE`
- `VW_FACILITY_DATADATES`
- `iaip_facility.FormatAirsNumber`
- `iaip_facility.DbFormatAirsNumber`
- `icis_edt.GetErrors`
- `icis_edt.GetErrorDetail`

## `epa-dx` repo

### Schema

- `etl-schema`

### Functions

- `etl.EpaActionId`
- `etl.EpaFacilityId`

### Views

- `etl.VW_ICIS_ID_REFERENCE`
- `etl.VW_ICIS_CaseFile`
- `etl.VW_ICIS_CaseFileComplianceEvents`
- `etl.VW_ICIS_ComplianceMonitoring_ACC`
- `etl.VW_ICIS_ComplianceMonitoring_FCE`
- `etl.VW_ICIS_ComplianceMonitoring_PCE`
- `etl.VW_ICIS_ComplianceMonitoring_STR`
- `etl.VW_ICIS_FormalEnforcementAction`
- `etl.VW_ICIS_InformalEnforcementAction`
- `etl.VW_ICIS_NoFurtherActionLetters`

### Procedures

- `etl.TriggerDataUpdateAtEPA`
- `etl.ICIS_CaseFile_Delete`
- `etl.ICIS_CaseFile_Update`
- `etl.ICIS_ComplianceMonitoring_Delete`
- `etl.ICIS_ComplianceMonitoring_Update`
- `etl.ICIS_Stage_All`
