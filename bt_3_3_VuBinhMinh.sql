--tao csdl
create database Khoa
--bang khoa
create table Khoa
(
	makhoa nchar(10) not null primary key,
	tenkhoa nvarchar(20) not null,
	dienthoai char(12)
)
--bang lop
create table Lop
(
	malop nchar(10) not null primary key,
	tenlop nvarchar(20) not null,
	hedt char(12),
	namnhaphoc int,
	makhoa nchar(10),
	constraint fk_Lop foreign key (makhoa) references Khoa(makhoa)
	on update cascade on delete cascade
)
-------chen dl
---thu tuc them
	create proc SP_Nhapkhoa(@makhoa int, @tenkhoa nvarchar(20), @dienthoai nvarchar(12))
	as
		begin
			if(exists(select*from Khoa where tenkhoa = @tenkhoa))
				print 'Ten khoa '+@tenkhoa +'da ton tai'
			else
				insert into Khoa values(@makhoa,@tenkhoa,@dienthoai)
	end
--------TEST
select*from Khoa
exec SP_Nhapkhoa 9,'Tivi','212121'
	select*from Khoa
exec SP_Nhapkhoa 6,'Dien tu','234545'

----thu tuc xoa
create proc SP_xoa(@makhoa int)
as
	begin
		if(not exists(select*from Khoa where makhoa = @makhoa))
			print 'Ma khoa khong ton tai'
		else
			delete Khoa where makhoa=@makhoa
end
----test
select*from Khoa
exec SP_xoa 9
	select*from Khoa
------sua
alter proc SP_Sua(@makhoa char(10), @tenkhoa nvarchar(20), @dienthoai nvarchar(12))
as 
	begin
		if(not exists(select*from Khoa where makhoa=@makhoa))
			print 'Ma khoa'+@makhoa +'khong ton tai'
		else
			update Khoa set tenkhoa=@tenkhoa, dienthoai=@dienthoai
			where makhoa=@makhoa
end
-----test
select*from Khoa
exec SP_Sua 6,'CNTT','3456543'
	select*from Khoa
exec SP_Sua 7,'tttt','2345345'
--tim kiem
create proc SP_tk(@makhoa int)
as
	begin
		if(not exists(select*from Khoa where makhoa = @makhoa))
			print 'Ma khoa khong ton tai'
		else
			select*from Khoa where makhoa=@makhoa
end
---test
exec SP_tk 9
exec SP_tk 4

--tao csdl
create database QLBanHang
--bang cung ung
create table CungUng
(
	MaCT nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongCungUng int,
	constraint pk_CungUng primary key(MaCT,MaSP),
	constraint fk1_CungUng foreign key(MaCT) references CongTy(MaCT)
	on update cascade on delete cascade
	constraint fk2_CungUng foreign key(MaSP) references SanPham(MaSP)
	on update cascade on delete cascade
	)
--bang cong ty
create table CongTy
(
	MaCT nchar(10) not null primary key,
	TenCT nvarchar(20) not null,
	Trangthai char(10),
	ThanhPho nvarchar(20))
--bang san pham
create table SanPham
(
	MaSP nchar(10) not null primary key,
	MauSac nchar(10) not null,
	SoLuong int,
	GiaBan float)
--a
insert into CungUng values('CT1','SP1','10'),
						  ('CT2','SP2','20'),
						  ('CT3','SP3','30'),
						  ('CT4','SP4','40'),
						  ('CT5','SP5','50')
insert into CongTy values('CT1','ABC','Tot','Ha Noi'),
						 ('CT3','QWE','Trung Binh','Hai Phong'),
						 ('CT5','ZXC','Kem','Da Nang')
insert into SanPham values('SP1','Do','20','10000'),
						  ('SP2','Vang','40','30000'),
						  ('SP5','Xanh','60','50000')
--b
alter proc SP_Danhsach(@TenCT char(10))
as
	begin
		if(not exists(select*from CongTy where TenCT = @TenCT))
			print 'Ten cong ty'+ @TenCT +' khong ton tai'
		else
			select*from SanPham inner join CungUng on SanPham.MaSP=CungUng.MaSP
								inner join CongTy on CongTy.MaCT=CungUng.MaCT
			 where TenCT = @TenCT
		
end
--test
exec SP_Danhsach 'ABC'

--c
alter proc SP_ThenCT(@MaCT char(10), @TenCT nvarchar(20), @TrangThai nvarchar(12),@ThanhPho nvarchar(20))
	as
		begin
			if(exists(select*from CongTy where TenCT = @TenCT))
				print 'Ten cong ty '+@TenCT +' da ton tai'
			else
				insert into CongTy values(@MaCT,@TenCT,@TrangThai,@ThanhPho)
	end
--test
select*from CongTy
exec SP_ThenCT 'CT4','FGH','tot','Phu Tho'
	select*from CongTy

--d
create proc SP_XoaCT(@ThanhPho nvarchar(20))
as
	begin
		if(not exists(select*from CongTy where ThanhPho = @ThanhPho))
			print 'Ten thanh pho'+ @ThanhPho +' khong ton tai'
		else
			delete Congty where ThanhPho=@ThanhPho
end
--test
select*from CongTy
exec SP_XoaCT 'Da Nang'
	select*from CongTy