use wangchengfeiMIS14
go

create table wangcf_major14
(
    wcf_id14   integer primary key identity (1, 1),
    wcf_name14 varchar(20) not null
)

create table wangcf_class14
(
    wcf_id14    integer primary key identity (1, 1),
    wcf_name14  varchar(20) not null,
    wcf_major14 integer,
    wcf_year14  integer     not null check (wcf_year14 > 2000),
    constraint wcf_fk_class_major14 foreign key (wcf_major14) references wangcf_major14 (wcf_id14) on update cascade on delete cascade
)

create table wangcf_src_place14
(
    wcf_id14    integer primary key identity (1, 1),
    wcf_name14  varchar(20) not null,
    wcf_count14 integer     not null default 0 check (wcf_count14 >= 0)
)

create table wangcf_student14
(
    wcf_id14        varchar(20) primary key,
    wcf_name14      varchar(20) not null,
    wcf_sex14       integer     not null check (wcf_sex14 = 0 or wcf_sex14 = 1), -- 0=男，1=女
    wcf_age14       integer     not null check (wcf_age14 > 0 and wcf_age14 < 200),
    wcf_src_place14 integer     not null,
    wcf_credit14    integer     not null default 0 check (wcf_credit14 >= 0),
    wcf_class14     integer,
    constraint wcf_fk_student_class14 foreign key (wcf_class14) references wangcf_class14 (wcf_id14) on update cascade on delete cascade,
    constraint wcf_fk_student_src_place14 foreign key (wcf_src_place14) references wangcf_src_place14 (wcf_id14) on update cascade on delete cascade,
)

create table wangcf_course14
(
    wcf_id14          varchar(20) primary key,
    wcf_name14        varchar(20) not null,
    wcf_credit14      float       not null default 0 check (wcf_credit14 >= 0),
    wcf_credit_hour14 float       not null default 0 check (wcf_credit_hour14 >= 0),
    wcf_type14        integer check (wcf_type14 = 0 or wcf_type14 = 1), -- 0=考试，1=考查
)

create table wangcf_semester14
(
    wcf_id14   integer primary key identity (1, 1),
    wcf_year14 integer not null check (wcf_year14 > 2000),
    wcf_no14  integer not null check (wcf_no14 = 1 or wcf_no14 = 2 or wcf_no14 = 3),
    constraint wcf_u_year_no_14 unique (wcf_year14, wcf_no14)
)

create table wangcf_title14
(
    wcf_id14   integer primary key identity (1, 1),
    wcf_name14 varchar(20) not null
)


create table wangcf_teacher14
(
    wcf_id14    varchar(20) primary key,
    wcf_name14  varchar(20) not null,
    wcf_sex14   integer     not null check (wcf_sex14 = 0 or wcf_sex14 = 1), -- 0=男，1=女
    wcf_age14   integer     not null check (wcf_age14 > 0 and wcf_age14 < 200),
    wcf_phone14 varchar(20),
    wcf_title14 integer     not null,
    constraint wcf_fk_teacher_title14 foreign key (wcf_title14) references wangcf_title14 (wcf_id14)
)

create table wangcf_course_open14
(
    wcf_id14       integer     not null identity (1, 1),
    wcf_course14   varchar(20) not null,
    wcf_teacher14  varchar(20) not null,
    wcf_class14    integer     not null,
    wcf_semester14 integer     not null,
    constraint wcf_fk_open_course14 foreign key (wcf_course14) references wangcf_course14 (wcf_id14) on update cascade on delete cascade,
    constraint wcf_fk_open_teacher14 foreign key (wcf_teacher14) references wangcf_teacher14 (wcf_id14) on update cascade on delete cascade,
    constraint wcf_fk_open_class14 foreign key (wcf_class14) references wangcf_class14 (wcf_id14) on update cascade on delete cascade,
    constraint wcf_fk_open_semester14 foreign key (wcf_semester14) references wangcf_semester14 (wcf_id14) on update cascade on delete cascade,
    constraint wcf_u_course_open14 unique (wcf_course14, wcf_class14),
    constraint wcf_pk_course_open14 primary key (wcf_id14)
)

create table wangcf_score14
(
    wcf_course14  varchar(20) not null,
    wcf_student14 varchar(20) not null,
    wcf_score14   integer     not null check (wcf_score14 >= 0 and wcf_score14 <= 100),
    constraint wcf_fk_score_course14 foreign key (wcf_course14) references wangcf_course14 (wcf_id14),
    constraint wcf_fk_score_student14 foreign key (wcf_student14) references wangcf_student14 (wcf_id14),
    constraint wcf_u_course_open_student14 unique (wcf_course14, wcf_student14)
)
