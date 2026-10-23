create table TVACCReviewData
(
    TVACCReviewDataId                 int identity,
    TVACCReviewedDate                 date not null,
    FacilityReportDeviationsIndicator char,
    PermitConditionsText              varchar(250),
    ExceedanceExcursionIndicator      char,
    ReviewerAgencyCode                varchar(10),
    TVACCReviewerName                 varchar(100),
    ReviewerComment                   varchar(500),
    ComplianceMonitoringId            varchar(25),
    constraint PK_TVACCReviewData
        primary key (TVACCReviewDataId)
            with (fillfactor = 80),
    constraint FK_TVACCReviewData_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
            on delete cascade
);

