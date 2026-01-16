USE NETWORKNODEFLOW;
GO

CREATE OR ALTER PROCEDURE dbo.CountFacilityRecords
    @airs varchar(8)
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Count how many records exist in all NETWORKNODEFLOW tables for a given facility ID.

Input Parameters:
  @airs - The AIRS number in "00100001" format

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2025-07-10  DWaldron            Initial version (copied from airbranch.dbo.CountFacilityRecords 
                                and NETWORKNODEFLOW.dbo.CountFacilityRecords)

***************************************************************************************************/

BEGIN
    SET NOCOUNT ON

    declare @dbairs varchar(12) = concat('0413', @airs);

    select *
    from (select 'dbo.AirComplianceMonitoringStrategy' as [Table],
                 count(*)                              as [Row count]
          from dbo.AirComplianceMonitoringStrategy
          where AirFacilityId = @dbairs
          union

          select 'dbo.AirDAFinalOrderAirFacility',
                 count(*)
          from dbo.AirDAFinalOrderAirFacility
          where AirFacilityId = @dbairs
          union
          select 'dbo.AirFacility',
                 count(*)
          from dbo.AirFacility
          where AirFacilityId = @dbairs
          union
          select 'dbo.AirGeographicCoordinate',
                 count(*)
          from dbo.AirGeographicCoordinate
          where AirFacilityId = @dbairs
          union
          select 'dbo.AirPollutants',
                 count(*)
          from dbo.AirPollutants
          where AirFacilityId = @dbairs
          union
          select 'dbo.AirPrograms',
                 count(*)
          from dbo.AirPrograms
          where AirFacilityId = @dbairs
          union
          select 'dbo.CaseFile',
                 count(*)
          from dbo.CaseFile
          where AirFacilityId = @dbairs
          union
          select 'dbo.ComplianceMonitoring',
                 count(*)
          from dbo.ComplianceMonitoring
          where AirFacilityId = @dbairs
          union
          select 'dbo.EnforcementActionAirFacility',
                 count(*)
          from dbo.EnforcementActionAirFacility
          where AirFacilityId = @dbairs
          union
          select 'dbo.FacilityAddress',
                 count(*)
          from dbo.FacilityAddress
          where AirFacilityId = @dbairs
          union
          select 'dbo.FacilityContact',
                 count(*)
          from dbo.FacilityContact
          where AirFacilityId = @dbairs
          union
          select 'dbo.NAICS',
                 count(*)
          from dbo.NAICS
          where AirFacilityId = @dbairs
          union
          select 'dbo.PortableSource',
                 count(*)
          from dbo.PortableSource
          where AirFacilityId = @dbairs
          union
          select 'dbo.SIC',
                 count(*)
          from dbo.SIC
          where AirFacilityId = @dbairs
          union
          select 'dbo.UniverseIndicator',
                 count(*)
          from dbo.UniverseIndicator
          where AirFacilityId = @dbairs) t
    where [Row count] > 0
    order by t.[Table];

END
GO
