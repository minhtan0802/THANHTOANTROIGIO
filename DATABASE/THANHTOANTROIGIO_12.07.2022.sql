USE [master]
GO
/****** Object:  Database [THANHTOANTROIGIO]    Script Date: 12/07/2022 4:25:24 PM ******/
CREATE DATABASE [THANHTOANTROIGIO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'THANHTOANTROIGIO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SERVER\MSSQL\DATA\THANHTOANTROIGIO.mdf' , SIZE = 31744KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'THANHTOANTROIGIO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SERVER\MSSQL\DATA\THANHTOANTROIGIO_log.ldf' , SIZE = 164672KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  User [GV01]    Script Date: 12/07/2022 4:25:24 PM ******/
CREATE USER [GV01] FOR LOGIN [sa2] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV01]
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_HuongDanTTTN]    Script Date: 12/07/2022 4:25:24 PM ******/
CREATE TYPE [dbo].[TYPE_HuongDanTTTN] AS TABLE(
	[MaGV] [varchar](10) NULL,
	[MaNKHK] [varchar](10) NULL,
	[HSPhanBien] [float] NULL,
	[SoSinhVienPB] [float] NULL,
	[Lop] [nvarchar](200) NULL,
	[SoSinhVienHD] [float] NULL,
	[SoTuan] [int] NULL,
	[HSHuongDan] [float] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DelimitedStringToTable]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_DelimitedStringToTable]  
(   
 @String nvarchar(max),  
 @Delimiter nchar(1)  
)  
RETURNS @returnTable TABLE(id int, val NVARCHAR(100))   
AS  
BEGIN  
 IF @String IS NULL RETURN;  
      
 DECLARE @currentStartIndex INT = 1  
  ,@currentEndIndex INT  
  ,@length INT = LEN(@String)  
  ,@idx INT = 0  
  
    SET @currentEndIndex=CHARINDEX(@Delimiter,@String,@currentStartIndex);  
    WHILE (@currentEndIndex<>0)  
    BEGIN   
        INSERT INTO @returnTable VALUES (@idx,LTRIM(SUBSTRING(@String, @currentStartIndex, @currentEndIndex-@currentStartIndex)))  
        SET @currentStartIndex=@currentEndIndex+1;  
        SET @currentEndIndex=CHARINDEX(@Delimiter,@String,@currentStartIndex);  
  SET @idx = @idx + 1;  
    END  
  
 IF (@currentStartIndex <= @length) INSERT INTO @returnTable  VALUES (@idx,LTRIM(SUBSTRING(@String, @currentStartIndex, @length-@currentStartIndex+1)));  
     
   RETURN;  
END 
GO
/****** Object:  Table [dbo].[BacHoc]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacHoc](
	[MaBac] [varchar](50) NOT NULL,
	[TenBac] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BacHoc] PRIMARY KEY CLUSTERED 
(
	[MaBac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BoMon]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BoMon](
	[MaBoMon] [nchar](10) NOT NULL,
	[TenBoMon] [nvarchar](100) NOT NULL,
	[MaKhoa] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BoMon] PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 12/07/2022 4:25:24 PM ******/
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
/****** Object:  Table [dbo].[DinhMucGiang]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucGiang](
	[MaGV] [varchar](50) NOT NULL,
	[MaNKHK] [varchar](50) NOT NULL,
	[DinhMucGiang] [float] NOT NULL,
 CONSTRAINT [PK_DinhMucGiang] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucNCKH]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucNCKH](
	[MaGV] [varchar](50) NOT NULL,
	[MaNKHK] [varchar](50) NOT NULL,
	[DinhMuc] [float] NOT NULL,
 CONSTRAINT [PK_DinhMucNCKH] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaGiangVien] [varchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[HeLop]    Script Date: 12/07/2022 4:25:24 PM ******/
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
/****** Object:  Table [dbo].[HocVi]    Script Date: 12/07/2022 4:25:24 PM ******/
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
/****** Object:  Table [dbo].[HuongDanTTTN]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuongDanTTTN](
	[MaGV] [varchar](50) NOT NULL,
	[MaNKHK] [varchar](50) NOT NULL,
	[HSPhanBien] [float] NOT NULL,
	[SoSinhVienPB] [float] NOT NULL,
	[Lop] [nvarchar](200) NOT NULL,
	[SoSinhVienHD] [float] NOT NULL,
	[SoTuan] [int] NOT NULL,
	[HSHuongDan] [float] NOT NULL,
 CONSTRAINT [PK_HuongDanTTTN_1] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC,
	[Lop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [varchar](50) NOT NULL,
	[TenKhoa] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiGiangVien]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiGiangVien](
	[MaLoaiGV] [nchar](10) NOT NULL,
	[TenLoaiGV] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_LoaiGiangVien] PRIMARY KEY CLUSTERED 
(
	[MaLoaiGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopDongLyThuyet]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopDongLyThuyet](
	[MaKhoa] [varchar](50) NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
	[SiSoMin] [int] NOT NULL,
	[SiSoMax] [int] NOT NULL,
	[HSLopDong] [float] NOT NULL,
 CONSTRAINT [PK_LopDongLyThuyet] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC,
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopDongThucHanh]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopDongThucHanh](
	[MaKhoa] [varchar](50) NOT NULL,
	[HSLopDong] [float] NOT NULL,
	[SiSoMin] [int] NOT NULL,
	[SiSoMax] [int] NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
 CONSTRAINT [PK_LopDongThucHanh] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC,
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopTinChi]    Script Date: 12/07/2022 4:25:24 PM ******/
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
	[HSHocKy] [float] NULL,
	[HSNhomTH] [float] NULL,
	[MaMon] [varchar](50) NOT NULL,
	[HSBac] [float] NOT NULL,
	[MaBac] [varchar](50) NOT NULL,
	[HSHeLop] [float] NOT NULL,
	[MaHeLop] [nchar](10) NOT NULL,
	[MaGV] [varchar](50) NOT NULL,
	[MaNKHK] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LopTinChi] PRIMARY KEY CLUSTERED 
(
	[MaLTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[MaMonHoc] [varchar](50) NOT NULL,
	[TenMonHoc] [nvarchar](50) NOT NULL,
	[TietLT] [float] NOT NULL,
	[TietTH] [float] NOT NULL,
	[TietBT] [float] NOT NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[MaMonHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NienKhoaHocKy]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NienKhoaHocKy](
	[MaNKHK] [varchar](50) NOT NULL,
	[TenHocKy] [nvarchar](15) NOT NULL,
	[TenNienKhoa] [nchar](10) NOT NULL,
 CONSTRAINT [PK_HocKy] PRIMARY KEY CLUSTERED 
(
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiBoMon]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiBoMon](
	[MaBoMon] [nchar](10) NOT NULL,
	[MaGV] [varchar](50) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiBoMon] PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC,
	[MaGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiChucVu]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiChucVu](
	[MaChucVu] [nchar](10) NOT NULL,
	[MaGV] [varchar](50) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiChucVu_1] PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC,
	[MaGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiGiaHocVi]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiGiaHocVi](
	[MaGVDieuChinh] [varchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[ThayDoiHocVi]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHocVi](
	[MaHocVi] [nchar](10) NOT NULL,
	[MaGV] [varchar](50) NOT NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_ThayDoiHocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC,
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHSBac]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHSBac](
	[MaBac] [varchar](50) NOT NULL,
	[MaGV] [varchar](50) NOT NULL,
	[HeSo] [float] NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiHSBac] PRIMARY KEY CLUSTERED 
(
	[MaBac] ASC,
	[MaGV] ASC,
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHSHeLop]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHSHeLop](
	[MaHeLop] [nchar](10) NOT NULL,
	[MaGV] [varchar](50) NOT NULL,
	[HeSo] [float] NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiHSHeLop] PRIMARY KEY CLUSTERED 
(
	[MaHeLop] ASC,
	[MaGV] ASC,
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiLoaiGV]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiLoaiGV](
	[MaGV] [varchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[ThietLapGiaLoaiGV]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThietLapGiaLoaiGV](
	[MaLoaiGV] [nchar](10) NOT NULL,
	[DonGia] [int] NOT NULL,
	[MaGVDieuChinh] [varchar](50) NOT NULL,
	[MaNKHK] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ThietLapGiaLoaiGV] PRIMARY KEY CLUSTERED 
(
	[MaLoaiGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThucHienNCKH]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucHienNCKH](
	[MaGV] [varchar](50) NOT NULL,
	[MaNKHK] [varchar](50) NOT NULL,
	[ThucTeNCKH] [float] NOT NULL,
 CONSTRAINT [PK_ThucHienNCKH] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[LopDongLyThuyet]  WITH CHECK ADD  CONSTRAINT [FK_LopDongLyThuyet_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopDongLyThuyet] CHECK CONSTRAINT [FK_LopDongLyThuyet_Khoa]
GO
ALTER TABLE [dbo].[LopDongThucHanh]  WITH CHECK ADD  CONSTRAINT [FK_LopDongThucHanh_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LopDongThucHanh] CHECK CONSTRAINT [FK_LopDongThucHanh_Khoa]
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
/****** Object:  StoredProcedure [dbo].[get_DS_GV]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_DS_GV]
@maBoMon nvarchar(10)='GD2'
AS
BEGIN
CREATE TABLE #chucDanhTemp(
MaChucDanh varchar(5),
TenChucDanh nvarchar(20)
)
CREATE TABLE #gioiTinh(
MaGioiTinh varchar(5),
GioiTinh nvarchar(20)
)

INSERT INTO #gioiTinh VALUES('0',N'Nữ')
INSERT INTO #gioiTinh VALUES('1',N'Nam')

INSERT INTO #chucDanhTemp VALUES('GV',N'Giảng viên')
INSERT INTO #chucDanhTemp VALUES('GVC',N'Giảng viên chính')
INSERT INTO #chucDanhTemp VALUES('GV',N'Giảng viên cao cấp')

SELECT MaGiangVien as MaGV,Ho,Ten,HocVi,ChucVu,TenChucDanh,gt.GioiTinh,NgaySinh,DiaChi,Sdt,GVCoHuu 
FROM GiangVien as gv LEFT JOIN #chucDanhTemp ON MaChucDanh=ChucDanh
LEFT JOIN #gioiTinh as gt ON gt.MaGioiTinh=gv.GioiTinh
WHERE MaBoMon=@maBoMon
END
GO
/****** Object:  StoredProcedure [dbo].[get_DS_Huong_Dan_TTTN]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_DS_Huong_Dan_TTTN]
@maGV varchar(50), @maNKHK varchar(10)
AS
SELECT * FROM HuongDanTTTN 
WHERE MaGV=@maGV AND MaNKHK=@maNKHK
GO
/****** Object:  StoredProcedure [dbo].[getDonGiaGV]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getDonGiaGV] @maHocVi nchar(10)='TS', @maGV nchar (10)='GV01', @monHoc nvarchar(30)='thể chất'
AS 
declare @chucDanh nchar(10)
declare @giaHocVi int
declare @giaChucDanh int
declare @donGia int
declare @maHocKy nchar(10)
SELECT @chucDanh=ChucDanh FROM GiangVien WHERE MaGiangVien=@maGV
IF (@monHoc LIKE N'%thể chất%')
BEGIN
	set @donGia=47500
	SELECT 'Return Value'=@donGia
	RETURN;
END


IF((SELECT count(MaHocVi)
FROM ThayDoiGiaHocVi
WHERE MaHocVi=@maHocVi)=0)
BEGIN
	set @giaHocVi=45000
END
ELSE
BEGIN
	SELECT @maHocKy=Max(MaNKHK)
	FROM ThayDoiGiaHocVi
	WHERE @maHocVi=@maHocVi

	SELECT @giaHocVi=DonGia
	FROM ThayDoiGiaHocVi
	WHERE MaHocVi=@maHocVi AND MaNKHK=@maHocKy
END
	IF(@chucDanh='GVC') set @giaChucDanh=55000
	ELSE IF (@chucDanh='GVCC') set @giaChucDanh=60000
	
	print(@giaChucDanh)
	IF(@giaChucDanh>@giaHocVi)
	BEGIN
		SET @donGia=@giaChucDanh
	END
	ELSE
		BEGIN
			SET @donGia=@giaHocVi
		END
	SELECT 'Return Value'=@donGia

GO
/****** Object:  StoredProcedure [dbo].[getListGiangVienByBoMon]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getListGiangVienByBoMon]
@maBoMon nvarchar(50)='GD2'
AS
SELECT * FROM GiangVien WHERE MaBoMon=@maBoMon
GO
/****** Object:  StoredProcedure [dbo].[getLTC]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getLTC]
@MaNKHK nchar(10), @MaGV nchar(20)
AS 
BEGIN
SELECT ltc.MaLTC,ltc.TenLTC, mh.TenMonHoc,ltc.SiSo,ltc.HSLopDongLT,ltc.SoNhomTH,ltc.HSLopDongTH,ltc.TietLTTD,ltc.TietBTTD,ltc.TietTHTD,ltc.TietLTQD,ltc.TietBTQD,ltc.TietTHQD,ltc.DonGia,helop.TenHeLop,bachoc.TenBac FROM LopTinChi as ltc, MonHoc as mh,HeLop as helop,BacHoc as bachoc
WHERE ltc.MaNKHK= @MaNKHK and ltc.MaGV=@MaGV
and mh.MaMonHoc=MaMon and helop.MaHeLop=ltc.MaHeLop and bachoc.MaBac=ltc.MaBac
END
GO
/****** Object:  StoredProcedure [dbo].[getNameByID]    Script Date: 12/07/2022 4:25:24 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Import_HuongDanTTTN]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Import_HuongDanTTTN] @HuongDanTTTN TYPE_HuongDanTTTN READONLY
AS 
BEGIN
MERGE INTO HuongDanTTTN AS Target
		USING (Select MaGV, MaNKHK,HSPhanBien,SoSinhVienPB,Lop,SoSinhVienHD,SoTuan,HSHuongDan FROM @HuongDanTTTN) AS Source
		ON Target.MaGV=Source.MaGV AND Target.MaNKHK=Source.MaNKHK AND Target.Lop=Source.Lop
		WHEN MATCHED THEN
			UPDATE SET
				TARGET.HSPhanBien = Source.HSPhanBien, TARGET.SoSinhVienPB = Source.SoSinhVienPB, TARGET.SoSinhVienHD=Source.SoSinhVienHD,
				TARGET.SoTuan=Source.SoTuan, TARGET.HSHuongDan=Source.HSHuongDan
		WHEN NOT MATCHED THEN
			INSERT (MaGV, MaNKHK,HSPhanBien,SoSinhVienPB,Lop,SoSinhVienHD,SoTuan,HSHuongDan)
			VALUES (Source.MaGV, Source.MaNKHK,Source.HSPhanBien,Source.SoSinhVienPB,Source.Lop,Source.SoSinhVienHD,Source.SoTuan,Source.HSHuongDan);
		return;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DangNhap]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_DangNhap]
@TENLOGIN NVARCHAR (50)='sa2'
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT MAGV = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM GiangVien  WHERE MaGiangVien = @TENUSER ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_BacHoc]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Delete_BacHoc]
@maBac varchar(10)
AS
SET XACT_ABORT ON
BEGIN TRAN
	BEGIN TRY
		DELETE FROM ThayDoiHSBac WHERE MaBac=@maBac
		DELETE FROM BacHoc WHERE MaBac=@maBac
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ErrorMessage VARCHAR(2000)
		SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMessage, 16, 1)
	END CATCH

GO
/****** Object:  StoredProcedure [dbo].[sp_get_Bac_Hoc]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_get_Bac_Hoc]
AS
BEGIN
	SELECT MaBac,MAX(NgayApDung) as NgayApDung INTO #BacHoc FROM ThayDoiHSBac GROUP BY MaBac
	SELECT bh.MaBac,td.NgayApDung, td.HeSo INTO #ThayDoiHSBac
	FROM #BacHoc as bh, ThayDoiHSBac as td
	WHERE bh.MaBac=td.MaBac and bh.NgayApDung=td.NgayApDung
	SELECT BH.MaBac,BH.TenBac,thayDoiHS.HeSo FROM BacHoc as BH, #ThayDoiHSBac as thayDoiHS
	WHERE BH.MaBac=thayDoiHS.MaBac
END
GO
/****** Object:  StoredProcedure [dbo].[updatePK]    Script Date: 12/07/2022 4:25:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updatePK]
@pk varchar(100)='TCNN',
@pkUpdate varchar(10)='TCNNN',
@tableName varchar(20)='BacHoc'
AS 
BEGIN
	IF(@tableName='GiangVien')
	BEGIN
		UPDATE GiangVien
		SET MaGiangVien=@pkUpdate
		WHERE MaGiangVien=@pk
	END
	IF(@tableName='BoMon')
	BEGIN
		UPDATE BoMon
		SET MaBoMon=@pkUpdate
		WHERE MaBoMon=@pk
	END
	IF(@tableName='HuongDanTTTN')
	BEGIN
		declare @lop varchar(50)
		declare @maGV varchar(10)
		declare @maNKHK varchar(10)
		SELECT @maGV=val from fn_DelimitedStringToTable(@pk,' ') WHERE id=0;
		SELECT @maNKHK=val from fn_DelimitedStringToTable(@pk,' ') WHERE id=1;
		SELECT @lop=val from fn_DelimitedStringToTable(@pk,' ') WHERE id=2;

		UPDATE HuongDanTTTN
		SET Lop=@pkUpdate
		WHERE MaGV=@maGV and MaNKHK=@maNKHK and Lop=@lop
	END
	IF(@tableName='MonHoc')
	BEGIN
		UPDATE MonHoc
		SET MaMonHoc=@pkUpdate
		WHERE MaMonHoc=@pk
	END

	IF(@tableName='ChucVu')
	BEGIN
		UPDATE ChucVu
		SET MaChucVu=@pkUpdate
		WHERE MaChucVu=@pk
	END

	IF(@tableName='BacHoc')
	BEGIN
		UPDATE BacHoc
		SET MaBac=@pkUpdate
		WHERE MaBac=@pk
	END

END
GO
USE [master]
GO
ALTER DATABASE [THANHTOANTROIGIO] SET  READ_WRITE 
GO
