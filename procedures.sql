use wangchengfeiMIS14
go

create or alter procedure insert_major @name varchar(20), @major_id integer output as
begin
    insert into wangcf_major14 (wcf_name14) values (@name);
    select @major_id = wcf_id14 from wangcf_major14 where wcf_name14 = @name;
end
go

create or alter procedure insert_class @name varchar(20), @major varchar(20), @year integer, @class_id integer output as
begin
    declare @major_id integer
    select @major_id = wcf_id14 from wangcf_major14 where wcf_name14 = @major;
    insert into wangcf_class14 (wcf_name14, wcf_major14, wcf_year14) values (@name, @major_id, @year)
    select @class_id = wcf_id14
    from wangcf_class14
    where wcf_name14 = @name
      and wcf_major14 = @major_id
      and wcf_year14 = @year
end
go

create or alter procedure insert_src_place @src_place varchar(20), @src_place_id integer output as
begin
    insert into wangcf_src_place14 (wcf_name14, wcf_count14) values (@src_place, 0)
    select @src_place_id = wcf_id14 from wangcf_src_place14 where wcf_name14 = @src_place;
end
go

create or alter procedure insert_semester @year integer, @no integer, @semester_id integer output as
begin
    insert into wangcf_semester14 (wcf_year14, wcf_no14) values (@year, @no)
    select @semester_id = wcf_id14 from wangcf_semester14 where wcf_year14 = @year and wcf_no14 = @no
end
go

create or alter procedure insert_title @name varchar(20), @title_id integer output as
begin
    insert into wangcf_title14 (wcf_name14) values (@name)
    select @title_id = wcf_id14 from wangcf_title14 where wcf_name14 = @name;
end
go

create or alter procedure insert_student @id varchar(20), @name varchar(20), @sex integer, @age integer,
                                         @src_place varchar(20), @class varchar(20), @year integer as
begin
    print @name + ' ' + @src_place
    insert into wangcf_student14 (wcf_id14, wcf_name14, wcf_sex14, wcf_age14, wcf_src_place14, wcf_credit14,
                                  wcf_class14)
    values (@id, @name, @sex, @age, (select wangcf_src_place14.wcf_id14
                                     from wangcf_src_place14
                                     where wangcf_src_place14.wcf_name14 = @src_place), 0,
            (select wangcf_class14.wcf_id14
             from wangcf_class14
             where wangcf_class14.wcf_name14 = @class
               and wcf_year14 = @year))
end
go

create or alter procedure insert_course @id varchar(20), @name varchar(20), @credit integer, @credit_hour integer,
                                        @type integer as
begin
    insert into wangcf_course14 (wcf_id14, wcf_name14, wcf_credit14, wcf_credit_hour14, wcf_type14)
    values (@id, @name, @credit, @credit_hour, @type)
end
go

create or alter procedure insert_course_open @course varchar(20), @teacher varchar(20), @class varchar(20),
                                             @semester varchar(20) as
begin
    declare @class_id integer
    set @class_id = null
    select @class_id = wcf_id14 from wangcf_class14 where wcf_name14 = @class
    declare @semester_id integer
    set @semester_id = null
    select @semester_id = wcf_id14
    from wangcf_semester14
    where wcf_year14 = cast(left(@semester, 4) as integer)
      and wcf_no14 = cast(right(@semester, 1) as integer)
    if @class_id is null or @class_id is null
        begin
            print 'course_open ' + @course + ' class' + @class + ' or semester ' +
                  @semester + ' not found'
            return
        end
    insert into wangcf_course_open14 (wcf_course14, wcf_teacher14, wcf_class14, wcf_semester14)
    values (@course, @teacher, @class_id, @semester_id)
end
go

create or alter procedure insert_teacher @id varchar(20), @name varchar(20), @sex integer, @age integer,
                                         @phone varchar(20), @title varchar(20) as
begin
    declare @title_id integer
    select @title_id = wcf_id14 from wangcf_title14 where wangcf_title14.wcf_name14 = @title
    insert into wangcf_teacher14 (wcf_id14, wcf_name14, wcf_sex14, wcf_age14, wcf_phone14, wcf_title14)
    values (@id, @name, @sex, @age, @phone, @title_id)
end
go

create or alter procedure insert_score @course varchar(20), @student varchar(20), @score integer as
begin
    insert into wangcf_score14 (wcf_course14, wcf_student14, wcf_score14) values (@course, @student, @score)
end
go
