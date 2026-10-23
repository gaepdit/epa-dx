create table Subactivity
(
    SubactivityId          int identity,
    ComplianceMonitoringId varchar(25) not null,
    SubactivityTypeCode    varchar(10) not null,
    SubactivityPlannedDate date,
    SubactivityDate        date,
    constraint PK_Subactivity
        primary key (SubactivityId)
            with (fillfactor = 80),
    constraint FK_Subactivity_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

