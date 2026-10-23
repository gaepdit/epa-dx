create table SIC
(
    SICId                   int identity,
    SICCode                 varchar(10),
    SICPrimaryIndicatorCode char,
    AirFacilityID           varchar(20),
    ComplianceMonitoringId  varchar(25),
    constraint PK_SIC
        primary key (SICId)
            with (fillfactor = 80)
);

