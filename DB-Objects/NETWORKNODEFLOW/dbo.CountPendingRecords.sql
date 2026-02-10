USE NETWORKNODEFLOW
GO

CREATE OR ALTER PROCEDURE dbo.CountPendingRecords
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Count how many records exist pending submittal to ICIS-Air.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-03  DWaldron            Initial version

***************************************************************************************************/

BEGIN
    SET NOCOUNT ON

    select *
    from (select 'GetDeletedCaseFileToCMLink' as [Service],
                 'CaseFile2CMLink'            as [Table],
                 ''                           as [Subtype],
                 'delete'                     as [Operation],
                 1                            as [ScheduleOrder],
                 count(*)                     as [Count]
          FROM [Transaction]
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  And SubmissionStatus.Status is null
                  AND SubmissionStatus.operation = 'delete'
                  AND SubmissionStatus.TableName = 'CaseFile2CMLink'

          union

          select 'GetDeletedCaseFileToDAEALink',
                 'CaseFile2DAEALink',
                 '',
                 'delete',
                 2,
                 count(*)
          FROM [Transaction]
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  And SubmissionStatus.Status is null
                  AND SubmissionStatus.operation = 'delete'
                  AND SubmissionStatus.TableName = 'CaseFile2DAEALink'

          union

          select 'GetDeletedDAFormalEnforcementAction',
                 'EnforcementAction',
                 'DAFormal',
                 'delete',
                 3,
                 count(*)
          FROM DeletedEnforcementAction EnforcementAction
              INNER JOIN [Transaction]
              ON EnforcementAction.TransactionId = [Transaction].TransactionID
                  AND EnforcementAction.Type = 'DAFormal'
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND SubmissionStatus.TableName = 'EnforcementAction'
                  AND SubmissionStatus.ID = EnforcementAction.EnforcementActionId
                  AND SubmissionStatus.Status is NULL
                  AND SubmissionStatus.Operation = 'delete'

          union

          select 'GetDeletedDAInFormalEnforcementAction',
                 'EnforcementAction',
                 'DAInFormal',
                 'delete',
                 4,
                 count(*)
          FROM DeletedEnforcementAction EnforcementAction
              INNER JOIN [Transaction]
              ON EnforcementAction.TransactionId = [Transaction].TransactionID
                  AND EnforcementAction.Type = 'DAInFormal'
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND SubmissionStatus.TableName = 'EnforcementAction'
                  AND SubmissionStatus.ID = EnforcementAction.EnforcementActionId
                  AND SubmissionStatus.Status is NULL
                  AND SubmissionStatus.Operation = 'delete'


          union

          select 'GetDeletedCaseFile',
                 'CaseFile',
                 '',
                 'delete',
                 5,
                 count(*)
          FROM [Transaction]
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND SubmissionStatus.TableName = 'CaseFile'
                  AND SubmissionStatus.Status is NULL
                  AND SubmissionStatus.Operation = 'delete'

          union

          select 'DeleteAgencyComplianceMonitoring',
                 'ComplianceMonitoring',
                 'DA',
                 'delete',
                 6,
                 count(*)
          from SubmissionStatus
              INNER JOIN [Transaction]
              on SubmissionStatus.TransactionID = [Transaction].TransactionID
          where SubmissionStatus.TableName = 'ComplianceMonitoring'
            AND SubmissionStatus.ForeignKey = 'DA'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation = 'delete'

          union

          select 'DeleteTVACC',
                 'ComplianceMonitoring',
                 'TVACC',
                 'delete',
                 7,
                 count(*)
          from SubmissionStatus
              INNER JOIN [Transaction]
              on SubmissionStatus.TransactionID = [Transaction].TransactionID
          where SubmissionStatus.TableName = 'ComplianceMonitoring'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation = 'delete'
            AND SubmissionStatus.ForeignKey = 'TVACC'

          union

          select 'DeleteComplianceMonitoringStrategy',
                 'AirComplianceMonitoringStrategy',
                 '',
                 'delete',
                 8,
                 count(*)
          from SubmissionStatus
              INNER JOIN [Transaction]
              on SubmissionStatus.TransactionID = [Transaction].TransactionID
          where SubmissionStatus.TableName = 'AirComplianceMonitoringStrategy'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation = 'delete'

          union

          select 'DeleteAirPollutant',
                 'AirPollutants',
                 '',
                 'delete',
                 9,
                 count(*)
          from SubmissionStatus
              INNER JOIN [Transaction]
              on SubmissionStatus.TransactionID = [Transaction].TransactionID
          where SubmissionStatus.TableName = 'AirPollutants'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation = 'delete'

          union

          select 'DeleteAirProgram',
                 'AirPrograms',
                 '',
                 'delete',
                 10,
                 count(*)
          from SubmissionStatus
              INNER JOIN [Transaction]
              on SubmissionStatus.TransactionID = [Transaction].TransactionID
          where SubmissionStatus.TableName = 'AirPrograms'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation = 'delete'

          union

          select 'DeleteAirFacility',
                 'AirFacility',
                 '',
                 'delete',
                 11,
                 count(*)
          from SubmissionStatus
              INNER JOIN [Transaction]
              on SubmissionStatus.TransactionID = [Transaction].TransactionID
          where SubmissionStatus.TableName = 'AirFacility'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation = 'delete'

          union

          select 'GetAirFacility',
                 'AirFacility',
                 '',
                 'update',
                 12,
                 count(*)
          FROM AirFacility
              INNER JOIN [Transaction]
              ON AirFacility.TransactionID = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON AirFacility.TransactionID = SubmissionStatus.TransactionID
          WHERE SubmissionStatus.TableName = 'AirFacility'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetAirPollutant',
                 'AirPollutants',
                 '',
                 'update',
                 13,
                 count(*)
          FROM [Transaction]
              INNER JOIN AirPollutants
              ON [Transaction].TransactionID = AirPollutants.TransactionID
              INNER JOIN SubmissionStatus
              ON AirPollutants.TransactionID = SubmissionStatus.TransactionID
          WHERE SubmissionStatus.TableName = 'AirPollutants'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetAirProgram',
                 'AirPrograms',
                 '',
                 'update',
                 14,
                 count(*)
          FROM [Transaction]
              INNER JOIN AirPrograms
              ON [Transaction].TransactionID = AirPrograms.TransactionID
              INNER JOIN SubmissionStatus
              ON AirPrograms.TransactionID = SubmissionStatus.TransactionID
          WHERE SubmissionStatus.TableName = 'AirPrograms'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetComplianceMonitoringStrategy',
                 'AirComplianceMonitoringStrategy',
                 '',
                 'update',
                 15,
                 count(*)
          FROM AirComplianceMonitoringStrategy AS A
              INNER JOIN [Transaction]
              ON A.TransactionID = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON A.AirFacilityID = SubmissionStatus.ID
          WHERE SubmissionStatus.TableName = 'AirComplianceMonitoringStrategy'
            AND SubmissionStatus.Status IS NULL
            AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetAgencyComplianceMonitoring',
                 'ComplianceMonitoring',
                 'DA',
                 'update',
                 16,
                 count(*)
          FROM ComplianceMonitoring C
              INNER JOIN [Transaction]
              ON C.TransactionID = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON C.ComplianceMonitoringId = SubmissionStatus.ID
                  AND C.MonitoringType = 'DA'
                  AND SubmissionStatus.TableName = 'ComplianceMonitoring'
                  AND SubmissionStatus.Status is NULL
                  AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetTVACC',
                 'ComplianceMonitoring',
                 'TVACC',
                 'update',
                 17,
                 count(*)
          FROM ComplianceMonitoring C
              INNER JOIN [Transaction]
              ON C.TransactionID = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON C.ComplianceMonitoringId = SubmissionStatus.ID
          WHERE C.MonitoringType = 'TVACC'
            AND SubmissionStatus.TableName = 'ComplianceMonitoring'
            AND SubmissionStatus.Status is NULL
            AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetCaseFile',
                 'CaseFile',
                 '',
                 'update',
                 18,
                 count(*)
          FROM CaseFile
              inner JOIN [Transaction]
              ON CaseFile.TransactionID = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND SubmissionStatus.ID = CaseFile.CaseFileId
                  AND SubmissionStatus.TableName = 'CaseFile'
                  AND SubmissionStatus.Status IS NULL
                  AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetDAFormalEnforcementAction',
                 'EnforcementAction',
                 'DAFormal',
                 'update',
                 19,
                 count(*)
          FROM EnforcementAction
              INNER JOIN EnforcementActionAirFacility
              ON EnforcementAction.EnforcementActionId = EnforcementActionAirFacility.EnforcementActionId
                  AND EnforcementAction.Type = 'DAFormal'
              INNER JOIN [Transaction]
              ON EnforcementAction.TransactionId = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND EnforcementAction.EnforcementActionId = SubmissionStatus.ID
                  AND SubmissionStatus.TableName = 'EnforcementAction'
                  AND SubmissionStatus.Status IS NULL
                  AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetCasefileToCMLink',
                 'CaseFile2CMLink',
                 '',
                 'update',
                 20,
                 count(*)
          FROM CaseFile2CMLink
              INNER JOIN [Transaction]
              ON CaseFile2CMLink.TransactionId = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON CaseFile2CMLink.CaseFileId = SubmissionStatus.ID
                  And SubmissionStatus.TableName = 'CaseFile2CMLink'
                  And SubmissionStatus.Status is null
                  AND SubmissionStatus.operation <> 'delete'
                  AND [Transaction].TransactionID = SubmissionStatus.TransactionID

          union

          select 'GetDAInFormalEnforcementAction',
                 'EnforcementAction',
                 'DAInFormal',
                 'update',
                 21,
                 count(*)
          FROM EnforcementAction
              INNER JOIN EnforcementActionAirFacility
              ON EnforcementAction.EnforcementActionId = EnforcementActionAirFacility.EnforcementActionId
                  AND EnforcementAction.Type = 'DAInFormal'
              INNER JOIN [Transaction]
              ON EnforcementAction.TransactionId = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND EnforcementAction.EnforcementActionId = SubmissionStatus.ID
                  AND SubmissionStatus.TableName = 'EnforcementAction'
                  AND SubmissionStatus.Status is NULL
                  AND SubmissionStatus.Operation <> 'delete'

          union

          select 'GetCasefileToDAEALink',
                 'CaseFile2DAEALink',
                 '',
                 'update',
                 22,
                 count(*)
          FROM CaseFile2DAEALink
              INNER JOIN [Transaction]
              ON CaseFile2DAEALink.TransactionId = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON CaseFile2DAEALink.CaseFileId = SubmissionStatus.ID
                  And SubmissionStatus.TableName = 'CaseFile2DAEALink'
                  And SubmissionStatus.Status is null
                  AND SubmissionStatus.operation <> 'delete'
                  AND [Transaction].TransactionID = SubmissionStatus.TransactionID

          union

          select 'GetDAEnforcementActionMileStone',
                 'EnforcementActionMilestone',
                 '',
                 'update',
                 23,
                 count(*)
          FROM EnforcementActionMilestone
              INNER JOIN [Transaction]
              ON EnforcementActionMilestone.TransactionId = [Transaction].TransactionID
              INNER JOIN SubmissionStatus
              ON [Transaction].TransactionID = SubmissionStatus.TransactionID
                  AND SubmissionStatus.TableName = 'EnforcementActionMilestone'
                  AND SubmissionStatus.Status IS NULL
                  AND SubmissionStatus.Operation <> 'delete') t
    order by t.ScheduleOrder;

END
GO
