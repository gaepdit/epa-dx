create table Telephone
(
    TelephoneID              int identity,
    ContactID                int,
    TelephoneNumberTypeCode  varchar(10),
    TelephoneNumber          varchar(15),
    TelephoneExtensionNumber varchar(5),
    constraint [PK_[Telephone]
        primary key (TelephoneID)
            with (fillfactor = 80),
    constraint FK_Telephone_Contact
        foreign key (ContactID) references Contact
);

