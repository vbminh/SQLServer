create database QLSinhVien

create table Khoa
(	MaKhoa nchar(10) not null primary key,
	TenKhoa nvarchar(20) not null)

create table Lop
(	MaLop nchar(10) not null primary key,
	TenLop nvarchar(20) not null,
	Siso int default 0,
	MaKhoa nchar(10) not null,
	constraint fk1 foreign key(MaKhoa) references Khoa(MaKhoa)
	on update cascade on delete cascade)

create table SinhVien
(	MaSV nchar(10) not null primary key,
	HoTen nvarchar(30) not null,
	NgaySinh date,
	GioiTInh bit,
	MaLop nchar(10) not null,
	constraint fk2 foreign key(MaLop) references Lop(MaLop)
	on update cascade on delete cascade)

--Nhap dl
insert into Khoa values('K01','CNTT'),('K02','Ke toan')
insert into Lop values('L01','TCNH','70','K02'),('L02','KTPM','65','K01')
insert into SinhVien values('SV01','Nguyen Van A','01/01/2001','1','L01'),
						   ('SV02','Pham Thi B','02/22/2001','0','L02'),
						   ('SV03','Hoang Thi C','06/06/2001','0','L02'),
						   ('SV04','Bui Van D','12/21/2001','1','L01'),
						   ('SV05','Tran Van E','7/15/2001','1','L02'),
						   ('SV06','Vu Thi G','09/23/2001','0','L01'),
						   ('SV07','Nguyen Van H','04/01/2001','1','L02')
select*from Khoa
select*from Lop
select*from SinhVien
--Cau 2
Create view Cau_2 as
select Khoa.TenKhoa, count(TenLop) as SoLop
from Khoa inner join Lop on Khoa.MaKhoa = Lop.MaKhoa
group by Khoa.TenKhoa

select*from Cau_2
--Cau 3
Create function fn_TTSV(@MaKhoa char(10))
Returns @bang Table ( MaSV nchar(10),
					  HoTen nvarchar(30),
					  NgaySinh date,
					  GioiTinh char(5),
					  TenLop nvarchar(20),
					  TenKhoa nvarchar(20))
As
Begin
	Insert into @bang
		Select MaSV, HoTen, NgaySinh,
				case GioiTInh
				 when 1 then 'nam'
				 else 'nu'
				end, 
				TenLop, TenKhoa
		from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
					  inner join Khoa on Lop.MaKhoa = Khoa.MaKhoa
		where Khoa.MaKhoa=@MaKhoa
	return
end

select*from fn_TTSV('K02')



-----------De 5
create database  QLBH
create table hang
(  
    mahang nvarchar(20) not null primary key,
	tenh char(20) not  null, 
	DVT  nvarchar(10) not null,
	SLTon int not null,
)

create table HDBan
(
    MaHD nvarchar(20) not null primary key,
	NgayB datetime not null,
	HoTenKhach char (20) not null,

)

create table HangBan
(
   mahang nvarchar(20) not null,
   MaHD nvarchar(20) not null,
   DG money not null,
   SL int not null,
   primary key(mahang,MaHD),
    constraint fk_HangBan_MaHD foreign key(MaHD) references HDBan(MaHD)
   on update cascade on delete cascade,
   constraint fk_HangBan_mahang foreign key(mahang) references hang(mahang)
   on update cascade on delete cascade
  

)

insert into hang values('001','nike','VND',30)
insert into hang values('002','gucci','VND',23)

insert into HDBan values('100','01/12/2020','tran son')
insert into HDBan values('200','05/12/2020','tran B')

insert into HangBan values('001','100',15.000,2)
insert into HangBan values('001','200',15.000,2)
insert into HangBan values('002','100',30.000,4)
insert into HangBan values('002','200',30.000,4)
select *from HDBan

--CAU 2

create view thongke
as
  select HDBan.MaHD,HDBan.NgayB,sum(SL*DG) as 'tổng tiền'
  from HDBan inner join HangBan on HDBan.MaHD=HangBan.MaHD
  group by HDBan.MaHD,HDBan.NgayB


  select*from hang
  select*from HDBan
  select *from HangBan


--CAU 3
create function tienban(@nam int)
returns money
 as
   begin
      declare @tong money
	  select @tong=sum(Sl *DG)
	  from HangBan inner join HDBan on HangBan.MaHD=HDBan.MaHD
	  where year(NgayB)=@nam
	  return @tong
end

select * from HangBan
select *from HDBan
select dbo.tienban(2020)