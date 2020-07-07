use wangchengfeiMIS14
go

create table major
(
    id   integer primary key identity (1, 1),
    name varchar(20) not null
)

create table class
(
    id    integer primary key identity (1, 1),
    name  varchar(20) not null,
    major integer,
    year  integer     not null check (year > 2000),
    constraint fk_class_major foreign key (major) references major (id) on update cascade on delete cascade
)

create table src_place
(
    id    integer primary key identity (1, 1),
    name  varchar(20) not null,
    count integer     not null default 0 check (count >= 0)
)

create table student
(
    id        varchar(20) primary key,
    name      varchar(20) not null,
    sex       integer     not null check (sex = 0 or sex = 1), -- 0=男，1=女
    age       integer     not null check (age > 0 and age < 200),
    src_place integer     not null,
    credit    integer     not null default 0 check (credit >= 0),
    class     integer,
    constraint fk_student_class foreign key (class) references class (id) on update cascade on delete cascade,
    constraint fk_student_src_place foreign key (src_place) references src_place (id) on update cascade on delete cascade,
)

create table course
(
    id          varchar(20) primary key,
    name        varchar(20) not null,
    credit      float       not null default 0 check (credit >= 0),
    credit_hour float       not null default 0 check (credit_hour >= 0),
    type        integer check (type = 0 or type = 1), -- 0=考试，1=考查
)

create table semester
(
    id   integer primary key identity (1, 1),
    year integer not null check (year > 2000),
    no   integer not null check (no = 1 or no = 2 or no = 3),
    constraint u_year_no unique (year, no)
)

create table title
(
    id   integer primary key identity (1, 1),
    name varchar(20) not null
)


create table teacher
(
    id    varchar(20) primary key,
    name  varchar(20) not null,
    sex   integer     not null check (sex = 0 or sex = 1), -- 0=男，1=女
    age   integer     not null check (age > 0 and age < 200),
    phone varchar(20),
    title integer     not null,
    constraint fk_teacher_title foreign key (title) references title (id)
)

create table course_open
(
    id       integer     not null identity (1, 1),
    course   varchar(20) not null,
    teacher  varchar(20) not null,
    class    integer     not null,
    semester integer     not null,
    constraint fk_open_course foreign key (course) references course (id) on update cascade on delete cascade,
    constraint fk_open_teacher foreign key (teacher) references teacher (id) on update cascade on delete cascade,
    constraint fk_open_class foreign key (class) references class (id) on update cascade on delete cascade,
    constraint fk_open_semester foreign key (semester) references semester (id) on update cascade on delete cascade,
    constraint u_course_open unique (course, class),
    constraint pk_course_open primary key (id)
)

create table score
(
    course  varchar(20) not null,
    student varchar(20) not null,
    score   integer     not null check (score >= 0 and score <= 100),
    constraint fk_score_course foreign key (course) references course (id),
    constraint fk_score_student foreign key (student) references student (id),
    constraint u_course_open_student unique (course, student)
)
