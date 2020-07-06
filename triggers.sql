use wangchengfeiMIS14
go

create or alter trigger t_src_place_count
    on student
    for insert, update, delete as
begin
    declare @src_place integer
    declare @count integer

    declare student_insert cursor for
        select src_place src_place, count(*) _count from inserted group by src_place
    open student_insert
    fetch next from student_insert into @src_place, @count
    while @@fetch_status = 0
        begin
            update src_place
            set count = count + @count
            where id = @src_place
            fetch next from student_insert into @src_place, @count
        end
    close student_insert
    deallocate student_insert

    declare student_delete cursor for
        select src_place src_place, count(*) _count from deleted group by src_place
    open student_delete
    fetch next from student_delete into @src_place, @count
    while @@fetch_status = 0
        begin
            update src_place
            set count = count - @count
            where id = @src_place
            fetch next from student_delete into @src_place, @count
        end
    close student_delete
    deallocate student_delete
end
go


create or alter trigger t_student_credit
    on score
    for update, delete, insert as
begin
    declare @student varchar(20)
    declare @course_id varchar(20)
    declare @score integer

    declare cursor_insert cursor for
        select student, course, score from inserted
    open cursor_insert
    fetch next from cursor_insert into @student, @course_id, @score
    while @@fetch_status = 0
        begin
            if @score >= 60
                begin
                    update student
                    set credit = credit + (select distinct credit from course where course.id = @course_id)
                    where id = @student
                end
            fetch next from cursor_insert into @student, @course_id, @score
        end
    close cursor_insert
    deallocate cursor_insert

    declare cursor_delete cursor for
        select student, course, score from deleted
    open cursor_delete
    fetch next from cursor_delete into @student, @course_id, @score
    while @@fetch_status = 0
        begin
            if @score >= 60
                begin
                    update student
                    set credit = credit - (select distinct credit from course where course.id = @course_id)
                    where id = @student
                end
            fetch next from cursor_delete into @student, @course_id, @score
        end
    close cursor_delete
    deallocate cursor_delete
end