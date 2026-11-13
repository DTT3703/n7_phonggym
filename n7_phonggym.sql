USE [master]
GO
/****** Object:  Database [n7_phongGym]    Script Date: 11/13/2026 8:20:05 PM ******/
CREATE DATABASE [n7_phongGym]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'n7_phongGym', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\n7_phongGym.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'n7_phongGym_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\n7_phongGym_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [n7_phongGym] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [n7_phongGym].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [n7_phongGym] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [n7_phongGym] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [n7_phongGym] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [n7_phongGym] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [n7_phongGym] SET ARITHABORT OFF 
GO
ALTER DATABASE [n7_phongGym] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [n7_phongGym] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [n7_phongGym] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [n7_phongGym] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [n7_phongGym] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [n7_phongGym] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [n7_phongGym] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [n7_phongGym] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [n7_phongGym] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [n7_phongGym] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [n7_phongGym] SET  DISABLE_BROKER 
GO
ALTER DATABASE [n7_phongGym] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [n7_phongGym] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [n7_phongGym] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [n7_phongGym] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [n7_phongGym] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [n7_phongGym] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [n7_phongGym] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [n7_phongGym] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [n7_phongGym] SET  MULTI_USER 
GO
ALTER DATABASE [n7_phongGym] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [n7_phongGym] SET DB_CHAINING OFF 
GO
ALTER DATABASE [n7_phongGym] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [n7_phongGym] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [n7_phongGym]
GO
/****** Object:  Table [dbo].[CHI_TIET_DANG_KI]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI_TIET_DANG_KI](
	[ID_CTG] [int] NOT NULL,
	[ID_MGT] [int] NOT NULL,
	[TenChiTietGoi] [nvarchar](100) NOT NULL,
	[SoLuongHVToiDa] [int] NOT NULL,
 CONSTRAINT [PK_CHI_TIET_GOI] PRIMARY KEY CLUSTERED 
(
	[ID_CTG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GOI_TAP]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GOI_TAP](
	[ID_MGT] [int] NOT NULL,
	[TenGoiTap] [nvarchar](100) NOT NULL,
	[SoThang] [int] NOT NULL,
	[SoLuotPT] [int] NOT NULL,
	[SoLuotTuDo] [int] NOT NULL,
	[MucGia] [decimal](12, 2) NOT NULL,
	[HinhAnh] [nvarchar](255) NULL,
 CONSTRAINT [PK_GOI_TAP] PRIMARY KEY CLUSTERED 
(
	[ID_MGT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HOI_VIEN]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOI_VIEN](
	[ID_MHV] [int] NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[DiaChi] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_HOI_VIEN] PRIMARY KEY CLUSTERED 
(
	[ID_MHV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HUAN_LUYEN_VIEN]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUAN_LUYEN_VIEN](
	[ID_MNV] [int] NOT NULL,
	[GiaBieuDay] [decimal](12, 2) NOT NULL,
	[HeSoHoaHong] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_HUAN_LUYEN_VIEN] PRIMARY KEY CLUSTERED 
(
	[ID_MNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HuanLuyenVien]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuanLuyenVien](
	[ID_MNV] [int] NOT NULL,
	[GiaBieuDay] [decimal](12, 2) NOT NULL,
	[HeSoHoaHong] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_HuanLuyenVien] PRIMARY KEY CLUSTERED 
(
	[ID_MNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LK_DANG_KY]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LK_DANG_KY](
	[ID_MHV] [int] NOT NULL,
	[ID_CTG] [int] NOT NULL,
	[NgayKichHoat] [date] NOT NULL,
	[NgayHetHan] [date] NOT NULL,
	[SoLuotConLai] [int] NOT NULL,
	[TrangThai] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_LK_DANG_KY] PRIMARY KEY CLUSTERED 
(
	[ID_MHV] ASC,
	[ID_CTG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LK_LICH_TAP]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LK_LICH_TAP](
	[ID_CTG] [int] NOT NULL,
	[ID_MNV] [int] NOT NULL,
	[NgayTap] [date] NOT NULL,
	[KhungGio] [nvarchar](50) NOT NULL,
	[SoLuongHV] [int] NOT NULL,
	[DanhGiaBuoi] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_LK_LICH_TAP] PRIMARY KEY CLUSTERED 
(
	[ID_CTG] ASC,
	[ID_MNV] ASC,
	[NgayTap] ASC,
	[KhungGio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHAN_VIEN]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHAN_VIEN](
	[ID_MNV] [int] NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[TrinhDo] [nvarchar](100) NOT NULL,
	[ChuyenMon] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_NHAN_VIEN] PRIMARY KEY CLUSTERED 
(
	[ID_MNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PT_CHUYEN_GIA]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PT_CHUYEN_GIA](
	[ID_MNV] [int] NOT NULL,
	[PhuCapVIP] [decimal](12, 2) NOT NULL,
	[HeSoKinhNghiem] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_PT_CHUYEN_GIA] PRIMARY KEY CLUSTERED 
(
	[ID_MNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PT_ChuyenGia]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PT_ChuyenGia](
	[ID_MNV] [int] NOT NULL,
	[PhuCapVIP] [decimal](12, 2) NOT NULL,
	[HeSoKinhNghiem] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_PT_ChuyenGia] PRIMARY KEY CLUSTERED 
(
	[ID_MNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TAI_KHOAN]    Script Date: 11/13/2026 8:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAI_KHOAN](
	[ID_TK] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [varchar](64) NOT NULL,
	[VaiTro] [nvarchar](20) NOT NULL,
	[ID_MNV] [int] NULL,
	[TrangThai] [bit] NOT NULL,
	[NgayTao] [datetime] NOT NULL,
 CONSTRAINT [PK_TAI_KHOAN] PRIMARY KEY CLUSTERED 
(
	[ID_TK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[CHI_TIET_DANG_KI] ([ID_CTG], [ID_MGT], [TenChiTietGoi], [SoLuongHVToiDa]) VALUES (101, 1, N'Cơ Bản - Ca Sáng', 30)
INSERT [dbo].[CHI_TIET_DANG_KI] ([ID_CTG], [ID_MGT], [TenChiTietGoi], [SoLuongHVToiDa]) VALUES (102, 2, N'Tiêu Chuẩn - Ca Chiều', 20)
INSERT [dbo].[CHI_TIET_DANG_KI] ([ID_CTG], [ID_MGT], [TenChiTietGoi], [SoLuongHVToiDa]) VALUES (103, 3, N'Nâng Cao - Ca Tối', 15)
INSERT [dbo].[CHI_TIET_DANG_KI] ([ID_CTG], [ID_MGT], [TenChiTietGoi], [SoLuongHVToiDa]) VALUES (104, 4, N'VIP - Kèm 1:1', 5)
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (1, N'Gói Cơ Bản', 1, 0, 12, CAST(300000.00 AS Decimal(12, 2)), NULL)
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (2, N'Gói Tiêu Chuẩn', 3, 6, 36, CAST(1200000.00 AS Decimal(12, 2)), NULL)
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (3, N'Gói Nâng Cao', 6, 12, 72, CAST(2800000.00 AS Decimal(12, 2)), NULL)
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (4, N'Gói VIP', 12, 36, 144, CAST(6500000.00 AS Decimal(12, 2)), NULL)
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (5, N'Whey Protein Optimum Nutrition Gold Standard', 12, 0, 0, CAST(3000000.00 AS Decimal(12, 2)), N'Uploads/GoiTap/2c8f6e5b95fd4f17aafa0a4187c52125.jpg')
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (6, N'Sữa Protein Mutant ISO Surge 5LB', 24, 0, 0, CAST(5000000.00 AS Decimal(12, 2)), N'Uploads/GoiTap/7e3461300fdf4816922236feda1e9ab3.jpg')
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (7, N'Sữa Tăng Cơ Rule One R1 Whey Protein', 18, 0, 0, CAST(3000000.00 AS Decimal(12, 2)), N'Uploads/GoiTap/8fd4984f508c4d50b72cfa86f9d44ece.jpg')
INSERT [dbo].[GOI_TAP] ([ID_MGT], [TenGoiTap], [SoThang], [SoLuotPT], [SoLuotTuDo], [MucGia], [HinhAnh]) VALUES (8, N'BioTechUSA Hyper Mass 8.8lbs (4kg)', 18, 0, 0, CAST(2000000.00 AS Decimal(12, 2)), N'Uploads/GoiTap/90d3fa82b58a40e5bb567d67ab3ab1ac.jpg')
INSERT [dbo].[HOI_VIEN] ([ID_MHV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (1001, N'Nguyễn Văn An', CAST(0x76210B00 AS Date), N'Nam', N'12 Trần Hưng Đạo, Long Xuyên, An Giang')
INSERT [dbo].[HOI_VIEN] ([ID_MHV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (1002, N'Trần Thị Bình', CAST(0xD2240B00 AS Date), N'Nữ', N'45 Nguyễn Huệ, Long Xuyên, An Giang')
INSERT [dbo].[HOI_VIEN] ([ID_MHV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (1003, N'Lê Hoàng Cường', CAST(0x191E0B00 AS Date), N'Nam', N'78 Lý Thái Tổ, Châu Đốc, An Giang')
INSERT [dbo].[HOI_VIEN] ([ID_MHV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (1004, N'Phạm Minh Dung', CAST(0xFF260B00 AS Date), N'Nữ', N'9 Hùng Vương, Long Xuyên, An Giang')
INSERT [dbo].[HOI_VIEN] ([ID_MHV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (1005, N'Võ Kim Em', CAST(0x98230B00 AS Date), N'Khác', N'23 Phạm Ngũ Lão, Long Xuyên, An Giang')
INSERT [dbo].[HUAN_LUYEN_VIEN] ([ID_MNV], [GiaBieuDay], [HeSoHoaHong]) VALUES (1, CAST(200000.00 AS Decimal(12, 2)), CAST(0.10 AS Decimal(5, 2)))
INSERT [dbo].[HUAN_LUYEN_VIEN] ([ID_MNV], [GiaBieuDay], [HeSoHoaHong]) VALUES (2, CAST(220000.00 AS Decimal(12, 2)), CAST(0.12 AS Decimal(5, 2)))
INSERT [dbo].[HUAN_LUYEN_VIEN] ([ID_MNV], [GiaBieuDay], [HeSoHoaHong]) VALUES (3, CAST(300000.00 AS Decimal(12, 2)), CAST(0.15 AS Decimal(5, 2)))
INSERT [dbo].[HuanLuyenVien] ([ID_MNV], [GiaBieuDay], [HeSoHoaHong]) VALUES (1, CAST(200000.00 AS Decimal(12, 2)), CAST(0.10 AS Decimal(5, 2)))
INSERT [dbo].[HuanLuyenVien] ([ID_MNV], [GiaBieuDay], [HeSoHoaHong]) VALUES (2, CAST(220000.00 AS Decimal(12, 2)), CAST(0.12 AS Decimal(5, 2)))
INSERT [dbo].[HuanLuyenVien] ([ID_MNV], [GiaBieuDay], [HeSoHoaHong]) VALUES (3, CAST(300000.00 AS Decimal(12, 2)), CAST(0.15 AS Decimal(5, 2)))
INSERT [dbo].[LK_DANG_KY] ([ID_MHV], [ID_CTG], [NgayKichHoat], [NgayHetHan], [SoLuotConLai], [TrangThai]) VALUES (1001, 101, CAST(0x444A0B00 AS Date), CAST(0x634A0B00 AS Date), 8, N'Đang hiệu lực')
INSERT [dbo].[LK_DANG_KY] ([ID_MHV], [ID_CTG], [NgayKichHoat], [NgayHetHan], [SoLuotConLai], [TrangThai]) VALUES (1002, 102, CAST(0xF4490B00 AS Date), CAST(0x504A0B00 AS Date), 0, N'Hết hạn')
INSERT [dbo].[LK_DANG_KY] ([ID_MHV], [ID_CTG], [NgayKichHoat], [NgayHetHan], [SoLuotConLai], [TrangThai]) VALUES (1003, 103, CAST(0x214A0B00 AS Date), CAST(0xD64A0B00 AS Date), 60, N'Đang hiệu lực')
INSERT [dbo].[LK_DANG_KY] ([ID_MHV], [ID_CTG], [NgayKichHoat], [NgayHetHan], [SoLuotConLai], [TrangThai]) VALUES (1004, 104, CAST(0xB7490B00 AS Date), CAST(0x244B0B00 AS Date), 100, N'Đang hiệu lực')
INSERT [dbo].[LK_DANG_KY] ([ID_MHV], [ID_CTG], [NgayKichHoat], [NgayHetHan], [SoLuotConLai], [TrangThai]) VALUES (1005, 101, CAST(0x314A0B00 AS Date), CAST(0x3F4A0B00 AS Date), 12, N'Đã hủy')
INSERT [dbo].[LK_LICH_TAP] ([ID_CTG], [ID_MNV], [NgayTap], [KhungGio], [SoLuongHV], [DanhGiaBuoi]) VALUES (101, 1, CAST(0x514A0B00 AS Date), N'06:00 - 08:00', 12, N'Buổi tập tốt, hội viên tập trung')
INSERT [dbo].[LK_LICH_TAP] ([ID_CTG], [ID_MNV], [NgayTap], [KhungGio], [SoLuongHV], [DanhGiaBuoi]) VALUES (101, 2, CAST(0x554A0B00 AS Date), N'06:00 - 08:00', 15, N'Lớp đông, không khí sôi nổi')
INSERT [dbo].[LK_LICH_TAP] ([ID_CTG], [ID_MNV], [NgayTap], [KhungGio], [SoLuongHV], [DanhGiaBuoi]) VALUES (102, 2, CAST(0x524A0B00 AS Date), N'16:00 - 18:00', 10, N'Hội viên tiến bộ rõ rệt')
INSERT [dbo].[LK_LICH_TAP] ([ID_CTG], [ID_MNV], [NgayTap], [KhungGio], [SoLuongHV], [DanhGiaBuoi]) VALUES (103, 3, CAST(0x534A0B00 AS Date), N'18:00 - 20:00', 8, N'Cường độ cao, cần chú ý khởi động')
INSERT [dbo].[LK_LICH_TAP] ([ID_CTG], [ID_MNV], [NgayTap], [KhungGio], [SoLuongHV], [DanhGiaBuoi]) VALUES (104, 3, CAST(0x544A0B00 AS Date), N'19:00 - 20:30', 2, N'Buổi tập 1:1 hiệu quả')
INSERT [dbo].[NHAN_VIEN] ([ID_MNV], [HoTen], [NgaySinh], [GioiTinh], [TrinhDo], [ChuyenMon]) VALUES (1, N'Đặng Quốc Huy', CAST(0x01190B00 AS Date), N'Nam', N'Cử nhân TDTT', N'Thể hình')
INSERT [dbo].[NHAN_VIEN] ([ID_MNV], [HoTen], [NgaySinh], [GioiTinh], [TrinhDo], [ChuyenMon]) VALUES (2, N'Bùi Thu Hà', CAST(0x5D1C0B00 AS Date), N'Nữ', N'Cử nhân TDTT', N'Yoga & Giảm cân')
INSERT [dbo].[NHAN_VIEN] ([ID_MNV], [HoTen], [NgaySinh], [GioiTinh], [TrinhDo], [ChuyenMon]) VALUES (3, N'Ngô Thanh Sơn', CAST(0x12170B00 AS Date), N'Nam', N'Thạc sĩ TDTT', N'Powerlifting')
INSERT [dbo].[NHAN_VIEN] ([ID_MNV], [HoTen], [NgaySinh], [GioiTinh], [TrinhDo], [ChuyenMon]) VALUES (4, N'Huỳnh Mỹ Linh', CAST(0x021F0B00 AS Date), N'Nữ', N'Cao đẳng', N'Lễ tân - Chăm sóc khách hàng')
INSERT [dbo].[NHAN_VIEN] ([ID_MNV], [HoTen], [NgaySinh], [GioiTinh], [TrinhDo], [ChuyenMon]) VALUES (5, N'Trương Văn Khoa', CAST(0x82140B00 AS Date), N'Nam', N'Trung cấp', N'Kỹ thuật thiết bị')
INSERT [dbo].[PT_CHUYEN_GIA] ([ID_MNV], [PhuCapVIP], [HeSoKinhNghiem]) VALUES (1, CAST(500000.00 AS Decimal(12, 2)), CAST(1.20 AS Decimal(5, 2)))
INSERT [dbo].[PT_CHUYEN_GIA] ([ID_MNV], [PhuCapVIP], [HeSoKinhNghiem]) VALUES (2, CAST(600000.00 AS Decimal(12, 2)), CAST(1.30 AS Decimal(5, 2)))
INSERT [dbo].[PT_CHUYEN_GIA] ([ID_MNV], [PhuCapVIP], [HeSoKinhNghiem]) VALUES (3, CAST(900000.00 AS Decimal(12, 2)), CAST(1.50 AS Decimal(5, 2)))
INSERT [dbo].[PT_ChuyenGia] ([ID_MNV], [PhuCapVIP], [HeSoKinhNghiem]) VALUES (1, CAST(500000.00 AS Decimal(12, 2)), CAST(1.20 AS Decimal(5, 2)))
INSERT [dbo].[PT_ChuyenGia] ([ID_MNV], [PhuCapVIP], [HeSoKinhNghiem]) VALUES (2, CAST(600000.00 AS Decimal(12, 2)), CAST(1.30 AS Decimal(5, 2)))
INSERT [dbo].[PT_ChuyenGia] ([ID_MNV], [PhuCapVIP], [HeSoKinhNghiem]) VALUES (3, CAST(900000.00 AS Decimal(12, 2)), CAST(1.50 AS Decimal(5, 2)))
SET IDENTITY_INSERT [dbo].[TAI_KHOAN] ON 

INSERT [dbo].[TAI_KHOAN] ([ID_TK], [TenDangNhap], [MatKhau], [VaiTro], [ID_MNV], [TrangThai], [NgayTao]) VALUES (1, N'admin', N'123456', N'Admin', NULL, 1, CAST(0x0000B501014ECDCF AS DateTime))
SET IDENTITY_INSERT [dbo].[TAI_KHOAN] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_TAI_KHOAN_TenDangNhap]    Script Date: 11/13/2026 8:20:05 PM ******/
ALTER TABLE [dbo].[TAI_KHOAN] ADD  CONSTRAINT [UQ_TAI_KHOAN_TenDangNhap] UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TAI_KHOAN] ADD  CONSTRAINT [DF_TAI_KHOAN_TrangThai]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[TAI_KHOAN] ADD  CONSTRAINT [DF_TAI_KHOAN_NgayTao]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[CHI_TIET_DANG_KI]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_GOI_GOI_TAP] FOREIGN KEY([ID_MGT])
REFERENCES [dbo].[GOI_TAP] ([ID_MGT])
GO
ALTER TABLE [dbo].[CHI_TIET_DANG_KI] CHECK CONSTRAINT [FK_CHI_TIET_GOI_GOI_TAP]
GO
ALTER TABLE [dbo].[HUAN_LUYEN_VIEN]  WITH CHECK ADD  CONSTRAINT [FK_HUAN_LUYEN_VIEN_NHAN_VIEN] FOREIGN KEY([ID_MNV])
REFERENCES [dbo].[NHAN_VIEN] ([ID_MNV])
GO
ALTER TABLE [dbo].[HUAN_LUYEN_VIEN] CHECK CONSTRAINT [FK_HUAN_LUYEN_VIEN_NHAN_VIEN]
GO
ALTER TABLE [dbo].[LK_DANG_KY]  WITH CHECK ADD  CONSTRAINT [FK_LK_DANG_KY_CHI_TIET_GOI] FOREIGN KEY([ID_CTG])
REFERENCES [dbo].[CHI_TIET_DANG_KI] ([ID_CTG])
GO
ALTER TABLE [dbo].[LK_DANG_KY] CHECK CONSTRAINT [FK_LK_DANG_KY_CHI_TIET_GOI]
GO
ALTER TABLE [dbo].[LK_DANG_KY]  WITH CHECK ADD  CONSTRAINT [FK_LK_DANG_KY_HOI_VIEN] FOREIGN KEY([ID_MHV])
REFERENCES [dbo].[HOI_VIEN] ([ID_MHV])
GO
ALTER TABLE [dbo].[LK_DANG_KY] CHECK CONSTRAINT [FK_LK_DANG_KY_HOI_VIEN]
GO
ALTER TABLE [dbo].[LK_LICH_TAP]  WITH CHECK ADD  CONSTRAINT [FK_LK_LICH_TAP_CHI_TIET_GOI] FOREIGN KEY([ID_CTG])
REFERENCES [dbo].[CHI_TIET_DANG_KI] ([ID_CTG])
GO
ALTER TABLE [dbo].[LK_LICH_TAP] CHECK CONSTRAINT [FK_LK_LICH_TAP_CHI_TIET_GOI]
GO
ALTER TABLE [dbo].[LK_LICH_TAP]  WITH CHECK ADD  CONSTRAINT [FK_LK_LICH_TAP_NHAN_VIEN] FOREIGN KEY([ID_MNV])
REFERENCES [dbo].[NHAN_VIEN] ([ID_MNV])
GO
ALTER TABLE [dbo].[LK_LICH_TAP] CHECK CONSTRAINT [FK_LK_LICH_TAP_NHAN_VIEN]
GO
ALTER TABLE [dbo].[PT_CHUYEN_GIA]  WITH CHECK ADD  CONSTRAINT [FK_PT_CHUYEN_GIA_HUAN_LUYEN_VIEN] FOREIGN KEY([ID_MNV])
REFERENCES [dbo].[HUAN_LUYEN_VIEN] ([ID_MNV])
GO
ALTER TABLE [dbo].[PT_CHUYEN_GIA] CHECK CONSTRAINT [FK_PT_CHUYEN_GIA_HUAN_LUYEN_VIEN]
GO
ALTER TABLE [dbo].[PT_ChuyenGia]  WITH CHECK ADD  CONSTRAINT [FK_PT_ChuyenGia_HuanLuyenVien] FOREIGN KEY([ID_MNV])
REFERENCES [dbo].[HuanLuyenVien] ([ID_MNV])
GO
ALTER TABLE [dbo].[PT_ChuyenGia] CHECK CONSTRAINT [FK_PT_ChuyenGia_HuanLuyenVien]
GO
ALTER TABLE [dbo].[TAI_KHOAN]  WITH CHECK ADD  CONSTRAINT [FK_TAI_KHOAN_NHAN_VIEN] FOREIGN KEY([ID_MNV])
REFERENCES [dbo].[NHAN_VIEN] ([ID_MNV])
GO
ALTER TABLE [dbo].[TAI_KHOAN] CHECK CONSTRAINT [FK_TAI_KHOAN_NHAN_VIEN]
GO
ALTER TABLE [dbo].[CHI_TIET_DANG_KI]  WITH CHECK ADD  CONSTRAINT [CK_CHI_TIET_GOI_SoLuongHVToiDa] CHECK  (([SoLuongHVToiDa]>(0)))
GO
ALTER TABLE [dbo].[CHI_TIET_DANG_KI] CHECK CONSTRAINT [CK_CHI_TIET_GOI_SoLuongHVToiDa]
GO
ALTER TABLE [dbo].[GOI_TAP]  WITH CHECK ADD  CONSTRAINT [CK_GOI_TAP_MucGia] CHECK  (([MucGia]>=(0)))
GO
ALTER TABLE [dbo].[GOI_TAP] CHECK CONSTRAINT [CK_GOI_TAP_MucGia]
GO
ALTER TABLE [dbo].[GOI_TAP]  WITH CHECK ADD  CONSTRAINT [CK_GOI_TAP_SoLuotPT] CHECK  (([SoLuotPT]>=(0)))
GO
ALTER TABLE [dbo].[GOI_TAP] CHECK CONSTRAINT [CK_GOI_TAP_SoLuotPT]
GO
ALTER TABLE [dbo].[GOI_TAP]  WITH CHECK ADD  CONSTRAINT [CK_GOI_TAP_SoLuotTuDo] CHECK  (([SoLuotTuDo]>=(0)))
GO
ALTER TABLE [dbo].[GOI_TAP] CHECK CONSTRAINT [CK_GOI_TAP_SoLuotTuDo]
GO
ALTER TABLE [dbo].[GOI_TAP]  WITH CHECK ADD  CONSTRAINT [CK_GOI_TAP_SoThang] CHECK  (([SoThang]>(0)))
GO
ALTER TABLE [dbo].[GOI_TAP] CHECK CONSTRAINT [CK_GOI_TAP_SoThang]
GO
ALTER TABLE [dbo].[HOI_VIEN]  WITH CHECK ADD  CONSTRAINT [CK_HOI_VIEN_GioiTinh] CHECK  (([GioiTinh]=N'Khác' OR [GioiTinh]=N'Nữ' OR [GioiTinh]=N'Nam'))
GO
ALTER TABLE [dbo].[HOI_VIEN] CHECK CONSTRAINT [CK_HOI_VIEN_GioiTinh]
GO
ALTER TABLE [dbo].[HUAN_LUYEN_VIEN]  WITH CHECK ADD  CONSTRAINT [CK_HUAN_LUYEN_VIEN_GiaBieuDay] CHECK  (([GiaBieuDay]>=(0)))
GO
ALTER TABLE [dbo].[HUAN_LUYEN_VIEN] CHECK CONSTRAINT [CK_HUAN_LUYEN_VIEN_GiaBieuDay]
GO
ALTER TABLE [dbo].[HUAN_LUYEN_VIEN]  WITH CHECK ADD  CONSTRAINT [CK_HUAN_LUYEN_VIEN_HeSoHoaHong] CHECK  (([HeSoHoaHong]>=(0)))
GO
ALTER TABLE [dbo].[HUAN_LUYEN_VIEN] CHECK CONSTRAINT [CK_HUAN_LUYEN_VIEN_HeSoHoaHong]
GO
ALTER TABLE [dbo].[LK_DANG_KY]  WITH CHECK ADD  CONSTRAINT [CK_LK_DANG_KY_Ngay] CHECK  (([NgayHetHan]>=[NgayKichHoat]))
GO
ALTER TABLE [dbo].[LK_DANG_KY] CHECK CONSTRAINT [CK_LK_DANG_KY_Ngay]
GO
ALTER TABLE [dbo].[LK_DANG_KY]  WITH CHECK ADD  CONSTRAINT [CK_LK_DANG_KY_SoLuotConLai] CHECK  (([SoLuotConLai]>=(0)))
GO
ALTER TABLE [dbo].[LK_DANG_KY] CHECK CONSTRAINT [CK_LK_DANG_KY_SoLuotConLai]
GO
ALTER TABLE [dbo].[LK_DANG_KY]  WITH CHECK ADD  CONSTRAINT [CK_LK_DANG_KY_TrangThai] CHECK  (([TrangThai]=N'Đã hủy' OR [TrangThai]=N'Hết hạn' OR [TrangThai]=N'Đang hiệu lực'))
GO
ALTER TABLE [dbo].[LK_DANG_KY] CHECK CONSTRAINT [CK_LK_DANG_KY_TrangThai]
GO
ALTER TABLE [dbo].[LK_LICH_TAP]  WITH CHECK ADD  CONSTRAINT [CK_LK_LICH_TAP_SoLuongHV] CHECK  (([SoLuongHV]>=(0)))
GO
ALTER TABLE [dbo].[LK_LICH_TAP] CHECK CONSTRAINT [CK_LK_LICH_TAP_SoLuongHV]
GO
ALTER TABLE [dbo].[NHAN_VIEN]  WITH CHECK ADD  CONSTRAINT [CK_NHAN_VIEN_GioiTinh] CHECK  (([GioiTinh]=N'Khác' OR [GioiTinh]=N'Nữ' OR [GioiTinh]=N'Nam'))
GO
ALTER TABLE [dbo].[NHAN_VIEN] CHECK CONSTRAINT [CK_NHAN_VIEN_GioiTinh]
GO
ALTER TABLE [dbo].[PT_CHUYEN_GIA]  WITH CHECK ADD  CONSTRAINT [CK_PT_CHUYEN_GIA_HeSoKinhNghiem] CHECK  (([HeSoKinhNghiem]>=(0)))
GO
ALTER TABLE [dbo].[PT_CHUYEN_GIA] CHECK CONSTRAINT [CK_PT_CHUYEN_GIA_HeSoKinhNghiem]
GO
ALTER TABLE [dbo].[PT_CHUYEN_GIA]  WITH CHECK ADD  CONSTRAINT [CK_PT_CHUYEN_GIA_PhuCapVIP] CHECK  (([PhuCapVIP]>=(0)))
GO
ALTER TABLE [dbo].[PT_CHUYEN_GIA] CHECK CONSTRAINT [CK_PT_CHUYEN_GIA_PhuCapVIP]
GO
ALTER TABLE [dbo].[TAI_KHOAN]  WITH CHECK ADD  CONSTRAINT [CK_TAI_KHOAN_VaiTro] CHECK  (([VaiTro]=N'Nhân viên' OR [VaiTro]=N'Admin'))
GO
ALTER TABLE [dbo].[TAI_KHOAN] CHECK CONSTRAINT [CK_TAI_KHOAN_VaiTro]
GO
USE [master]
GO
ALTER DATABASE [n7_phongGym] SET  READ_WRITE 
GO
