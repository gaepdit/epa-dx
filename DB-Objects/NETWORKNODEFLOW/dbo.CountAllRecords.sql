USE NETWORKNODEFLOW
GO

CREATE OR ALTER PROCEDURE dbo.CountAllRecords
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Count how many records exist in all tables.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2023-09-07  DWaldron            Initial version (copied from airbranch.dbo.CountFacilityRecords)

***************************************************************************************************/

BEGIN
    SET NOCOUNT ON

    select *
    from (select 'dbo.AirComplianceMonitoringStrategy' as [Table],
                 count(*)                              as [Row count]
          from dbo.AirComplianceMonitoringStrategy
          union
          select 'dbo.AirDAFinalOrder',
                 count(*)
          from dbo.AirDAFinalOrder
          union
          select 'dbo.AirDAFinalOrderAirFacility',
                 count(*)
          from dbo.AirDAFinalOrderAirFacility
          union
          select 'dbo.AirFacility',
                 count(*)
          from dbo.AirFacility
          union
          select 'dbo.AirGeographicCoordinate',
                 count(*)
          from dbo.AirGeographicCoordinate
          union
          select 'dbo.AirPermit',
                 count(*)
          from dbo.AirPermit
          union
          select 'dbo.AirPollutants',
                 count(*)
          from dbo.AirPollutants
          union
          select 'dbo.AirPrograms',
                 count(*)
          from dbo.AirPrograms
          union
          select 'dbo.AirProgramSubpart',
                 count(*)
          from dbo.AirProgramSubpart
          union
          select 'dbo.AirStackTestData',
                 count(*)
          from dbo.AirStackTestData
          union
          select 'dbo.AIRVIOLATIONDATA',
                 count(*)
          from dbo.AIRVIOLATIONDATA
          union
          select 'dbo.CAFOInspection',
                 count(*)
          from dbo.CAFOInspection
          union
          select 'dbo.CaseFile',
                 count(*)
          from dbo.CaseFile
          union
          select 'dbo.CaseFile2CaseFileLink',
                 count(*)
          from dbo.CaseFile2CaseFileLink
          union
          select 'dbo.CaseFile2CMLink',
                 count(*)
          from dbo.CaseFile2CMLink
          union
          select 'dbo.CaseFile2DAEALink',
                 count(*)
          from dbo.CaseFile2DAEALink
          union
          select 'dbo.CaseFile2FederalEALink',
                 count(*)
          from dbo.CaseFile2FederalEALink
          union
          select 'dbo.CASEFILECODE',
                 count(*)
          from dbo.CASEFILECODE
          union
          select 'dbo.CaseFileComment',
                 count(*)
          from dbo.CaseFileComment
          union
          select 'dbo.Citation',
                 count(*)
          from dbo.Citation
          union
          select 'dbo.CM2CMLink',
                 count(*)
          from dbo.CM2CMLink
          union
          select 'dbo.CM2DAEALink',
                 count(*)
          from dbo.CM2DAEALink
          union
          select 'dbo.CM2FederalEALink',
                 count(*)
          from dbo.CM2FederalEALink
          union
          select 'dbo.ComplianceMonitoring',
                 count(*)
          from dbo.ComplianceMonitoring
          union
          select 'dbo.ComplianceMonitoringCode',
                 count(*)
          from dbo.ComplianceMonitoringCode
          union
          select 'dbo.ComplianceMonitoringComment',
                 count(*)
          from dbo.ComplianceMonitoringComment
          union
          select 'dbo.ComplianceMonitoringContact',
                 count(*)
          from dbo.ComplianceMonitoringContact
          union
          select 'dbo.Contact',
                 count(*)
          from dbo.Contact
          union
          select 'dbo.CSOInspectioGeographicCoordinate',
                 count(*)
          from dbo.CSOInspectioGeographicCoordinate
          union
          select 'dbo.CSOInspection',
                 count(*)
          from dbo.CSOInspection
          union
          select 'dbo.DAEA2DAEALink',
                 count(*)
          from dbo.DAEA2DAEALink
          union
          select 'dbo.DAEA2FederalEALink',
                 count(*)
          from dbo.DAEA2FederalEALink
          union
          select 'dbo.DeletedEnforcementAction',
                 count(*)
          from dbo.DeletedEnforcementAction
          union
          select 'dbo.EAComment',
                 count(*)
          from dbo.EAComment
          union
          select 'dbo.EAGovernmentContact',
                 count(*)
          from dbo.EAGovernmentContact
          union
          select 'dbo.EnforcementAction',
                 count(*)
          from dbo.EnforcementAction
          union
          select 'dbo.EnforcementActionAirFacility',
                 count(*)
          from dbo.EnforcementActionAirFacility
          union
          select 'dbo.ENFORCEMENTACTIONCODE',
                 count(*)
          from dbo.ENFORCEMENTACTIONCODE
          union
          select 'dbo.EnforcementActionMilestone',
                 count(*)
          from dbo.EnforcementActionMilestone
          union
          select 'dbo.FacilityAddress',
                 count(*)
          from dbo.FacilityAddress
          union
          select 'dbo.FacilityContact',
                 count(*)
          from dbo.FacilityContact
          union
          select 'dbo.GeographicCoordinate',
                 count(*)
          from dbo.GeographicCoordinate
          union
          select 'dbo.InspectionConclusion',
                 count(*)
          from dbo.InspectionConclusion
          union
          select 'dbo.InspectionConclusionCode',
                 count(*)
          from dbo.InspectionConclusionCode
          union
          select 'dbo.InspectionGovernmentContact',
                 count(*)
          from dbo.InspectionGovernmentContact
          union
          select 'dbo.NAICS',
                 count(*)
          from dbo.NAICS
          union
          select 'dbo.OTHERPATHWAYACTIVITYDATA',
                 count(*)
          from dbo.OTHERPATHWAYACTIVITYDATA
          union
          select 'dbo.PortableSource',
                 count(*)
          from dbo.PortableSource
          union
          select 'dbo.Pretreatment',
                 count(*)
          from dbo.Pretreatment
          union
          select 'dbo.SIC',
                 count(*)
          from dbo.SIC
          union
          select 'dbo.SSOInspection',
                 count(*)
          from dbo.SSOInspection
          union
          select 'dbo.SSOInspectionGeographicCoordinate',
                 count(*)
          from dbo.SSOInspectionGeographicCoordinate
          union
          select 'dbo.SSOStep',
                 count(*)
          from dbo.SSOStep
          union
          select 'dbo.SSOSystemComponent',
                 count(*)
          from dbo.SSOSystemComponent
          union
          select 'dbo.StormWaterConstructionInspection',
                 count(*)
          from dbo.StormWaterConstructionInspection
          union
          select 'dbo.StormWaterMS4Inspection',
                 count(*)
          from dbo.StormWaterMS4Inspection
          union
          select 'dbo.Subactivity',
                 count(*)
          from dbo.Subactivity
          union
          select 'dbo.SubmissionStatus',
                 count(*)
          from dbo.SubmissionStatus
          union
          select 'dbo.sysdiagrams',
                 count(*)
          from dbo.sysdiagrams
          union
          select 'dbo.Telephone',
                 count(*)
          from dbo.Telephone
          union
          select 'dbo.TestResultsData',
                 count(*)
          from dbo.TestResultsData
          union
          select 'dbo.Transaction',
                 count(*)
          from dbo.[Transaction]
          union
          select 'dbo.TVACCReviewData',
                 count(*)
          from dbo.TVACCReviewData
          union
          select 'dbo.UniverseIndicator',
                 count(*)
          from dbo.UniverseIndicator) t
    order by t.[Table]

END
GO
