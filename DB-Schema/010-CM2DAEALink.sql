create table CM2DAEALink
(
    ComplianceMonitoringId varchar(50) not null,
    EnforcementActionId    varchar(50) not null,
    TransactionId          varchar(40),
    constraint PK_CM2DAEALink
        primary key (ComplianceMonitoringId, EnforcementActionId)
            with (fillfactor = 80)
);

