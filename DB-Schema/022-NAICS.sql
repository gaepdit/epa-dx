create table NAICS
(
    NAICSId                   int identity,
    NAICSCode                 varchar(10) not null,
    NAICSPrimaryIndicatorCode char,
    AirFacilityID             varchar(20),
    ComplianceMonitoringId    varchar(25),
    constraint PK_NAIC
        primary key (NAICSId)
            with (fillfactor = 80)
);

