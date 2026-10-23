create table SSOInspection
(
    SSOInspectionId           int identity,
    ComplianceMonitoringId    varchar(25) not null,
    CauseSSOOverflowEvent     varchar(1100),
    SSOOverflowLocationStreet varchar(4000),
    DurationSSOOverflowEvent  varchar(8),
    SSOVolume                 int,
    NameReceivingWater        varchar(1000),
    ImpactSSOEvent            varchar(3),
    DescriptionStepsTaken     varchar(4000),
    constraint PK_SSOInspection
        primary key (SSOInspectionId)
            with (fillfactor = 80),
    constraint FK_SSOInspection_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

