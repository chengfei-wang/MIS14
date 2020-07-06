create database wangchengfeiMIS14
    on (
    name = 'wangchengfeiMIS14_data',
    filename = '/home/mssql/wangchengfeiMIS14.mdf',
    size = 10 MB,
    maxsize = unlimited,
    filegrowth = 10 MB
    )
    log on (
    name = 'wangchengfeiMIS14_log',
    filename = '/home/mssql/wangchengfeiMIS14.log',
    size = 10 MB,
    maxsize = unlimited,
    filegrowth = 10 MB
    )
go

ALTER DATABASE wangchengfeiMIS14 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
go
ALTER DATABASE wangchengfeiMIS14 COLLATE Chinese_PRC_CI_AS
go
ALTER DATABASE wangchengfeiMIS14 SET MULTI_USER
go
