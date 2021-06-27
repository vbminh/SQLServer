create database MarkManagement

create table Students
(
	StudentID	Nvarchar(12)	PRIMARY KEY,
	StudentsName	Nvarchar(25)	not null,
	DateofBirth		Datetime	not null,
	Email	Nvarchar(40),
	Phone	Nvarchar(12),
	Class	Nvarchar(10)
)
create table Subjects
(
	SubjectID	Nvarchar(10)	PRIMARY KEY,
	SubjectName	Nvarchar(25)	not null
)
create table Mark
(
	StudentID	Nvarchar(12),
	SubjectID	Nvarchar(10),
	Date	Datetime,
	Theory	Tinyint,
	Practical	Tinyint
	constraint pk_Mark primary key(StudentID,SubjectID)
)

INSERT INTO Students VALUES('AV0807005','Mai Trung Hiếu','11/10/1989','trunghieu@yahoo.com','0904115116','AV1'),('AV0807006','Nguyễn Quý Hùng','2/12/1988','quyhung@yahoo.com','0955667787','AV2'),('AV0807007','Đỗ Khắc Huỳnh','2/1/1990','dachuynh@yahoo.com','0988574747','AV2'),('AV0807009','An Đăng Khuê','6/3/1986','dangkhue@yahoo.com','0986757463','AV1'),('AV0807010','Nguyễn T.Tuyết Lan','12/7/1989','tuyetlan@yahoo.com','0983310342','AV2'),('AV0807011','Đinh Phụng Long','2/12/1990','phunglong@yahoo.com',' ','AV1'),('AV0807012','Nguyễn Tuấn Nam','2/3/1990','tuannam@yahoo.com',' ','AV1')

INSERT INTO Subjects Values('S001','SQL'),('S002','Java Simplefield'),('S003','Active Server Page')

INSERT INTO Mark Values('AV0807005','S001','06/05/2008','8','25'),
('AV0807006','S002','06/05/2008','16','30'),
('AV0807007','S001','06/05/2008','10','25'),
('AV0807009','S003','06/05/2008','7','13'),
('AV0807010','S003','06/05/2008','9','16'),
('AV0807011','S002','06/05/2008','8','30'),
('AV0807012','S001','06/05/2008','7','31')
--
select*from Students
--
select*from Students where class = 'AV1'
--
update Students set class = 'AV2' where StudentID = 'AV0807012'
--
select Class,count(Class) as sosinhvien from Students
group by Class
--
select StudentsName from Students where Class = 'AV2' order by StudentsName
--
select StudentsName from Students S, Mark M
where S.StudentID = M.StudentID
and Theory < '10' and Date = '06/05/2008'
--
select count(StudentsName) as sosv from Students S, Mark M
where S.StudentID = M.StudentID and Theory < '10'
--
select StudentsName from Students
where Class = 'AV1' and DateofBirth > '1/1/1980'
--
delete from Students where StudentID = 'AV0807011'
--
select S.StudentID,StudentsName,SubjectName,Theory,Practical,Date from Students S, Subjects J, Mark M
where S.StudentID = M.StudentID 
and M.SubjectID = J.SubjectID 
and J.SubjectID = 'S001' 
and Date = '06/05/2008'
