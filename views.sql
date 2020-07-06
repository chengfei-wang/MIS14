use wangchengfeiMIS14
go

create or alter view view_student as
select student.id               student_id,
       student.name             student_name,
       iif(sex = 0, N'男', N'女') student_sex,
       age                      student_age,
       place.name               student_place,
       credit                   student_credit,
       dbo.calc_gpa(student.id) student_gpa,
       _class.id                class_id,
       _class.name              class_name
from student,
     src_place place,
     class _class
where src_place = place.id
  and class = _class.id
go

create or alter view view_teacher as
select teacher.id               teacher_id,
       teacher.name             teacher_name,
       iif(sex = 0, N'男', N'女') teacher_sex,
       age                      teacher_age,
       phone                    teacher_phone,
       _title.name              teacher_title
from teacher,
     title _title
where _title.id = title;
go

create or alter view view_course as
select id                          course_id,
       name                        course_name,
       credit                      course_credit,
       credit_hour                 course_credit_hour,
       iif(type = 0, N'考试', N'考查') course_type
from course
go

create or alter view view_course_open as
select course                                                                      course_id,
       _course.name                                                                course_name,
       iif(_course.type = 0, N'考试', N'考查')                                         course_type,
       _course.credit                                                              course_credit,
       class.id                                                                    class_id,
       class.name                                                                  class_name,
       class.year                                                                  class_year,
       teacher.id                                                                  teacher_id,
       teacher.name                                                                teacher_name,
       cast(semester.year as varchar(20)) + '-' + cast(semester.no as varchar(20)) semester_name,
       dbo.calc_avg(course, class.id)                                              course_avg
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
select id   majer_id,
       name major_name
from major
go

create or alter view view_class as
select major.id   major_id,
       major.name major_name,
       class.id   class_id,
       class.name class_name,
       class.year class_year
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
       score.score                               couese_score
from score,
     course _course,
     student
where score.student = student.id
  and score.course = _course.id
go