create database QuanLyBanHang111

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
constraint pk_SanPham_maSP primary key(maSP)
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
constraint pk_PNhap_soHDN primary key(soHDN)
)
create table Nhap
(
soHDN nchar(10) not null,
maSP nchar(10) not null,
soluongN int not null,
donGia float not null,
constraint pk_Nhap primary key(soHDN,maSP)
)
create table PXuat
(
soHDX nchar(10) not null,
ngayXuat date not null,
maNV nchar(10) not null,
constraint pk_PXuat primary key(soHDX)
)
create table Xuat
(
soHDX nchar(10) not null,
maSP nchar(10) not null,
soLuongX int not null,
constraint pk_Xuat primary key(soHDX,maSP)
)

insert into HangSX values('H01','SamSung','Korea','011-08271717','ss@gmail.com.kr'),('H02','OPPO','China','081-08626262','oppo@gmail.com.cn'),('H03','Vinfone','VietNam','084-098262626','vf@gmail.con.vn')
insert into NhanVien values('NV01','Nguyễn Thị Thu','Nữ','Hà Nội','0983636521','thu@gmail.com','Kế Toán'),('NV02','Lê Văn Nam','Nam','Bắc Ninh','0972525252','nam@gmail.com','Vật tư'),('NV03','Trần Hòa Bình','Nữ','Hà Nội','038604543','hb@gmaill.com','Kế toán')
insert into SanPham values('SP01','H02','F1 plus','100','Xám','7000000','chiếc','Hàng cận cao cấp'),('SP02','H01','Galaxy Note 11','50','Đỏ','19000000','chiếc','Hàng cao cấp'),('SP03','H02','F3 lite','200','Nâu','3000000','chiếc','Hàng phổ thông'),('SP04','H03','Vjoy3','200','Xám','1500000','chiếc','Hàng phổ thông'),('SP05','H01','Galaxy V21','500','Nâu','8000000','chiếc','Hàng cận cao cấp')
 insert into PNhap values('N01','02-05-2019','NV01'),('N02','04-07-2020','NV02'),('N03','05-17-2020','NV02'),('N04','03-22-2020','NV03'),('N05','07-07-2020','NV01')
insert into Nhap values('N01','SP02','10','17000000'),('N02','SP01','30','6000000'),('N03','SP04','30','12000000'),('N04','SP01','10','6200000'),('N05','SP05','20','7000000')
insert into PXuat values('X01','06-14-2020','NV02'),('X02','03-05-2019','NV03'),('X03','12-12-2020','NV01'),('X04','06-02-2020','NV02'),('X05','05-18-2020','NV01')
insert into Xuat values('X01','SP03','5'),('X02','SP01','3'),('X03','SP02','1'),('X04','SP03','2'),('X04','SP05','1')


--a
create trigger trg_nhap
on Nhap
for insert
as
	begin
		declare @masp nchar(10), @sln int, @dgn float
		select @masp = maSP,@sln = soluongN,@dgn = donGia from inserted
		if(not exists(select*from SanPham where maSP = @masp))
			begin
				raiserror('Khong ton tai san pham',16,1)
				rollback transaction
			end
		else
			if(@sln < 0 and @dgn < 0)
				begin
					raiserror('So luong nhap va don gia khong hop le',16,1)
					rollback transaction
				end
		else
			update SanPham set soLuong = soLuong + @sln
			from SanPham where maSP = @masp
		end

select*from SanPham
select*from Nhap
select*from NhanVien

insert into Nhap values('N06','Sp01',10,0)

select*from SanPham
select*from Nhap
insert into Nhap values('N99','SP03',10,1110)
select*from Nhap
select*from SanPham

--b
alter trigger trg_xuat
on Xuat
for insert
as
	begin
		declare @masp nchar(10), @slx int, @sl int
		select @masp = maSP, @slx = soLuongX from inserted
		if(not exists(select*from SanPham where maSP  =@masp))
		begin
			raiserror('Khong ton tai san pham',16,1)
			rollback transaction
		end
		else
			select @sl = soLuong from SanPham where maSP = @masp
			if(@slx > @sl)
				begin
					raiserror('So luong xuat khong hop le',16,1)
					rollback transaction
				end
		else
			update SanPham set soLuong = soLuong - @slx
			from SanPham where maSP = @masp
	end

insert into Xuat values('X05','SP03',1000)

select*from Xuat
select*from SanPham
insert into Xuat values('X07','SP01',5)
select*from Xuat
select*from SanPham

--c
create trigger trg_xoa1
on Xuat
for delete
as
	begin
		declare @masp nchar(10), @slx int
		select @masp = maSP, @slx = soLuongX from deleted
		if(not exists(select*from SanPham where maSP = @masp))
			begin
				raiserror('San phan khong ton tai',16,1)
				rollback transaction
			end
		else
		update SanPham set soLuong = soLuong + @slx
		from SanPham where maSP = @masp
	end



select*from Xuat
select*from SanPham
delete from Xuat where soHDX = 'X02'
select*from Xuat
select*from SanPham

--d
create trigger trg_capnhat
on Xuat
for update
as
	if(@@ROWCOUNT > 1)
	begin
		raiserror('Khong duoc cap nhat nhieu ban ghi cung luc',16,1)
		rollback transaction
	end
	else
		declare @masp nchar(10), @truoc int, @sau int, @sl int
		select @truoc = soLuongX, @masp = maSP from deleted
		select @sau = soLuongX from inserted
		select @sl = soLuong from SanPham where maSP = @masp
		if(update(soLuongX))
			begin
				if(@sl < (@sau - @truoc))
					begin
						raiserror('Khong du so luong de xuat',16,1)
						rollback transaction
					end
				else
					update SanPham set soLuong = soLuong - (@sau - @truoc)
					from SanPham where maSP = @masp
			end

select*from Xuat
select*from SanPham
update Xuat set soLuongX = 10 from Xuat where soHDX = 'X07'
select*from Xuat
select*from SanPham

--b
create trigger trg_update1
on Nhap
for update
as
	if(@@rowcount > 1)
		begin
			raiserror('Khong the cap nhat nhieu ban ghi',16,1)
			rollback transaction
		end
	else
		declare @masp nchar(10), @cu int, @moi int
		select @masp = maSP, @cu = soluongN from deleted
		select @moi = soLuongN from inserted
		if(not exists(select*from SanPham where maSP = @masp))
			begin
				raiserror('Khong co san pham nay',16,1)
				rollback transaction
			end
		else
			update SanPham set soLuong = soLuong + (@moi - @cu)
			from SanPham where maSP = @masp

select*from Nhap
select*from SanPham
update Nhap set soluongN = 100 where soHDN = 'N03'
select*from Nhap
select*from SanPham

--c
create trigger trg_delete
on Nhap
for delete
as
	begin
		declare @masp nchar(10), @sln int
		select @masp = maSP, @sln = soluongN from deleted
		if(not exists(select*from SanPham where maSP = @masp))
		begin
			raiserror('Khong co loai san pham nay',16,1)
			rollback transaction
		end
		else
			update SanPham set soLuong = soLuong - @sln
			from SanPham where maSP = @masp
	end

select*from Nhap
select*from SanPham
delete from Nhap where soHDN = 'N02'
select*from Nhap
select*from SanPham