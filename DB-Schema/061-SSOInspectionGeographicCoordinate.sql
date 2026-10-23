create table SSOInspectionGeographicCoordinate
(
    SSOInspectionId        int not null,
    GeographicCoordinateID int not null,
    constraint PK_SSOInspectionGeographicCoordinate
        primary key (SSOInspectionId, GeographicCoordinateID)
            with (fillfactor = 80),
    constraint FK_SSOInspectionGeographicCoordinate_GeographicCoordinate
        foreign key (GeographicCoordinateID) references GeographicCoordinate,
    constraint FK_SSOInspectionGeographicCoordinate_SSOInspection
        foreign key (SSOInspectionId) references SSOInspection
);

