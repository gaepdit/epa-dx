create table AirPermit
(
    ComplianceMonitoringId       varchar(25) not null,
    AirPermitIdentifier          varchar(100),
    CertificationPeriodStartDate date,
    CertificationPeriodEndDate   date,
    constraint PK_AirPermit
        primary key (ComplianceMonitoringId)
            with (fillfactor = 80)
);

