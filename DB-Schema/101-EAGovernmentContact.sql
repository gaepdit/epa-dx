create table EAGovernmentContact
(
    EnforcementActionId varchar(25) not null,
    ContactId           int         not null,
    constraint PK_EnforcementActionGovernmentContact
        primary key (EnforcementActionId, ContactId)
            with (fillfactor = 80),
    constraint FK_EAGovernmentContact_EnforcementAction
        foreign key (EnforcementActionId) references EnforcementAction
);

