create database De1

create table Sach
(
	Masach nchar(10) not null primary key,
	tensach nvarchar(20) not null,
	slco int,
	ngayxb date
)

create table NXB
(
	MaNXB nchar(10) not null primary key,
	TenNXB nvarchar(20) not null
)

create table XuatSach
(
	MaNXB nchar(10) not null,
	Masach nchar(10) not null,
	soluong int,
	gia float,
	constraint pk_XuatSach primary key(MaNXB,Masach)
)

insert into Sach values('S01','abc',20,'01/12/2001'),
					   ('S02','tyu',50,'05/10/2009'),
					   ('S03','nbv',70,'11/02/2012')
insert into NXB values('N01','Tuoi Tre'),('N02','Thanh Nien')
insert into XuatSach values('N01','S01',10,100000),('N02','S02',25,90000),('N01','S03',50,250000),('N02','S01',5,150000),('N01','S02',2,85000)

select*from Sach
select*from NXB
select*from XuatSach

--cau 2
create proc sp_update(@masach nchar(10),@ngay date)
as
begin
	if(not exists(select*from Sach where Masach = @masach))
		print 'Sach khong ton tai'
	else
		begin
			if(exists(select*from Sach where ngayxb = @ngay))
				print 'Khong the sua'
			else
				if(@ngay > GETDATE())
					print 'Khong the sua'
				else
					update Sach set ngayxb = @ngay where Masach = @masach
		end
end

exec sp_update 'S05','01/01/2001'
exec sp_update 'S02','05/09/2022'

select*from Sach
exec sp_update 'S01','03/15/2019'
	select*from Sach

--cau 3
alter trigger trg_insert
on Sach
for insert
as
begin
	declare @masach nchar(10), @ngay date
	select @masach = Masach from inserted
			if(@ngay > GETDATE())
				begin
					raiserror ('Du lieu khong chinh xac',16,1)
					rollback transaction
				end
end

insert into Sach values('S05','hgf',10,'10/22/2043')

select*from Sach
insert into Sach values('S06','hgf',10,'10/22/2003')
select*from Sach

create database De2

create table SanPham
(
	MaSP nchar(10) not null primary key,
	Tensp nvarchar(20) not null,
	Mausac nchar(10),
	Soluong int,
	Giaban float
)

create table CongTy
(
	MaCT nchar(10) not null primary key,
	TenCT nvarchar(20) not null,
	Trangthai nvarchar(20),
	Thanhpho nvarchar(20)
)

create table CungUng
(
	MaCT nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongCungUng int,
	constraint pk_CungUng primary key(MaCT,MaSP)
)

insert into SanPham values('S01','ABC','Den',100,10000),('S02','DNC','Do',50,20000),('S03','AMBC','Trang',150,55000)
insert into CongTy values('CT01','SamSung','Tot','Ha Noi'),('CT02','Viettel','Tot','Da Nang'),('CT03','Sony','Tot','Hai Phong')
insert into CungUng values('CT01','SP01',20),('CT02','SP02',30),('CT03','SP03',15),('CT01','SP02',5),('CT02','SP03',100)

select*from SanPham
select*from CongTy
select*from CungUng

--cau2
create proc sp_delete (@masp nchar(10))
as
begin
	if(not exists(select*from SanPham where MaSP = @masp))
		print 'Khong ton tai ma san pham'
	else
		begin
			declare @sl int
			select @sl = Soluong from SanPham where MaSP = @masp
			if(@sl > 60)
				print 'Khong duoc xoa san pham nay'
			else
				delete SanPham where MaSP = @masp
		end
end

exec sp_delete 'SP11'
exec sp_delete 'S01'
select*from SanPham
exec sp_delete 'S02'
	select*from SanPham

--Cau3
create trigger trg_insert
on CungUng
for insert
as
begin
	declare @slcu int,@sl int, @masp nchar(10)
	select @masp = MaSP from inserted
	select @sl = Soluong from SanPham where MaSP = @masp
	if(@slcu > @sl)
		begin
			raiserror('Khong the nhap',16,1)
			rollback transaction
		end
end

insert into CungUng values('CT01','SP03',1000)
select*from CungUng
select*from SanPham
insert into CungUng values('CT01','SP03',10)
	select*from CungUng