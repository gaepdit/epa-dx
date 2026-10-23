create table CSOInspectioGeographicCoordinate
(
    CSOInspectionId        int not null,
    GeographicCoordinateID int not null,
    constraint PK_CSOInspectioGeographicCoordinate
        primary key (CSOInspectionId, GeographicCoordinateID)
            with (fillfactor = 80),
    constraint FK_CSOInspectioGeographicCoordinate_CSOInspection
        foreign key (CSOInspectionId) references CSOInspection,
    constraint FK_CSOInspectioGeographicCoordinate_GeographicCoordinate
        foreign key (GeographicCoordinateID) references GeographicCoordinate
);

