
-- Count unprocessed data by VES service

select t.[VES Service],
       count(*) as [Count]
from (select case
                 when s.TableName = 'ComplianceMonitoring'
                     AND left(s.ForeignKey, 5) = 'DA'
                     AND s.Operation = 'delete'
                     then '06 DeleteAgencyComplianceMonitoring'
                 when s.TableName = 'AirFacility'
                     AND s.Operation = 'delete'
                     then '11 DeleteAirFacility'
                 when s.TableName = 'AirPollutants'
                     AND s.Operation = 'delete'
                     then '09 DeleteAirPollutant'
                 when s.TableName = 'AirPrograms'
                     AND s.Operation = 'delete'
                     then '10 DeleteAirProgram'
                 when s.TableName = 'AirComplianceMonitoringStrategy'
                     AND s.Operation = 'delete'
                     then '08 DeleteComplianceMonitoringStrategy'
                 when s.TableName = 'ComplianceMonitoring'
                     AND left(s.ForeignKey, 5) = 'TVACC'
                     AND s.Operation = 'delete'
                     then '07 DeleteTVACC'
                 when s.TableName = 'ComplianceMonitoring'
                     AND s.Operation <> 'delete'
                     AND c.MonitoringType = 'DA'
                     then '16 GetAgencyComplianceMonitoring'
                 when s.TableName = 'AirFacility'
                     AND s.Operation <> 'delete'
                     then '12 GetAirFacility'
                 when s.TableName = 'AirPollutants'
                     AND s.Operation <> 'delete'
                     then '13 GetAirPollutant'
                 when s.TableName = 'AirPrograms'
                     AND s.Operation <> 'delete'
                     then '14 GetAirProgram'
                 when s.TableName = 'CaseFile'
                     AND s.Operation <> 'delete'
                     then '18 GetCaseFile'
                 when s.TableName = 'CaseFile2CMLink'
                     AND s.operation <> 'delete'
                     then '20 GetCasefileToCMLink'
                 when s.TableName = 'CaseFile2DAEALink'
                     AND s.operation <> 'delete'
                     then '22 GetCasefileToDAEALink'
                 when s.TableName = 'AirComplianceMonitoringStrategy'
                     AND s.Operation <> 'delete'
                     then '15 GetComplianceMonitoringStrategy'
                 when s.TableName = 'EnforcementActionMilestone'
                     AND s.Operation <> 'delete'
                     then '23 GetDAEnforcementActionMileStone'
                 when s.TableName = 'EnforcementAction'
                     AND s.Operation <> 'delete'
                     AND e.Type = 'DAFormal'
                     then '19 GetDAFormalEnforcementAction'
                 when s.TableName = 'EnforcementAction'
                     AND s.Operation <> 'delete'
                     AND e.Type = 'DAInFormal'
                     then '21 GetDAInFormalEnforcementAction'
                 when s.TableName = 'CaseFile'
                     AND s.Operation = 'delete'
                     then '05 GetDeletedCaseFile'
                 when s.TableName = 'CaseFile2CMLink'
                     AND s.operation = 'delete'
                     then '01 GetDeletedCaseFileToCMLink'
                 when s.TableName = 'CaseFile2DAEALink'
                     AND s.operation = 'delete'
                     then '02 GetDeletedCaseFileToDAEALink'
                 when s.TableName = 'EnforcementAction'
                     AND s.Operation = 'delete'
                     AND e.Type = 'DAFormal'
                     then '03 GetDeletedDAFormalEnforcementAction'
                 when s.TableName = 'EnforcementAction'
                     AND s.Operation = 'delete'
                     AND e.Type = 'DAInFormal'
                     then '04 GetDeletedDAInFormalEnforcementAction'
                 when c.MonitoringType = 'TVACC'
                     AND s.TableName = 'ComplianceMonitoring'
                     AND s.Operation <> 'delete'
                     then '17 GetTVACC'
             end as [VES Service]
      from NETWORKNODEFLOW.dbo.SubmissionStatus s
          left join NETWORKNODEFLOW.dbo.ComplianceMonitoring c
          on c.ComplianceMonitoringId = s.ID
          left join NETWORKNODEFLOW.dbo.EnforcementAction e
          on e.EnforcementActionId = s.ID
      where s.Status is null) t
group by t.[VES Service]
order by t.[VES Service];

select count(*) as Count,
       s.TableName,
       iif(s.foreignkey is null, null,'Yes') as [ForeignKey exists],
       s.Operation,
       e.Type,
       c.MonitoringType
from NETWORKNODEFLOW.dbo.SubmissionStatus s
    left join NETWORKNODEFLOW.dbo.ComplianceMonitoring c
    on c.ComplianceMonitoringId = s.ID
    left join NETWORKNODEFLOW.dbo.EnforcementAction e
    on e.EnforcementActionId = s.ID
where s.Status is null
group by s.TableName, iif(s.foreignkey is null, null, 'Yes'), s.Operation, e.Type, c.MonitoringType
order by s.TableName, iif(s.foreignkey is null, null, 'Yes'), s.Operation, e.Type, c.MonitoringType
