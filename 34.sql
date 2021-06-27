create database de3

create table CongTy
(
	MaCT nchar(10) not null primary key,
	TenCT nvarchar(20) not null,
	Trangthai nvarchar(20),
	Thanhpho nvarchar(20)
)

create table SanPham
(
	MaSP nchar(10) not null primary key,
	TenSP nvarchar(20) not null,
	Mausac nchar(10),
	Soluong int,
	Dongia float
)

create table CungUng
(
	MaCT nchar(10) not null,
	MaSP nchar(10) not null,
	Soluongcungung int,
	constraint pk_CungUng primary key(MaCT,MaSP)
)

insert into CongTy values('CT01','ABC','Tot','Ha Noi'),('CT02','MJD','Binh thuong','Hai Duong'),('CT03','RTG','Tot','Nam Dinh')
insert into SanPham values('SP01','abv','do',100,10000),('SP02','ytv','trang',70,5000),('SP03','fgh','den',50,25000)
insert into CungUng values('CT01','SP01',50),('CT02','SP02',20),('CT03','SP03',15),('CT01','SP02',5),('CT02','SP03',31)

select*from CongTy
select*from SanPham
select*from CungUng

--Cau2
create proc sp_show (@tenct nvarchar(20))
as
begin
	if(not exists(select*from CongTy where TenCT = @tenct))
		print 'Ten cong ty ' + @tenct + ' khong ton tai'
	else
		select TenSP,Mausac,Soluong,Dongia from SanPham inner join CungUng on SanPham.MaSP = CungUng.MaSP
							inner join CongTy on CongTy.MaCT = CungUng.MaCT
							where TenCT = @tenct
end

exec sp_show 'iop'

select*from CongTy
select*from SanPham
select*from CungUng
exec sp_show 'MJD'

--cau3
alter trigger trg_update
on CungUng
for Update
as
begin
	if(@@ROWCOUNT > 1)
		begin
			raiserror ('Khong the cap nhat nhieu ban ghi',16,1)
			rollback transaction
		end
	else
	begin
	declare @masp nchar(10),@sl int,@slc int,@slm int
	select @masp = MaSP,@slc = Soluongcungung from deleted
	select @slm = Soluongcungung from inserted
	if(not exists(select*from SanPham where MaSP = @masp))
		begin
			raiserror ('San pham khong ton tai',16,1)
			rollback transaction
		end
	else
		begin
			select @sl = Soluong from SanPham where MaSP = @masp
			if((@slm - @slc) > @sl)
				begin
					raiserror ('Khong the cap nhat',16,1)
					rollback transaction
				end
			else
				update SanPham set Soluong = Soluong - @slc + @slm
				where MaSP = @masp
		end
	end
end

update CungUng set Soluongcungung = 10 where MaSP = 'SP05'
update CungUng set Soluongcungung = 1000 where MaSP = 'SP01'

select*from CungUng
select*from SanPham

update CungUng set Soluongcungung = 60 where MaSP = 'SP01'
	select*from CungUng
	select*from SanPham

create database De4

create table NhanVien
(
	MaNV nchar(10) not null primary key,
	TenNV nvarchar(20) not null,
	GioiTinh nchar(4),
	Hesoluong int
)

create table DuAn
(
	MaDA nchar(10) not null primary key,
	TenDA nvarchar(20) not null,
	Ngaybatdau date,
	SoluongNV int
)

create table ThamGia
(	
	MaNV nchar(10) not null,
	MaDA nchar(10) not null,
	NhiemVu nvarchar(20),
	constraint pk_ThamGia primary key(MaNV,MaDA)
)

insert into NhanVien values('NV01','Nguyen A','Nam',3.5),('NV02','Nguyen B','Nam',5),('NV03','Nguyen C','Nu',4)
insert into DuAn values('D01','DAA','12/21/2019',30),('D02','DAB','1/10/2020',10),('D03','DAC','10/12/2015',15)
insert into ThamGia values('NV01','D01','Quan ly'),('NV02','D02','Ke toan'),('NV03','D03','Thuc hien'),('NV01','D02','Quan ly'),('NV02','D03','Thuc hien'),('NV01','D03','Giam sat'),('NV02','D01','Thuc hien')

select*from NhanVien
select*from DuAn
select*from ThamGia

--cau2
create proc sp_update (@manv nchar(10),@hs float)
as
begin
	if(not exists(select*from NhanVien where MaNV = @manv))
		print 'Khong co nhan vien nay'
	else
		begin
			declare @luong float
			select @luong = Hesoluong from NhanVien where MaNV = @manv
			if(@hs < @luong)
				print 'He so luong moi khong hop le'
			else
				update NhanVien set Hesoluong = @hs
				where MaNV = @manv
		end
end

exec sp_update 'NV00',6
exec sp_update 'NV01',2

select*from NhanVien
exec sp_update 'NV02',6
	select*from NhanVien

--Cau3
alter trigger trg_insert
on ThamGia
for insert
as
begin
	declare @manv nchar(10), @hsl float, @mada nchar(10)
	select @manv = MaNV,@mada = MaDA from inserted
	select @hsl = Hesoluong from NhanVien where MaNV = @manv
	if(@hsl > 4)
		begin
			raiserror('Khong the them',16,1)
			rollback transaction
		end
	else
		update DuAn set SoluongNV = SoluongNV + 1 where MaDA = @mada
end


insert into ThamGia values('NV03','D02','Chu thau')