create database Phieu8

create table Khoa
(
	Makhoa nchar(10) not null primary key,
	Tenkhoa nvarchar(20) not null,
	Dienthoai char(12)
)

create table Lop
(
	Malop nchar(10) not null primary key,
	Tenlop nvarchar(20) not null,
	Khoa nchar(10) not null,
	Hedt nchar(12) not null,
	Namnhaphoc int,
	Makhoa nchar(10),
	constraint fk1 foreign key(Makhoa) references Khoa(Makhoa)
	on update cascade on delete cascade
)
--them dl
insert into Khoa values('K01','CNTT','12345'),('K02','Ke toan','54326'),('K03','Du lich','09876')
insert into Lop values('L01','KT','14','dh','2021','K02'),('L02','HTTT','13','cd','2019','K01')

select*from Khoa
select*from Lop

--BT1
create proc sp_nhapkhoa(@Makhoa nchar(10),@Tenkhoa nvarchar(20),@Dienthoai char(12))
as
	begin
		if(exists(select*from Khoa where Tenkhoa=@Tenkhoa))
			print 'Ten khoa' + @Tenkhoa +' da ton tai'
		else
			insert into Khoa values(@Makhoa,@Tenkhoa,@Dienthoai)
	end

select*from Khoa
exec sp_nhapkhoa 'K01','CNTT','12345'
exec sp_nhapkhoa 'K04','Dien','87654'
	select*from Khoa

--BT2
create proc sp_nhaplop(@Malop nchar(10), @Tenlop nvarchar(20), @Khoa char(14), @Hedt char(12), @Namnhaphoc int, @Makhoa nchar(10))
as
	begin
		if(exists(select*from Lop where Tenlop = @Tenlop))
			print 'Ten lop ' + @Tenlop + ' da ton tai'
		else if(not exists(select*from Khoa where Makhoa = @Makhoa))
			print 'Ma khoa ' + @Makhoa + ' chua ton tai'
		else
			insert into Lop values(@Malop,@Tenlop,@Khoa,@Hedt,@Namnhaphoc,@Makhoa)
	end

exec sp_nhaplop 'L05','KT','12','dh','2018','k01'
exec sp_nhaplop 'L03','ABC','15','dh','2021','K05'
exec sp_nhaplop 'L07','wer','13','cd','2019','K02'
	select*from Lop

--BT3
create proc sp_nhapkhoa3(@makhoa char(10), @tenkhoa nvarchar(20), @dienthoai char(12),@kq int output)
as
	begin
		if(exists(select*from Khoa where Tenkhoa=@tenkhoa))
			set @kq=0
		else 
		insert into Khoa values(@makhoa,@tenkhoa,@dienthoai)
		return @kq
	end

declare @Error int
exec sp_nhapkhoa3 'K01','CNTT','87653', @Error output
select @Error

declare @Error int
exec sp_nhapkhoa3 'K08','TCNH','76543', @Error output
	select*from Khoa

--BT4
create proc sp_nhaplop4 (@malop char(10), @tenlop nvarchar(20), @khoa char(10), @hedt char(10), @namnhaphoc int, @makhoa char(10), @kq int output)
as
	begin
		if(exists(select*from Lop where Tenlop = @tenlop))
			set @kq = 0
		else if(not exists(select*from Khoa where Makhoa = @makhoa))
			set @kq = 1
		else
			insert into Lop values(@malop,@tenlop,@khoa,@hedt,@namnhaphoc,@makhoa)
			return @kq
	end

declare @error int
exec sp_nhaplop4 'L04','CNTT','12','dh','2019','K01',@error output
select @error

declare @error int
exec sp_nhaplop4 'L06','QHQT','11','dh','2017','K09',@error output
select @error

declare @error int
exec sp_nhaplop4 'L09','URF','11','cd','2017','K07',@error output
	select*from Lop


--Phieu 2
create database QLNV

create table Chucvu
(	MaCV nvarchar(2) not null primary key,
	TenCV nvarchar(20))

create table Nhanvien
(	MaNV nvarchar(4) not null primary key,
	MaCV nvarchar(2) not null,
	TenNV nvarchar(30),
	NgaySinh datetime,
	LuongCoBan float,
	Ngaycong int,
	Phucap float,
	constraint fk foreign key(MaCV) references Chucvu(MaCV)
	on update cascade on delete cascade)

--nhap dl
insert into Chucvu values('BV','Bao ve'),('GD','Giam doc'),('HC','Hanh chinh'),('KT','Ke toan'),('TQ','Thu quy'),('VS','Ve sinh')
insert into Nhanvien values('NV01','GD','Nguyen Van An','12/12/1977','700000','25','500000'),
						   ('NV02','BV','Bui Van Ti','10/10/1978','400000','24','100000'),
						   ('NV03','KT','Tran Thanh Nhat','9/9/1977','600000','26','400000'),
						   ('NV04','VS','Nguyen Thi Ut','10/10/1980','300000','26','300000'),
						   ('NV05','HC','Le Thi Ha','10/10/1979','500000','27','200000')

select*from Chucvu
select*from Nhanvien

--a
create proc sp_themnv(@manv nvarchar(4),@macv nvarchar(2),@tennv nvarchar(30),@ngaysinh datetime, 
                      @luongcanban float,@ngaycong int,@phucap float)
as
    begin 
      if(not exists(select * from Chucvu where MaCV=@macv))
		print 'khong co chuc vu nay'
	  else 
		insert into Nhanvien values(@manv,@macv,@tennv,@ngaysinh,@luongcanban,@ngaycong,@phucap) 
   end

--truong hop 1
exec sp_themnv 'NV06','KK','Nguyen Van A','1/1/1979','1000000','30','900000'
--truong hop 2
exec sp_themnv 'NV08','GD','Nguyen Van A','1/1/1979','1000000','30','900000'
	select*from Nhanvien

--b
create proc sp_capnhatnv(@manv nvarchar(4),@macv nvarchar(2),@tennv nvarchar(30),@ngaysinh datetime, 
                      @luongcanban float,@ngaycong int,@phucap float)
as
    begin 
      if(not exists(select * from Chucvu where MaCV=@macv))
		print 'khong co chuc vu nay'
	  else 
		update Nhanvien set MaCV=@macv, TenNV=@tennv, NgaySinh=@ngaysinh, LuongCoBan=@luongcanban, Ngaycong=@ngaycong, Phucap=@phucap
		where MaNV=@manv
   end

--Truong hop 1
exec sp_capnhatnv 'NV07','TT','Pham Thi B','2/2/1978','999999','21','444444'
--truong hop 2
exec sp_capnhatnv 'NV01','GD','Pham Thi B','2/2/1978','999999','21','444444'
	select*from Nhanvien

--c
create proc sp_luongLN
as
	begin
		select MaNV, Nhanvien.LuongCoBan*Nhanvien.Ngaycong + Nhanvien.Phucap as Luong
		from Nhanvien
	end

exec sp_luongLN