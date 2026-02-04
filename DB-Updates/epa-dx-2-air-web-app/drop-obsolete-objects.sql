-- Triggers
begin
    use AIRBRANCH;
    drop trigger dbo.TG_AFS_FCE;
    drop trigger dbo.TG_ICIS_SSCPACCS;
    drop trigger dbo.TG_ICIS_SSCPFCE;
    drop trigger dbo.TG_ICIS_SSCPFCEMASTER;
    drop trigger dbo.TG_ICIS_SSCPINSPECTIONS;
    drop trigger dbo.TG_ICIS_SSCPITEMMASTER;
    drop trigger dbo.TG_SSCPITEMMASTER_DEL;
    drop trigger dbo.TG_ICIS_SSCPTESTREPORTS;
    drop trigger dbo.TG_ICIS_ISMPREPORTINFORMATION;
    drop trigger dbo.TG_ICIS_CASEFILE;
    drop trigger dbo.TG_SSCP_AUDITEDENFORCEMENT;
    drop trigger dbo.TG_SSCP_EnforcementEvents_DEL;
    drop trigger dbo.TG_ICIS_CASEFILE_CODES;
    drop trigger dbo.TG_SSCPFCEMASTER_DEL;

end

-- Procedures
begin
    use AIRBRANCH;
    drop procedure etl.ICIS_CASEFILE_DELETE;
    drop procedure etl.ICIS_CASEFILE_UPDATE;
    drop procedure etl.ICIS_CF2CM_DELETE;
    drop procedure etl.ICIS_CM_DELETE;
    drop procedure etl.ICIS_CM_UPDATE;
    drop procedure etl.ICIS_EAMILESTONE_DELETE;
end

-- Views
begin
    use AIRBRANCH;
    drop view dbo.VW_ICIS_AIRFACILITY;
    drop view dbo.VW_ICIS_CASEFILE;
    drop view dbo.VW_ICIS_COMPLIANCEMONITORING;
    drop view dbo.VW_ICIS_ENFORCEMENTACTION;
    drop view dbo.VW_ICIS_ID_REFERENCE;
end

-- Functions
begin
    use AIRBRANCH;
    drop function etl.FormatEpaAirComplianceId
    drop function etl.FormatEpaAirFacilityId
end
