create database QLBanHang

create table Congty
(	MaCongTy nchar(10) not null primary key,
	TenCongTy nvarchar(20) not null,
	Diachi nvarchar(20) not null)

create table SanPham
(	MaSanPham nchar(10) not null primary key,
	TenSanPham nvarchar(20) not null,
	SoLuongCo int,
	GiaBan float)

create table CungUng
(	MaCongTy nchar(10) not null,
	MaSanPham nchar(10) not null,
	SoLuongCungUng int,
	constraint sk_CungUng primary key (MaCongTy,MaSanPham))

--nhap dl
insert into Congty values('CT01','ABC','Ha Noi'),('CT02','ZXC','Bac Ninh'),('CT03','QWE','Hai Phong')
insert into SanPham values('SP01','Kem','100','5000'),('SP02','Sach','75','20000'),('SP03','Ban','50','200000')
insert into CungUng values('CT01','SP01','10'),('CT02','SP02','20'),('CT03','SP03','30'),('CT01','SP03','15'),('CT03','SP02','5')
--Xem dl
select*from Congty
select*from SanPham
select*from CungUng

--Cau 2
alter view cau_2
as
select SanPham.MaSanPham,TenSanPham,sum(SoLuongCo) as SoLuongCo,sum(SoLuongCungUng) as SoLuongCungUng
from SanPham inner join CungUng on SanPham.MaSanPham = CungUng.MaSanPham
group by SanPham.MaSanPham,TenSanPham


--thuc thi
select*from cau_2

--Cau 3
alter proc sp_them(@mact nchar(10),@tenct nvarchar(20),@dc nvarchar(20),@kq int output)
as
	begin
		if(exists(select*from Congty where TenCongTy = @tenct))
			set @kq = 1
		else
			begin
			insert into Congty values(@mact,@tenct,@dc)
			set @kq = 0
			end
			return @kq
	end

--Truong hop sai
declare @kq int
exec sp_them 'CT04','ABC','Quang Ninh', @kq output
select @kq

--Truong hop dung

select*from Congty
declare @kq int
exec sp_them 'CT04','MNB','Quang Ninh', @kq output
	select*from Congty
select @kq

--Cau 4
create trigger trg_update
on CungUng
for update
as
	if(@@ROWCOUNT > 1)
	begin
		raiserror('Khong the cap nhat nhieu ban ghi cung luc',16,1)
		rollback transaction
	end
	else
		declare @masp nchar(10),@moi int, @cu int, @sl int
		select @masp = MaSanPham, @cu = SoLuongCungUng from deleted
		select @moi = SoLuongCungUng from inserted
		select @sl = SoLuongCo from SanPham where MaSanPham = @masp
		if(@sl < (@moi - @cu))
			begin
				raiserror('Du lieu khong hop le',16,1)
				rollback transaction
			end
		else
			update SanPham set SoLuongCo = SoLuongCo + (@moi - @cu)
			from SanPham where MaSanPham = @masp


--truong hop sai
update CungUng set SoLuongCungUng = 50 where MaSanPham = 'SP02'

update CungUng set SoLuongCungUng = 1000 where MaSanPham = 'SP01'

--truong hop dung
select*from CungUng
select*from SanPham
update CungUng set SoLuongCungUng = 20 where MaSanPham = 'SP01'
	select*from CungUng
	select*from SanPham
