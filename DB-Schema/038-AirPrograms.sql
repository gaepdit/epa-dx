create table AirPrograms
(
    AirProgramID                       int identity,
    AirFacilityID                      varchar(20) not null,
    AirProgramCode                     varchar(10),
    OtherAirProgramText                varchar(50),
    AirProgramOperatingStatusCode      varchar(10),
    AirProgramOperatingStatusStartDate date,
    TransactionID                      varchar(50),
    constraint PK_AirPrograms_1
        primary key (AirProgramID)
            with (fillfactor = 80),
    constraint FK_AirPrograms_AirFacility
        foreign key (AirFacilityID) references AirFacility
);

