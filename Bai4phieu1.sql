create database QuanLyBanHang11

create table HangSX
(
maHangSx nchar(10) not null primary key,
tenHang nvarchar(20) not null,
diaChi nvarchar(30) not null,
soDT nvarchar(20) not null,
email nvarchar(20) not null
)
create table SanPham
(
maSP nchar(10) not null,
maHangSx nchar(10) not null,
tenSP nvarchar(20) not null,
soLuong int not null,
mauSac nvarchar(20) not null,
giaBan money not null,
donViTinh nchar(10) not null,
moTa nvarchar(30),
constraint pk_SanPham_maSP primary key(maSP),
constraint fk_SanPham_maHangSX foreign key(maHangSX) references HangSX(maHangSX)
on delete cascade on update cascade
)
create table NhanVien
(
maNV nchar(10) not null primary key,
tenNV nvarchar(20) not null,
gioiTinh nchar(10) not null,
diaChi nvarchar(20) not null,
soDT nvarchar(20) not null,
email nvarchar(30) not null,
tenPhong nvarchar(30) not null
)
create table PNhap
(
soHDN nchar(10) not null,
ngayNhap date not null,
maNV nchar(10) not null,
constraint pk_PNhap_soHDN primary key(soHDN),
constraint fk_PNhap foreign key(maNV) references NhanVien(maNV)
on delete cascade on update cascade
)
create table Nhap
(
soHDN nchar(10) not null,
maSP nchar(10) not null,
soluongN int not null,
donGia float not null,
constraint pk_Nhap primary key(soHDN,maSP),
constraint fk_Nhap foreign key(soHDN) references PNhap(soHDN)
on delete cascade on update cascade,
constraint fk_Nhap_sp foreign key(maSP) references SanPham(maSP)
)
create table PXuat
(
soHDX nchar(10) not null,
ngayXuat date not null,
maNV nchar(10) not null,
constraint pk_PXuat primary key(soHDX),
constraint fk_PXuat foreign key(maNV) references NhanVien(maNV)
on delete cascade on update cascade
)
create table Xuat
(
soHDX nchar(10) not null,
maSP nchar(10) not null,
soLuongX int not null,
constraint pk_Xuat primary key(soHDX,maSP),
constraint fk_Xuat foreign key(soHDX) references PXuat(soHDX)
on delete cascade on update cascade,
constraint fk_Xuat1 foreign key(maSP) references SanPham(maSP)
on delete cascade on update cascade
)

insert into HangSX values('H01','SamSung','Korea','011-08271717','ss@gmail.com.kr'),('H02','OPPO','China','081-08626262','oppo@gmail.com.cn'),('H03','Vinfone','VietNam','084-098262626','vf@gmail.con.vn')
insert into NhanVien values('NV01','Nguyễn Thị Thu','Nữ','Hà Nội','0983636521','thu@gmail.com','Kế Toán'),('NV02','Lê Văn Nam','Nam','Bắc Ninh','0972525252','nam@gmail.com','Vật tư'),('NV03','Trần Hòa Bình','Nữ','Hà Nội','038604543','hb@gmaill.com','Kế toán')
insert into SanPham values('SP01','H02','F1 plus','100','Xám','7000000','chiếc','Hàng cận cao cấp'),('SP02','H01','Galaxy Note 11','50','Đỏ','19000000','chiếc','Hàng cao cấp'),('SP03','H02','F3 lite','200','Nâu','3000000','chiếc','Hàng phổ thông'),('SP04','H03','Vjoy3','200','Xám','1500000','chiếc','Hàng phổ thông'),('SP05','H01','Galaxy V21','500','Nâu','8000000','chiếc','Hàng cận cao cấp')
 insert into PNhap values('N01','02-05-2019','NV01'),('N02','04-07-2020','NV02'),('N03','05-17-2020','NV02'),('N04','03-22-2020','NV03'),('N05','07-07-2020','NV01')
insert into Nhap values('N01','SP02','10','17000000'),('N02','SP01','30','6000000'),('N03','SP04','30','12000000'),('N04','SP01','10','6200000'),('N05','SP05','20','7000000')
insert into PXuat values('X01','06-14-2020','NV02'),('X02','03-05-2019','NV03'),('X03','12-12-2020','NV01'),('X04','06-02-2020','NV02'),('X05','05-18-2020','NV01')
insert into Xuat values('X01','SP03','5'),('X02','SP01','3'),('X03','SP02','1'),('X04','SP03','2'),('X04','SP05','1')
--a
select*from HangSX
select*from NhanVien
select*from SanPham
select*from PNhap
select*from Nhap
select*from PXuat
select*from Xuat
--b
Select maSP, tenSP, tenHang,soLuong,mauSac,giaBan,donViTinh,moTa 
From SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSx 
Order by giaBan DESC
--c
Select maSP, tenSP, soLuong, mauSac, giaBan, donViTinh, moTa 
From SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX 
Where tenHang = 'SamSung'
--d
Select * From NhanVien 
Where gioiTinh = 'Nữ' And tenPhong = 'Kế Toán'
--e
Select PNhap.soHDN, SanPham.maSP, tenSP, tenHang, soLuongN, donGia, 
soLuongN*donGia As 'Tiền nhập', mauSac, donViTinh, ngayNhap, tenNV, tenPhong
From Nhap Inner join SanPham on Nhap.maSP = SanPham.maSP 
                    Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                   Inner join NhanVien on PNhap.maNV = NhanVien.maNV 
                   Inner join HangSX on HangSX.maHangSx=SanPham.maHangSX
				   order by soHDN
--f
Select 	Xuat.soHDX, 	SanPham.maSP, 	tenSP, 	tenHang, 	soLuongX, 	giaBan, 
soLuongX*giaBan As 'Tiền xuất', mauSac, donViTinh, ngayXuat, tenNV, tenPhong 
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP 
                 Inner join PXuat on Xuat.soHDX=PXuat.soHDX  
                 Inner join NhanVien on PXuat.maNV = NhanVien.maNV 
                 Inner join HangSX on SanPham.maHangSX=HangSX.maHangSX 
Where Month(ngayXuat)=06 And Year(ngayXuat)=2020 
Order by soHDX
--g
Select Nhap.soHDN, SanPham.maSP, tenSP, soLuongN, donGia, ngayNhap, tenNV, tenPhong 
From Nhap Inner join SanPham on Nhap.MaSP = SanPham.MaSP 
                 Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                 Inner join NhanVien on PNhap.maNV = NhanVien.maNV 
                 Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX 
Where tenHang = 'SamSung' And Year(ngayNhap)= 2017
--h
Select Top 10 Xuat.soHDX, ngayXuat, soLuongX 
From Xuat Inner join PXuat on Xuat.soHDX=PXuat.soHDX  
Where Year(ngayXuat)=2020 
Order by soLuongX DESC
--i
Select top 10 maSP, tenSP,giaBan 
From SanPham 
Order by giaBan DESC
--j
Select maSP, tenSP, soLuong, mauSac, giaBan, donViTinh, moTa 
From SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX Where tenHang = 'Samsung' and giaBan Between 100.000 And 500.000
--k
Select Sum(soLuongN*donGia) As 'Tổng tiền nhập' 
From Nhap Inner join SanPham on Nhap.maSP = SanPham.maSP 
                  Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX 
                  Inner join PNhap on Nhap.soHDN=PNhap.soHDN Where Year(ngayNhap)=2020 And tenHang = 'Samsung'
--l
Select Nhap.soHDN,ngayNhap 
From Nhap Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
Where Year(ngayNhap)=2020 And soLuongN*donGia = (Select Max(soLuongN*donGia) 
                     From Nhap Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                     Where Year(ngayNhap)=2020)
--m
select top 10 SoluongN from Nhap inner join PNhap on Nhap.soHDN=PNhap.soHDN
where year(ngayNhap) =2019
--n
select SanPham.maSP, tenSP from SanPham inner join HangSX on SanPham.maHangSX=HangSX.maHangSx
					inner join Nhap on Nhap.maSP = SanPham.maSP
					inner join PNhap on PNhap.soHDN = Nhap.soHDN
					where tenHang = 'SamSung' and maNV = 'NV01'
--p
select Nhap.soHDN, Nhap.maSP,soluongN,ngayNhap from  Nhap inner join PNhap on Nhap.soHDN=PNhap.soHDN
					inner join SanPham on SanPham.maSP=Nhap.maSP
					inner join Xuat on Xuat.maSP = SanPham.maSP
					inner join PXuat on PXuat.soHDX = Xuat.soHDX
					where Nhap.maSP = 'SP02' and PXuat.maNV = 'NV02'
--q
select NhanVien.maNV, tenNV from NhanVien inner join PXuat on PXuat.maNV = NhanVien.maNV
where PXuat.maNV = 'SP02' and ngayXuat = '03-02-2020'

create proc sp_NhapSP(@masp nvarchar(10),@mahang nvarchar(10), @ten nvarchar(20),@sl int, @mau nvarchar(10),@gia float,@dv nvarchar(10),@mota nvarchar(20))
as
	begin
		if(exists(select*from SanPham where tenSP = @ten))
			print 'Ten san pham' + @ten + ' da ton tai'
		else
			insert into SanPham values(@masp,@mahang,@ten,@sl,@mau,@gia,@dv,@mota)
	end

exec sp_NhapSP 's001','h01','F1 plus','10','vang','100000','chiec','tot'
select*from SanPham
exec sp_NhapSP 's001','h01','plus','10','vang','10000','chiec','tot'
	select*from SanPham

create proc sp_xoa(@ten nvarchar(20))
as
	begin
		if(not exists(select*from HangSX where tenHang = @ten))
			print 'Khong ton tai hang ' + @ten
		else
			begin
				declare @ma nvarchar(10)
				select @ma = maHangSx from HangSX where tenHang = @ten
				delete from SanPham where maHangSX = @ma
				delete from HangSX where maHangSx = @ma
			end
	end

exec sp_xoa 'asb'

exec sp_xoa 'OPPO'
	select*from HangSX
	select*from SanPham

create proc sp_nhap(@ma nvarchar(20),@ten nvarchar(20),@dc nvarchar(20),@sdt nvarchar(12),@email nvarchar(20),@kq bit output)
as
	begin
		if(not exists(select*from HangSX where tenHang = @ten))
			set @kq = 1
		else
			begin
				insert into HangSX values(@ma,@ten,@dc,@sdt,@email)
				set @kq = 0
			end
			return @kq
	end

declare @kq bit
exec sp_nhap '001','SamSung','ha noi','0098765432','minh@gmail.com',@kq output
select @kq

declare @kq bit
exec sp_nhap '001','minh','minh','098765432','minh@gmail.com',@kq output
select @kq
select*from HangSX


--proc
--a
create proc sp_nhap(@ma nvarchar(10),@ten nvarchar(20),@dc nvarchar(20),@sdt nvarchar(12),@email nvarchar(20))
as
	begin
		if(exists(select*from HangSX where tenHang = @ten))
			print 'ten hang' + @ten + ' da ton tai'
		else
			insert into HangSX values(@ma,@ten,@dc,@sdt,@email)
	end

exec sp_nhap 'H04','SamSung','VietNam','0987654323','ss@gmail.com'

exec sp_nhap 'H04','Apple','VietNam','0987654323','ss@gmail.com'
	select*from HangSX

	--b
create proc sp_nhap1(@ma nvarchar(10),@tenh nvarchar(20),@tensp nvarchar(20),@sl int,@mau nvarchar(10),@gia float,@dv nvarchar(20),@mota nvarchar(20))
as
	begin
		if(not exists(select*from HangSX where tenHang = @tenh))
			print 'Ten hang ' + @tenh + ' khong ton tai'
		else
			begin
				declare @mah nvarchar(20)
				select @mah = maHangsx from HangSX where tenHang = @tenh
				if(exists(select*from SanPham where maSP = @ma))
					update SanPham set maHangSx = @mah, tenSP = @tensp, soLuong = @sl, mauSac = @mau,giaBan = @gia, donViTinh = @dv, moTa =@mota
					where maSP = @ma
				else
					insert into SanPham values(@ma,@mah,@tensp,@sl,@mau,@gia,@dv,@mota)
			end 
		end

select*from SanPham
select*from HangSX

exec sp_nhap1 'SP05','Nokia','E63',100,'den',1000000,'chiec','tot'

exec sp_nhap1 'SP03','Apple','E63',100,'den',1000000,'chiec','tot'
	select*from SanPham

exec sp_nhap1 'SP06','OPPO','E63',100,'den',1000000,'chiec','tot'
	select*from SanPham

--c
create proc sp_xoa(@ten nvarchar(20))
as
	begin
		if(not exists(select*from HangSX where tenHang = @ten))
			print 'ten hang ' + @ten +' khong ton tai'
		else
			begin
				declare @mah nvarchar(20)
				select @mah = maHangSx from HangSX where tenHang = @ten
				delete from SanPham where maHangSx = @mah
				delete from HangSX where maHangSx = @mah
			end
	end

exec sp_xoa 'Allll'

select*from HangSX
select*from SanPham
exec sp_xoa 'Apple'
	select*from HangSX
	select*from SanPham
--d
create proc sp_nhap2(@manv nvarchar(20),@ten nvarchar(20), @gt nvarchar(4),@dc nvarchar(20),@sdt nvarchar(12),@email nvarchar(20),@phong nvarchar(20),@flag bit = 0)
as
	begin
		if @flag = 0
		update NhanVien set tenNV = @ten,gioiTinh = @gt,diaChi = @dc,soDT = @sdt,email = @email,tenPhong =@phong
		where maNV = @manv
		else
			insert into NhanVien values(@manv,@ten,@gt,@dc,@sdt,@email,@phong)
	end

select*from NhanVien
exec sp_nhap2 'NV01','Nguyen Van A','Nam','Ha Noi','234567890','A@gmail.com','Hanh chinh', 0
	select*from NhanVien

select*from NhanVien
exec sp_nhap2 'NV06','Nguyen Van A','Nam','Ha Noi','234567890','A@gmail.com','Hanh chinh', 5
	select*from NhanVien

	--e
	alter proc sp_nhap3(@sohdn nchar(10),@masp nvarchar(10),@manv nvarchar(10),@ngay date,@sl int,@dg float)
	as
		begin
			if(not exists(select*from SanPham where maSP = @masp))
				print 'San pham co ma ' + @masp + ' khong ton tai'
			if(not exists(select*from NhanVien where maNV = @manv))
					print 'Nhan vien co ma ' + @manv + ' khong ton tai'
			else
				begin
						if(exists(select*from Nhap where soHDN = @sohdn))
							update Nhap set maSP = @masp, soluongN = @sl,donGia = @dg
							where soHDN = @sohdn
						else
								insert into PNhap values(@sohdn,@ngay,@manv)
								insert into Nhap values(@sohdn,@masp,@sl,@dg)
				end
		end
select*from NhanVien
select*from Nhap
exec sp_nhap3 'N06','SP03','NV04','1/1/2021',100,5000
exec sp_nhap3 'N06','SP01','NV04','1/1/2021',100,5000

select*from Nhap
exec sp_nhap3 'N0000','SP01','NV01','1/1/2021',100,5000
	select*from Nhap
select*from Nhap
exec sp_nhap3 'N08','SP04','NV01','1/1/2021',100,5000
	select*from Nhap

--f
alter proc sp_nhap4(@sohdx nchar(10), @masp nchar(10), @manv nchar(10), @ngay date, @sl int)
as
	begin
		if(not exists(select*from SanPham where maSP = @masp))
			print 'San pham co ma ' + @masp + ' khong ton tai'
		if(not exists(select*from NhanVien where maNV = @manv))
			print 'Nhan vien co ma ' + @manv + ' khong ton tai'
		if(not exists(select*from Xuat inner join SanPham on Xuat.maSP = SanPham.maSP where @sl <= soLuong))
			print 'So luong xuat lon hon so luong co'
		else
				if(exists(select*from Xuat where soHDX = @sohdx))
					update Xuat set maSP = @masp, soLuongX = @sl
					where soHDX = @sohdx
				else
					begin
						insert into PXuat values(@sohdx,@ngay,@manv)
						insert into Xuat values(@sohdx,@masp,@sl)
					end
	end

select*from Xuat
select*from PXuat

exec sp_nhap4 'X07','SP11','NV00','1/1/2021','1000'

select*from Xuat
exec sp_nhap4 'X02','SP04','NV03','1/1/2021','10'
	select*from Xuat

select*from Xuat
exec sp_nhap4 'X06','SP04','NV01','1/1/2021','10'
	select*from Xuat

	--g
create proc sp_xoa1(@manv nchar(10))
as
	begin
		if(not exists(select*from NhanVien where maNV = @manv))
			print 'Khong ton tai nhan vien can xoa'
		else
			declare @sohdn nchar(10)
			declare @sohdx nchar(10)
			select @sohdn = soHDN from PNhap where maNV = @manv
			select @sohdx = soHDX from PXuat where maNV = @manv
			delete from Nhap where soHDN = @sohdn
			delete from Xuat where soHDX = @sohdx
			delete from NhanVien where maNV = @manv
	end

exec sp_xoa1 'NV005'

select*from NhanVien
select*from Nhap
select*from Xuat
exec sp_xoa1 'NV01'
	select*from NhanVien
	select*from Nhap
	select*from Xuat

--h
create proc sp_xoa2(@masp nchar(10))
as
	begin
		if(not exists(select*from SanPham where maSP = @masp))
			print 'Khong ton tai san pham can xoa'
		else
			delete from Nhap where maSP = @masp
			delete from Xuat where maSP = @masp
			delete from SanPham where maSP = @masp
	end


exec sp_xoa2 'SP111'

select*from SanPham
select*from Nhap
select*from Xuat
exec sp_xoa2 'SP01'
	select*from SanPham
	select*from Nhap
	select*from Xuat

--a
create proc sp_them(@manv nchar(10),@tennv nvarchar(20),@gt nchar(4),@dc nvarchar(20),@sdt nchar(12),@email nvarchar(20),@phong nvarchar(10),@flag int,@kt bit output)
as
	begin
		if(@gt <> 'Nam' and @gt <> 'Nu')
		set @kt = 1
		else
			begin
			set @kt = 0
			if(@flag = 0)
				insert into NhanVien values(@manv,@tennv,@gt,@dc,@sdt,@email,@phong)
			else
				update NhanVien set tenNV = @tennv,gioiTinh = @gt,diaChi = @dc,soDT = @sdt,email = @email,tenPhong = @phong
				where maNV = @manv
			end
			return @kt
	end

declare @kt bit

exec sp_them 'NV04','NBC','Nosex','ha noi','34567887','mgfdx@gmail','hgf',0,@kt output
select @kt

declare @kt bit
select*from NhanVien
exec sp_them 'NV04','NBC','Nam','ha noi','34567887','mgfdx@gmail','hgf',0,@kt output
	select*from NhanVien
select @kt

declare @kt bit
select*from NhanVien
exec sp_them 'NV02','NBC','Nam','ha noi','34567887','mgfdx@gmail','hgf',2,@kt output
	select*from NhanVien
select @kt

--b
alter proc sp_them1(@masp nchar(10),@tenhang nvarchar(20),@tensp nvarchar(20),@sl int, @mau nvarchar(10),@gia float,@dv nchar(10),@mota nvarchar(20),@flag int,@kq int output)
as
	begin
		if(not exists(select*from HangSX where tenHang = @tenhang))
			set @kq = 1
		else if(exists(select*from SanPham where @sl < 0 ))
			set @kq = 2
		else
			begin
				declare @mah nchar(10)
				select @mah = maHangSx from HangSX where tenHang = @tenhang
				set @kq = 0
				if(@flag = 0)
					insert into SanPham values(@masp,@mah,@tensp,@sl,@mau,@gia,@dv,@mota)
				else
					update SanPham set maHangSx = @mah, tenSP =@tensp, soLuong = @sl, mauSac = @mau,giaBan = @gia, donViTinh = @dv,moTa = @mota
					where maSP = @masp
			end
			return @kq
	end

declare @kq int
exec sp_them1 'SP20','Vettel','Note 9','100','do','550000','chiec','tot',0,@kq output
select @kq

declare @kq int
select*from SanPham
exec sp_them1 'SP21','SamSung','Note 9','50','do','550000','chiec','tot',0,@kq output
select*from SanPham
select @kq

declare @kq int
select*from SanPham
exec sp_them1 'SP02','SamSung','Note 9','50','do','550000','chiec','tot',1,@kq output
select*from SanPham
select @kq

--c
create proc sp_xoanv(@manv nchar(10),@xoa int output)
as
	begin
		if(not exists(select*from NhanVien where maNV = @manv))
			set @xoa = 1
		else
			begin
			set @xoa = 0
			declare @sohdn nchar(10)
			declare @sohdx nchar(10)
			select @sohdn = soHDN from PNhap where maNV = @manv
			select @sohdx = soHDX from PXuat where maNV = @manv
			delete from Nhap where soHDN = @sohdn
			delete from Xuat where soHDX = @sohdx
			delete from NhanVien where maNV = @manv
			end
			return @xoa
	end

declare @xoa int
exec sp_xoanv 'NVFFF',@xoa output
select @xoa

declare @xoa int
select*from NhanVien
exec sp_xoanv 'NV06',@xoa output
select*from NhanVien
select @xoa