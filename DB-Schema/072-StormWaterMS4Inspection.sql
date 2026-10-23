create table StormWaterMS4Inspection
(
    StormWaterMS4InspectionId          int identity,
    ComplianceMonitoringId             varchar(25) not null,
    LegalEntityTypeCode                varchar(5),
    MS4PermitClassCode                 varchar(5),
    MS4TypeCode                        varchar(5),
    MS4AcreageCoveredNumber            int,
    MS4PopulationServedNumber          int,
    UrbanizedAreaIncorporatedPlaceName varchar(50),
    constraint PK_StormWaterMS4Inspection
        primary key (StormWaterMS4InspectionId)
            with (fillfactor = 80),
    constraint FK_StormWaterMS4Inspection_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

