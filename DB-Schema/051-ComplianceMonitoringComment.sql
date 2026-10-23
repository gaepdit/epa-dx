create table ComplianceMonitoringComment
(
    ComplianceMonitoringCommentId int identity,
    ComplianceMonitoringId        varchar(25)   not null,
    CommentName                   varchar(50)   not null,
    CommentText                   varchar(4000) not null,
    constraint PK_ComplianceMonitoringComment
        primary key (ComplianceMonitoringCommentId)
            with (fillfactor = 80),
    constraint FK_ComplianceMonitoringComment_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);

