use wangchengfeiMIS14
go

create or alter trigger t_src_place_count
    on student
    for insert, update, delete as
begin
    select src_place, count(*) _count into #inserted from inserted group by src_place
    update src_place
    set count = count + (
        select _count
        from #inserted
        where #inserted.src_place = src_place.id
    );
    select src_place, count(*) _count into #deleted from inserted group by src_place
    update src_place
    set count = count - (
        select _count
        from #deleted
        where #deleted.src_place = src_place.id
    );
end

go

create or alter trigger t_student_credit
    on score
    for update, delete, insert as
begin
    declare @student varchar(20)
    declare @course_id integer
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
                end
            fetch next from cursor_delete into @student, @course_id, @score
        end
    close cursor_delete
    deallocate cursor_delete
end