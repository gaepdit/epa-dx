create table FacilityAddress
(
    FacilityAddressID             int identity,
    AirFacilityID                 varchar(20) not null,
    AffiliationTypeText           varchar(10),
    OrganizationFormalName        varchar(50),
    OrganizationDUNSNumber        varchar(10),
    MailingAddressText            varchar(100),
    SupplementalAddressText       varchar(100),
    MailingAddressCityName        varchar(50),
    MailingAddressStateCode       char(2),
    MailingAddressZipCode         varchar(10),
    CountyName                    varchar(50),
    MailingAddressCountryCode     varchar(20),
    DivisionName                  varchar(20),
    TelephoneNumberTypeCode       varchar(10),
    TelephoneNumber               varchar(15),
    TelephoneExtensionNumber      varchar(5),
    ElectronicAddressText         varchar(50),
    StartDateOfAddressAssociation date,
    EndDateOfAddressAssociation   date,
    LocationProvince              varchar(20),
    constraint PK_FacilityAddress
        primary key (FacilityAddressID)
            with (fillfactor = 80),
    constraint FK_FacilityAddress_AirFacility
        foreign key (AirFacilityID) references AirFacility
);

