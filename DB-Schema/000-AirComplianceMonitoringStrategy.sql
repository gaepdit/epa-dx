create table AirComplianceMonitoringStrategy
(
    ComplianceMonitoringStrategyID int identity,
    AirFacilityId                  varchar(20) not null,
    AirCMSSourceCategoryCode       varchar(10),
    AirCMSMinimumFrequency         int,
    AirCMSStartDate                date,
    AirActiveCMSPlanIndicator      char,
    AirRemovedPlanDate             date,
    Comments                       varchar(500),
    TransactionID                  varchar(50),
    constraint PK_AirComplianceMonitoringStrategy
        primary key (ComplianceMonitoringStrategyID)
            with (fillfactor = 80)
);

