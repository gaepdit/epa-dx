create table InspectionGovernmentContact
(
    ComplianceMonitoringId varchar(25) not null,
    ContactId              int         not null,
    constraint PK_InspectionGovernmentContact
        primary key (ComplianceMonitoringId, ContactId)
            with (fillfactor = 80)
);

