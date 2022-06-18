USE [master]
GO
/****** Object:  Database [THANHTOANTROIGIO]    Script Date: 11/06/2022 5:39:58 PM ******/
CREATE DATABASE [THANHTOANTROIGIO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'THANHTOANTROIGIO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SERVER\MSSQL\DATA\THANHTOANTROIGIO.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'THANHTOANTROIGIO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SERVER\MSSQL\DATA\THANHTOANTROIGIO_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [THANHTOANTROIGIO] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [THANHTOANTROIGIO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [THANHTOANTROIGIO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET ARITHABORT OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET RECOVERY FULL 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET  MULTI_USER 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [THANHTOANTROIGIO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [THANHTOANTROIGIO] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'THANHTOANTROIGIO', N'ON'
GO
USE [THANHTOANTROIGIO]
GO
/****** Object:  Table [dbo].[BacHoc]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacHoc](
	[MaBac] [nchar](10) NOT NULL,
	[TenBac] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BacHoc] PRIMARY KEY CLUSTERED 
(
	[MaBac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BoMon]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BoMon](
	[MaBoMon] [nchar](10) NOT NULL,
	[TenBoMon] [nvarchar](100) NOT NULL,
	[MaKhoa] [nchar](10) NOT NULL,
 CONSTRAINT [PK_BoMon] PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaChucVu] [nchar](10) NOT NULL,
	[TenChucVu] [nvarchar](20) NOT NULL,
	[DinhMucGiam] [float] NOT NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucGiang]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucGiang](
	[MaGV] [nchar](20) NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
	[DinhMucGiang] [float] NOT NULL,
 CONSTRAINT [PK_DinhMucGiang] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucNCKH]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucNCKH](
	[MaGV] [nchar](20) NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
	[DinhMuc] [float] NOT NULL,
 CONSTRAINT [PK_DinhMucNCKH] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaGiangVien] [nchar](20) NOT NULL,
	[Ho] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](10) NOT NULL,
	[HocVi] [nvarchar](20) NOT NULL,
	[ChucVu] [nvarchar](20) NOT NULL,
	[ChucDanh] [nvarchar](20) NOT NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Sdt] [nchar](10) NULL,
	[MaBoMon] [nchar](10) NOT NULL,
	[GVCoHuu] [bit] NOT NULL,
	[TrangThaiXoa] [bit] NULL,
 CONSTRAINT [PK_GiangVien] PRIMARY KEY CLUSTERED 
(
	[MaGiangVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeLop]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeLop](
	[MaHeLop] [nchar](10) NOT NULL,
	[TenHeLop] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_HeLop] PRIMARY KEY CLUSTERED 
(
	[MaHeLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocVi]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocVi](
	[MaHocVi] [nchar](10) NOT NULL,
	[TenHocVi] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_HocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HuongDanTTTN]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuongDanTTTN](
	[MaGV] [nchar](20) NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
	[HeSoPB] [float] NOT NULL,
	[SoSinhVienPB] [float] NOT NULL,
	[Lop] [nvarchar](200) NOT NULL,
	[SoSinhVienHD] [float] NOT NULL,
	[SoTuan] [int] NOT NULL,
	[HeSoHD] [float] NOT NULL,
 CONSTRAINT [PK_HuongDanTTTN_1] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC,
	[Lop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [nchar](10) NOT NULL,
	[TenKhoa] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiGiangVien]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiGiangVien](
	[MaLoaiGV] [nchar](10) NOT NULL,
	[TenLoaiGV] [nvarchar](20) NULL,
 CONSTRAINT [PK_LoaiGiangVien] PRIMARY KEY CLUSTERED 
(
	[MaLoaiGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopDongLyThuyet]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopDongLyThuyet](
	[MaLTC] [nchar](10) NOT NULL,
	[MaNgayThayDoi] [nchar](10) NOT NULL,
	[SiSoMin] [int] NULL,
	[SiSoMax] [int] NULL,
	[HSLopDong] [float] NULL,
 CONSTRAINT [PK_ThayDoiHeSoLT] PRIMARY KEY CLUSTERED 
(
	[MaLTC] ASC,
	[MaNgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopDongThucHanh]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopDongThucHanh](
	[MaKhoa] [nchar](10) NOT NULL,
	[MaNV] [nchar](10) NOT NULL,
	[HeSoLopDong] [float] NULL,
	[SiSoMin] [int] NULL,
	[SiSoMax] [int] NULL,
	[NgayApDung] [datetime] NULL,
 CONSTRAINT [PK_ThayDoiHSLopDongTH] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC,
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopTinChi]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopTinChi](
	[MaLTC] [int] IDENTITY(1,1) NOT NULL,
	[TenLTC] [nvarchar](50) NOT NULL,
	[SiSo] [int] NOT NULL,
	[SoNhomTH] [int] NOT NULL,
	[TietBTQD] [float] NOT NULL,
	[TietBTTD] [float] NOT NULL,
	[TietLTQD] [float] NOT NULL,
	[TietLTTD] [float] NOT NULL,
	[TietTHQD] [float] NOT NULL,
	[TietTHTD] [float] NOT NULL,
	[DonGia] [int] NOT NULL,
	[HSMonMoi] [float] NOT NULL,
	[HSNgoaiGio] [float] NOT NULL,
	[HSLopDongTH] [float] NOT NULL,
	[HSLopDongLT] [float] NOT NULL,
	[HSLTC] [float] NOT NULL,
	[MaMon] [nchar](10) NOT NULL,
	[HeSoBac] [float] NOT NULL,
	[MaBac] [nchar](10) NOT NULL,
	[HeSoHeLop] [float] NOT NULL,
	[MaHeLop] [nchar](10) NOT NULL,
	[MaGV] [nchar](20) NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
 CONSTRAINT [PK_LopTinChi] PRIMARY KEY CLUSTERED 
(
	[MaLTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[MaMonHoc] [nchar](10) NOT NULL,
	[TenMonHoc] [nvarchar](20) NOT NULL,
	[TietLT] [float] NOT NULL,
	[TietTH] [float] NOT NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[MaMonHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NienKhoaHocKy]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NienKhoaHocKy](
	[MaNKHK] [nchar](10) NOT NULL,
	[TenHocKy] [nvarchar](15) NOT NULL,
	[TenNienKhoa] [nchar](10) NOT NULL,
 CONSTRAINT [PK_HocKy] PRIMARY KEY CLUSTERED 
(
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiBoMon]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiBoMon](
	[MaBoMon] [nchar](10) NOT NULL,
	[MaGV] [nchar](20) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiBoMon] PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC,
	[MaGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiChucVu]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiChucVu](
	[MaChucVu] [nchar](10) NOT NULL,
	[MaGV] [nchar](20) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiChucVu_1] PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC,
	[MaGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiGiaHocVi]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiGiaHocVi](
	[MaGVDieuChinh] [nchar](20) NOT NULL,
	[MaHocVi] [nchar](10) NOT NULL,
	[DonGia] [int] NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ThayDoiGiaHocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHocVi]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHocVi](
	[MaHocVi] [nchar](10) NOT NULL,
	[MaGV] [nchar](20) NOT NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_ThayDoiHocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC,
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHSBac]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHSBac](
	[MaBac] [nchar](10) NOT NULL,
	[MaGV] [nchar](20) NOT NULL,
	[HeSo] [float] NOT NULL,
	[NgayApDung] [datetime] NULL,
 CONSTRAINT [PK_ThayDoiHSBac] PRIMARY KEY CLUSTERED 
(
	[MaBac] ASC,
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHSHeLop]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHSHeLop](
	[MaHeLop] [nchar](10) NOT NULL,
	[MaGV] [nchar](20) NOT NULL,
	[HeSo] [float] NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiHSHeLop] PRIMARY KEY CLUSTERED 
(
	[MaHeLop] ASC,
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiLoaiGV]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiLoaiGV](
	[MaGV] [nchar](20) NOT NULL,
	[MaLoaiGV] [nchar](10) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiLoaiGV_1] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaLoaiGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThietLapGiaLoaiGV]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThietLapGiaLoaiGV](
	[MaLoaiGV] [nchar](10) NOT NULL,
	[DonGia] [int] NOT NULL,
	[MaGVDieuChinh] [nchar](20) NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ThietLapGiaLoaiGV] PRIMARY KEY CLUSTERED 
(
	[MaLoaiGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThucHienNCKH]    Script Date: 11/06/2022 5:39:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucHienNCKH](
	[MaGV] [nchar](20) NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
	[ThucTeNCKH] [float] NOT NULL,
 CONSTRAINT [PK_ThucHienNCKH] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'AT2       ', N'An toàn thông tin', N'CNTT2     ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'CNDPT     ', N'Công nghệ đa phương tiện', N'CNTT2     ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'DK&XLTH   ', N'Xử lý tín hiệu và truyền thông', N'KTDT2     ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'GD2       ', N'Giáo dục chính trị và thể chất', N'CB2       ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'KT1       ', N'Điện tử máy tính', N'KTDT2     ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'MS2       ', N'Truyền thông và mạng máy tính', N'CNTT2     ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'TH2       ', N'Thí nghiệm - Thực hành kỹ thuật điện tử', N'KTDT2     ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'TO2       ', N'Toán', N'CB2       ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'VL2       ', N'Vật lý', N'CB2       ')
GO
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'GV        ', N'Giảng viên', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PGD       ', N'Phó Giám Đốc', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PK        ', N'Phó khoa', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PT_KH     ', N'Phụ trách khoa', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PT_PH     ', N'Phụ trách phòng', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PTK       ', N'Phó trưởng khoa', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PTNM      ', N'Phụ trách bộ môn', 0)
GO
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV01                ', N'Trương', N'Tân', N'Kỹ sư', N'Giảng viên', N'GVCC', 1, CAST(N'1970-01-01' AS Date), N'Sài Gòn', NULL, N'TO2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV011               ', N'Huỳnh Trọng', N'Thưa', N'false', N'Phó Giám Đốc', N'GV', 1, CAST(N'1970-01-01' AS Date), N'Long An nè', N'0336995842', N'GD2       ', 1, 1)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV02                ', N'Lê', N'Luân', N'Giáo sư - Tiến Sĩ', N'Phó Giám Đốc', N'GVC', 1, CAST(N'1970-01-01' AS Date), NULL, NULL, N'AT2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV03                ', N'Trần', N'Lam', N'PGS - Tiến sĩ', N'Phó khoa', N'GVCC', 0, CAST(N'1972-07-05' AS Date), N'Hà Nội', N'0334568774', N'TO2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV04                ', N'Huỳnh', N'An', N'Thạc sĩ', N'Giảng viên', N'GVC', 0, CAST(N'1970-01-01' AS Date), N'Long An', N'0336995842', N'GD2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV05                ', N'Trần', N'Phương', N'Giáo sư - Tiến Sĩ', N'Giảng viên', N'GV', 0, CAST(N'1970-02-01' AS Date), NULL, NULL, N'GD2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV10                ', N'Lê', N'Tiến', N'Cử nhân', N'Giảng viên', N'GV', 0, CAST(N'1970-01-01' AS Date), NULL, NULL, N'GD2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV23                ', N'Nguyễn Anh', N'Hào', N'Cử nhân', N'Phó Giám Đốc', N'GVC', 1, CAST(N'1970-01-01' AS Date), NULL, NULL, N'GD2       ', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'Test                ', N'Lê', N'A', N'Giáo sư - Tiến Sĩ', N'Phó Giám Đốc', N'GVC', 1, CAST(N'1970-01-01' AS Date), NULL, NULL, N'GD2       ', 0, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'Test2               ', N'Lê', N'Lúa', N'Giáo sư - Tiến Sĩ', N'Phụ trách khoa', N'GVCC', 1, CAST(N'1970-01-01' AS Date), NULL, NULL, N'GD2       ', 0, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'VL01                ', N'Lê Thị', N'Nhãn', N'Cử nhân', N'Giảng viên', N'GV', 0, CAST(N'1985-01-01' AS Date), NULL, NULL, N'VL2       ', 1, 0)
GO
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'CN        ', N'Cử nhân')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'GS.TS     ', N'Giáo sư - Tiến Sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'KS        ', N'Kỹ sư')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'PGS.TS    ', N'PGS - Tiến sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'THS       ', N'Thạc sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'TS        ', N'Tiến sĩ')
GO
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'CB2       ', N'Cơ bản 2')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'CNTT2     ', N'Công nghệ thông tin 2')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'KTDT2     ', N'Kỹ thuật điện tử 2')
GO
INSERT [dbo].[LoaiGiangVien] ([MaLoaiGV], [TenLoaiGV]) VALUES (N'0         ', N'Không cơ hữu')
INSERT [dbo].[LoaiGiangVien] ([MaLoaiGV], [TenLoaiGV]) VALUES (N'1         ', N'Cơ hữu')
GO
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20201     ', N'Học Kỳ 1', N'2020-2021 ')
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20202     ', N'Học Kỳ 2', N'2020-2021 ')
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20211     ', N'Học Kỳ 3', N'2021-2022 ')
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20212     ', N'Học Kỳ 2', N'2021-2022 ')
GO
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'AT2       ', N'GV011               ', CAST(N'2022-06-09T20:14:58.647' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'AT2       ', N'GV02                ', CAST(N'2022-05-30T10:45:04.533' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV01                ', CAST(N'2022-05-28T10:01:05.973' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV02                ', CAST(N'2022-05-29T20:37:37.317' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV03                ', CAST(N'2022-05-30T10:51:18.727' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV04                ', CAST(N'2022-05-30T11:46:06.000' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV05                ', CAST(N'2022-06-09T00:48:12.000' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV10                ', CAST(N'2022-06-10T09:51:49.303' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'GV23                ', CAST(N'2022-06-10T10:50:23.010' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'Test                ', CAST(N'2022-06-10T11:05:40.783' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'GD2       ', N'Test2               ', CAST(N'2022-06-10T11:12:33.247' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'MS2       ', N'GV011               ', CAST(N'2022-06-09T20:16:04.277' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'TO2       ', N'GV03                ', CAST(N'2022-06-09T00:18:44.697' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'VL2       ', N'VL01                ', CAST(N'2022-06-11T17:36:31.583' AS DateTime))
GO
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'GV01                ', CAST(N'2022-05-28T10:01:05.973' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'GV011               ', CAST(N'2022-06-09T20:14:58.647' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'GV04                ', CAST(N'2022-05-30T11:46:06.000' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'GV05                ', CAST(N'2022-06-09T00:48:12.000' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'GV10                ', CAST(N'2022-06-10T09:51:49.303' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'GV23                ', CAST(N'2022-06-10T10:50:23.010' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV        ', N'VL01                ', CAST(N'2022-06-11T17:36:31.583' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PGD       ', N'GV011               ', CAST(N'2022-06-09T22:48:02.587' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PGD       ', N'GV011               ', CAST(N'2022-06-09T23:27:11.530' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PGD       ', N'GV02                ', CAST(N'2022-05-29T20:37:37.317' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PGD       ', N'GV23                ', CAST(N'2022-06-10T11:02:59.830' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PGD       ', N'Test                ', CAST(N'2022-06-10T11:05:40.783' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PK        ', N'GV03                ', CAST(N'2022-05-30T10:51:18.727' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PK        ', N'GV23                ', CAST(N'2022-06-10T10:59:35.020' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PK        ', N'Test2               ', CAST(N'2022-06-10T11:12:33.247' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'PT_KH     ', N'Test2               ', CAST(N'2022-06-10T11:20:08.840' AS DateTime))
GO
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'CN        ', N'GV01                ', CAST(N'2022-05-28T10:01:05.973' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'CN        ', N'GV011               ', CAST(N'2022-06-09T22:48:10.410' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'CN        ', N'GV05                ', CAST(N'2022-06-09T00:48:12.000' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'CN        ', N'GV10                ', CAST(N'2022-06-10T09:51:49.303' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'CN        ', N'VL01                ', CAST(N'2022-06-11T17:36:31.583' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'GS.TS     ', N'GV02                ', CAST(N'2022-05-29T20:37:37.317' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'GS.TS     ', N'GV05                ', CAST(N'2022-06-10T10:14:14.597' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'GS.TS     ', N'Test                ', CAST(N'2022-06-10T11:05:40.783' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'GS.TS     ', N'Test2               ', CAST(N'2022-06-10T11:12:33.247' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'KS        ', N'GV01                ', CAST(N'2022-05-30T10:47:24.557' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'PGS.TS    ', N'GV03                ', CAST(N'2022-05-30T10:51:18.727' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'THS       ', N'GV04                ', CAST(N'2022-05-30T11:46:06.000' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'THS       ', N'GV23                ', CAST(N'2022-06-10T10:50:42.623' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'TS        ', N'GV011               ', CAST(N'2022-06-09T20:14:58.647' AS DateTime))
GO
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV01                ', N'1         ', CAST(N'2022-05-28T10:01:05.973' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV011               ', N'1         ', CAST(N'2022-06-09T20:14:58.647' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV02                ', N'1         ', CAST(N'2022-05-29T20:37:37.317' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV03                ', N'1         ', CAST(N'2022-05-30T10:51:18.727' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV04                ', N'0         ', CAST(N'2022-05-30T11:46:06.000' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV04                ', N'0         ', CAST(N'2022-06-09T16:34:51.603' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV04                ', N'1         ', CAST(N'2022-06-09T10:48:22.907' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV04                ', N'1         ', CAST(N'2022-06-09T16:37:47.517' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV05                ', N'0         ', CAST(N'2022-06-09T00:48:12.000' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV05                ', N'1         ', CAST(N'2022-06-09T10:48:52.877' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV10                ', N'1         ', CAST(N'2022-06-10T09:51:49.303' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV23                ', N'1         ', CAST(N'2022-06-10T10:50:23.010' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'Test                ', N'0         ', CAST(N'2022-06-10T11:05:40.783' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'Test2               ', N'0         ', CAST(N'2022-06-10T11:12:33.247' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'VL01                ', N'1         ', CAST(N'2022-06-11T17:36:31.583' AS DateTime))
GO
ALTER TABLE [dbo].[BoMon]  WITH CHECK ADD  CONSTRAINT [FK_BoMon_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BoMon] CHECK CONSTRAINT [FK_BoMon_Khoa]
GO
ALTER TABLE [dbo].[DinhMucGiang]  WITH CHECK ADD  CONSTRAINT [FK_DinhMucGiang_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DinhMucGiang] CHECK CONSTRAINT [FK_DinhMucGiang_GiangVien]
GO
ALTER TABLE [dbo].[DinhMucGiang]  WITH CHECK ADD  CONSTRAINT [FK_DinhMucGiang_NienKhoaHocKy] FOREIGN KEY([MaNKHK])
REFERENCES [dbo].[NienKhoaHocKy] ([MaNKHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DinhMucGiang] CHECK CONSTRAINT [FK_DinhMucGiang_NienKhoaHocKy]
GO
ALTER TABLE [dbo].[DinhMucNCKH]  WITH CHECK ADD  CONSTRAINT [FK_DinhMucNCKH_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DinhMucNCKH] CHECK CONSTRAINT [FK_DinhMucNCKH_GiangVien]
GO
ALTER TABLE [dbo].[DinhMucNCKH]  WITH CHECK ADD  CONSTRAINT [FK_DinhMucNCKH_NienKhoaHocKy] FOREIGN KEY([MaNKHK])
REFERENCES [dbo].[NienKhoaHocKy] ([MaNKHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DinhMucNCKH] CHECK CONSTRAINT [FK_DinhMucNCKH_NienKhoaHocKy]
GO
ALTER TABLE [dbo].[HuongDanTTTN]  WITH CHECK ADD  CONSTRAINT [FK_HuongDanTTTN_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[HuongDanTTTN] CHECK CONSTRAINT [FK_HuongDanTTTN_GiangVien]
GO
ALTER TABLE [dbo].[HuongDanTTTN]  WITH CHECK ADD  CONSTRAINT [FK_HuongDanTTTN_NienKhoaHocKy] FOREIGN KEY([MaNKHK])
REFERENCES [dbo].[NienKhoaHocKy] ([MaNKHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[HuongDanTTTN] CHECK CONSTRAINT [FK_HuongDanTTTN_NienKhoaHocKy]
GO
ALTER TABLE [dbo].[LopTinChi]  WITH CHECK ADD  CONSTRAINT [FK_LopTinChi_BacHoc] FOREIGN KEY([MaBac])
REFERENCES [dbo].[BacHoc] ([MaBac])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopTinChi] CHECK CONSTRAINT [FK_LopTinChi_BacHoc]
GO
ALTER TABLE [dbo].[LopTinChi]  WITH CHECK ADD  CONSTRAINT [FK_LopTinChi_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopTinChi] CHECK CONSTRAINT [FK_LopTinChi_GiangVien]
GO
ALTER TABLE [dbo].[LopTinChi]  WITH CHECK ADD  CONSTRAINT [FK_LopTinChi_HeLop] FOREIGN KEY([MaHeLop])
REFERENCES [dbo].[HeLop] ([MaHeLop])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopTinChi] CHECK CONSTRAINT [FK_LopTinChi_HeLop]
GO
ALTER TABLE [dbo].[LopTinChi]  WITH CHECK ADD  CONSTRAINT [FK_LopTinChi_MonHoc] FOREIGN KEY([MaMon])
REFERENCES [dbo].[MonHoc] ([MaMonHoc])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopTinChi] CHECK CONSTRAINT [FK_LopTinChi_MonHoc]
GO
ALTER TABLE [dbo].[LopTinChi]  WITH CHECK ADD  CONSTRAINT [FK_LopTinChi_NienKhoaHocKy] FOREIGN KEY([MaNKHK])
REFERENCES [dbo].[NienKhoaHocKy] ([MaNKHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopTinChi] CHECK CONSTRAINT [FK_LopTinChi_NienKhoaHocKy]
GO
ALTER TABLE [dbo].[ThayDoiBoMon]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiBoMon_BoMon] FOREIGN KEY([MaBoMon])
REFERENCES [dbo].[BoMon] ([MaBoMon])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiBoMon] CHECK CONSTRAINT [FK_ThayDoiBoMon_BoMon]
GO
ALTER TABLE [dbo].[ThayDoiBoMon]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiBoMon_GiangVien1] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiBoMon] CHECK CONSTRAINT [FK_ThayDoiBoMon_GiangVien1]
GO
ALTER TABLE [dbo].[ThayDoiChucVu]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiChucVu_ChucVu] FOREIGN KEY([MaChucVu])
REFERENCES [dbo].[ChucVu] ([MaChucVu])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiChucVu] CHECK CONSTRAINT [FK_ThayDoiChucVu_ChucVu]
GO
ALTER TABLE [dbo].[ThayDoiChucVu]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiChucVu_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiChucVu] CHECK CONSTRAINT [FK_ThayDoiChucVu_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiGiaHocVi]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSHocVi_GiangVien] FOREIGN KEY([MaGVDieuChinh])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiGiaHocVi] CHECK CONSTRAINT [FK_ThayDoiHSHocVi_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiGiaHocVi]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSHocVi_HocVi] FOREIGN KEY([MaHocVi])
REFERENCES [dbo].[HocVi] ([MaHocVi])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiGiaHocVi] CHECK CONSTRAINT [FK_ThayDoiHSHocVi_HocVi]
GO
ALTER TABLE [dbo].[ThayDoiHocVi]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHocVi_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHocVi] CHECK CONSTRAINT [FK_ThayDoiHocVi_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiHocVi]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHocVi_HocVi] FOREIGN KEY([MaHocVi])
REFERENCES [dbo].[HocVi] ([MaHocVi])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHocVi] CHECK CONSTRAINT [FK_ThayDoiHocVi_HocVi]
GO
ALTER TABLE [dbo].[ThayDoiHSBac]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSBac_BacHoc] FOREIGN KEY([MaBac])
REFERENCES [dbo].[BacHoc] ([MaBac])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHSBac] CHECK CONSTRAINT [FK_ThayDoiHSBac_BacHoc]
GO
ALTER TABLE [dbo].[ThayDoiHSBac]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSBac_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHSBac] CHECK CONSTRAINT [FK_ThayDoiHSBac_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiHSHeLop]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSHeLop_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHSHeLop] CHECK CONSTRAINT [FK_ThayDoiHSHeLop_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiHSHeLop]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSHeLop_HeLop] FOREIGN KEY([MaHeLop])
REFERENCES [dbo].[HeLop] ([MaHeLop])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHSHeLop] CHECK CONSTRAINT [FK_ThayDoiHSHeLop_HeLop]
GO
ALTER TABLE [dbo].[ThayDoiLoaiGV]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiLoaiGV_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiLoaiGV] CHECK CONSTRAINT [FK_ThayDoiLoaiGV_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiLoaiGV]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiLoaiGV_LoaiGiangVien] FOREIGN KEY([MaLoaiGV])
REFERENCES [dbo].[LoaiGiangVien] ([MaLoaiGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiLoaiGV] CHECK CONSTRAINT [FK_ThayDoiLoaiGV_LoaiGiangVien]
GO
ALTER TABLE [dbo].[ThietLapGiaLoaiGV]  WITH CHECK ADD  CONSTRAINT [FK_ThietLapGiaLoaiGV_GiangVien] FOREIGN KEY([MaGVDieuChinh])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThietLapGiaLoaiGV] CHECK CONSTRAINT [FK_ThietLapGiaLoaiGV_GiangVien]
GO
ALTER TABLE [dbo].[ThietLapGiaLoaiGV]  WITH CHECK ADD  CONSTRAINT [FK_ThietLapGiaLoaiGV_LoaiGiangVien] FOREIGN KEY([MaLoaiGV])
REFERENCES [dbo].[LoaiGiangVien] ([MaLoaiGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThietLapGiaLoaiGV] CHECK CONSTRAINT [FK_ThietLapGiaLoaiGV_LoaiGiangVien]
GO
ALTER TABLE [dbo].[ThietLapGiaLoaiGV]  WITH CHECK ADD  CONSTRAINT [FK_ThietLapGiaLoaiGV_NienKhoaHocKy] FOREIGN KEY([MaNKHK])
REFERENCES [dbo].[NienKhoaHocKy] ([MaNKHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThietLapGiaLoaiGV] CHECK CONSTRAINT [FK_ThietLapGiaLoaiGV_NienKhoaHocKy]
GO
ALTER TABLE [dbo].[ThucHienNCKH]  WITH CHECK ADD  CONSTRAINT [FK_ThucHienNCKH_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThucHienNCKH] CHECK CONSTRAINT [FK_ThucHienNCKH_GiangVien]
GO
ALTER TABLE [dbo].[ThucHienNCKH]  WITH CHECK ADD  CONSTRAINT [FK_ThucHienNCKH_NienKhoaHocKy] FOREIGN KEY([MaNKHK])
REFERENCES [dbo].[NienKhoaHocKy] ([MaNKHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThucHienNCKH] CHECK CONSTRAINT [FK_ThucHienNCKH_NienKhoaHocKy]
GO
/****** Object:  StoredProcedure [dbo].[getListGiangVienByBoMon]    Script Date: 11/06/2022 5:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getListGiangVienByBoMon]
@maBoMon nvarchar(50)='GD2'
AS
SELECT * FROM GiangVien WHERE MaBoMon=@maBoMon
GO
/****** Object:  StoredProcedure [dbo].[getNameByID]    Script Date: 11/06/2022 5:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getNameByID]
@id nvarchar(20), @table_name nvarchar(20)
AS
BEGIN
	CREATE TABLE #tempTable(ID nvarchar(10), name nvarchar(20))
	IF(@table_name='ChucVu')
		BEGIN
			INSERT INTO #tempTable (ID,name)
			SELECT MaChucVu,TenChucVu FROM ChucVu
		END

	ELSE IF(@table_name='HocVi')
		BEGIN
			INSERT INTO #tempTable (ID,name)
			SELECT MaHocVi,TenHocVi FROM HocVi
		END
	SELECT name FROM #tempTable where ID=@id

END
GO
/****** Object:  StoredProcedure [dbo].[updateMaGV]    Script Date: 11/06/2022 5:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateMaGV]
@MaGV varchar(10)='GV07',
@MaGVUpdate varchar(10)='GV06'
AS 
BEGIN
	UPDATE GiangVien
	SET MaGiangVien=@MaGVUpdate
	WHERE MaGiangVien=@MaGV
END
GO
USE [master]
GO
ALTER DATABASE [THANHTOANTROIGIO] SET  READ_WRITE 
GO
