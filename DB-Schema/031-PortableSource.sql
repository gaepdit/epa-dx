create table PortableSource
(
    PortableSourceID        int identity,
    AirFacilityID           varchar(20) not null,
    PortableSourceIndicator char,
    PortableSourceSiteName  varchar(50),
    PortableSourceStartDate date,
    PortableSourceEndDate   date,
    constraint PK_AirFacility_Portable1
        primary key (PortableSourceID)
            with (fillfactor = 80),
    constraint FK_PortableSource_AirFacility1
        foreign key (AirFacilityID) references AirFacility
);

