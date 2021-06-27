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
select*from HangSX
select*from NhanVien
select*from SanPham
select*from PNhap
select*from Nhap
select*from PXuat
select*from Xuat
--b

Select maSP, tenSP, tenHang,soLuong,mauSac,giaBan,donViTinh,moTa 
Fromcreate view cau_b as SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSx 

select*from cau_b
--c
create view cau_c as
Select maSP, tenSP, soLuong, mauSac, giaBan, donViTinh, moTa 
From SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX 
Where tenHang = 'SamSung'

select*from cau_c
--d
create view cau_d as
Select * From NhanVien 
Where gioiTinh = 'Nữ' And tenPhong = 'Kế Toán'
select*from cau_d
--e
create view cau_e as
Select PNhap.soHDN, SanPham.maSP, tenSP, tenHang, soLuongN, donGia, 
soLuongN*donGia As 'Tiền nhập', mauSac, donViTinh, ngayNhap, tenNV, tenPhong
From Nhap Inner join SanPham on Nhap.maSP = SanPham.maSP 
                    Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                   Inner join NhanVien on PNhap.maNV = NhanVien.maNV 
                   Inner join HangSX on HangSX.maHangSx=SanPham.maHangSX
select*from cau_e
--f
create view cau_f as
Select 	Xuat.soHDX, 	SanPham.maSP, 	tenSP, 	tenHang, 	soLuongX, 	giaBan, 
soLuongX*giaBan As 'Tiền xuất', mauSac, donViTinh, ngayXuat, tenNV, tenPhong 
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP 
                 Inner join PXuat on Xuat.soHDX=PXuat.soHDX  
                 Inner join NhanVien on PXuat.maNV = NhanVien.maNV 
                 Inner join HangSX on SanPham.maHangSX=HangSX.maHangSX 
Where Month(ngayXuat)=06 And Year(ngayXuat)=2020 
select*from cau_f
--g
create view cau_g as
Select Nhap.soHDN, SanPham.maSP, tenSP, soLuongN, donGia, ngayNhap, tenNV, tenPhong 
From Nhap Inner join SanPham on Nhap.MaSP = SanPham.MaSP 
                 Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                 Inner join NhanVien on PNhap.maNV = NhanVien.maNV 
                 Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX 
Where tenHang = 'SamSung' And Year(ngayNhap)= 2017
select*from cau_g
--h
create view cau_h as
Select Top 10 Xuat.soHDX, ngayXuat, soLuongX 
From Xuat Inner join PXuat on Xuat.soHDX=PXuat.soHDX  
Where Year(ngayXuat)=2020 
select*from cau_h
--i
create view cau_i as
Select maSP, tenSP,giaBan 
From SanPham 
select*from cau_i
--j
create view cau_j as
Select maSP, tenSP, soLuong, mauSac, giaBan, donViTinh, moTa 
From SanPham Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX Where tenHang = 'Samsung' and giaBan Between 100.000 And 500.000
select*from cau_j
--k
create view cau_k as
Select Sum(soLuongN*donGia) As 'Tổng tiền nhập' 
From Nhap Inner join SanPham on Nhap.maSP = SanPham.maSP 
                  Inner join HangSX on SanPham.maHangSX = HangSX.maHangSX 
                  Inner join PNhap on Nhap.soHDN=PNhap.soHDN Where Year(ngayNhap)=2020 And tenHang = 'Samsung'
select*from cau_k
--l
create view cau_l as
Select Nhap.soHDN,ngayNhap 
From Nhap Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
Where Year(ngayNhap)=2020 And soLuongN*donGia = (Select Max(soLuongN*donGia) 
                     From Nhap Inner join PNhap on Nhap.soHDN=PNhap.soHDN 
                     Where Year(ngayNhap)=2020)
select*from cau_l
--m
create view cau_m as
select top 10 SoluongN from Nhap inner join PNhap on Nhap.soHDN=PNhap.soHDN
where year(ngayNhap) =2019
select*from cau_m
--n
create view cau_n as
select SanPham.maSP, tenSP from SanPham inner join HangSX on SanPham.maHangSX=HangSX.maHangSx
					inner join Nhap on Nhap.maSP = SanPham.maSP
					inner join PNhap on PNhap.soHDN = Nhap.soHDN
					where tenHang = 'SamSung' and maNV = 'NV01'
select*from cau_n
--p
create view cau_p as
select Nhap.soHDN, Nhap.maSP,soluongN,ngayNhap from  Nhap inner join PNhap on Nhap.soHDN=PNhap.soHDN
					inner join SanPham on SanPham.maSP=Nhap.maSP
					inner join Xuat on Xuat.maSP = SanPham.maSP
					inner join PXuat on PXuat.soHDX = Xuat.soHDX
					where Nhap.maSP = 'SP02' and PXuat.maNV = 'NV02'
select*from cau_p
--q
create view cau_q as
select NhanVien.maNV, tenNV from NhanVien inner join PXuat on PXuat.maNV = NhanVien.maNV
where PXuat.maNV = 'SP02' and ngayXuat = '03-02-2020'
select*from cau_q