create table CSOInspection
(
    CSOInspectionId                      int identity,
    ComplianceMonitoringId               varchar(25) not null,
    DryOrWetWeatherInd                   varchar(5),
    PermittedFeatureId                   varchar(25),
    CSOOverflowLocationStreet            varchar(4000),
    DurationCSOOverflowEvent             varchar(10),
    DischargeVolumeTreated               int,
    DischargeVolumeUntreated             int,
    CorrectiveActionTakenDescriptionText varchar(4000),
    InchesPrecipitation                  varchar(6),
    constraint PK_CSOInspection
        primary key (CSOInspectionId)
            with (fillfactor = 80),
    constraint FK_CSOInspection_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

