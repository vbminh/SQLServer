create database QLSACH

create table TacGia
(
maTG nchar(10) not null primary key,
tenTG nvarchar(20) not null,
SLco int
)
create table Sach
(
maSach nchar(10) not null primary key,
tenSach nvarchar(20) not null,
maNXb nchar(10) not null,
maTG nchar(10) not null,
namXB date not null,
SL int,
DG float,
constraint fk_Sach_maTG foreign key(maTG) references TacGia(maTG)
on delete cascade on update cascade
)
create table NhaXB
(
maNXb nchar(10) not null primary key,
tenNXb nvarchar(20) not null,
SLco int,
)

insert into TacGia values('H01','Vu Binh Minh','100'),('H02','Nguyen Khanh An','90'),('H03','Nguyen Khanh Binh','80')
insert into Sach values('S01','Lich Van Nien','N01','H02','2007','50','70000'),('S02','Co So Du Lieu','N03','H01','2003','80','75000'),('S03','Toan Cao Cap','N02','H03','2009','40','34000'),('S04','Toan Roi Rac','N03','H02','2005','70','80000')
insert into NhaXB values('N01','Nguyen Ha Trang','30'),('N02','Cu Trong Xoay','50'),('N03','Alan Walker','90')
--Cau 1
select NhaXB.maNXb, tenNXb, sum(SLco*DG) as TienBan from NhaXB inner join Sach on Sach.maNXb = NhaXB.maNXb
group by NhaXB.maNXb, tenNXb
--Cau 2
create view TienBan as
select TacGia.maTG,sum(SLco*DG) as TienBan from TacGia inner join Sach on TacGia.maTG=Sach.maTG
group by TacGia.maTG