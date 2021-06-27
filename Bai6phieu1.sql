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
create view C2 as
Select TenVT
from Ton 
where SoluongT = ( select max(SoluongT) from Ton)

select * from C2
--Cau3
create view C3 as
select Ton.MaVT, Ton.TenVT
from Ton inner join Xuat on Xuat.MaVT=Ton.MaVT
group by Ton.MaVT, Ton.TenVT
having sum(SoluongX) >= 100

select*from C3
--Cau4
create view Cau_4 as
select month(NgayX) as ThangX, year(NgayX) as NamX, sum(SoluongX) as TongSl from Xuat
group by month(NgayX),year(NgayX)

select*from Cau_4
--Cau5
create view C5 as
select Ton.MaVT, Ton.TenVT, SoluongN, SoluongX, DonGiaN, DonGiaX, NgayN, NgayX
from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
		inner join Xuat on Ton.MaVT = Xuat.MaVT
		group by Ton.MaVT, Ton.TenVT,SoluongN, SoluongX, DonGiaN, DonGiaX, NgayN, NgayX

select *from C5
-- Cau6
create view C6 as
select Ton.MaVT, Ton.TenVT, sum(SoluongN) - sum(SoluongX) + sum(SoluongT) as TongTon
from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
		inner join Xuat on Ton.MaVT = Xuat.MaVT
where year(NgayN) = 2020
group by Ton.MaVT, Ton.TenVT

select*from C6
--cau a
create view cau_a as
select Ton.TenVT,sum(SoluongN) as TongNhap
from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
where year(NgayN) = 2021
group by Ton.TenVT

select*from cau_a
--Caub
create view cau_b as
select Ton.TenVT, sum(SoluongX*DongiaX) as TongTienX
from Xuat inner join Ton on Xuat.MaVT = Ton.MaVT
where year(NgayX) = 2021
group by Ton.TenVT

select*from cau_b
--Cauc
create view c as
select SoHDN, sum(SoluongN*DongiaN) as TongTienN
from Nhap
where month(NgayN) = 1 and year(NgayN) = 2021
group by SoHDN
having sum(SoluongN*DongiaN) >= 100000

select*from c
--Cau d
create view d as
select Ton.MaVT, TenVT
from Ton inner join Nhap on Nhap.MaVT=Ton.MaVT
		inner join Xuat on Ton.MaVT=Xuat.MaVT
	where year(NgayN) = 2021 and year(NgayX) = 2021

select*from d
--Caue
create view cau_e as
select Ton.MaVT, TenVT from Ton
where Ton.MaVT not in (select Ton.MaVT
						from Ton inner join Nhap on Ton.MaVT=Nhap.MaVT)
				 and  Ton.MaVT not in (select Ton.MaVT						
				    	from Ton inner join Xuat on Ton.MaVT=Xuat.MaVT)
						
select*from cau_e

--Ham
--cau a
create function f_Tong(@x int, @y int)
Returns int
as
begin  
	declare @Tong int
	set @Tong = (select sum(SoluongN*DongiaN)
	from Nhap where year(NgayN) between @x and @y)
	return @Tong
end

select dbo.f_Tong(2020,2021)

--caub
alter function f_TongSl(@TenVT nvarchar(20), @y int)
Returns int
as
begin
	declare @TK int
	set @TK = (select sum(SoluongN) - sum(SoluongX)
				from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
						  inner join Xuat on Ton.MaVT = Xuat.MaVT
				where TenVT = @TenVT and year(NgayN) = @y)
	return @TK
end

select dbo.f_TongSl('Dien thoai',2021)

--cau c
create function f_TongGT(@x int, @y int)
Returns int
as
begin  
	declare @Tong int
	set @Tong = (select sum(SoluongN*DongiaN)
	from Nhap where Day(NgayN) between @x and @y)
	return @Tong
end

select dbo.f_TongGT(01,12)

--cau d
create function f_TongX(@A nvarchar(20),@x int)
Returns int
as
begin  
	declare @TX int
	set @TX = (select sum(SoluongX*DongiaX)
	from Xuat inner join Ton on Xuat.MaVT=Ton.MaVT
	where TenVT = @A and year(NgayX) = @x)
	return @TX
end

select dbo.f_TongX('Dieu hoa',2021)

--Cau e
create function f_ThongKe(@x nvarchar(20),@y int)
Returns int
as
begin  
	declare @Tk int
	set @Tk = (select count(SoHDX)
	from Xuat inner join Ton on Xuat.MaVT=Ton.MaVT
	where TenVT = @x and day(NgayX) = @y)
	return @Tk
end

select dbo.f_Thongke('Dien thoai',15)

--cau f
create function f_Tong_Sl(@x nvarchar(20),@y int)
Returns int
as
begin
	declare @TK int
	set @TK = (select sum(SoluongN) - sum(SoluongX)
				from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
						  inner join Xuat on Ton.MaVT = Xuat.MaVT
				where TenVT = @x and year(NgayN) = @y)
	return @TK
end

select dbo.f_Tong_Sl('Dieu hoa',2021)