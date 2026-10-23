create table UniverseIndicator
(
    UniverseIndicatorId   int identity,
    UniverseIndicatorCode varchar(10) not null,
    AirFacilityID         varchar(20),
    constraint PK_UniversityIndicator
        primary key (UniverseIndicatorId)
            with (fillfactor = 80)
);

