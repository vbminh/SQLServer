create database QuanLyBanHang

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
maHangSX nchar(10) not null,
tenSP nvarchar(20) not null,
soLuong int not null,
mauSac nvarchar(20) not null,
giaBan money not null,
donViTinh nchar(10) not null,
moTa nvarchar(max),
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
donGia money not null,
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
soHDX nchar(100) not null,
maSP nchar(10) not null,
soLuongX int not null,
constraint pk_Xuat primary key(soHDX,maSP),
constraint fk_Xuat foreign key(soHDX) references PXuat(soHDX)
on delete cascade on update cascade,
constraint fk_Nhapp1 foreign key(maSP) references SanPham(maSP)
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
Select HangSX.maHangSx, tenHang, Count(*) As 'Số lượng sp' 
From SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSx
Group by HangSX.maHangSx, tenHang
--b
Select  SanPham.maSP,tenSP, sum(soLuongN*donGia) As 'Tổng tiền nhập' 
From Nhap Inner join SanPham on Nhap.maSP = SanPham.maSP 
                   Inner join PNhap on PNhap.soHDN=Nhap.soHDN 
Where Year(ngayNhap)=2020 
Group by SanPham.maSP,tenSP
--c
Select SanPham.maSP,tenSP,sum(soLuongX) As 'Tổng xuất' 
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.maSP 
                Inner join  HangSX on HangSX.maHangSX = SanPham.maHangSX 
                Inner join PXuat on Xuat.soHDX=PXuat.soHDX 
Where Year(ngayXuat)=2018 And tenHang = 'SamSung' 
Group by SanPham.maSP,tenSP Having sum(soLuongX) >=10000
--d
Select tenPhong, count(maNV) as soNhanVien From NhanVien 
Where gioiTinh = 'Nam'
group by tenPhong
--e
Select Nhap.maSP, tenHang, sum(soLuongN) as TongSLN
From Nhap Inner join SanPham on Nhap.maSP = SanPham.maSP 
                    Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                   Inner join HangSX on HangSX.maHangSx=SanPham.maHangSX
				   where year(ngayNhap)=2018
				   group by Nhap.maSP, tenHang
--f
Select maNV, count(soLuongX*giaBan) As TongTienXuat
From PXuat Inner join Xuat on PXuat.soHDX = Xuat.soHDX
		inner join SanPham on SanPham.maSP = Xuat.maSP 
where year(ngayXuat)=2018
group by maNV
--g
Select maNV, sum(soluongN*donGia) as TongTienN 
From PNhap Inner join Nhap on PNhap.soHDN=Nhap.soHDN  
group by maNV
having sum(soluongN*donGia) > '100000'
--h
Select SanPham.maSP,tenSP 
From SanPham Inner join Nhap on SanPham.maSP = Nhap.maSP 
Where SanPham.maSP Not In (Select maSP From Xuat)
--i
Select SanPham.maSP,tenSP 
From SanPham Inner join Nhap on SanPham.maSP = Nhap.maSP
			inner join PNhap on Nhap.soHDN = PNhap.soHDN
			inner join Xuat on SanPham.maSP = Xuat.maSP
			inner join PXuat on Xuat.soHDX = PXuat.soHDX
			where year(ngayNhap)=2020 and year(ngayXuat)=2020
--j
Select NhanVien.maNV, tenNV
from NhanVien inner join PNhap on NhanVien.maNV=PNhap.maNV
			inner join PXuat on NhanVien.maNV=PXuat.maNV
			where PNhap.maNV=PXuat.maNV
--k 
Select NhanVien.maNV,tenNV 
From NhanVien Inner join PNhap on NhanVien.maNV = PNhap.maNV
inner join PXuat on NhanVien.maNV = PNhap.maNV
Where NhanVien.maNV Not In (Select PNhap.maNV From PNhap inner join PXuat on PXuat.maNV=PNhap.maNV)