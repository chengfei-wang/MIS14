use wangchengfeiMIS14
go

create or alter procedure init_major as
begin
    declare @major_id integer
    exec insert_major N'软件工程', @major_id output
    exec insert_major N'网络工程', @major_id output
    exec insert_major N'数字媒体技术', @major_id output
    exec insert_major N'物联网工程', @major_id output
    exec insert_major N'数据科学与大数据技术', @major_id output
    exec insert_major N'计算机科学与技术', @major_id output
    exec insert_major N'电气工程及其自动化', @major_id output
    exec insert_major N'自动化', @major_id output
    exec insert_major N'电子信息工程', @major_id output
    exec insert_major N'通信工程', @major_id output
    exec insert_major N'电子科学与技术', @major_id output
    exec insert_major N'建筑学', @major_id output
    exec insert_major N'化学工程', @major_id output
end
go

create or alter procedure init_class as
begin
    declare @class_id integer
    exec insert_class N'移动应用开发方向01', N'软件工程', 2020, @class_id output
    exec insert_class N'移动应用开发方向02', N'软件工程', 2020, @class_id output
    exec insert_class N'移动应用开发方向03', N'软件工程', 2020, @class_id output
    exec insert_class N'移动应用开发方向03', N'软件工程', 2018, @class_id output
    exec insert_class N'大数据方向01', N'软件工程', 2020, @class_id output
    exec insert_class N'大数据方向02', N'软件工程', 2020, @class_id output
    exec insert_class N'大数据方向03', N'软件工程', 2020, @class_id output
    exec insert_class N'服务外包方向01', N'软件工程', 2020, @class_id output
    exec insert_class N'服务外包方向02', N'软件工程', 2020, @class_id output

    exec insert_class N'嵌入式方向01', N'计算机科学与技术', 2020, @class_id output
    exec insert_class N'嵌入式方向02', N'计算机科学与技术', 2020, @class_id output
    exec insert_class N'嵌入式方向03', N'计算机科学与技术', 2020, @class_id output
    exec insert_class N'嵌入式方向04', N'计算机科学与技术', 2020, @class_id output
end
go

create or alter procedure init_src_place as
begin
    declare @src_place_id integer
    exec insert_src_place N'浙江省', @src_place_id output
    exec insert_src_place N'北京市', @src_place_id output
    exec insert_src_place N'天津市', @src_place_id output
    exec insert_src_place N'河北省', @src_place_id output
    exec insert_src_place N'山西省', @src_place_id output
    exec insert_src_place N'内蒙古自治区', @src_place_id output
    exec insert_src_place N'辽宁省', @src_place_id output
    exec insert_src_place N'吉林省', @src_place_id output
end
go

create or alter procedure init_title as
begin
    declare @title_id integer
    exec insert_title N'助教', @title_id output
    exec insert_title N'讲师', @title_id output
    exec insert_title N'副教授', @title_id output
    exec insert_title N'教授', @title_id output
end
go

create or alter procedure init_student as
begin
    exec insert_student '201806061219', N'王程飞', 0, 20, N'浙江省', N'移动应用开发方向02', 2020
    exec insert_student '201806061108', N'胡皓睿', 0, 20, N'浙江省', N'移动应用开发方向02', 2020
    exec insert_student '201806061201', N'陈昊天', 0, 21, N'浙江省', N'移动应用开发方向01', 2020
    exec insert_student '201806060001', N'学生01', 0, 20, N'河北省', N'移动应用开发方向03', 2020
    exec insert_student '201806060002', N'学生02', 1, 20, N'天津市', N'移动应用开发方向03', 2020
    exec insert_student '201806060003', N'学生03', 1, 20, N'天津市', N'移动应用开发方向03', 2018
    exec insert_student '201806060004', N'学生04', 1, 20, N'北京市', N'嵌入式方向01', 2020
    exec insert_student '201806060005', N'学生05', 0, 20, N'河北省', N'嵌入式方向01', 2020
    exec insert_student '201806060006', N'学生06', 0, 20, N'浙江省', N'嵌入式方向02', 2020
end
go

create or alter procedure init_course as
begin
    exec insert_course 'G209031', N'大学英语', 4, 64, 0
    exec insert_course 'G210002', N'线性代数', 2, 32, 0
    exec insert_course 'G210013', N'高等数学Ⅰ', 5, 80, 0
    exec insert_course 'G226002', N'程序设计基础C', 4, 64, 0
    exec insert_course 'G237002', N'中国近现代史纲要', 2, 32, 1
    exec insert_course 'G331009', N'高分子材料', 2, 32, 1
    exec insert_course '11370', N'大学生职业发展', 1, 16, 1
    exec insert_course '405024', N'互联网思维Ⅰ', 2, 32, 1
end
go

create or alter procedure init_teacher as
begin
    exec insert_teacher '000001', N'阮晓亮', 0, 30, '17767222001', N'讲师'
    exec insert_teacher '000002', N'金建国', 0, 30, '17767222002', N'教授'
    exec insert_teacher '000003', N'练晓鹏', 0, 30, '17767222003', N'教授'
    exec insert_teacher '000004', N'潘清', 0, 30, '17767222004', N'副教授'
    exec insert_teacher '000005', N'颜桂珍', 1, 30, '17767222005', N'副教授'
    exec insert_teacher '000006', N'教师06', 0, 30, '17767222006', N'教授'
    exec insert_teacher '000007', N'教师07', 0, 30, '17767222007', N'教授'
    exec insert_teacher '000008', N'教师08', 1, 30, '17767222008', N'副教授'
end
go

create or alter procedure init_semester as
begin
    declare @semester_id integer
    exec insert_semester 2018, 1, @semester_id output
    exec insert_semester 2018, 2, @semester_id output
    exec insert_semester 2018, 3, @semester_id output
    exec insert_semester 2019, 1, @semester_id output
    exec insert_semester 2019, 2, @semester_id output
    exec insert_semester 2019, 3, @semester_id output
    exec insert_semester 2020, 1, @semester_id output
    exec insert_semester 2020, 2, @semester_id output
    exec insert_semester 2020, 3, @semester_id output
    exec insert_semester 2021, 1, @semester_id output
    exec insert_semester 2021, 2, @semester_id output
    exec insert_semester 2021, 3, @semester_id output
end
go

create or alter procedure init_course_open as
begin
    exec insert_course_open 'G209031', '000001', N'移动应用开发方向01', '2018-1'
    exec insert_course_open 'G209031', '000001', N'移动应用开发方向02', '2018-1'
    exec insert_course_open 'G209031', '000006', N'移动应用开发方向03', '2018-1'
    exec insert_course_open 'G209031', '000006', N'大数据方向01', '2018-1'
    exec insert_course_open 'G210002', '000002', N'移动应用开发方向01', '2018-1'
    exec insert_course_open 'G210002', '000003', N'移动应用开发方向02', '2018-1'
    exec insert_course_open 'G210002', '000003', N'移动应用开发方向03', '2018-1'
    exec insert_course_open 'G226002', '000002', N'移动应用开发方向01', '2018-1'
    exec insert_course_open 'G226002', '000003', N'移动应用开发方向02', '2018-1'
    exec insert_course_open 'G226002', '000003', N'移动应用开发方向03', '2018-1'
end
go

create or alter procedure init_score as
begin
    exec insert_score 'G210013', '201806061219', 85
    exec insert_score 'G209031', '201806061219', 50
    exec insert_score 'G209031', '201806061108', 87
end
go

create or alter procedure init_all as
begin
    exec init_major
    exec init_class
    exec init_src_place
    exec init_title
    exec init_student
    exec init_course
    exec init_teacher
    exec init_semester
    exec init_course_open
    exec init_score
end
go

exec init_all
