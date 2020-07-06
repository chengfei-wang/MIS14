use wangchengfeiMIS14
go

create or alter procedure insert_major @name varchar(20), @major_id integer output as
begin
    insert into major (name) values (@name);
    select @major_id = id from major where name = @name;
end
go

create or alter procedure insert_class @name varchar(20), @major varchar(20), @year integer, @class_id integer output as
begin
    declare @major_id integer
    select @major_id = id from major where name = @major;
    insert into class (name, major, year) values (@name, @major_id, @year)
    select @class_id = id from class where name = @name and major = @major_id and year = @year
end
go

create or alter procedure insert_src_place @src_place varchar(20), @src_place_id integer output as
begin
    insert into src_place (name, count) values (@src_place, 0)
    select @src_place_id = id from src_place where name = @src_place;
end
go

create or alter procedure insert_semester @year integer, @no integer, @semester_id integer output as
begin
    insert into semester (year, no) values (@year, @no)
    select @semester_id = id from semester where year = @year and no = @no
end
go

create or alter procedure insert_title @name varchar(20), @title_id integer output as
begin
    insert into title (name) values (@name)
    select @title_id = id from title where name = @name;
end
go

create or alter procedure insert_student @id varchar(20), @name varchar(20), @sex integer, @age integer,
                                         @src_place varchar(20), @class varchar(20), @year integer as
begin
    print @name + ' '+ @src_place
    insert into student (id, name, sex, age, src_place, credit, class)
    values (@id, @name, @sex, @age, (select id from src_place where name = @src_place), 0,
            (select id from class where name = @class and year = @year))
end
go

create or alter procedure insert_course @id varchar(20), @name varchar(20), @credit integer, @credit_hour integer,
                                        @type integer as
begin
    insert into course (id, name, credit, credit_hour, type) values (@id, @name, @credit, @credit_hour, @type)
end
go

create or alter procedure insert_course_open @course varchar(20), @teacher varchar(20), @class varchar(20),
                                             @semester varchar(20) as
begin
    declare @class_id integer
    set @class_id = null
    select @class_id = id from class where name = @class
    declare @semester_id integer
    set @semester_id = null
    select @semester_id = id
    from semester
    where year = cast(left(@semester, 4) as integer)
      and no = cast(right(@semester, 1) as integer)
    if @class_id is null or @class_id is null
        begin
            print 'course_open ' + @course + ' class' + @class + ' or semester ' +
                  @semester + ' not found'
            return
        end
    insert into course_open (course, teacher, class, semester) values (@course, @teacher, @class_id, @semester_id)
end
go

create or alter procedure insert_teacher @id varchar(20), @name varchar(20), @sex integer, @age integer,
                                         @phone varchar(20), @title varchar(20) as
begin
    declare @title_id integer
    select @title_id = id from title where title.name = @title
    insert into teacher (id, name, sex, age, phone, title)
    values (@id, @name, @sex, @age, @phone, @title_id)
end
go

create or alter procedure insert_score @course varchar(20), @student varchar(20), @score integer as
begin
    insert into score (course, student, score) values (@course, @student, @score)
end
go