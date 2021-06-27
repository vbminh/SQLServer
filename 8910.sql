create database DE8

create table Khoa
(
	Makhoa nchar(10) not null primary key,
	Tenkhoa nvarchar(20) not null
)

create table Lop
(
	Malop nchar(10) not null primary key,
	Tenlop nvarchar(20) not null,
	Siso int,
	Makhoa nchar(10) not null
)

create table SinhVien
(
	Masv nchar(10) not null primary key,
	Hoten nvarchar(10) not null,
	Ngaysinh date,
	Gioitinh bit,
	Malop nchar(10) not null
)


insert into Khoa values('K01','CNTT'),('K02','Du lich')
insert into Lop values('L01','KTPM',50,'K01'),('L02','Du lich',60,'K02')
insert into SinhVien values('SV01','Nguyen A','12/12/2000',0,'L02'),
							('SV02','Nguyen B','12/12/2000',1,'L01'),
							('SV03','Nguyen C','12/12/2000',1,'L01'),
							('SV04','Nguyen D','12/12/2000',0,'L02'),
							('SV05','Nguyen E','12/12/2000',0,'L01'),
							('SV06','Nguyen F','12/12/2000',1,'L02'),
							('SV07','Nguyen G','12/12/2000',0,'L02')

select*from Khoa
select*from Lop
select*from SinhVien

--cau2
create proc sp_search(@makhoa nchar(10))
as
begin
	select Masv,Hoten,Ngaysinh,case Gioitinh
								when 1 then 'nam'
								else 'nu'
								end,Tenlop, Tenkhoa
	from SinhVien inner join Lop on SinhVien.Malop = Lop.Malop
				  inner join Khoa on Khoa.Makhoa = Lop.Makhoa
		where Khoa.Makhoa = @makhoa
end

exec sp_search 'K01'

--cau3
create trigger trg_insert
on SinhVien
for insert
as
begin
	declare @tuoi int, @ngay date
	select @ngay = Ngaysinh from inserted
	select @tuoi = datediff(year,@ngay,getdate())
	if(@tuoi < 18)
		begin
			raiserror('Khong the them sinh vien nay!',16,1)
			rollback transaction 
		end
end

insert into SinhVien values('SV08','Nguyen G','12/12/2005',0,'L01')

select*from SinhVien
insert into SinhVien values('SV08','Nguyen G','12/12/1999',0,'L01')
	select*from SinhVien

create database De9

create table BenhVien
(
	MaBV nchar(10) not null primary key,
	TenBV nvarchar(20) not null
)

create table KhoaKham
(
	Makhoa nchar(10) not null primary key,
	Tenkhoa nvarchar(20) not null,
	SoBN int,
	MaBV nchar(10) not null
)

create table BenhNhan
(
	MaBN nchar(10) not null primary key,
	Hoten nvarchar(20) not null,
	Ngaysinh date,
	Gioitinh bit,
	SongayNV int,
	Makhoa nchar(10) not null
)

insert into BenhVien values('BV01','BV A'),('BV02','BV B')
insert into KhoaKham values('K01','Hoi suc',7,'BV01'),('K02','Cap cuu',10,'BV02')
insert into BenhNhan values('BN01','Nguyen G','11/11/1999',0,12,'K01'),
							('BN02','Nguyen F','11/11/1999',1,7,'K02'),
							('BN03','Nguyen E','11/11/1999',0,15,'K02'),
							('BN04','Nguyen D','11/11/1999',1,6,'K01'),
							('BN05','Nguyen C','11/11/1999',0,5,'K02'),
							('BN06','Nguyen B','11/11/1999',0,10,'K01'),
							('BN07','Nguyen A','11/11/1999',1,8,'K01')

select*from BenhVien
select*from KhoaKham
select*from BenhNhan

--cau2
alter proc sp_search(@makhoa nchar(10))
as
begin
	select Tenkhoa,count(MaBN) as Songuoi from BenhNhan inner join KhoaKham on BenhNhan.Makhoa = KhoaKham.Makhoa
		where Gioitinh = 0 and BenhNhan.Makhoa = @makhoa
		group by Tenkhoa
end

exec sp_search 'K01'

--cau3
create trigger trg_insert
on BenhNhan
for insert
as
begin
	declare @makhoa nchar(10)
	select @makhoa = Makhoa from inserted
	if(not exists(select*from Khoa where Makhoa = @makhoa))
		begin
			raiserror ('Ma khoa khong ton tai!',16,1)
			rollback transaction 
		end
	else
		update KhoaKham set SoBN = SoBN + 1 where Makhoa = @makhoa
end

insert into BenhNhan values('BN08','Nguyen A','11/11/1999',1,8,'K03')

select*from BenhNhan
select*from KhoaKham
insert into BenhNhan values('BN08','Nguyen A','11/11/1999',1,9,'K02')
	select*from BenhNhan
	select*from KhoaKham

create database De10

create table Khoa
(
	Makhoa nchar(10) not null primary key,
	Tenkhoa nvarchar(20) not null
)

create table Lop
(
	Malop nchar(10) not null primary key,
	Tenlop nvarchar(20) not null,
	Siso int,
	Makhoa nchar(10) not null
)

create table SinhVien
(
	Masv nchar(10) not null primary key,
	Hoten nvarchar(10) not null,
	Ngaysinh date,
	Gioitinh bit,
	Malop nchar(10) not null
)


insert into Khoa values('K01','CNTT'),('K02','Du lich')
insert into Lop values('L01','KTPM',50,'K01'),('L02','Du lich',60,'K02')
insert into SinhVien values('SV01','Nguyen A','12/12/2000',0,'L02'),
							('SV02','Nguyen B','12/12/2000',1,'L01'),
							('SV03','Nguyen C','12/12/2000',1,'L01'),
							('SV04','Nguyen D','12/12/2000',0,'L02'),
							('SV05','Nguyen E','12/12/2000',0,'L01'),
							('SV06','Nguyen F','12/12/2000',1,'L02'),
							('SV07','Nguyen G','12/12/2000',0,'L02')

select*from Khoa
select*from Lop
select*from SinhVien

--cau2
alter proc sp_search(@tutuoi int,@dentuoi int,@tenlop nvarchar(20))
as
begin
	select Masv,Hoten,Ngaysinh,Tenlop,Tenkhoa, datediff(year,Ngaysinh,GETDATE()) as Tuoi
	from SinhVien inner join Lop on Lop.Malop = SinhVien.Malop
					inner join Khoa on Khoa.Makhoa = Lop.Makhoa
		where datediff(year,Ngaysinh,GETDATE()) between @tutuoi and @dentuoi
		and Tenlop = @tenlop
end

exec sp_search 18,21,'KTPM'

--cau 3
alter trigger trg_delete
on SinhVien
for delete
as
begin
	declare @dem int,@ns date,@malop nchar(10)
	select @ns = Ngaysinh,@malop = Malop from deleted
	select @dem = count(MaSV) from SinhVien where datediff(year,Ngaysinh,GETDATE()) > 21
	if(datediff(year,@ns,GETDATE()) > 21)
		update Lop set Siso = Siso - @dem where Malop = @malop
end

select*from SinhVien
delete SinhVien where datediff(year,Ngaysinh,GETDATE()) >21
select*from SinhVien