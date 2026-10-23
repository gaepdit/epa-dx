create table AirGeographicCoordinate
(
    AirFacilityID          varchar(20) not null,
    GeographicCoordinateID int         not null,
    constraint PK_AirGeographicCoordinate
        primary key (AirFacilityID, GeographicCoordinateID)
            with (fillfactor = 80),
    constraint FK_AirGeographicCoordinate_AirFacility
        foreign key (AirFacilityID) references AirFacility,
    constraint FK_AirGeographicCoordinate_GeographicCoordinate
        foreign key (GeographicCoordinateID) references GeographicCoordinate
);

