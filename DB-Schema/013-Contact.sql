create table Contact
(
    ContactID                     int identity,
    AffiliationTypeText           varchar(10),
    FirstName                     varchar(20),
    MiddleName                    varchar(20),
    LastName                      varchar(20),
    IndividualTitleText           varchar(50),
    OrganizationFormalName        varchar(50),
    StateCode                     char(2),
    RegionCode                    varchar(10),
    ElectronicAddressText         varchar(50),
    StartDateOfContactAssociation date,
    EndDateOfContactAssociation   date,
    constraint [PK_[Contact]
        primary key (ContactID)
            with (fillfactor = 80)
);

