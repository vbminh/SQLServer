create database DemtEmpB

create table Department
(
	DepartmentNo int not null,
	DepartmentName char(25) not null,
	Location char(25) not null,
	constraint pk_Department primary key(DepartmentNo)
)
create table Employee
(
	EmpNo int not null,
	Fname varchar(15) not null,
	Lname varchar(15) not null,
	Job varchar(25) not null,
	HireDate Datetime not null,
	Salary Numeric not null,
	Commision Numeric not null,
	DepartmentNo int,
	constraint pk_Employee primary key(EmpNo),
	constraint fk_Employee foreign key(DepartmentNo) references Department(DepartmentNo) on delete cascade on update cascade
)

insert into Department values('10','Accounting','Melbourne'),('20','Research','Adealide'),('30','Sales','Sydney'),('40','Operation','Perth')
insert into Employee values('1','John','Smith','Clerk','02-17-1980','800','200','20'),('2','Peter','Allen','Salesman','11-20-1981','1600','300','30'),('3','Kate','Ward','Salesman','11-22-1981','1250','500','30'),('4','Jack','Jones','Manager','07-02-1975','2975','100','20'),('5','Joes','Martin','Salesman','09-28-1981','1250','1400','30')

--Hien thi nd bang department
select*from Department
--Hien thi nd bang Employee
select*from Employee
--Hien thi EmpNo, Fname, Lname - Fname co ten la Kate
select EmpNo,Fname,Lname from Employee where Fname = 'Kate'
--Ghep Lname va Fname = Fullname,Salary, 10%Salary
select Fname +' '+ Lname as FullName,Salary,Salary + Salary*0.1 as Tangluong
from Employee
--Fname,Lname,HireDate: HireDate=1981, Lname tang dan
select Fname,Lname,HireDate from Employee
where year(HireDate) = '1981'
order by Lname
--avg,max,min cua salary
select avg(Salary) as AvgS,max(Salary) as MaxS,min(Salary) as MinS from Employee
--DepartmentNo, so nguoi
select E.DepartmentNo, count(DepartmentName) as Songuoi
from Employee E, Department D
where E.DepartmentNo = D.DepartmentNo
group by E.DepartmentNo,DepartmentName
--DepartmentNo, DepartmentName, FullName (Fname và Lname), Job, Salary
select E.DepartmentNo, DepartmentName,Fname+' '+Lname as Fullname, Job, Salary
from Employee E, Department D
where E.DepartmentNo = D.DepartmentNo
--DepartmentNo, DepartmentName, Location va so nguoi
select E.DepartmentNo, DepartmentName, Location, count(DepartmentName) as Songuoi
from Employee E, Department D
where E.DepartmentNo = D.DepartmentNo
group by E.DepartmentNo,DepartmentName,Location
--
select DepartmentNo, DepartmentName, Location, count(DepartmentName) as Songuoi
from Employee E, Department D
where E.DepartmentNo = D.DepartmentNo
group by D.DepartmentNo,DepartmentName,Location
