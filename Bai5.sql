--Cau1
create database QLKHO

create table Nhap
(
	SoHDN nchar(10) not null primary key,
	MaVT nchar(10) not null,
	SoluongN int,
	DonGiaN float,
	NgayN date,
	constraint fk_Nhap foreign key(MaVT) references Ton(MaVT)
	on delete cascade on update cascade
)

create table Xuat
(
	SoHDX nchar(10) not null primary key,
	MaVT nchar(10) not null,
	SoluongX int,
	DonGiaX float,
	NgayX date,
	constraint fk_Xuat foreign key(MaVT) references Ton(MaVT)
	on delete cascade on update cascade
)

create table Ton
(
	MaVT nchar(10) not null primary key,
	TenVT nvarchar(20) not null,
	SoluongT int
)

insert into Nhap values('N001','VT01','100','10000','01-01-2021'),('N002','VT03','20','50000','12-12-2020'),('N003','VT05','50','30000','11-02-2021')
insert into Xuat values('X001','VT02','20','100000','02/02/2021'),('X002','VT01','50','20000','03/15/2021')
insert into Ton values('VT01','Dien Thoai','50'),('VT02','Dieu hoa','90'),('VT03','May giat','10'),('VT04','Tu lanh','70'),('VT05','Tivi','20')
--Cau2
create view cau2 as
Select Ton.MaVT, TenVT, sum(SoluongX * DongiaX) as TienBan
from Ton inner join Xuat on Ton.MaVT = Xuat.MaVT
group by Ton.MaVT, TenVT

select * from cau2
--Cau3
create view cau3 as
select Ton.TenVT, sum(SoluongX) as 'Tong sl' from Xuat inner join Ton on Xuat.MaVT=Ton.MaVT
group by Ton.TenVT
select*from cau3
--Cau4
create view cau4 as
select Ton.TenVT, sum(SoluongN) as 'Tong sl' from Nhap inner join Ton on Nhap.MaVT=Ton.MaVT
group by Ton.TenVT
select*from cau3
--Cau5
create view cau5 as
select Ton.MaVT, Ton.TenVT, sum(SoluongN)- sum(SoluongX)- sum(SoluongT) as Tongton
from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
		inner join Xuat on Ton.MaVT = Xuat.MaVT
		group by Ton.MaVT, Ton.TenVT
select *from cau5