create table StormWaterConstructionInspection
(
    StormWaterConstructionInspectionId int identity,
    ComplianceMonitoringId             varchar(25) not null,
    ProjectTypeCode                    varchar(20),
    ProjectTypeCodeOtherDescription    varchar(1000),
    EstimatedStartDate                 date,
    EstimatedCompleteDate              date,
    EstimatedAreaDisturbedAcresNumber  int,
    ProjectPlanSizeCode                varchar(5),
    constraint PK_StormWaterConstructionInspection
        primary key (StormWaterConstructionInspectionId)
            with (fillfactor = 80),
    constraint FK_StormWaterConstructionInspection_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

