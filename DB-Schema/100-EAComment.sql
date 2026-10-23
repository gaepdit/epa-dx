create table EAComment
(
    EAInspectionCommentId int identity,
    EnforcementActionId   varchar(25)   not null,
    CommentName           varchar(50)   not null,
    CommentText           varchar(4000) not null,
    constraint PK_EAInspectionComment
        primary key (EAInspectionCommentId)
            with (fillfactor = 80),
    constraint FK_EAComment_EnforcementAction
        foreign key (EnforcementActionId) references EnforcementAction
);

