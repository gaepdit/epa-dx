create table GeographicCoordinate
(
    GeographicCoordinateID         int identity,
    LatitudeMeasure                varchar(15),
    LongitudeMeasure               varchar(15),
    HorizontalAccuracyMeasure      varchar(10),
    GeometricTypeCode              varchar(10),
    HorizontalCollectionMethodCode varchar(10),
    HorizontalReferenceDatumCode   varchar(10),
    ReferencePointCode             varchar(10),
    SourceMapScaleNumber           varchar(10),
    UTMCoordinate1                 varchar(15),
    UTMCoordinate2                 varchar(15),
    UTMCoordinate3                 varchar(15),
    GaAirFacilityID                varchar(20),
    constraint PK_GeographicCoordinate
        primary key (GeographicCoordinateID)
            with (fillfactor = 80)
);

