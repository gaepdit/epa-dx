create table ComplianceMonitoringCode
(
    ComplianceMonitoringCodeId int identity,
    ComplianceMonitoringId     varchar(25) not null,
    CodeName                   varchar(50) not null,
    CodeValue                  varchar(20) not null,
    constraint PK_ComplianceMonitoringCode
        primary key (ComplianceMonitoringCodeId)
            with (fillfactor = 80),
    constraint FK_ComplianceMonitoringCode_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
            on delete cascade
);

