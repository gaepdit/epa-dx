create table Citation
(
    CitationId             int identity,
    ComplianceMonitoringId varchar(25) not null,
    CitationTitle          varchar(40) not null,
    CitationPart           varchar(40) not null,
    CitationSection        varchar(100),
    constraint PK_Citation
        primary key (CitationId)
            with (fillfactor = 80),
    constraint FK_Citation_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

