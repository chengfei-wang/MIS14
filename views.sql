use wangchengfeiMIS14
go

create or alter view view_student as
select student.wcf_id14                       student_id,
       student.wcf_name14                     student_name,
       iif(student.wcf_sex14 = 0, N'男', N'女') student_sex,
       student.wcf_age14                      student_age,
       place.wcf_name14                       student_place,
       student.wcf_credit14                   student_credit,
       dbo.calc_gpa(student.wcf_id14)         student_gpa,
       class.wcf_id14                         class_id,
       class.wcf_name14                       class_name
from wangcf_student14 student,
     wangcf_src_place14 place,
     wangcf_class14 class
where wcf_src_place14 = place.wcf_id14
  and wcf_class14 = class.wcf_id14
go

create or alter view view_teacher as
select teacher.wcf_id14               teacher_id,
       teacher.wcf_name14             teacher_name,
       iif(wcf_sex14 = 0, N'男', N'女') teacher_sex,
       teacher.wcf_age14              teacher_age,
       teacher.wcf_phone14            teacher_phone,
       title.wcf_name14               teacher_title
from wangcf_teacher14 teacher,
     wangcf_title14 title
where title.wcf_id14 = wcf_title14;
go

create or alter view view_course as
select course.wcf_id14                          course_id,
       course.wcf_name14                        course_name,
       course.wcf_credit14                      course_credit,
       course.wcf_credit_hour14                 course_credit_hour,
       iif(course.wcf_type14 = 0, N'考试', N'考查') course_type
from wangcf_course14 course
go

create or alter view view_course_open as
select course_open.wcf_course14                   course_id,
       course.wcf_name14                          course_name,
       iif(course.wcf_type14 = 0, N'考试', N'考查')   course_type,
       course.wcf_credit14                        course_credit,
       class.wcf_id14                             class_id,
       class.wcf_name14                           class_name,
       class.wcf_year14                           class_year,
       teacher.wcf_id14                           teacher_id,
       teacher.wcf_name14                         teacher_name,
       semester.wcf_id14                          semester_id,
       semester.wcf_year14                        semester_year,
       semester.wcf_no14                          semester_no,
       dbo.calc_avg(wcf_course14, class.wcf_id14) course_avg
from wangcf_course_open14 course_open,
     wangcf_course14 course,
     wangcf_class14 class,
     wangcf_teacher14 teacher,
     wangcf_semester14 semester
where course_open.wcf_course14 = course.wcf_id14
  and course_open.wcf_teacher14 = teacher.wcf_id14
  and course_open.wcf_class14 = class.wcf_id14
  and course_open.wcf_semester14 = semester.wcf_id14
go

create or alter view view_major as
select major.wcf_id14   major_id,
       major.wcf_name14 major_name
from wangcf_major14 major
go

create or alter view view_class as
select major.wcf_id14   major_id,
       major.wcf_name14 major_name,
       class.wcf_id14   class_id,
       class.wcf_name14 class_name,
       class.wcf_year14 class_year
from wangcf_class14 class,
     wangcf_major14 major
where class.wcf_major14 = major.wcf_id14
go

create or alter view view_score as
select student.wcf_id14                                     student_id,
       student.wcf_name14                                   student_name,
       student.wcf_class14                                  class_id,
       score.wcf_course14                                   course_id,
       course.wcf_name14                                    course_name,
       iif(course.wcf_type14 = 0, N'考试', N'考查')             course_type,
       iif(score.wcf_score14 >= 60, course.wcf_credit14, 0) course_credit,
       score.wcf_score14                                    course_score
from wangcf_score14 score,
     wangcf_course14 course,
     wangcf_student14 student
where score.wcf_student14 = student.wcf_id14
  and score.wcf_course14 = course.wcf_id14
go

create or alter view view_src_place as
select src_place.wcf_id14    place_id,
       src_place.wcf_name14  place_name,
       src_place.wcf_count14 place_count
from wangcf_src_place14 src_place;
go

create or alter view view_score_info as
select _student.wcf_id14    student_id,
       _student.wcf_name14  student_name,
       _semester.wcf_year14 semester_year,
       _semester.wcf_no14   semester_name,
       _teacher.wcf_id14    teacher_id,
       _teacher.wcf_name14  teacher_name,
       _class.wcf_id14      class_id,
       _class.wcf_name14    class_name,
       _course.wcf_id14     course_id,
       _course.wcf_name14   course_name,
       _course.wcf_credit14 course_credit
from wangcf_course_open14 _course_open,
     wangcf_semester14 _semester,
     wangcf_student14 _student,
     wangcf_teacher14 _teacher,
     wangcf_course14 _course,
     wangcf_class14 _class
where _course_open.wcf_semester14 = _semester.wcf_id14
  and _course_open.wcf_teacher14 = _teacher.wcf_id14
  and _course_open.wcf_class14 = _class.wcf_id14
  and _class.wcf_id14 = _student.wcf_class14
  and _course_open.wcf_course14 = _course.wcf_id14
go