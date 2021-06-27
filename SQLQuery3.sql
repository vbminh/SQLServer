create database QuanLyDaoTao

create table HocVien
(
	MaHv nchar(10) not null primary key,
	TenHv nvarchar(20) not null,
	DiaChi nvarchar(20) not null,
	NgaySinh date
)

create table MonHoc
(
	MaMh nchar(10) not null primary key,
	TenMh nvarchar(20) not null,
	MoTa nvarchar(20)
)

create table Diem
(
	MaHv nchar(10) not null,
	MaMh nchar(10) not null,
	DiemPra float,
	DiemQFX float,
	NgayThi date,
	constraint pk_Diem primary key(MaHv,MaMh)
)

--cau1: nhap dl
insert into HocVien values('HV01','Nguyen Van A','Ha Noi','01/12/2000'),
						  ('HV02','Nguyen Thi B','Yen Bai','02/21/2000'),
						  ('HV03','Tran Van C','Nghe An','05/10/2000')
insert into MonHoc values('IT6012','CSDL','Co so du lieu'),('IT6013','HDH','He dieu hanh')
insert into Diem values('HV01','IT6012',8,9,'12/12/2020'),
						('HV02','IT6013',5,7,'12/20/2020'),
						('HV03','IT6013',8,10,'03/13/2021'),
						('HV04','IT6012',10,7,'05/10/2021')
--thuc thi
select*from HocVien
select*from MonHoc
select*from Diem

--cau2: tao thu tuc luu tru
create proc prcDanhSachHV(@mahv nchar(10))
as
begin
	if(not exists(select*from HocVien where MaHv = @mahv))
		print 'Hoc vien nay khong ton tai'
	else
		select TenHv, DiaChi, TenMh, DiemPra, DiemQFX
		from HocVien inner join Diem on HocVien.MaHv = Diem.MaHv
					 inner join MonHoc on MonHoc.MaMh = Diem.MaMh
			where HocVien.MaHv = @mahv
end

--thuc thi cau lenh
--Sai
exec prcDanhSachHV '07042'
--Dung
exec prcDanhSachHV 'HV02'

--cau3
create function DIEMMON(@mamon nchar(10))
returns @bang table(MaHv nchar(10),TenHv nvarchar(20),DiemPra float, DiemQFX float)
as
begin
	Insert into @bang
		select HocVien.MaHv,TenHv, DiemPra, DiemQFX 
		from HocVien inner join Diem on HocVien.MaHv = Diem.MaHv
					 inner join MonHoc on MonHoc.MaMh = Diem.MaMh
			where MonHoc.MaMh = @mamon
	return
end
--goi ham
Select*from DIEMMON('IT6012')
