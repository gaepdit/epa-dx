create table CAFOInspection
(
    CAFOInspectionId            int identity,
    ComplianceMonitoringId      varchar(25) not null,
    CAFOClassificationCode      varchar(20),
    IsAnimalFacilityTypeCAFOInd char,
    CAFODesignationDate         date,
    CAFODesignationReasonText   varchar(1000),
    constraint PK_CAFOInspection
        primary key (CAFOInspectionId)
            with (fillfactor = 80),
    constraint FK_CAFOInspection_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

