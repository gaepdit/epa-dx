create table FacilityContact
(
    AirFacilityId varchar(20) not null,
    ContactId     int         not null,
    constraint PK_FacilityContact
        primary key (AirFacilityId, ContactId)
            with (fillfactor = 80),
    constraint FK_FacilityContact_AirFacility
        foreign key (AirFacilityId) references AirFacility,
    constraint FK_FacilityContact_Contact
        foreign key (ContactId) references Contact
);

