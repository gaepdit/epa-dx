create table AirFacility
(
    AirFacilityID                       varchar(20) not null,
    FacilitySiteName                    varchar(80),
    LocationAddressText                 varchar(250),
    SupplementalLocationText            varchar(250),
    GNISCityCode                        varchar(11),
    LocationStateCode                   char(2),
    LocationZipCode                     varchar(11),
    LCONCode                            varchar(10),
    TribalLandCode                      varchar(10),
    FacilityDescription                 varchar(250),
    FacilityTypeOfOwnershipCode         varchar(10),
    RegistrationNumber                  varchar(10),
    SmallBusinessIndicator              char,
    FederallyReportableIndicator        char,
    SourceUniformResourceLocatorURL     varchar(150),
    EnvironmentalJusticeCode            varchar(50),
    FacilityCongressionalDistrictNumber varchar(10),
    FacilityComments                    varchar(500),
    FacilityUserDefinedField1           varchar(100),
    FacilityUserDefinedField2           varchar(100),
    FacilityUserDefinedField3           varchar(100),
    FacilityUserDefinedField4           varchar(100),
    FacilityUserDefinedField5           varchar(100),
    TransactionID                       varchar(50),
    LocalityName                        varchar(60),
    LocationAddressCountyCode           varchar(5),
    constraint PK_AirFacility
        primary key (AirFacilityID)
            with (fillfactor = 80)
);

