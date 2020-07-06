use wangchengfeiMIS14
go

create or alter function calc_gpa(@id varchar(20)) returns float as
begin
    declare @course varchar(20)
    declare @score integer
    declare @credit float
    declare @all_gpa float = 0
    declare @all_credit float = 0

    declare student_score cursor for
        select course, credit, score
        from score,
             course _course
        where _course.id = course
          and student = @id
    open student_score
    fetch next from student_score into @course, @credit, @score
    while @@fetch_status = 0
        begin
            declare @single_gpa float
            set @single_gpa = iif(@score >= 60, (@score - 50) / 10.0, 0)
            set @all_credit = @all_credit + @credit
            set @all_gpa = @all_gpa + @single_gpa * @credit
            fetch next from student_score into @course, @credit, @score
        end
    close student_score
    deallocate student_score

    return iif(@all_credit = 0, 0, round(@all_gpa / @all_credit, 2))
end
go

create or alter function calc_avg(@course varchar(20), @class integer) returns float
as
begin
    declare @avg float = 0
    select @avg = avg(score)
    from score,
         student
    where score.course = @course
      and student.class = @class
      and score.student = student.id
    return iif(@avg is null, 0, @avg)
end
go
