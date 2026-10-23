create table CaseFileComment
(
    CaseFileCommentId int identity,
    CaseFileId        varchar(25)   not null,
    CommentName       varchar(50)   not null,
    CommentText       varchar(4000) not null,
    constraint PK_CaseFileComment
        primary key (CaseFileCommentId)
            with (fillfactor = 80),
    constraint FK_CaseFileComment_CaseFile
        foreign key (CaseFileId) references CaseFile
);

