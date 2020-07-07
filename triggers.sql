use wangchengfeiMIS14
go

create or alter trigger t_src_place_count
    on wangcf_student14
    for insert, update, delete as
begin
    declare @src_place integer
    declare @count integer

    declare student_insert cursor for
        select wcf_src_place14 src_place, count(*) _count from inserted group by wcf_src_place14
    open student_insert
    fetch next from student_insert into @src_place, @count
    while @@fetch_status = 0
        begin
            update wangcf_src_place14
            set wcf_count14 = wcf_count14 + @count
            where wcf_id14 = @src_place
            fetch next from student_insert into @src_place, @count
        end
    close student_insert
    deallocate student_insert

    declare student_delete cursor for
        select wcf_src_place14 src_place, count(*) _count from deleted group by wcf_src_place14
    open student_delete
    fetch next from student_delete into @src_place, @count
    while @@fetch_status = 0
        begin
            update wangcf_src_place14
            set wcf_count14 = wcf_count14 - @count
            where wcf_id14 = @src_place
            fetch next from student_delete into @src_place, @count
        end
    close student_delete
    deallocate student_delete
end
go


create or alter trigger t_student_credit
    on wangcf_score14
    for update, delete, insert as
begin
    declare @student varchar(20)
    declare @course_id varchar(20)
    declare @score integer

    declare cursor_insert cursor for
        select wcf_student14, wcf_course14, wcf_score14 from inserted
    open cursor_insert
    fetch next from cursor_insert into @student, @course_id, @score
    while @@fetch_status = 0
        begin
            if @score >= 60
                begin
                    update wangcf_student14
                    set wcf_credit14 = wcf_credit14 + (select distinct wcf_credit14 from wangcf_course14 where wangcf_course14.wcf_id14 = @course_id)
                    where wcf_id14 = @student
                end
            fetch next from cursor_insert into @student, @course_id, @score
        end
    close cursor_insert
    deallocate cursor_insert

    declare cursor_delete cursor for
        select wcf_student14, wcf_course14, wcf_score14 from deleted
    open cursor_delete
    fetch next from cursor_delete into @student, @course_id, @score
    while @@fetch_status = 0
        begin
            if @score >= 60
                begin
                    update wangcf_student14
                    set wcf_credit14 = wcf_credit14 - (select distinct wcf_credit14 from wangcf_course14 where wangcf_course14.wcf_id14 = @course_id)
                    where wcf_id14 = @student
                end
            fetch next from cursor_delete into @student, @course_id, @score
        end
    close cursor_delete
    deallocate cursor_delete
end