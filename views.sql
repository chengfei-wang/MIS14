use wangchengfeiMIS14
go

create or alter view view_student as
select student.id, student.name name, iif(sex = 0, N'男', N'女') sex, age, place.name place
from student,
     src_place place
where src_place = place.id
go

create or alter view view_teacher as
select teacher.id, teacher.name, iif(sex = 0, N'男', N'女') sex, age, phone, _title.name title
from teacher,
     title _title
where _title.id = title;
go

create or alter view view_course as
select id, name, credit, credit_hour, iif(type = 0, N'考试', N'考查') type
from course
go

create or alter view view_course_open as
select course                                                                      course_id,
       _course.name                                                                course_name,
       iif(_course.type = 0, N'考试', N'考查')                                         course_type,
       _course.credit                                                              course_credit,
       class.name                                                                  class_name,
       class.year                                                                  class_year,
       teacher.name                                                                teacher,
       cast(semester.year as varchar(20)) + '-' + cast(semester.no as varchar(20)) semester
from course_open,
     course _course,
     class,
     teacher,
     semester
where course_open.course = _course.id
  and course_open.teacher = teacher.id
  and course_open.class = class.id
  and course_open.semester = semester.id
go

create or alter view view_major as
select name
from major
go

create or alter view view_class as
select major.name major, class.name class, class.year year
from class,
     major
where class.major = major.id
go

create or alter view view_score as
select student.id                                student_id,
       student.name                              student_name,
       course                                    course_id,
       _course.name                              course_name,
       iif(_course.type = 0, N'考试', N'考查')       course_type,
       iif(score.score >= 60, _course.credit, 0) course_credit,
       score.score                               score
from score,
     course _course,
     student
where score.student = student.id
  and score.course = _course.id
go