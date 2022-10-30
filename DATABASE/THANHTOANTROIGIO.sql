USE [master]
GO
/****** Object:  Database [THANHTOANTROIGIO]    Script Date: 25/10/2022 12:36:21 PM ******/
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
/****** Object:  User [GV01]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE USER [GV01] FOR LOGIN [sa2] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [GV01]
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_DinhMucGiang]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE TYPE [dbo].[TYPE_DinhMucGiang] AS TABLE(
	[MaGV] [varchar](50) NULL,
	[MaNKHK] [varchar](10) NULL,
	[DinhMuc] [float] NOT NULL,
	[GhiChu] [nvarchar](255) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_DinhMucNCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE TYPE [dbo].[TYPE_DinhMucNCKH] AS TABLE(
	[MaGV] [varchar](50) NULL,
	[MaNKHK] [varchar](10) NULL,
	[DinhMuc] [float] NOT NULL,
	[GhiChu] [nvarchar](255) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_HuongDanTTTN]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE TYPE [dbo].[TYPE_HuongDanTTTN] AS TABLE(
	[MaGV] [varchar](20) NULL,
	[MaNKHK] [varchar](20) NULL,
	[HSPhanBien] [float] NULL,
	[SoSinhVienPB] [float] NULL,
	[Lop] [nvarchar](200) NULL,
	[SoSinhVienHD] [float] NULL,
	[SoTuan] [int] NULL,
	[HSHuongDan] [float] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_LopTinChi]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE TYPE [dbo].[TYPE_LopTinChi] AS TABLE(
	[MaLTC] [int] NULL,
	[TenLTC] [nvarchar](50) NULL,
	[SiSo] [int] NULL,
	[SoNhomTH] [int] NULL,
	[TietBTQD] [float] NULL,
	[TietBTTD] [float] NULL,
	[TietLTQD] [float] NULL,
	[TietLTTD] [float] NULL,
	[TietTHQD] [float] NULL,
	[TietTHTD] [float] NULL,
	[DonGia] [int] NULL,
	[HSMonMoi] [float] NULL,
	[HSNgoaiGio] [float] NULL,
	[HSLopDongTH] [float] NULL,
	[HSLopDongLT] [float] NULL,
	[HSLTC] [float] NULL,
	[HSHocKy] [float] NULL,
	[HSNhomTH] [float] NULL,
	[MaMon] [varchar](50) NULL,
	[HSBac] [float] NULL,
	[MaBac] [varchar](50) NULL,
	[HSHeLop] [float] NULL,
	[MaHeLop] [varchar](50) NULL,
	[MaGV] [varchar](50) NULL,
	[MaNKHK] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_LopTinChiImport]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE TYPE [dbo].[TYPE_LopTinChiImport] AS TABLE(
	[MaGV] [varchar](50) NULL,
	[HocVi] [varchar](20) NULL,
	[HoGV] [nvarchar](50) NULL,
	[TenGV] [nvarchar](15) NULL,
	[ChucDanh] [varchar](10) NULL,
	[DinhMuc] [float] NULL,
	[DinhMucNCKH] [float] NULL,
	[TenMH] [nvarchar](100) NULL,
	[MaMH] [varchar](20) NULL,
	[HeLop] [varchar](10) NULL,
	[TenLTC] [nvarchar](50) NULL,
	[SiSo] [int] NULL,
	[SoNhomTH] [int] NULL,
	[TietLTQD] [float] NULL,
	[TietBTQD] [float] NULL,
	[TietTHQD] [float] NULL,
	[HSNgoaiGio] [float] NULL,
	[HSMonMoi] [float] NULL,
	[HSLopDongTH] [float] NULL,
	[HSLopDongLT] [float] NULL,
	[HSLTC] [float] NULL,
	[HSNhomTH] [float] NULL,
	[HSHocKy] [float] NULL,
	[MaBac] [varchar](10) NULL,
	[MaNKHK] [varchar](50) NULL,
	[MoTa] [float] NULL,
	[MoTaNCKH] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_ThucHienNCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
CREATE TYPE [dbo].[TYPE_ThucHienNCKH] AS TABLE(
	[MaGV] [varchar](50) NULL,
	[MaNKHK] [varchar](10) NULL,
	[ThucTeNCKH] [float] NOT NULL,
	[GhiChu] [nvarchar](255) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_DelimitedStringToTable]    Script Date: 25/10/2022 12:36:22 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[func_ChuanHoaXau]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_ChuanHoaXau](@String varchar(10)
)
RETURNS varchar(20)
AS 
BEGIN
	DECLARE @Chuoi varchar(20)
	SET @Chuoi=LTRIM(@String)
	SET @Chuoi=RTRIM(@String)


	RETURN @Chuoi
END;
GO
/****** Object:  UserDefinedFunction [dbo].[func_getDonGiaGV]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_getDonGiaGV](@HocVi varchar(10), @ChucDanh varchar(20), @MonHoc nvarchar(50)
)
RETURNS DEC(10,2)
AS 
BEGIN
	DECLARE @DonGia DECIMAL(10,2);
	DECLARE @giaChucDanh float=45000
	DECLARE @giaHocVi float
	IF (@monHoc LIKE N'%thể chất%')
	BEGIN
	set @DonGia=47500
	END
	ELSE
	BEGIN
	set @DonGia=50000
	END

	IF((SELECT count(MaHocVi)
	FROM HocVi
	WHERE MaHocVi=@HocVi)=0)
	BEGIN
		set @DonGia=45000
END
ELSE
BEGIN
	SET @giaHocVi=[dbo].[func_getDonGiaHocVi](@HocVi)
END
	
	IF(@chucDanh='GVC') set @giaChucDanh=55000
	ELSE IF (@chucDanh='GVCC') set @giaChucDanh=60000

	IF(@giaChucDanh>@giaHocVi)
	BEGIN
		SET @DonGia=@giaChucDanh
	END
	ELSE
		BEGIN
			SET @DonGia=@giaHocVi
		END

	RETURN @DonGia;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[func_getDonGiaHocVi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_getDonGiaHocVi](@HocVi varchar(10)='CN'
)
RETURNS DEC(10,0)
AS 
BEGIN
	DECLARE @DonGia DECIMAL(10,0);
	SELECT TOP 1 @DonGia=DonGia
	FROM ThayDoiGiaHocVi
	WHERE MaHocVi=@HocVi
	ORDER BY MaNKHK DESC
	IF (@DonGia IS NULL) 
	BEGIN SET @DonGia=45000 END
	RETURN @DonGia;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[func_getHocViGV]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_getHocViGV](@MaGV varchar(10)
)
RETURNS nvarchar(15)
AS
BEGIN
	DECLARE @HocVi nvarchar(15)
	DECLARE @MaHocVi varchar(10)
	SELECT TOP 1 @MaHocVi=MaHocVi
	FROM ThayDoiHocVi
	WHERE MaGV=@MaGV
	ORDER BY NgayThayDoi DESC

	SELECT @HocVi=TenHocVi
	FROM HocVi
	WHERE MaHocVi=@MaHocVi

	RETURN @HocVi
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetHSBacHoc]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[func_GetHSBacHoc](@MaBac varchar(10)
)
RETURNS DEC(10,2)
AS 
BEGIN
	DECLARE @HeSo DECIMAL(10,0);
	SELECT TOP 1 @HeSo=HeSo
	FROM ThayDoiHSBac
	WHERE MaBac=@MaBac
	ORDER BY NgayApDung DESC

	RETURN @HeSo;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetHSHeLop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[func_GetHSHeLop](@MaHeLop varchar(10)
)
RETURNS DEC(10,2)
AS 
BEGIN
	DECLARE @HeSo DECIMAL(10,0);
	SELECT TOP 1 @HeSo=HeSo
	FROM ThayDoiHSHeLop
	WHERE MaHeLop=@MaHeLop
	ORDER BY NgayApDung DESC
	RETURN @HeSo;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[func_getNguoiKy]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_getNguoiKy](@KyHieu varchar(10), @MaNKHK varchar(10)
)
RETURNS nvarchar(15)
AS
BEGIN
	DECLARE @NguoiKy nvarchar(15)
	SELECT TOP 1 @NguoiKy=HoTen FROM NguoiKy as nk
	WHERE MaNKHK <=@MaNKHK AND KyHieu =@KyHieu
	ORDER BY MaNKHK DESC
	return @NguoiKy
END
GO
/****** Object:  Table [dbo].[BacHoc]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacHoc](
	[MaBac] [varchar](20) NOT NULL,
	[TenBac] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BacHoc] PRIMARY KEY CLUSTERED 
(
	[MaBac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BoMon]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BoMon](
	[MaBoMon] [varchar](10) NOT NULL,
	[TenBoMon] [nvarchar](100) NOT NULL,
	[MaKhoa] [varchar](20) NOT NULL,
	[TipDauNguMonHoc] [varchar](255) NULL,
 CONSTRAINT [PK_BoMon] PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaChucVu] [varchar](10) NOT NULL,
	[TenChucVu] [nvarchar](20) NOT NULL,
	[DinhMucGiam] [float] NOT NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucGiang]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucGiang](
	[MaGV] [varchar](20) NOT NULL,
	[MaNKHK] [varchar](20) NOT NULL,
	[DinhMuc] [float] NULL,
	[GhiChu] [nvarchar](255) NULL,
 CONSTRAINT [PK_DinhMucGiang] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucNCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucNCKH](
	[MaGV] [varchar](20) NOT NULL,
	[MaNKHK] [varchar](20) NOT NULL,
	[DinhMuc] [float] NOT NULL,
	[GhiChu] [nvarchar](255) NULL,
 CONSTRAINT [PK_DinhMucNCKH] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaGiangVien] [varchar](20) NOT NULL,
	[Ho] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](10) NOT NULL,
	[HocVi] [nvarchar](20) NOT NULL,
	[ChucVu] [nvarchar](20) NOT NULL,
	[ChucDanh] [nvarchar](20) NOT NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Sdt] [varchar](12) NULL,
	[MaBoMon] [varchar](50) NOT NULL,
	[GVCoHuu] [bit] NULL,
	[TrangThaiXoa] [bit] NOT NULL,
 CONSTRAINT [PK_GiangVien] PRIMARY KEY CLUSTERED 
(
	[MaGiangVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeLop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeLop](
	[MaHeLop] [varchar](20) NOT NULL,
	[TenHeLop] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_HeLop] PRIMARY KEY CLUSTERED 
(
	[MaHeLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocVi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocVi](
	[MaHocVi] [varchar](10) NOT NULL,
	[TenHocVi] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_HocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HuongDanTTTN]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuongDanTTTN](
	[MaGV] [varchar](20) NOT NULL,
	[MaNKHK] [varchar](20) NOT NULL,
	[Lop] [nvarchar](200) NOT NULL,
	[SoTuan] [int] NOT NULL,
	[SoSinhVienHD] [float] NOT NULL,
	[HSHuongDan] [float] NOT NULL,
	[SoSinhVienPB] [float] NOT NULL,
	[HSPhanBien] [float] NOT NULL,
 CONSTRAINT [PK_HuongDanTTTN_1] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC,
	[Lop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [varchar](20) NOT NULL,
	[TenKhoa] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiGiangVien]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiGiangVien](
	[MaLoaiGV] [varchar](10) NOT NULL,
	[TenLoaiGV] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_LoaiGiangVien] PRIMARY KEY CLUSTERED 
(
	[MaLoaiGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopDongLyThuyet]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopDongLyThuyet](
	[NgayApDung] [datetime] NOT NULL,
	[SiSoMin] [int] NOT NULL,
	[SiSoMax] [int] NOT NULL,
	[HSLopDong] [float] NOT NULL,
 CONSTRAINT [PK_LopDongLyThuyet] PRIMARY KEY CLUSTERED 
(
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopDongThucHanh]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopDongThucHanh](
	[NgayApDung] [datetime] NOT NULL,
	[SiSoMin] [int] NOT NULL,
	[SiSoMax] [int] NOT NULL,
	[HSLopDong] [float] NOT NULL,
 CONSTRAINT [PK_LopDongThucHanh_1] PRIMARY KEY CLUSTERED 
(
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopTinChi]    Script Date: 25/10/2022 12:36:22 PM ******/
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
	[MaMon] [varchar](20) NOT NULL,
	[HSBac] [float] NOT NULL,
	[MaBac] [varchar](20) NOT NULL,
	[HSHeLop] [float] NOT NULL,
	[MaHeLop] [varchar](20) NOT NULL,
	[MaGV] [varchar](20) NOT NULL,
	[MaNKHK] [varchar](20) NOT NULL,
 CONSTRAINT [PK_LopTinChi] PRIMARY KEY CLUSTERED 
(
	[MaLTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[MaMonHoc] [varchar](20) NOT NULL,
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
/****** Object:  Table [dbo].[NguoiKy]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiKy](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[KyHieu] [varchar](15) NOT NULL,
	[ChucVu] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[MaNKHK] [varchar](15) NOT NULL,
 CONSTRAINT [PK_NguoiKy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NienKhoaHocKy]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NienKhoaHocKy](
	[MaNKHK] [varchar](20) NOT NULL,
	[TenHocKy] [nvarchar](15) NOT NULL,
	[TenNienKhoa] [varchar](10) NOT NULL,
 CONSTRAINT [PK_HocKy] PRIMARY KEY CLUSTERED 
(
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiBoMon]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiBoMon](
	[MaBoMon] [varchar](10) NOT NULL,
	[MaGV] [varchar](20) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiBoMon] PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC,
	[MaGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiChucVu]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiChucVu](
	[MaChucVu] [varchar](10) NOT NULL,
	[MaGV] [varchar](20) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiChucVu_1] PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC,
	[MaGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiGiaHocVi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiGiaHocVi](
	[MaGVDieuChinh] [varchar](20) NOT NULL,
	[MaHocVi] [varchar](10) NOT NULL,
	[DonGia] [int] NOT NULL,
	[MaNKHK] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ThayDoiGiaHocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHocVi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHocVi](
	[MaHocVi] [varchar](10) NOT NULL,
	[MaGV] [varchar](20) NOT NULL,
	[NgayThayDoi] [datetime] NULL,
 CONSTRAINT [PK_ThayDoiHocVi] PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC,
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHSBac]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHSBac](
	[MaBac] [varchar](20) NOT NULL,
	[MaGVDieuChinh] [varchar](20) NOT NULL,
	[HeSo] [float] NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiHSBac_1] PRIMARY KEY CLUSTERED 
(
	[MaBac] ASC,
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiHSHeLop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiHSHeLop](
	[MaHeLop] [varchar](20) NOT NULL,
	[MaGVDieuChinh] [varchar](20) NOT NULL,
	[HeSo] [float] NOT NULL,
	[NgayApDung] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiHSHeLop_1] PRIMARY KEY CLUSTERED 
(
	[MaHeLop] ASC,
	[NgayApDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThayDoiLoaiGV]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiLoaiGV](
	[MaGV] [varchar](20) NOT NULL,
	[MaLoaiGV] [varchar](10) NOT NULL,
	[NgayThayDoi] [datetime] NOT NULL,
 CONSTRAINT [PK_ThayDoiLoaiGV_1] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaLoaiGV] ASC,
	[NgayThayDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThietLapGiaLoaiGV]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThietLapGiaLoaiGV](
	[MaLoaiGV] [varchar](10) NOT NULL,
	[DonGia] [int] NOT NULL,
	[MaGVDieuChinh] [varchar](20) NOT NULL,
	[MaNKHK] [varchar](20) NOT NULL,
 CONSTRAINT [PK_ThietLapGiaLoaiGV] PRIMARY KEY CLUSTERED 
(
	[MaLoaiGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThucHienNCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucHienNCKH](
	[MaGV] [varchar](20) NOT NULL,
	[MaNKHK] [varchar](20) NOT NULL,
	[ThucTeNCKH] [float] NOT NULL,
	[GhiChu] [nvarchar](255) NULL,
 CONSTRAINT [PK_ThucHienNCKH] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC,
	[MaNKHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ReportKLGioGiang]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_ReportKLGioGiang](@maNKHK varchar(10))
RETURNS TABLE 
AS RETURN (
SELECT KH.TenKhoa, BM.TenBoMon, GV.MaGiangVien,GV.Ho+' '+GV.Ten AS TenGiangVien,GV.ChucDanh,GV.HocVi,MH.TenMonHoc,LTC.TenLTC, LTC.SiSo,case WHEN LTC.SoNhomTH!=0 THEN FLOOR(LTC.SiSo/LTC.SoNhomTH) END as SoSVNhomTH,
LTC.HSHocKy, LTC.HSLopDongTH,LTC.HSLopDongLT,HSNgoaiGio,HSMonMoi,HSLTC,TietLTTD,TietBTTD,TietTHTD,SoNhomTH, 
LTC.TietLTTD*(LTC.HSLopDongLT+LTC.HSNgoaiGio+LTC.HSMonMoi+LTC.HSBac+LTC.HSHeLop-4)*LTC.HSLTC as LTQuiChuan,
LTC.TietBTTD*(LTC.HSLopDongLT+LTC.HSNgoaiGio+LTC.HSMonMoi+LTC.HSBac+LTC.HSHeLop-4)*LTC.HSLTC as BTQuiChuan,
LTC.TietTHTD*(LTC.HSLopDongTH+LTC.HSNgoaiGio+LTC.HSMonMoi+LTC.HSBac+LTC.HSHeLop-4)*LTC.HSLTC*LTC.SoNhomTH*LTC.HSNhomTH as THQuiChuan,
--TietLTTD*HSLopDongLT*HSNgoaiGio*HSMonMoi*HSLTC +
--TietBTTD*HSLopDongLT*HSNgoaiGio*HSMonMoi*HSLTC +TietTHTD*HSLopDongTH*HSNgoaiGio*HSMonMoi*HSLTC*SoNhomTH*0.5 as TongCong,KH.MaKhoa
LTC.TietLTTD*(LTC.HSLopDongLT+LTC.HSNgoaiGio+LTC.HSMonMoi+LTC.HSBac+LTC.HSHeLop-4)*LTC.HSLTC +
LTC.TietBTTD*(LTC.HSLopDongLT+LTC.HSNgoaiGio+LTC.HSMonMoi+LTC.HSBac+LTC.HSHeLop-4)*LTC.HSLTC +
LTC.TietTHTD*(LTC.HSLopDongTH+LTC.HSNgoaiGio+LTC.HSMonMoi+LTC.HSBac+LTC.HSHeLop-4)*LTC.HSLTC*LTC.SoNhomTH*LTC.HSNhomTH  as TongCong, KH.MaKhoa
FROM GiangVien as GV
LEFT JOIN LopTinChi LTC ON MaGiangVien = MaGV AND  MaNKHK=@maNKHK 
LEFT JOIN MonHoc MH ON MH.MaMonHoc=LTC.MaMon
LEFT JOIN BoMon BM ON BM.MaBoMon=GV.MaBoMon
LEFT JOIN Khoa KH ON KH.MaKhoa=BM.MaKhoa
WHERE TrangThaiXoa=0 AND GVCoHuu=1 )
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetSoTietHuongDanTTTN]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_GetSoTietHuongDanTTTN](@MaNKHK varchar(10))
RETURNS TABLE AS RETURN(
SELECT MaGV,GV.Ho+' '+GV.Ten as TenGiangVien ,KH.TenKhoa, BM.TenBoMon, ChucDanh, HocVi as TrinhDo, Sum(SoTuan*SoSinhVienHD*HSHuongDan+SoSinhVienPB*HSPhanBien) as HuongDanTTTNQuiChuan 
FROM HuongDanTTTN
LEFT JOIN GiangVien GV ON MaGV=MaGiangVien
LEFT JOIN BoMon as BM ON GV.MaBoMon=BM.MaBoMon
LEFT JOIN Khoa as KH ON BM.MaKhoa=KH.MaKhoa
WHERE MaNKHK=@maNKHK AND GV.TrangThaiXoa=0 AND GV.GVCoHuu=1
Group by MaGV, GV.Ho+' '+GV.Ten,KH.TenKhoa,BM.TenBoMon,ChucDanh, HocVi)
GO
/****** Object:  UserDefinedFunction [dbo].[NCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NCKH](@NKHK varchar(20),@HOC_KY int, @NKHK_TRUOC varchar(20))
RETURNS TABLE AS
RETURN
SELECT GiangVien.MaGiangVien, GiangVien.Ho, GiangVien.Ten, DINH_MUC_NCKH=ISNULL(DinhMucNCKH.DinhMuc,0),DINH_MUC_NCKH_HKTRUOC=ISNULL(DinhMucNCKH_HKTRUOC.DinhMuc,0),
TT_NCKH=CASE WHEN @HOC_KY=2 THEN ISNULL(ThucHienNCKH.ThucTeNCKH/2,0) ELSE ISNULL(ThucHienNCKH.ThucTeNCKH,0) END,TT_NCKH_HKTRUOC=ISNULL (ThucHienNCKH_HKTRUOC.ThucTeNCKH/2,0),-- VÌ CHỈ CÓ Thanh toan troi gio mới dùng đến field này nên cứ /2
TAM_TRU=ROUND((CASE WHEN @HOC_KY=2 THEN 0 ELSE (ISNULL(ThucHienNCKH_HKTRUOC.ThucTeNCKH/2,0)-ISNULL(DinhMucNCKH_HKTRUOC.DinhMuc,0))/CASE WHEN GiangVien.ChucDanh='GV' THEN 3.2
WHEN GiangVien.ChucDanh='GVCC' THEN 2.8 ELSE 2.5 END END),2),
GIO_TROI=ROUND(CASE WHEN @HOC_KY=2 THEN ISNULL(ThucHienNCKH.ThucTeNCKH/2,0)-ISNULL(DinhMucNCKH.DinhMuc,0)
ELSE ISNULL(ThucHienNCKH.ThucTeNCKH,0)-(ISNULL(DinhMucNCKH.DinhMuc,0)+ISNULL(DinhMucNCKH_HKTRUOC.DinhMuc,0))
END/CASE WHEN GiangVien.ChucDanh='GV' THEN 3.2
WHEN GiangVien.ChucDanh='GVCC' THEN 2.8 ELSE 2.5 END ,2)
FROM GiangVien
LEFT JOIN DinhMucNCKH ON GiangVien.MaGiangVien = DinhMucNCKH.MaGV AND DinhMucNCKH.MaNKHK=@NKHK
LEFT JOIN DinhMucNCKH AS DinhMucNCKH_HKTRUOC ON GiangVien.MaGiangVien=DinhMucNCKH_HKTRUOC.MaGV AND DinhMucNCKH_HKTRUOC.MaNKHK=@NKHK_TRUOC
LEFT JOIN ThucHienNCKH ON GiangVien.MaGiangVien=ThucHienNCKH.MaGV AND ThucHienNCKH.MaNKHK=@NKHK
LEFT JOIN ThucHienNCKH AS ThucHienNCKH_HKTRUOC ON GiangVien.MaGiangVien=ThucHienNCKH_HKTRUOC.MaGV AND ThucHienNCKH_HKTRUOC.MaNKHK=@NKHK_TRUOC
WHERE GiangVien.TrangThaiXoa=0
GO
INSERT [dbo].[BacHoc] ([MaBac], [TenBac]) VALUES (N'CD', N'Cao Đẳng')
INSERT [dbo].[BacHoc] ([MaBac], [TenBac]) VALUES (N'DH', N'Đại Học')
INSERT [dbo].[BacHoc] ([MaBac], [TenBac]) VALUES (N'TC', N'Trung Cấp')
GO
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'AT2', N'An toàn thông tin', N'CNTT2', NULL)
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'CNDPT', N'Công nghệ đa phương tiện', N'CNTT2', N'CDT, MUL')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'DK&XLTH', N'Xử lý tín hiệu và truyền thông', N'KTDT2', NULL)
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'GD2', N'Giáo Dục Chính Trị Và Thể Chất', N'CB2', NULL)
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'KM2', N'Khoa học máy tính', N'CNTT2', N'INT, CNM, CNP, CNT')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'KT1', N'Điện tử máy tính', N'KTDT2', N'ELE,DTC, DTD, DTL')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'MS2', N'Truyền thông và mạng máy tính', N'CNTT2', NULL)
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'TH2', N'Thí nghiệm - Thực hành kỹ thuật điện tử', N'KTDT2', NULL)
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'TO2', N'Toán', N'CB2', NULL)
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa], [TipDauNguMonHoc]) VALUES (N'VL2', N'Vật lý', N'CB2', NULL)
GO
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'GV', N'Giảng Viên', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PGD', N'Phó Giám Đốc', 0.85)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PK', N'Phó Khoa', 0.25)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PT_KH', N'Phụ Trách Khoa', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PT_PH', N'Phụ Trách Phòng', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PTBM', N'Phụ Trách Bộ Môn', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'PTK', N'Phó Trưởng Khoa', 0)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'TBM', N'Trưởng Bộ Môn', 0.3)
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [DinhMucGiam]) VALUES (N'TK', N'Trưởng Khoa', 0.3)
GO
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211008', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211008', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211008', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211011', N'20202', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211011', N'20211', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211011', N'20212', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211016', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211016', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211016', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211020', N'20202', 101.25, N'Thực hiện 75% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211020', N'20211', 101.25, N'Thực hiện 75% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211020', N'20212', 101.25, N'Thực hiện 75% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211021', N'20202', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211021', N'20211', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211021', N'20212', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0221017', N'20202', 94.5, N'Thực hiện 70% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0221017', N'20211', 94.5, N'Thực hiện 70% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0221017', N'20212', 94.5, N'Thực hiện 70% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0244193', N'20202', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0244193', N'20211', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0244193', N'20212', 108, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20172', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20172', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20172', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20173', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20173', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20173', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20176', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20176', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20176', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20178', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20178', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20178', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20179', N'20202', 102.11, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20179', N'20211', 102.11, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20179', N'20212', 102.11, N'Thực hiện 80% định mức giảng dạy')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20205', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20205', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20205', N'20212', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20226', N'20202', 32.4, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20226', N'20212', 32.4, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20227', N'20202', 61.365, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20227', N'20212', 61.365, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20228', N'20202', 32.4, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20228', N'20212', 32.4, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG028', N'20202', 134.385, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG028', N'20211', 134.385, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG028', N'20212', 134.385, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG084', N'20202', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG084', N'20211', 135, N'')
INSERT [dbo].[DinhMucGiang] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG084', N'20212', 135, N'')
GO
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211008', N'20202', 270, NULL)
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211008', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211008', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211011', N'20202', 108, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211011', N'20211', 216, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211011', N'20212', 216, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211016', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211016', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211016', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211020', N'20202', 101.25, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211020', N'20211', 202.5, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211020', N'20212', 202.5, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211021', N'20202', 270, NULL)
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211021', N'20211', 216, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0211021', N'20212', 216, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0221017', N'20202', 94.5, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0221017', N'20211', 189, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0221017', N'20212', 189, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0244193', N'20202', 108, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0244193', N'20211', 216, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'0244193', N'20212', 216, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20172', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20172', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20172', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20173', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20173', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20173', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20176', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20176', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20176', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20178', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20178', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20178', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20179', N'20202', 102.11, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20179', N'20211', 204.22, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20179', N'20212', 204.22, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20205', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20205', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20205', N'20212', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20226', N'20202', 32.4, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20226', N'20212', 64.8, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20227', N'20202', 61.365, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20227', N'20212', 122.73, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20228', N'20202', 32.4, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'GV/N-20228', N'20212', 64.8, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG028', N'20202', 134.385, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG028', N'20211', 268.77, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG028', N'20212', 268.77, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG084', N'20202', 135, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG084', N'20211', 270, N'')
INSERT [dbo].[DinhMucNCKH] ([MaGV], [MaNKHK], [DinhMuc], [GhiChu]) VALUES (N'TG084', N'20212', 270, N'')
GO
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0211008', N'Nguyễn Anh', N'Hào', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0211011', N'Lê Minh', N'Hóa', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'CNDPT', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0211016', N'Nguyễn Văn', N'Sáu', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'CNDPT', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0211020', N'Lưu Nguyễn Kỳ', N'Thư', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0211021', N'Huỳnh Trọng', N'Thưa', N'Tiến sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0221017', N'Nguyễn Hồng', N'Sơn', N'Tiến sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'0244193', N'Huỳnh Thanh', N'Tâm', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'123456', N'Lê Văn', N'A', N'Thạc sĩ', N'Giảng Viên', N'GV', 1, CAST(N'1970-01-01' AS Date), NULL, NULL, N'GD2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20172', N'Huỳnh Trung', N'Trụ', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20173', N'Nguyễn Ngọc', N'Duy', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20176', N'Lưu Ngọc', N'Điệp', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'CNDPT', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20178', N'Huỳnh Thị Tuyết', N'Trinh', N'Thạc sĩ', N'Giảng viên', N'GV', 1, CAST(N'1970-12-01' AS Date), NULL, NULL, N'CNDPT', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20179', N'Nguyễn Xuân', N'Sâm', N'Tiến sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20205', N'Phan Thanh', N'Hy', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20226', N'Đàm Minh', N'Lịnh', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20227', N'Trần Thị Nhã', N'Vi', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'CNDPT', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV/N-20228', N'Nguyễn Trung', N'Hiếu', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 1, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'GV01', N'Trương', N'Tân', N'Tiến sĩ', N'Giảng viên', N'GVCC', 1, CAST(N'1970-01-01' AS Date), N'Sài Gòn', NULL, N'TO2', 1, 1)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'TG028', N'Nguyễn Tất', N'Mão', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'CNDPT', 0, 0)
INSERT [dbo].[GiangVien] ([MaGiangVien], [Ho], [Ten], [HocVi], [ChucVu], [ChucDanh], [GioiTinh], [NgaySinh], [DiaChi], [Sdt], [MaBoMon], [GVCoHuu], [TrangThaiXoa]) VALUES (N'TG084', N'Nguyễn Thị Bích', N'Nguyên', N'Thạc sĩ', N'Giảng viên', N'GV', 1, NULL, NULL, NULL, N'KM2', 0, 0)
GO
INSERT [dbo].[HeLop] ([MaHeLop], [TenHeLop]) VALUES (N'CQ', N'Chính quy')
INSERT [dbo].[HeLop] ([MaHeLop], [TenHeLop]) VALUES (N'HC', N'Hoàn chỉnh ĐH')
INSERT [dbo].[HeLop] ([MaHeLop], [TenHeLop]) VALUES (N'VHVL', N'Vừa học vừa làm')
GO
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'CN', N'Cử Nhân')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'GS.TS', N'Giáo sư - Tiến Sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'KS', N'Kỹ sư')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'PGS.TS', N'PGS - Tiến sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'ThS', N'Thạc sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'TS', N'Tiến sĩ')
GO
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211011', N'20211', N'D17CQCN01', 6, 25, 0.8, 25, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211011', N'20211', N'D17CQCN05', 6, 25, 0.8, 25, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211011', N'20212', N'D17CQCN01', 6, 25, 0.8, 25, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211011', N'20212', N'D17CQCN05', 6, 25, 0.8, 25, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211016', N'20211', N'D17CQCN03', 6, 28, 0.8, 28, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211016', N'20211', N'D17CQCN04', 6, 20, 0.8, 20, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211016', N'20212', N'D17CQCN03', 6, 28, 0.8, 28, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'0211016', N'20212', N'D17CQCN04', 6, 20, 0.8, 20, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'GV/N-20178', N'20211', N'D17CQCN02', 6, 10, 0.8, 10, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'GV/N-20178', N'20211', N'D18CQCN02', 6, 20, 0.8, 20, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'GV/N-20178', N'20212', N'D17CQCN02', 6, 10, 0.8, 10, 0.4)
INSERT [dbo].[HuongDanTTTN] ([MaGV], [MaNKHK], [Lop], [SoTuan], [SoSinhVienHD], [HSHuongDan], [SoSinhVienPB], [HSPhanBien]) VALUES (N'GV/N-20178', N'20212', N'D18CQCN02', 6, 20, 0.8, 20, 0.4)
GO
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'CB2', N'Cơ bản 2')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'CNTT2', N'Công nghệ thông tin 2')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'KTDT2', N'Kỹ thuật điện tử 2')
GO
INSERT [dbo].[LoaiGiangVien] ([MaLoaiGV], [TenLoaiGV]) VALUES (N'0         ', N'Không cơ hữu')
INSERT [dbo].[LoaiGiangVien] ([MaLoaiGV], [TenLoaiGV]) VALUES (N'1         ', N'Cơ hữu')
GO
INSERT [dbo].[LopDongLyThuyet] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:22:12.133' AS DateTime), 1, 40, 1)
INSERT [dbo].[LopDongLyThuyet] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:22:22.120' AS DateTime), 41, 60, 1.1)
INSERT [dbo].[LopDongLyThuyet] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:22:33.707' AS DateTime), 61, 80, 1.2)
INSERT [dbo].[LopDongLyThuyet] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:22:42.793' AS DateTime), 81, 100, 1.3)
INSERT [dbo].[LopDongLyThuyet] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:22:55.090' AS DateTime), 101, 120, 1.4)
INSERT [dbo].[LopDongLyThuyet] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:23:02.327' AS DateTime), 121, 999, 1.5)
GO
INSERT [dbo].[LopDongThucHanh] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:23:18.827' AS DateTime), 0, 20, 1)
INSERT [dbo].[LopDongThucHanh] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:23:26.107' AS DateTime), 21, 25, 1.1)
INSERT [dbo].[LopDongThucHanh] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:23:43.623' AS DateTime), 31, 35, 1.4)
INSERT [dbo].[LopDongThucHanh] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:24:00.143' AS DateTime), 36, 200, 1.6)
INSERT [dbo].[LopDongThucHanh] ([NgayApDung], [SiSoMin], [SiSoMax], [HSLopDong]) VALUES (CAST(N'2022-08-20T11:24:09.837' AS DateTime), 26, 30, 1.3)
GO
SET IDENTITY_INSERT [dbo].[LopTinChi] ON 

INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2384, N'Khóa 2017- nhóm 1', 144, 4, 6, 6, 36, 36, 6, 6, 55000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1405', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2385, N'Khóa 2019 - nhóm 3', 76, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1358', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2386, N'Khóa 2019- nhóm 4', 72, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1358', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2387, N'Khóa 2019 - nhóm 5', 81, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1358', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2388, N'Khoá 2018 - nhóm 1', 65, 0, 6, 6, 24, 24, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1325', 1, N'DH', 1, N'CQ', N'0221017', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2389, N'Khoá 2018 - nhóm 1', 71, 0, 6, 6, 24, 24, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1323', 1, N'DH', 1, N'CQ', N'0221017', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2390, N'Khoá 2016 - nhóm 1', 31, 0, 32, 32, 12, 12, 0, 0, 55000, 1, 1, 1.4, 1, 1.1, 1, 0.5, N'INT14100', 1, N'DH', 1, N'CQ', N'0221017', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2391, N'Khoá 2017- nhóm 1', 76, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1433', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2392, N'Khoá 2017 - nhóm 2', 81, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1433', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2393, N'Khoá 2017- nhóm 3', 96, 3, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1433', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2394, N'Khoá 2019- nhóm 2', 79, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1339', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2395, N'Khoá 2017 - nhóm 1', 67, 2, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1488', 1, N'DH', 1, N'CQ', N'0211021', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2396, N'Khoá 2019 - nhóm 1', 92, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1358', 1, N'DH', 1, N'CQ', N'0211021', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2397, N'Khoá 2019- nhóm 2', 75, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1358', 1, N'DH', 1, N'CQ', N'0211021', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2398, N'Khóa 2016 - nhóm 1', 36, 0, 32, 32, 12, 12, 0, 0, 55000, 1, 1, 1.6, 1, 1.1, 1, 0.5, N'INT1499', 1, N'DH', 1, N'CQ', N'0211021', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2399, N'Khoá 2017 - nhóm 1', 66, 2, 8, 8, 30, 30, 12, 12, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT14105', 1, N'DH', 1, N'CQ', N'0244193', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2400, N'Khoá 2018 - nhóm 2', 89, 3, 8, 8, 34, 34, 6, 6, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1319', 1, N'DH', 1, N'CQ', N'0244193', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2401, N'Khoá 2018 - nhóm 4', 80, 2, 8, 8, 34, 34, 6, 6, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1319', 1, N'DH', 1, N'CQ', N'0244193', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2402, N'Khoá 2016- nhóm 1', 12, 0, 0, 0, 45, 45, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'INT14101 - H3', 1, N'DH', 1, N'CQ', N'0244193', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2403, N'Khoá 2019 - nhóm 1', 79, 3, 6, 6, 34, 34, 8, 8, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13108', 1, N'DH', 1, N'CQ', N'TG084', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2404, N'Khoá 2018- nhóm 2', 86, 3, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1332', 1, N'DH', 1, N'CQ', N'TG084', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2405, N'Khoá 2018 - nhóm 3', 81, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1332', 1, N'DH', 1, N'CQ', N'TG084', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2406, N'Khoá 2018 - nhóm 4', 90, 3, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1332', 1, N'DH', 1, N'CQ', N'TG084', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2407, N'Khoá 2017- nhóm 1', 76, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1450', 1, N'DH', 1, N'CQ', N'0211008', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2408, N'Khoá 2017 - nhóm 2', 106, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.4, 1.1, 1, 0.5, N'INT1450', 1, N'DH', 1, N'CQ', N'0211008', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2409, N'Khoá 2017- nhóm 1', 83, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1342', 1, N'DH', 1, N'CQ', N'0211008', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2410, N'Khoá 2017 - nhóm 2', 111, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.4, 1.1, 1, 0.5, N'INT1342', 1, N'DH', 1, N'CQ', N'0211008', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2411, N'Khoá 2018
 - nhóm 1', 70, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1422', 1, N'DH', 1, N'CQ', N'0211008', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2412, N'Khoá 2016
 - nhóm 1', 59, 0, 36, 36, 8, 8, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'INT14104', 1, N'DH', 1, N'CQ', N'0211008', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2413, N'Khoá 2019 - nhóm 1', 95, 3, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1339', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2414, N'Khóa 2018- nhóm 1', 106, 3, 8, 8, 34, 34, 6, 6, 50000, 1, 1, 1.6, 1.4, 1.1, 1, 0.5, N'INT1319', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2415, N'Khóa 2018 - nhóm 3', 80, 2, 8, 8, 34, 34, 6, 6, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1319', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2416, N'Khóa 2016 - nhóm 1', 13, 0, 37, 37, 8, 8, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'INT1497', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2417, N'Khoá 2018 - nhóm 1', 72, 2, 4, 4, 32, 32, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13109', 1, N'DH', 1, N'CQ', N'0211020', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2418, N'Khoá 2017 - nhóm 1', 92, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1414', 1, N'DH', 1, N'CQ', N'0211020', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2419, N'Khoá 2017- nhóm 2', 125, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1414', 1, N'DH', 1, N'CQ', N'0211020', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2420, N'Khóa 2018 - nhóm 1', 109, 3, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.4, 1.1, 1, 0.5, N'INT1313', 1, N'DH', 1, N'CQ', N'0211020', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2421, N'Khoá 2018 - nhóm 1', 72, 2, 0, 0, 24, 24, 12, 12, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1357', 1, N'DH', 1, N'CQ', N'0211020', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2422, N'Khoá 2016- nhóm 1', 38, 0, 37, 37, 8, 8, 0, 0, 50000, 1, 1, 1.6, 1, 1.1, 1, 0.5, N'INT1498', 1, N'DH', 1, N'CQ', N'0211020', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2423, N'Khoá 2017 - nhóm 1', 31, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.4, 1, 1.1, 1, 0.5, N'INT1448', 1, N'DH', 1, N'CQ', N'GV/N-20172', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2424, N'Khoá 2017
nhóm 1', 98, 3, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1434-3 ', 1, N'DH', 1, N'CQ', N'GV/N-20172', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2425, N'Khoá 2017- nhóm 2', 99, 3, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1434-3 ', 1, N'DH', 1, N'CQ', N'GV/N-20172', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2426, N'Khoá 2017- nhóm 1', 55, 0, 14, 14, 30, 30, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14136', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2427, N'Khoá 2017 - nhóm 1', 62, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL14138', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2428, N'Khóa 2016 - nhóm 1', 41, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL1485', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2429, N'Khóa 2017- nhóm 1', 55, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14135', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2430, N'Khóa 2016- nhóm 1', 5, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1484', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2431, N'Khóa 2020- nhóm 1', 94, 0, 10, 10, 20, 20, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL1320', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2432, N'Khóa 2017- nhóm 1', 55, 0, 0, 0, 15, 15, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL1465', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2433, N'Khoá 2018 - nhóm 1', 69, 0, 12, 12, 18, 18, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1429', 1, N'DH', 1, N'CQ', N'0211016', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2434, N'Khoá 2017 - nhóm 1', 10, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL14123', 1, N'DH', 1, N'CQ', N'0211016', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2435, N'Khoá 2017 - nhóm 1', 9, 0, 0, 0, 15, 15, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1451', 1, N'DH', 1, N'CQ', N'0211016', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2436, N'Khoá 2019 - nhóm 3', 77, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1339', 1, N'DH', 1, N'CQ', N'0211016', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2437, N'Khoá 2019 - nhóm 4', 70, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1339', 1, N'DH', 1, N'CQ', N'0211016', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2438, N'Khoá 2020- nhóm 1', 94, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL1238', 1, N'DH', 1, N'CQ', N'TG028', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2439, N'Khoá 2017 - nhóm 1', 52, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14144', 1, N'DH', 1, N'CQ', N'TG028', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2440, N'Khoá 2018 - nhóm 1', 69, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1423', 1, N'DH', 1, N'CQ', N'TG028', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2441, N'Khoá 2017 - nhóm 1', 53, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14140', 1, N'DH', 1, N'CQ', N'0211011', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2442, N'Khoá 2017- nhóm 1', 9, 1, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL14125', 1, N'DH', 1, N'CQ', N'0211011', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2443, N'Khoá 2017 - nhóm 1', 10, 1, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1446', 1, N'DH', 1, N'CQ', N'0211011', N'20211')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2444, N'Khóa 2017 - nhóm 1', 22, 1, 6, 6, 36, 36, 6, 6, 55000, 1, 1, 1.1, 1, 1.1, 1, 0.5, N'INT1405', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2445, N'Khóa 2017 - nhóm 1', 70, 2, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1429-2', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2446, N'Khóa 2017 - nhóm 1', 68, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1461', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2447, N'Khóa 2017 - nhóm 2', 69, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1461', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2448, N'Khoá 2017- nhóm 1', 68, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1483', 1, N'DH', 1, N'CQ', N'GV/N-20226', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2449, N'Khoá 2020- nhóm 5', 95, 3, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20226', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2450, N'Khoá 2018- nhóm  1', 88, 3, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1484', 1, N'DH', 1, N'CQ', N'0221017', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2451, N'Khóa 2019- nhóm 2', 68, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13145', 1, N'DH', 1, N'CQ', N'0221017', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2452, N'Khóa 2019- nhóm 3', 76, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13145', 1, N'DH', 1, N'CQ', N'0221017', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2453, N'Khoá 2020
nhóm 1', 73, 2, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2454, N'Khoá 2020
nhóm 2', 95, 3, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2455, N'Khoá 2020
nhóm 3', 76, 2, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2456, N'Khoá 2018
nhóm 1', 14, 1, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'INT13110', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2457, N'Khoá 2017- nhóm 1', 73, 2, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT14102', 1, N'DH', 1, N'CQ', N'0211021', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2458, N'Khoá 2019- nhóm 2', 156, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1359-3 ', 1, N'DH', 1, N'CQ', N'0211021', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2459, N'Khoá 2018- nhóm 1', 91, 3, 8, 8, 30, 30, 12, 12, 55000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1344', 1, N'DH', 1, N'CQ', N'0211021', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2460, N'Khóa 2018 - nhóm 2', 65, 2, 10, 10, 32, 32, 4, 4, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1303', 1, N'DH', 1, N'CQ', N'0244193', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2461, N'Khóa 2018 - nhóm 3', 80, 2, 10, 10, 32, 32, 4, 4, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1303', 1, N'DH', 1, N'CQ', N'0244193', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2462, N'Khóa 2018 - nhóm 1', 87, 3, 8, 8, 30, 30, 12, 12, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1472', 1, N'DH', 1, N'CQ', N'0244193', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2463, N'Khóa 2017 - nhóm 1', 66, 2, 8, 8, 30, 30, 12, 12, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT14107', 1, N'DH', 1, N'CQ', N'0244193', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2464, N'Khoá 2017- nhóm 1', 27, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.3, 1, 1.1, 1, 0.5, N'INT1446', 1, N'DH', 1, N'CQ', N'TG084', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2465, N'Khoá 2018 - nhóm 1', 92, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1340', 1, N'DH', 1, N'CQ', N'TG084', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2466, N'Khoá 2018 - nhóm 2', 76, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1340', 1, N'DH', 1, N'CQ', N'TG084', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2467, N'Khoá 2018 - nhóm 3', 61, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1340', 1, N'DH', 1, N'CQ', N'TG084', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2468, N'Khoá 2017 - nhóm 1', 148, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1416', 1, N'DH', 1, N'CQ', N'0211008', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2469, N'Khoá 2017- nhóm 1', 25, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.1, 1, 1.1, 1, 0.5, N'INT1445', 1, N'DH', 1, N'CQ', N'0211008', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2470, N'Khoá 2017 - nhóm 1', 10, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1450', 1, N'DH', 1, N'CQ', N'0211008', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2471, N'Khoá 2017 - nhóm 1', 70, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1342', 1, N'DH', 1, N'CQ', N'0211008', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2472, N'Khóa 2017- nhóm 1', 24, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.1, 1, 1.1, 1, 0.5, N'INT1422', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2473, N'Khóa 2018 - nhóm 1', 85, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1341', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2474, N'Khóa 2018 - nhóm 2', 154, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1341', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2475, N'Khoá 2018- nhóm 1', 47, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'INT1434-3', 1, N'DH', 1, N'CQ', N'GV/N-20228', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2476, N'Khoá 2018- nhóm 3', 46, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'INT1434-3', 1, N'DH', 1, N'CQ', N'GV/N-20228', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2477, N'Khóa 2017 - nhóm 1', 148, 0, 12, 12, 2, 2, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1408', 1, N'DH', 1, N'CQ', N'0211020', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2478, N'Khóa 2017 - nhóm 1', 33, 0, 12, 12, 2, 2, 0, 0, 50000, 1, 1, 1.4, 1, 1.1, 1, 0.5, N'INT1409', 1, N'DH', 1, N'CQ', N'0211020', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2479, N'Khóa 2019  nhóm 1', 161, 4, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1306', 1, N'DH', 1, N'CQ', N'0211020', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2480, N'Khóa 2019 -  nhóm 4', 99, 3, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1306', 1, N'DH', 1, N'CQ', N'0211020', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2481, N'Khoá 2017 - nhóm 1', 140, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1448', 1, N'DH', 1, N'CQ', N'GV/N-20172', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2482, N'Khoá 2017 - nhóm 1', 54, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14139', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20202')
GO
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2483, N'Khoá 2018 - nhóm 1', 54, 0, 10, 10, 20, 20, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14133', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2484, N'Khoá 2020 - nhóm 1', 89, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL13150', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2485, N'Khóa 2019 - nhóm 4', 77, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13145', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2486, N'Khóa 2017 - nhóm 1', 61, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1392', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2487, N'Khóa 2017 - nhóm 1', 51, 0, 14, 14, 16, 16, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14141', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2488, N'Khóa 2017- nhóm 2', 50, 0, 28, 28, 2, 2, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL1482', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2489, N'Khoá 2017 - nhóm 1', 10, 0, 28, 28, 2, 2, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1482', 1, N'DH', 1, N'CQ', N'0211016', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2490, N'Khóa 2018 nhóm 1', 14, 1, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'INT13111', 1, N'DH', 1, N'CQ', N'0211016', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2491, N'Khóa 2019 - nhóm 1', 83, 0, 14, 14, 16, 16, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL1425', 1, N'DH', 1, N'CQ', N'0211016', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2492, N'Khóa 2017 - nhóm 1', 10, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL14130', 1, N'DH', 1, N'CQ', N'0211016', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2493, N'Khoá 2018 - nhóm 1', 54, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14131', 1, N'DH', 1, N'CQ', N'TG028', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2494, N'Khoá 2019 - nhóm 1', 73, 0, 26, 26, 18, 18, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1454', 1, N'DH', 1, N'CQ', N'TG028', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2495, N'Khoá 2020 - nhóm 1', 90, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL13149', 1, N'DH', 1, N'CQ', N'TG028', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2496, N'Khoá 2018- nhóm 1', 55, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14132', 1, N'DH', 1, N'CQ', N'GV/N-20227', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2497, N'Khoá 2017 - nhóm 1', 49, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL1421', 1, N'DH', 1, N'CQ', N'0211011', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2498, N'Khóa 2017 - nhóm 1', 11, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL14128', 1, N'DH', 1, N'CQ', N'0211011', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2499, N'Khóa 2018 - nhóm 2', 158, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1362', 1, N'DH', 1, N'CQ', N'0211011', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2500, N'Khóa 2018
Khóa 2019 - nhóm 1', 130, 0, 20, 20, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'MUL14134', 1, N'DH', 1, N'CQ', N'0211011', N'20202')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2501, N'Khóa 2017 - nhóm 1', 22, 1, 6, 6, 36, 36, 6, 6, 55000, 1, 1, 1.1, 1, 1.1, 1, 0.5, N'INT1405', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2502, N'Khóa 2017 - nhóm 1', 70, 2, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1429-2', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2503, N'Khóa 2017 - nhóm 1', 68, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1461', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2504, N'Khóa 2017 - nhóm 2', 69, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1461', 1, N'DH', 1, N'CQ', N'GV/N-20179', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2505, N'Khoá 2017- nhóm 1', 68, 2, 6, 6, 30, 30, 16, 16, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1483', 1, N'DH', 1, N'CQ', N'GV/N-20226', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2506, N'Khoá 2020- nhóm 5', 95, 3, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20226', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2507, N'Khoá 2018- nhóm  1', 88, 3, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1484', 1, N'DH', 1, N'CQ', N'0221017', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2508, N'Khóa 2019- nhóm 2', 68, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13145', 1, N'DH', 1, N'CQ', N'0221017', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2509, N'Khóa 2019- nhóm 3', 76, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13145', 1, N'DH', 1, N'CQ', N'0221017', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2510, N'Khoá 2020
nhóm 1', 73, 2, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2511, N'Khoá 2020
nhóm 2', 95, 3, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2512, N'Khoá 2020
nhóm 3', 76, 2, 4, 4, 20, 20, 8, 8, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1155', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2513, N'Khoá 2018
nhóm 1', 14, 1, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'INT13110', 1, N'DH', 1, N'CQ', N'GV/N-20205', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2514, N'Khoá 2017- nhóm 1', 73, 2, 6, 6, 20, 20, 8, 8, 55000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT14102', 1, N'DH', 1, N'CQ', N'0211021', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2515, N'Khoá 2019- nhóm 2', 156, 0, 8, 8, 36, 36, 0, 0, 55000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1359-3 ', 1, N'DH', 1, N'CQ', N'0211021', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2516, N'Khoá 2018- nhóm 1', 91, 3, 8, 8, 30, 30, 12, 12, 55000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1344', 1, N'DH', 1, N'CQ', N'0211021', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2517, N'Khóa 2018 - nhóm 2', 65, 2, 10, 10, 32, 32, 4, 4, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1303', 1, N'DH', 1, N'CQ', N'0244193', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2518, N'Khóa 2018 - nhóm 3', 80, 2, 10, 10, 32, 32, 4, 4, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1303', 1, N'DH', 1, N'CQ', N'0244193', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2519, N'Khóa 2018 - nhóm 1', 87, 3, 8, 8, 30, 30, 12, 12, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1472', 1, N'DH', 1, N'CQ', N'0244193', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2520, N'Khóa 2017 - nhóm 1', 66, 2, 8, 8, 30, 30, 12, 12, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT14107', 1, N'DH', 1, N'CQ', N'0244193', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2521, N'Khoá 2017- nhóm 1', 27, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.3, 1, 1.1, 1, 0.5, N'INT1446', 1, N'DH', 1, N'CQ', N'TG084', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2522, N'Khoá 2018 - nhóm 1', 92, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1340', 1, N'DH', 1, N'CQ', N'TG084', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2523, N'Khoá 2018 - nhóm 2', 76, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1340', 1, N'DH', 1, N'CQ', N'TG084', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2524, N'Khoá 2018 - nhóm 3', 61, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1340', 1, N'DH', 1, N'CQ', N'TG084', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2525, N'Khoá 2017 - nhóm 1', 148, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1416', 1, N'DH', 1, N'CQ', N'0211008', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2526, N'Khoá 2017- nhóm 1', 25, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.1, 1, 1.1, 1, 0.5, N'INT1445', 1, N'DH', 1, N'CQ', N'0211008', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2527, N'Khoá 2017 - nhóm 1', 10, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1450', 1, N'DH', 1, N'CQ', N'0211008', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2528, N'Khoá 2017 - nhóm 1', 70, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT1342', 1, N'DH', 1, N'CQ', N'0211008', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2529, N'Khóa 2017- nhóm 1', 24, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.1, 1, 1.1, 1, 0.5, N'INT1422', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2530, N'Khóa 2018 - nhóm 1', 85, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1341', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2531, N'Khóa 2018 - nhóm 2', 154, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1341', 1, N'DH', 1, N'CQ', N'GV/N-20173', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2532, N'Khoá 2018- nhóm 1', 47, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'INT1434-3', 1, N'DH', 1, N'CQ', N'GV/N-20228', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2533, N'Khoá 2018- nhóm 3', 46, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'INT1434-3', 1, N'DH', 1, N'CQ', N'GV/N-20228', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2534, N'Khóa 2017 - nhóm 1', 148, 0, 12, 12, 2, 2, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1408', 1, N'DH', 1, N'CQ', N'0211020', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2535, N'Khóa 2017 - nhóm 1', 33, 0, 12, 12, 2, 2, 0, 0, 50000, 1, 1, 1.4, 1, 1.1, 1, 0.5, N'INT1409', 1, N'DH', 1, N'CQ', N'0211020', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2536, N'Khóa 2019  nhóm 1', 161, 4, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1306', 1, N'DH', 1, N'CQ', N'0211020', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2537, N'Khóa 2019 -  nhóm 4', 99, 3, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'INT1306', 1, N'DH', 1, N'CQ', N'0211020', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2538, N'Khoá 2017 - nhóm 1', 140, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1448', 1, N'DH', 1, N'CQ', N'GV/N-20172', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2539, N'Khoá 2017 - nhóm 1', 54, 2, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14139', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2540, N'Khoá 2018 - nhóm 1', 54, 0, 10, 10, 20, 20, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14133', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2541, N'Khoá 2020 - nhóm 1', 89, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL13150', 1, N'DH', 1, N'CQ', N'GV/N-20178', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2542, N'Khóa 2019 - nhóm 4', 77, 0, 8, 8, 36, 36, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'INT13145', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2543, N'Khóa 2017 - nhóm 1', 61, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1392', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2544, N'Khóa 2017 - nhóm 1', 51, 0, 14, 14, 16, 16, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14141', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2545, N'Khóa 2017- nhóm 2', 50, 0, 28, 28, 2, 2, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL1482', 1, N'DH', 1, N'CQ', N'GV/N-20176', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2546, N'Khoá 2017 - nhóm 1', 10, 0, 28, 28, 2, 2, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL1482', 1, N'DH', 1, N'CQ', N'0211016', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2547, N'Khóa 2018 nhóm 1', 14, 1, 8, 8, 32, 32, 8, 8, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'INT13111', 1, N'DH', 1, N'CQ', N'0211016', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2548, N'Khóa 2019 - nhóm 1', 83, 0, 14, 14, 16, 16, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL1425', 1, N'DH', 1, N'CQ', N'0211016', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2549, N'Khóa 2017 - nhóm 1', 10, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL14130', 1, N'DH', 1, N'CQ', N'0211016', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2550, N'Khoá 2018 - nhóm 1', 54, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14131', 1, N'DH', 1, N'CQ', N'TG028', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2551, N'Khoá 2019 - nhóm 1', 73, 0, 26, 26, 18, 18, 0, 0, 50000, 1, 1, 1.6, 1.2, 1.1, 1, 0.5, N'MUL1454', 1, N'DH', 1, N'CQ', N'TG028', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2552, N'Khoá 2020 - nhóm 1', 90, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.3, 1.1, 1, 0.5, N'MUL13149', 1, N'DH', 1, N'CQ', N'TG028', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2553, N'Khoá 2018- nhóm 1', 55, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL14132', 1, N'DH', 1, N'CQ', N'GV/N-20227', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2554, N'Khoá 2017 - nhóm 1', 49, 0, 12, 12, 32, 32, 0, 0, 50000, 1, 1, 1.6, 1.1, 1.1, 1, 0.5, N'MUL1421', 1, N'DH', 1, N'CQ', N'0211011', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2555, N'Khóa 2017 - nhóm 1', 11, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1, 1, 1.1, 1, 0.5, N'MUL14128', 1, N'DH', 1, N'CQ', N'0211011', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2556, N'Khóa 2018 - nhóm 2', 158, 0, 6, 6, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'INT1362', 1, N'DH', 1, N'CQ', N'0211011', N'20212')
INSERT [dbo].[LopTinChi] ([MaLTC], [TenLTC], [SiSo], [SoNhomTH], [TietBTQD], [TietBTTD], [TietLTQD], [TietLTTD], [TietTHQD], [TietTHTD], [DonGia], [HSMonMoi], [HSNgoaiGio], [HSLopDongTH], [HSLopDongLT], [HSLTC], [HSHocKy], [HSNhomTH], [MaMon], [HSBac], [MaBac], [HSHeLop], [MaHeLop], [MaGV], [MaNKHK]) VALUES (2557, N'Khóa 2018
Khóa 2019 - nhóm 1', 130, 0, 20, 20, 24, 24, 0, 0, 50000, 1, 1, 1.6, 1.5, 1.1, 1, 0.5, N'MUL14134', 1, N'DH', 1, N'CQ', N'0211011', N'20212')
SET IDENTITY_INSERT [dbo].[LopTinChi] OFF
GO
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'ELE1421', N'Mạng cảm biến', 11, 4, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1155', N'Tin học cơ sở 2', 20, 8, 4)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1303', N'An toàn và bảo mật hệ thống thông tin', 32, 4, 10)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1306', N'Cấu trúc dữ liệu và giải thuật', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT13108', N'Ngôn ngữ lập trình java', 34, 6, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT13109', N'Lập trình hướng đối tượng với C++', 32, 4, 16)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT13110', N'Lập trình mạng với C++', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT13111', N'Kỹ thuật đồ họa', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1313', N'Cơ sở dữ liệu', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT13145', N'Kiến trúc máy tính ', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1319', N'Hệ điều hành', 34, 8, 6)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1323', N'Kiến trúc máy tính', 32, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1325', N'Kiến trúc máy tính và hệ điều hành', 120, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1332', N'Lập trình hướng đối tượng', 30, 6, 16)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1339', N'Ngôn ngữ lập trình C++', 30, 6, 16)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1340', N'Nhập môn công nghệ phần mềm', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1341', N'Nhập môn trí tuệ nhân tạo ', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1342', N'Phân tích và thiết kế hệ thống thông tin', 36, 8, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1344', N'Mật mã học cơ sở', 30, 8, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1357', N'Tin học quản lý', 24, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1358', N'Toán rời rạc 1', 120, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1359-3 ', N'Toán rời rạc 2', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1362', N'Xử lý ảnh', 24, 0, 6)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1405', N'Các hệ thống phân tán', 120, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1408', N'Chuyên đề công nghệ phần mềm', 2, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1409', N'Chuyên đề hệ thống thông tin', 2, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT14100', N'Chuyên đề an ninh mạng', 12, 32, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT14101 - H3', N'Xây dựng và quản trị các hệ thống ảo hoá', 45, 0, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT14102', N'Các kỹ thuật giấu tin', 20, 8, 6)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT14104', N'Phân tích thiết kế đảm bảo chất
 lượng phần mềm', 8, 36, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT14105', N'An toàn ứng dụng Web và cơ sở dữ liệu', 30, 8, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT14107', N'Kiểm thử xâm nhập', 30, 12, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1414', N'Cơ sở dữ liệu phân tán', 24, 6, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1416', N'Đảm bảo chất lượng  phần mềm', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1422', N'Kho dữ liệu và khai phá dữ liệu', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1429-2', N'Kỹ thuật theo dõi, giám sát an toàn mạng', 120, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1433', N'Lập trình mạng', 30, 6, 16)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1434-3 ', N'Lập trình web', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1445', N'Phát triển hệ thống thông tin quản lý', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1446', N'Phát triển hệ thống thương mại điện tử', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1448', N'Phát triển phần mềm hướng dịch vụ', 36, 8, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1450', N'Quản lý dự án phần mềm', 24, 6, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1461', N'Xây dựng các hệ thống nhúng', 120, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1472', N'Cơ sở an toàn thông tin', 30, 12, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1483', N'An toàn mạng nâng cao', 30, 16, 6)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1484', N'An toàn hệ điều hành', 32, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1488', N'Khoa học pháp lý số', 32, 4, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1497', N'Phát triển hệ thống dựa trên tri thức', 8, 37, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1498', N'Phát triển ứng dụng phân tán', 8, 37, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INT1499', N'Chuyên đề an toàn phần mềm', 12, 32, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INTGame', N'Lập trình game cơ bản', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INTVideo', N'Xử Lý Ảnh & Video', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'INTWeb', N' Thiết kế web cơ bản', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1238', N'Cơ sở tạo hình', 32, 12, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL13149', N'Mỹ thuật cơ bản', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL13150', N'Thiết kế đồ họa', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1320', N'Nhập môn đa phương tiện', 20, 10, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1392', N'Truyền thông: lý thuyết và ứng dụng', 24, 0, 6)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14123', N'Lập trình ứng dụng đa phương tiện', 32, 12, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14125', N'Xử lý ảnh và video', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14128', N'Lập trình kỹ xảo hình ảnh', 24, 0, 6)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14130', N'Khai phá dữ liệu đa phương tiện ', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14131', N'Luật xa gần', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14132', N'Cơ sở tạo hình nâng cao', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14133', N'Mỹ thuật nâng cao', 20, 0, 10)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14134', N'Thiết kế hình động 1', 24, 0, 20)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14135', N'Thiết kế sản phẩm đa phương tiện', 32, 12, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14136', N'Nghệ thuật đồ họa chữ (Typography)', 30, 14, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14138', N'Thiết kế ấn phẩm điện tử 1', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14139', N'Thiết kế ấn phẩm điện tử 2', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14140', N'Thiết kế hình động 2', 32, 12, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14141', N'Đồ án thiết kế sản phẩm đa phương tiện', 16, 0, 14)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL14144', N'Kịch bản phân cảnh', 32, 12, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1421', N'Thiết kế quảng cáo truyền hình', 32, 0, 12)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1422', N'Tổ chức sản xuất sản phẩm đa phương tiện', 24, 6, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1423', N'Kịch bản đa phương tiện', 24, 6, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1425', N'Thiết kế tương tác đa phương tiện', 16, 0, 14)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1429', N'Thiết kế web cơ bản', 18, 12, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1446', N'Lập trình game cơ bản', 32, 8, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1450', N'Phát triển dịch vụ giá trị gia tăng trên mạng viễn', 36, 0, 8)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1451', N'Chuyên đề phát triển ứng dụng đa phương tiện', 15, 0, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1454', N'Thiết kế đồ họa 3D', 18, 0, 26)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1465', N'Chuyên đề thiết kế đồ họa đa phương tiện', 15, 0, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1482', N'Thực hành chuyên sâu', 2, 0, 28)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1484', N'Thiết kế và tổ chức sản xuất sản phẩm đa phương ti', 36, 8, 0)
INSERT [dbo].[MonHoc] ([MaMonHoc], [TenMonHoc], [TietLT], [TietTH], [TietBT]) VALUES (N'MUL1485', N'Thiết kế đồ họa nâng cao', 32, 12, 0)
GO
SET IDENTITY_INSERT [dbo].[NguoiKy] ON 

INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (1, N'TPGV', N'TRƯỞNG PHÒNG GIÁO VỤ', N'NGUYỄN XUÂN KHÁNH', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (2, N'PGD', N'PHÓ GIÁM ĐỐC HỌC VIỆN', N'TS TÂN HẠNH', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (4, N'NLB', N'NGƯỜI LẬP BẢNG', N'LÊ THỊ THU TRANG', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (5, N'TPKTTC', N'TRƯỞNG PHÒNG KINH TẾ TÀI CHÍNH', N'PHAN THỊ BÍCH DIỄM', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (6, N'TKCB2', N'TRƯỞNG KHOA CƠ BẢN', N'NGUYỄN XUÂN HẢI', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (7, N'TKCNTT2', N'TRƯỞNG KHOA CNTT2', N'NGUYỄN HỒNG SƠN', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (8, N'TKKTDT2', N'TRƯỞNG KHOA KTDT2', N'NGUYỄN VĂN C', N'20201')
INSERT [dbo].[NguoiKy] ([id], [KyHieu], [ChucVu], [HoTen], [MaNKHK]) VALUES (11, N'TKCB2', N'TRƯỞNG KHOA CB 2', N'NGUYỄN VĂN NEW', N'20212')
SET IDENTITY_INSERT [dbo].[NguoiKy] OFF
GO
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20201', N'Học Kỳ 1', N'2020-2021 ')
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20202', N'Học Kỳ 2', N'2020-2021 ')
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20211', N'Học Kỳ 1', N'2021-2022 ')
INSERT [dbo].[NienKhoaHocKy] ([MaNKHK], [TenHocKy], [TenNienKhoa]) VALUES (N'20212', N'Học Kỳ 2', N'2021-2022 ')
GO
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'AT2', N'0211016', CAST(N'2022-09-01T18:14:05.540' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'0211011', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'0211016', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'0211016', CAST(N'2022-09-01T18:14:15.647' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'123456', CAST(N'2022-09-11T20:11:23.327' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'GV/N-20176', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'GV/N-20178', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'GV/N-20227', CAST(N'2022-08-20T12:30:33.447' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'GV/N-20227', CAST(N'2022-09-03T14:38:34.187' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'CNDPT', N'TG028', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'0211008', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'0211020', CAST(N'2022-08-20T10:20:23.747' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'0211021', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'0221017', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'0244193', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'GV/N-20172', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'GV/N-20173', CAST(N'2022-08-20T10:20:23.743' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'GV/N-20179', CAST(N'2022-08-20T10:20:23.717' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'GV/N-20205', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'GV/N-20226', CAST(N'2022-08-20T12:30:33.427' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'GV/N-20228', CAST(N'2022-08-20T12:30:33.440' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'KM2', N'TG084', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiBoMon] ([MaBoMon], [MaGV], [NgayThayDoi]) VALUES (N'TO2', N'GV/N-20227', CAST(N'2022-09-03T14:38:04.917' AS DateTime))
GO
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0211008', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0211011', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0211016', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0211020', CAST(N'2022-08-20T10:20:23.747' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0211021', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0221017', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'0244193', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'123456', CAST(N'2022-09-11T20:11:23.327' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20172', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20173', CAST(N'2022-08-20T10:20:23.743' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20176', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20178', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20179', CAST(N'2022-08-20T10:20:23.717' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20205', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20226', CAST(N'2022-08-20T12:30:33.427' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20227', CAST(N'2022-08-20T12:30:33.447' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'GV/N-20228', CAST(N'2022-08-20T12:30:33.440' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'TG028', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiChucVu] ([MaChucVu], [MaGV], [NgayThayDoi]) VALUES (N'GV', N'TG084', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
GO
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'CN', 55000, N'20201     ')
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'CN', 50000, N'20212     ')
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'GS.TS', 65000, N'20201     ')
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'KS', 55000, N'20212     ')
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'PGS.TS', 60000, N'20201     ')
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'ThS', 50000, N'20201     ')
INSERT [dbo].[ThayDoiGiaHocVi] ([MaGVDieuChinh], [MaHocVi], [DonGia], [MaNKHK]) VALUES (N'GV01', N'TS', 55000, N'20201     ')
GO
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'0211008', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'0211011', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'0211016', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'0211020', CAST(N'2022-08-20T10:20:23.747' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'0244193', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'123456', CAST(N'2022-09-11T20:11:23.327' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20172', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20173', CAST(N'2022-08-20T10:20:23.743' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20176', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20178', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20205', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20226', CAST(N'2022-08-20T12:30:33.427' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20227', CAST(N'2022-08-20T12:30:33.447' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'GV/N-20228', CAST(N'2022-08-20T12:30:33.440' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'TG028', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'ThS', N'TG084', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'TS', N'0211021', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'TS', N'0221017', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiHocVi] ([MaHocVi], [MaGV], [NgayThayDoi]) VALUES (N'TS', N'GV/N-20179', CAST(N'2022-08-20T10:20:23.717' AS DateTime))
GO
INSERT [dbo].[ThayDoiHSBac] ([MaBac], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'CD', N'GV01', 0.85, CAST(N'2022-08-17T17:14:20.777' AS DateTime))
INSERT [dbo].[ThayDoiHSBac] ([MaBac], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'CD', N'GV01', 0.85, CAST(N'2022-08-17T20:44:47.947' AS DateTime))
INSERT [dbo].[ThayDoiHSBac] ([MaBac], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'CD', N'GV01', 0.9, CAST(N'2022-08-18T16:58:34.743' AS DateTime))
INSERT [dbo].[ThayDoiHSBac] ([MaBac], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'DH', N'GV01', 1, CAST(N'2022-07-29T00:00:00.000' AS DateTime))
INSERT [dbo].[ThayDoiHSBac] ([MaBac], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'TC', N'GV01', 0.8, CAST(N'2022-07-29T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[ThayDoiHSHeLop] ([MaHeLop], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'CQ', N'GV01', 1, CAST(N'2022-06-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ThayDoiHSHeLop] ([MaHeLop], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'CQ', N'GV01', 1.2, CAST(N'2022-06-27T00:00:00.000' AS DateTime))
INSERT [dbo].[ThayDoiHSHeLop] ([MaHeLop], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'CQ', N'GV01', 1, CAST(N'2022-08-18T16:58:05.637' AS DateTime))
INSERT [dbo].[ThayDoiHSHeLop] ([MaHeLop], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'HC', N'GV01', 1, CAST(N'2022-06-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ThayDoiHSHeLop] ([MaHeLop], [MaGVDieuChinh], [HeSo], [NgayApDung]) VALUES (N'VHVL', N'GV01', 1.1, CAST(N'2022-06-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211008', N'1', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211011', N'1', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211016', N'0', CAST(N'2022-09-01T18:13:53.490' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211016', N'1', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211016', N'1', CAST(N'2022-09-01T18:13:56.867' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211020', N'1', CAST(N'2022-08-20T10:20:23.747' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0211021', N'1', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0221017', N'1', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'0244193', N'1', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'123456', N'1', CAST(N'2022-09-11T20:11:23.327' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20172', N'1', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20173', N'1', CAST(N'2022-08-20T10:20:23.743' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20176', N'1', CAST(N'2022-08-20T10:20:23.753' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20178', N'1', CAST(N'2022-08-20T10:20:23.750' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20179', N'1', CAST(N'2022-08-20T10:20:23.717' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20205', N'1', CAST(N'2022-08-20T10:20:23.737' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20226', N'1', CAST(N'2022-08-20T12:30:33.427' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20227', N'1', CAST(N'2022-08-20T12:30:33.447' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'GV/N-20228', N'1', CAST(N'2022-08-20T12:30:33.440' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'TG028', N'0', CAST(N'2022-08-20T10:20:23.757' AS DateTime))
INSERT [dbo].[ThayDoiLoaiGV] ([MaGV], [MaLoaiGV], [NgayThayDoi]) VALUES (N'TG084', N'0', CAST(N'2022-08-20T10:20:23.740' AS DateTime))
GO
INSERT [dbo].[ThucHienNCKH] ([MaGV], [MaNKHK], [ThucTeNCKH], [GhiChu]) VALUES (N'0211008', N'20211', 700, NULL)
INSERT [dbo].[ThucHienNCKH] ([MaGV], [MaNKHK], [ThucTeNCKH], [GhiChu]) VALUES (N'0211008', N'20212', 270, NULL)
INSERT [dbo].[ThucHienNCKH] ([MaGV], [MaNKHK], [ThucTeNCKH], [GhiChu]) VALUES (N'0211011', N'20211', 216, NULL)
INSERT [dbo].[ThucHienNCKH] ([MaGV], [MaNKHK], [ThucTeNCKH], [GhiChu]) VALUES (N'0211011', N'20212', 216, NULL)
INSERT [dbo].[ThucHienNCKH] ([MaGV], [MaNKHK], [ThucTeNCKH], [GhiChu]) VALUES (N'0211016', N'20211', 270, NULL)
INSERT [dbo].[ThucHienNCKH] ([MaGV], [MaNKHK], [ThucTeNCKH], [GhiChu]) VALUES (N'0211016', N'20212', 270, NULL)
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
ALTER TABLE [dbo].[ThayDoiHSBac]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSBac_GiangVien] FOREIGN KEY([MaGVDieuChinh])
REFERENCES [dbo].[GiangVien] ([MaGiangVien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ThayDoiHSBac] CHECK CONSTRAINT [FK_ThayDoiHSBac_GiangVien]
GO
ALTER TABLE [dbo].[ThayDoiHSHeLop]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiHSHeLop_GiangVien] FOREIGN KEY([MaGVDieuChinh])
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
/****** Object:  StoredProcedure [dbo].[get_DS_GV]    Script Date: 25/10/2022 12:36:22 PM ******/
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
INSERT INTO #chucDanhTemp VALUES('GVCC',N'Giảng viên cao cấp')

SELECT MaGiangVien as MaGiangVien,Ho,Ten,HocVi,ChucVu,TenChucDanh as ChucDanh,gv.GioiTinh,NgaySinh,DiaChi,Sdt,GVCoHuu 
FROM GiangVien as gv LEFT JOIN #chucDanhTemp ON MaChucDanh=ChucDanh
WHERE MaBoMon=@maBoMon AND gv.TrangThaiXoa=0
END
GO
/****** Object:  StoredProcedure [dbo].[get_DS_Huong_Dan_TTTN]    Script Date: 25/10/2022 12:36:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getDonGiaGV]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getDonGiaGV] @maHocVi nchar(10)='TS', @chucDanh varchar (10)='GV', @monHoc nvarchar(30)='thể chất'
AS 
declare @donGia int
SET @donGia=[dbo].[func_getDonGiaGV](@maHocVi,@chucDanh,@monHoc)

	SELECT 'Return Value'=@donGia

GO
/****** Object:  StoredProcedure [dbo].[getListGiangVienByBoMon]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getListGiangVienByBoMon]
@maBoMon nvarchar(50)='GD2'
AS
SELECT * FROM GiangVien WHERE MaBoMon=@maBoMon
GO
/****** Object:  StoredProcedure [dbo].[getLTC]    Script Date: 25/10/2022 12:36:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getNameByID]    Script Date: 25/10/2022 12:36:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Import_HuongDanTTTN]    Script Date: 25/10/2022 12:36:22 PM ******/
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
		WHEN NOT MATCHED THEN
			INSERT (MaGV, MaNKHK,HSPhanBien,SoSinhVienPB,Lop,SoSinhVienHD,SoTuan,HSHuongDan)
			VALUES (Source.MaGV, Source.MaNKHK,Source.HSPhanBien,Source.SoSinhVienPB,Source.Lop,Source.SoSinhVienHD,Source.SoTuan,Source.HSHuongDan);
		return;
END
GO
/****** Object:  StoredProcedure [dbo].[Import_LopTinChi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Import_LopTinChi] @LopTinChi TYPE_LopTinChiImport READONLY
AS 
BEGIN
	DECLARE @MaGV varchar(50)
	DECLARE @HocVi varchar(50)
	DECLARE @HoGV nvarchar(50)
	DECLARE @TenGV nvarchar(15)
	DECLARE @ChucDanh varchar(10)
	DECLARE @DinhMuc float
	DECLARE @DinhMucNCKH float
	DECLARE @TenMH nvarchar(50)
	DECLARE @MaMH varchar(50)
	DECLARE @HeLop varchar(10)
	DECLARE @TenLTC nvarchar(50)
	DECLARE @SiSo int
	DECLARE @HSHocKy float
	DECLARE @SoNhomTH int
	DECLARE @TietLTQD float
	DECLARE @TietTHQD float
	DECLARE @TietBTQD float
	DECLARE @HSNgoaiGio float
	DECLARE @HSMonMoi float
	DECLARE @HSLopDongTH float
	DECLARE @HSLopDongLT float
	DECLARE @HSLTC float
	DECLARE @HSNhomTH float
	DECLARE @MaBac varchar(10)
	DECLARE @MaNKHK varchar(50)
	DECLARE @MaBoMon varchar(20)
	DECLARE @MoTa float
	DECLARE @MoTaNCKH int
	DECLARE @DonGia float
	DECLARE @NgayThayDoi DateTime
	DECLARE @HSBac float
	DECLARE @HSHeLop float
	DECLARE @TenHocVi nvarchar(10)
	DECLARE cursorLTC CURSOR FOR  -- khai báo con trỏ lấy học vị của GV
	SELECT * FROM @LopTinChi      -- dữ liệu trỏ tới
	OPEN cursorLTC               -- Mở con trỏ
	FETCH NEXT FROM cursorLTC     -- Đọc dòng đầu tiên
		INTO @MaGV, @HocVi, @HoGV,@TenGV, @ChucDanh,@DinhMuc,@DinhMucNCKH,@TenMH,
		@MaMH,@HeLop,@TenLTC,@SiSo,@SoNhomTH,@TietLTQD,@TietBTQD,
		@TietTHQD,@HSNgoaiGio,@HSMonMoi,@HSLopDongTH,@HSLopDongLT,
		@HSLTC,@HSNhomTH,@HSHocKy,@MaBac,@MaNKHK, @MoTa, @MoTaNCKH
	WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
	BEGIN
	
	IF NOT EXISTS (SELECT MaMonHoc FROM MonHoc WHERE MaMonHoc=@MaMH)
	BEGIN
		INSERT INTO MonHoc VALUES (@MaMH, @TenMH, @TietLTQD, @TietTHQD, @TietBTQD)
	END

	IF NOT EXISTS (SELECT MaGiangVien FROM GiangVien WHERE MaGiangVien=@MaGV)
	BEGIN
		SELECT @NgayThayDoi=GETDATE()
		SELECT @TenHocVi=TenHocVi FROM HocVi WHERE MaHocVi=@HocVi
		SELECT @MaBoMon=MaBoMon FROM BoMon WHERE TipDauNguMonHoc LIKE CONCAT('%',LEFT(@MaMH,3),'%')
		IF @MaBoMon IS NULL SET @MaBoMon='AT2'
		INSERT INTO GiangVien VALUES (
		@MaGV,@HoGV, @TenGV, @TenHocVi,N'Giảng viên',@ChucDanh,1,null,null,null,
		CASE WHEN @MaBoMon IS NOT NULL THEN @MaBoMon ELSE 'AT2' END,
		CASE WHEN LEFT(@MaGV,2)='TG' THEN 0 ELSE 1 END,0)

		INSERT INTO ThayDoiBoMon VALUES(@MaBoMon,@MaGV, @NgayThayDoi)

		INSERT INTO ThayDoiChucVu VALUES('GV',@MaGV,@NgayThayDoi)

		INSERT INTO ThayDoiHocVi VALUES (@HocVi,@MaGV,@NgayThayDoi)

		INSERT INTO ThayDoiLoaiGV VALUES (@MaGV,CASE WHEN LEFT(@MaGV,2)='TG' THEN 0 ELSE 1 END,@NgayThayDoi)

	
	END
		IF NOT EXISTS (SELECT MaLTC FROM LopTinChi
		WHERE  MaMon=@MaMH AND TenLTC=@TenLTC AND MaGV=@MaGV AND MaNKHK=@MaNKHK)
		BEGIN
			SET @HSHeLop=dbo.[func_GetHSHeLop](@HeLop)
			SET @HSBac=dbo.[func_GetHSBacHoc](@MaBac)
			SET @DonGia=[dbo].[func_getDonGiaGV](@HocVi, @ChucDanh, @TenMH)
			INSERT INTO LopTinChi VALUES (@TenLTC,@SiSo,@SoNhomTH,@TietBTQD,@TietBTQD, @TietLTQD,@TietLTQD,@TietTHQD,@TietTHQD,@DonGia,
			@HSMonMoi,@HSNgoaiGio,@HSLopDongTH,@HSLopDongLT,@HSLTC,@HSHocKy,0.5,@MaMH,@HSBac,@MaBac,@HSHeLop,@HeLop,@MaGV,@MaNKHK)
		END
			IF NOT EXISTS (SELECT MaGV FROM DinhMucGiang WHERE MaGV=@MaGV AND MaNKHK=@MaNKHK)
		BEGIN
			IF (@MoTa!=100)
			INSERT INTO DinhMucGiang VALUES (@MaGV, @MaNKHK, @DinhMuc, CONCAT(N'Thực hiện ',@MoTa,N'% định mức giảng dạy'))
			ELSE
			INSERT INTO DinhMucGiang VALUES (@MaGV, @MaNKHK, @DinhMuc, '')
		END

		IF NOT EXISTS (SELECT MaGV FROM DinhMucNCKH WHERE MaGV=@MaGV AND MaNKHK=@MaNKHK)
		BEGIN
			INSERT INTO DinhMucNCKH VALUES (@MaGV, @MaNKHK, @DinhMuc, '')
		END
	FETCH NEXT FROM cursorLTC -- Đọc dòng tiếp
	INTO @MaGV, @HocVi, @HoGV,@TenGV, @ChucDanh,@DinhMuc,@DinhMucNCKH,@TenMH,
		@MaMH,@HeLop,@TenLTC,@SiSo,@SoNhomTH,@TietLTQD,@TietBTQD,
		@TietTHQD,@HSNgoaiGio,@HSMonMoi,@HSLopDongTH,@HSLopDongLT,
		@HSLTC,@HSNhomTH,@HSHocKy,@MaBac,@MaNKHK,@MoTa, @MoTaNCKH
	END

	CLOSE cursorLTC             -- Đóng Cursor
	DEALLOCATE cursorLTC        -- Giải phóng tài nguyên
END
GO
/****** Object:  StoredProcedure [dbo].[SaoChep_DinhMucGiang]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaoChep_DinhMucGiang] @DinhMucGiang TYPE_DinhMucGiang READONLY
AS 
BEGIN
MERGE INTO DinhMucGiang AS Target
		USING (Select MaGV, MaNKHK,DinhMuc,GhiChu FROM @DinhMucGiang) AS Source
		ON Target.MaGV=Source.MaGV AND Target.MaNKHK=Source.MaNKHK
		WHEN NOT MATCHED THEN
			INSERT (MaGV, MaNKHK,DinhMuc,GhiChu)
			VALUES (Source.MaGV, Source.MaNKHK,Source.DinhMuc,Source.GhiChu);
		return;
END
GO
/****** Object:  StoredProcedure [dbo].[SaoChep_DinhMucNCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaoChep_DinhMucNCKH] @DinhMucNCKH TYPE_DinhMucGiang READONLY
AS 
BEGIN
MERGE INTO DinhMucNCKH AS Target
		USING (Select MaGV, MaNKHK,DinhMuc,GhiChu FROM @DinhMucNCKH) AS Source
		ON Target.MaGV=Source.MaGV AND Target.MaNKHK=Source.MaNKHK
		WHEN NOT MATCHED THEN
			INSERT (MaGV, MaNKHK,DinhMuc,GhiChu)
			VALUES (Source.MaGV, Source.MaNKHK,Source.DinhMuc,Source.GhiChu);
		return;
END
GO
/****** Object:  StoredProcedure [dbo].[SaoChep_ThucHienNCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaoChep_ThucHienNCKH] @ThucHienNCKH TYPE_ThucHienNCKH READONLY
AS 
BEGIN
MERGE INTO ThucHienNCKH AS Target
		USING (Select MaGV, MaNKHK,ThucTeNCKH,GhiChu FROM @ThucHienNCKH) AS Source
		ON Target.MaGV=Source.MaGV AND Target.MaNKHK=Source.MaNKHK
		WHEN NOT MATCHED THEN
			INSERT (MaGV, MaNKHK,ThucTeNCKH,GhiChu)
			VALUES (Source.MaGV, Source.MaNKHK,Source.ThucTeNCKH,Source.GhiChu);
		return;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DangNhap]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_DangNhap]
@TENLOGIN NVARCHAR (50)='sa2'
AS
DECLARE @TENUSER NVARCHAR(50)
DECLARE @uid int
SELECT @TENUSER=NAME, @uid=UID FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT MAGV = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM GiangVien  WHERE MaGiangVien = @TENUSER ),@uid as id,
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_BacHoc]    Script Date: 25/10/2022 12:36:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Delete_HeLop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Delete_HeLop]
@maHeLop varchar(10)
AS
SET XACT_ABORT ON
BEGIN TRAN
	BEGIN TRY
		DELETE FROM ThayDoiHSHeLop WHERE MaHeLop=@maHeLop
		DELETE FROM HeLop WHERE MaHeLop=@maHeLop
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ErrorMessage VARCHAR(2000)
		SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMessage, 16, 1)
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_HocVi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Delete_HocVi] 
@maHocVi varchar(10)
AS
DELETE ThayDoiGiaHocVi WHERE MaHocVi=@maHocVi
DELETE ThayDoiHocVi WHERE MaHocVi=@maHocVi
DELETE HocVi WHERE MaHocVi=@maHocVi
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_LDLT]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Delete_LDLT]
@SiSoMin int,@SiSoMax int
AS
DELETE FROM LopDongLyThuyet
WHERE SiSoMin=@SiSoMin AND SiSoMax=@SiSoMax
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_LDTH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Delete_LDTH]
@SiSoMin int,@SiSoMax int
AS
DELETE FROM LopDongThucHanh
WHERE SiSoMin=@SiSoMin AND SiSoMax=@SiSoMax
GO
/****** Object:  StoredProcedure [dbo].[sp_get_Bac_Hoc]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_get_Bac_Hoc]
@all bit=0
AS
BEGIN
	IF(@all=0)
	BEGIN 
		SELECT MaBac,MAX(NgayApDung) as NgayApDung INTO #BacHoc FROM ThayDoiHSBac GROUP BY MaBac
		SELECT bh.MaBac,td.NgayApDung, td.HeSo,TD.MaGVDieuChinh INTO #ThayDoiHSBac
		FROM #BacHoc as bh, ThayDoiHSBac as td
		WHERE bh.MaBac=td.MaBac and bh.NgayApDung=td.NgayApDung
		SELECT BH.MaBac,BH.TenBac,thayDoiHS.HeSo,thayDoiHS.NgayApDung, thayDoiHS.MaGVDieuChinh ,gv.Ho+' '+gv.Ten as GVDieuChinh
		FROM BacHoc as BH
		JOIN #ThayDoiHSBac as thayDoiHS
		ON BH.MaBac=thayDoiHS.MaBac
		JOIN GiangVien gv
		ON thayDoiHS.MaGVDieuChinh=gv.MaGiangVien
	END
	ELSE
	BEGIN
		SELECT BH.MaBac, BH.TenBac,TD.HeSo,TD.NgayApDung, TD.MaGVDieuChinh, gv.Ho+' '+gv.Ten as GVDieuChinh
		FROM BacHoc as BH JOIN  ThayDoiHSBac as TD
		ON BH.MaBac=TD.MaBac
		JOIN GiangVien gv ON TD.MaGVDieuChinh=gv.MaGiangVien
		ORDER BY MaBac,NgayApDung DESC
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Dinh_Muc_Giang]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_Dinh_Muc_Giang] 
@MaKhoa varchar(10)='CB2', @MaNKHK varchar(10)='20211'
AS
CREATE TABLE #ChucDanh(
	MaChucDanh varchar(10),
	TenChucDanh nvarchar(20)
)
INSERT INTO #ChucDanh VALUES('GV',N'Giảng viên')
INSERT INTO #ChucDanh VALUES('GVC',N'Giảng viên chính')
INSERT INTO #ChucDanh VALUES('GVCC',N'Giảng viên cao cấp')
SELECT MaBoMon INTO #BoMon FROM BoMon WHERE MaKhoa=@MaKhoa
SELECT GV.MaGiangVien,DMG.MaNKHK,GV.Ho+' '+GV.Ten as HoTen,CD.TenChucDanh as ChucDanh,GV.ChucVu,DMG.DinhMuc,DMG.GhiChu FROM GIANGVIEN as GV JOIN DinhMucGiang as DMG ON GV.MaGiangVien=DMG.MaGV
JOIN #ChucDanh CD ON CD.MaChucDanh=GV.ChucDanh
WHERE DMG.MaNKHK=@MaNKHK AND GV.MaBoMon in (SELECT MaBoMon FROM #BoMon)
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Dinh_Muc_NCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_Dinh_Muc_NCKH] 
@MaKhoa varchar(10)='CB2', @MaNKHK varchar(10)='20211'
AS
CREATE TABLE #ChucDanh(
	MaChucDanh varchar(10),
	TenChucDanh nvarchar(20)
)
INSERT INTO #ChucDanh VALUES('GV',N'Giảng viên')
INSERT INTO #ChucDanh VALUES('GVC',N'Giảng viên chính')
INSERT INTO #ChucDanh VALUES('GVCC',N'Giảng viên cao cấp')
SELECT MaBoMon INTO #BoMon FROM BoMon WHERE MaKhoa=@MaKhoa
SELECT GV.MaGiangVien,DMNCKH.MaNKHK,GV.Ho+' '+GV.Ten as HoTen,CD.TenChucDanh as ChucDanh,GV.ChucVu,DMNCKH.DinhMuc,DMNCKH.GhiChu FROM GIANGVIEN as GV JOIN DinhMucNCKH as DMNCKH ON GV.MaGiangVien=DMNCKH.MaGV
JOIN #ChucDanh CD ON CD.MaChucDanh=GV.ChucDanh
WHERE DMNCKH.MaNKHK=@MaNKHK AND GV.MaBoMon in (SELECT MaBoMon FROM #BoMon)
GO
/****** Object:  StoredProcedure [dbo].[sp_get_DS_He_Lop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_get_DS_He_Lop]
@all bit=0
AS
BEGIN
	IF(@all=0)
	BEGIN 
		SELECT MaHeLop,MAX(NgayApDung) as NgayApDung INTO #HeLop FROM ThayDoiHSHeLop GROUP BY MaHeLop
		SELECT bh.MaHeLop,td.NgayApDung, td.HeSo,TD.MaGVDieuChinh INTO #ThayDoiHSHeLop
		FROM #HeLop as bh, ThayDoiHSHeLop as td
		WHERE bh.MaHeLop=td.MaHeLop and bh.NgayApDung=td.NgayApDung
		SELECT BH.MaHeLop,BH.TenHeLop,thayDoiHS.HeSo,thayDoiHS.NgayApDung, thayDoiHS.MaGVDieuChinh ,gv.Ho+' '+gv.Ten as GVDieuChinh
		FROM HeLop as BH
		JOIN #ThayDoiHSHeLop as thayDoiHS
		ON BH.MaHeLop=thayDoiHS.MaHeLop
		JOIN GiangVien gv
		ON thayDoiHS.MaGVDieuChinh=gv.MaGiangVien
	END
	ELSE
	BEGIN
		SELECT BH.MaHeLop, BH.TenHeLop,TD.HeSo,TD.NgayApDung, TD.MaGVDieuChinh, gv.Ho+' '+gv.Ten as GVDieuChinh
		FROM HeLop as BH JOIN  ThayDoiHSHeLop as TD
		ON BH.MaHeLop=TD.MaHeLop
		JOIN GiangVien gv ON TD.MaGVDieuChinh=gv.MaGiangVien
		ORDER BY MaHeLop,NgayApDung DESC
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_GV_Khoa]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_GV_Khoa] 
@MaKhoa varchar(10)='CB2'
AS
CREATE TABLE #ChucDanh(
	MaChucDanh varchar(10),
	TenChucDanh nvarchar(20)
)
INSERT INTO #ChucDanh VALUES('GV',N'Giảng viên')
INSERT INTO #ChucDanh VALUES('GVC',N'Giảng viên chính')
INSERT INTO #ChucDanh VALUES('GVCC',N'Giảng viên cao cấp')

SELECT MaBoMon INTO #BoMon FROM BoMon WHERE MaKhoa=@MaKhoa
SELECT GV.MaGiangVien,GV.Ho+' '+GV.Ten as HoTen, ChucVu, TenChucDanh as ChucDanh FROM GIANGVIEN as GV JOIN #ChucDanh AS CD ON GV.ChucDanh=CD.MaChucDanh
WHERE GV.MaBoMon in (SELECT MaBoMon FROM #BoMon) AND GV.TrangThaiXoa=0
GO
/****** Object:  StoredProcedure [dbo].[sp_get_He_Lop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_get_He_Lop]
AS
BEGIN
	SELECT MaHeLop,MAX(NgayApDung) as NgayApDung INTO #HeLop FROM ThayDoiHSHeLop GROUP BY MaHeLop
	SELECT hl.MaHeLop,td.NgayApDung, td.HeSo INTO #ThayDoiHSHeLop
	FROM #HeLop as hl, ThayDoiHSHeLop as td
	WHERE hl.MaHeLop=td.MaHeLop and hl.NgayApDung=td.NgayApDung
	SELECT HL.MaHeLop,HL.TenHeLop,thayDoiHS.HeSo,thayDoiHS.NgayApDung FROM HeLop as HL, #ThayDoiHSHeLop as thayDoiHS
	WHERE HL.MaHeLop=thayDoiHS.MaHeLop
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_Hoc_Vi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_get_Hoc_Vi]
@all bit=1
AS
BEGIN
	IF(@all=0)
	BEGIN 
		SELECT MaHocVi, Max(MaNKHK) AS MaNKHK INTO #ThayDoiGiaHocVi
		FROM ThayDoiGiaHocVi
		GROUP BY MaHocVi

		SELECT thayDoi.MaHocVi,hv.TenHocVi,thayDoi.DonGia, thayDoi.MaNKHK, thayDoi.MaGVDieuChinh INTO #HocViTemp
		FROM ThayDoiGiaHocVi thayDoi, #ThayDoiGiaHocVi thayDoiTemp, HocVi hv
		WHERE thayDoi.MaHocVi=thayDoiTemp.MaHocVi AND thayDoiTemp.MaNKHK=thayDoi.MaNKHK 
		AND hv.MaHocVi=thayDoiTemp.MaHocVi

		SELECT hv.*, gv.Ho+' '+gv.Ten AS GVDieuChinh
		FROM  #HocViTemp hv
		JOIN GiangVien gv
		ON hv.MaGVDieuChinh=gv.MaGiangVien
	END
	ELSE
	BEGIN
		SELECT HV.MaHocVi, HV.TenHocVi,TD.DonGia,TD.MaNKHK, TD.MaGVDieuChinh, gv.Ho+' '+gv.Ten AS GVDieuChinh
		FROM HocVi as HV, ThayDoiGiaHocVi as TD, GiangVien as gv
		WHERE HV.MaHocVi=TD.MaHocVi AND TD.MaGVDieuChinh=gv.MaGiangVien
		ORDER BY HV.MaHocVi,MaNKHK DESC
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_HS_LDTH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_get_HS_LDTH]
@MaMon varchar(10)='INT',
@SiSo int=8
AS
IF(LTRIM(RTRIM(@MaMon)) IN (SELECT LTRIM(RTRIM(MaMonHoc)) FROM MonHoc
WHERE TenMonHoc=N'Thực hành chuyên sâu' or TenMonHoc=N'Thực hành cơ sở' or TenMonHoc=N'Thực hành chuyên sâu tổng hợp'))
	SELECT TOP 1 HSLopDong
	FROM LopDongThucHanh
	WHERE @SiSo>=SiSoMin AND @SiSo<=SiSoMax
	ORDER BY NgayApDung DESC
ELSE

	IF EXISTS(SELECT MaBoMon FROM BoMon WHERE TipDauNguMonHoc LIKE CONCAT('%',LEFT(@MaMon,3),'%') AND MaKhoa!='KTDT2') 
		SELECT TOP 1 HSLopDong
		FROM LopDongThucHanh
		WHERE @SiSo>=SiSoMin AND @SiSo<=SiSoMax
		ORDER BY NgayApDung DESC

	ELSE
		SELECT TOP 1 HSLopDong
		FROM LopDongThucHanh
		WHERE @SiSo>=SiSoMin-10 AND @SiSo<=SiSoMax-10
		ORDER BY NgayApDung DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_HSBacHoc]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_HSBacHoc]
@maBacHoc varchar(20)='DH'
AS
CREATE TABLE #BACHOC(
MaBac varchar(10),
TenBacHoc nvarchar(20),
HeSo float,
NgayApDung DateTime
)
INSERT INTO #BACHOC EXEC [dbo].[sp_get_Bac_Hoc]

SELECT HeSo
FROM #BACHOC
WHERE MaBac=@maBacHoc
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_HSHeLop]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_HSHeLop]
@maHeLop varchar(20)='CQ'
AS
CREATE TABLE #HELOP(
MaHeLop varchar(10),
TenHeLop nvarchar(20),
HeSo float,
NgayApDung DateTime
)
INSERT INTO #HELOP EXEC [dbo].[sp_get_He_Lop]

SELECT HeSo
FROM #HELOP
WHERE MaHeLop=@maHeLop
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_NguoiKy]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_NguoiKy]
@MaNKHK varchar(20)
,@KyHieu varchar(20)
AS

DECLARE @ChucVuComp nvarchar(50)
SET @ChucVuComp=N'@ChucVu'
print(@ChucVuComp)
SELECT TOP 1 * FROM NguoiKy as nk
WHERE MaNKHK <=@MaNKHK AND KyHieu =@KyHieu
ORDER BY MaNKHK DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Thuc_Hien_NCKH]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_Thuc_Hien_NCKH] 
@MaKhoa varchar(10)='CNTT2', @MaNKHK varchar(10)='20211'
AS
CREATE TABLE #ChucDanh(
	MaChucDanh varchar(10),
	TenChucDanh nvarchar(20)
)
INSERT INTO #ChucDanh VALUES('GV',N'Giảng viên')
INSERT INTO #ChucDanh VALUES('GVC',N'Giảng viên chính')
INSERT INTO #ChucDanh VALUES('GVCC',N'Giảng viên cao cấp')
SELECT MaBoMon INTO #BoMon FROM BoMon WHERE MaKhoa=@MaKhoa
SELECT GV.MaGiangVien,THNCKH.MaNKHK,GV.Ho+' '+GV.Ten as HoTen,CD.TenChucDanh as ChucDanh,GV.ChucVu,THNCKH.ThucTeNCKH,THNCKH.GhiChu FROM GIANGVIEN as GV JOIN ThucHienNCKH as THNCKH ON GV.MaGiangVien=THNCKH.MaGV
JOIN #ChucDanh CD ON CD.MaChucDanh=GV.ChucDanh
WHERE THNCKH.MaNKHK=@MaNKHK AND GV.MaBoMon in (SELECT MaBoMon FROM #BoMon)
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDSTruongKhoa]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetDSTruongKhoa]
AS
SELECT MaGiangVien,Ho, Ten, MaBoMon  INTO #GiangVien FROM GiangVien
where ChucVu like N'%Trưởng khoa%'

SELECT MaBoMon, MaKhoa INTO #BoMon
FROM BoMon
WHERE MaBoMon in (SELECT MaBoMon FROM #GiangVien)

SELECT kh.MaKhoa, kh.TenKhoa, bm.MaBoMon INTO #Khoa
FROM Khoa kh, #BoMon bm
WHERE bm.MaKhoa=kh.MaKhoa

SELECT gv.MaGiangVien, gv.Ho+' '+gv.Ten as HoTen, kh.MaKhoa,kh.TenKhoa
FROM #GiangVien gv, #Khoa kh
WHERE gv.MaBoMon=kh.MaBoMon
GO
/****** Object:  StoredProcedure [dbo].[sp_GetHocVi]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetHocVi]
@MaGV varchar(10)
AS
SELECT TOP 1 MaGV, MaHocVi INTO #ThayDoiHocVi FROM ThayDoiHocVi
WHERE MaGV=@MaGV
ORDER BY NgayThayDoi DESC

SELECT gv.MaGiangVien, hv.MaHocVi, gv.ChucDanh, DonGia=0
FROM GiangVien gv, #ThayDoiHocVi hv
WHERE gv.MaGiangVien=hv.MaGV
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLopDongLyThuyet]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetLopDongLyThuyet]
@all bit=1
AS
IF(@all=0)
BEGIN
	SELECT SiSoMin, SiSoMax, Max(NgayApDung)as NgayApDung INTO #LDLTTemp
	FROM LopDongLyThuyet
	GROUP BY SiSoMin, SiSoMax

	SELECT temp.SiSoMin, temp.SiSoMax, ld.HSLopDong, temp.NgayApDung
	FROM #LDLTTemp temp
	LEFT JOIN LopDongLyThuyet ld ON temp.NgayApDung=ld.NgayApDung
	WHERE temp.SiSoMin=ld.SiSoMin AND temp.SiSoMax=ld.SiSoMax
END
ELSE
BEGIN
	SELECT * FROM LopDongLyThuyet
	ORDER BY SiSoMin, NgayApDung DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLopDongThucHanh]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetLopDongThucHanh]
@all bit=0
AS
IF(@all=0)
BEGIN
	SELECT SiSoMin, SiSoMax, Max(NgayApDung)as NgayApDung INTO #LDTHTemp
	FROM LopDongThucHanh
	GROUP BY SiSoMin, SiSoMax

	SELECT temp.SiSoMin, temp.SiSoMax, ld.HSLopDong, temp.NgayApDung
	FROM #LDTHTemp temp
	LEFT JOIN LopDongThucHanh ld ON temp.NgayApDung=ld.NgayApDung
	WHERE temp.SiSoMin=ld.SiSoMin AND temp.SiSoMax=ld.SiSoMax
END
ELSE
BEGIN
	SELECT * FROM LopDongThucHanh
	ORDER BY SiSoMin, NgayApDung DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_DinhMuc]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Report_DinhMuc] 
@MaNKHK varchar(20)='20211'
AS
SELECT * INTO #DinhMucGiang
FROM DinhMucGiang 
WHERE MaNKHK=@MaNKHK

SELECT * INTO #NCKH
FROM DinhMucNCKH
WHERE MaNKHK=@MaNKHK

CREATE TABLE #chucDanhTemp(
MaChucDanh varchar(5),
TenChucDanh nvarchar(20)
)
INSERT INTO #chucDanhTemp VALUES('GV',N'Giảng viên')
INSERT INTO #chucDanhTemp VALUES('GVC',N'Giảng viên chính')
INSERT INTO #chucDanhTemp VALUES('GVCC',N'Giảng viên cao cấp')

SELECT KH.TenKhoa,BM.TenBoMon,gv.Ho, gv.Ten,#chucDanhTemp.TenChucDanh as ChucDanh, gv.HocVi, gv.ChucVu,g.DinhMuc,nckh.DinhMuc as DinhMucNCKH,g.GhiChu
FROM GiangVien as gv 
LEFT JOIN #DinhMucGiang as g ON gv.MaGiangVien=g.MaGV
LEFT JOIN #NCKH as nckh ON gv.MaGiangVien=nckh.MaGV
JOIN BoMon BM ON BM.MaBoMon=gv.MaBoMon
JOIN Khoa KH ON KH.MaKhoa=BM.MaKhoa
JOIN #chucDanhTemp ON #chucDanhTemp.MaChucDanh=gv.ChucDanh
WHERE gv.TrangThaiXoa=0
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_KL_Giang]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Report_KL_Giang]
@maNKHK varchar(10)='20211'
AS
CREATE TABLE #chucDanhTemp(
MaChucDanh varchar(5),
TenChucDanh nvarchar(20)
)
INSERT INTO #chucDanhTemp VALUES('GV',N'Giảng viên')
INSERT INTO #chucDanhTemp VALUES('GVC',N'Giảng viên chính')
INSERT INTO #chucDanhTemp VALUES('GVCC',N'Giảng viên cao cấp')

CREATE TABLE #TruongKhoa (
HoTen nvarchar (50),
MaKhoa varchar(10),
TenKhoa nvarchar(50))

INSERT INTO #TruongKhoa VALUES(dbo.[func_getNguoiKy]('TKCB2',@maNKHK),'CB2',N'Cơ bản 2')

INSERT INTO #TruongKhoa VALUES(dbo.[func_getNguoiKy]('TKCNTT2',@maNKHK),'CNTT2',N'Công nghệ thông tin 2')

INSERT INTO #TruongKhoa VALUES(dbo.[func_getNguoiKy]('TKKTDT2',@maNKHK),'KTDT2',N'Kỹ thuật điện tử 2')

SELECT * INTO #LopTinChi 
FROM[dbo].[fn_ReportKLGioGiang](@maNKHK) 

SELECT kl.TenKhoa,kl.TenBoMon,kl.MaGiangVien,kl.TenGiangVien,chucDanh.TenChucDanh, kl.HocVi,kl.TenMonHoc,
kl.TenLTC,SiSo,SoSVNhomTH,HSLopDongTH,HSLopDongLT,HSNgoaiGio,HSMonMoi,HSLTC,TietLTTD,TietBTTD,TietTHTD,
SoNhomTH,LTQuiChuan,BTQuiChuan,THQuiChuan,TongCong, tk.HoTen as TruongKhoa
FROM #LopTinChi as kl, #chucDanhTemp as chucDanh, #TruongKhoa as tk
WHERE chucDanh.MaChucDanh=kl.ChucDanh and kl.MaKhoa=tk.MaKhoa
Order By TenKhoa,TenBoMon,TenGiangVien
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_KL_TTTN]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Report_KL_TTTN] 
@MaNKHK varchar(20)='20211'
AS
SELECT * INTO #HuongDanTTTN FROM HuongDanTTTN
WHERE MaNKHK=@MaNKHK

CREATE TABLE #chucDanhTemp(
MaChucDanh varchar(5),
TenChucDanh nvarchar(20)
)
INSERT INTO #chucDanhTemp VALUES('GV',N'Giảng viên')
INSERT INTO #chucDanhTemp VALUES('GVC',N'Giảng viên chính')
INSERT INTO #chucDanhTemp VALUES('GVCC',N'Giảng viên cao cấp')

SELECT TenKhoa, gv.Ho+' '+gv.Ten as HoTen, #chucDanhTemp.TenChucDanh, tttn.Lop, SoTuan, SoSinhVienHD, HSHuongDan, SoTuan*SoSinhVienHD*HSHuongDan as SoGioHDTTTN, SoSinhVienPB, HSPhanBien, SoSinhVienPB*HSPhanBien as SoGioPB, SoTuan*SoSinhVienHD*HSHuongDan+ SoSinhVienPB*HSPhanBien as TongCong
FROM #HuongDanTTTN tttn
JOIN GiangVien gv
ON tttn.MaGV=gv.MaGiangVien
JOIN BoMon BM ON BM.MaBoMon=gv.MaBoMon
JOIN Khoa KH ON KH.MaKhoa=BM.MaKhoa
JOIN #chucDanhTemp ON gv.ChucDanh=#chucDanhTemp.MaChucDanh
WHERE gv.TrangThaiXoa=0
GO
/****** Object:  StoredProcedure [dbo].[sp_Report_TinhTienTroiGio]    Script Date: 25/10/2022 12:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Report_TinhTienTroiGio]
@maNKHK varchar(10)='20211', @maNKHK_TRUOC varchar(10)='20202'
AS

DECLARE @MaGV varchar(10), @HocVi varchar(10), @ChucDanh varchar(10)
CREATE TABLE #GiangVienTemp(
MaGV varchar(10),
HocVi varchar(10),
ChucDanh varchar(10),
DonGia float)
DECLARE cursorGV CURSOR FOR  -- khai báo con trỏ lấy học vị của GV
SELECT MaGiangVien FROM GiangVien     -- dữ liệu trỏ tới

OPEN cursorGV                -- Mở con trỏ

FETCH NEXT FROM cursorGV     -- Đọc dòng đầu tiên
      INTO @MaGV

WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
BEGIN
INSERT INTO #GiangVienTemp EXEC sp_GetHocVi @MaGV
 FETCH NEXT FROM cursorGV -- Đọc dòng tiếp
          INTO @MaGV
END

CLOSE cursorGV              -- Đóng Cursor
DEALLOCATE cursorGV         -- Giải phóng tài nguyên

DECLARE cursorGV2 CURSOR FOR  -- khai báo con trỏ để lấy đơn giá học vị
SELECT MaGV, HocVi, ChucDanh FROM #GiangVienTemp     -- dữ liệu trỏ tới

OPEN cursorGV2               -- Mở con trỏ

FETCH NEXT FROM cursorGV2     -- Đọc dòng đầu tiên
      INTO @MaGV, @HocVi, @ChucDanh

WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
BEGIN

UPDATE #GiangVienTemp
SET DonGia= [dbo].[func_getDonGiaGV](@HocVi, @ChucDanh, '')
WHERE MaGV=@MaGV

FETCH NEXT FROM cursorGV2 -- Đọc dòng tiếp
          INTO @MaGV, @HocVi, @ChucDanh
END

CLOSE cursorGV2              -- Đóng Cursor
DEALLOCATE cursorGV2         -- Giải phóng tài nguyên

DECLARE @HuongDanTTTN float=0
DECLARE @GioTroi float=0
SELECT TenKhoa,TenBoMon, MaGiangVien, TenGiangVien,ChucDanh,HocVi as TrinhDo,HSHocKy, Sum(TongCong) as ThucTeGiangDay INTO #ThucTeGiangDay
FROM [dbo].[fn_ReportKLGioGiang](@maNKHK)
GROUP BY TenKhoa,TenBoMon,MaGiangVien, TenGiangVien,ChucDanh,HocVi,HSHocKy

DECLARE @HSHocKy float
SELECT TOP 1 @HSHocKy=HSHocKy
FROM #ThucTeGiangDay


SELECT tt.*, gv.DonGia INTO #GiangVien
FROM #GiangVienTemp gv
JOIN #ThucTeGiangDay tt ON gv.MaGV=tt.MaGiangVien

SELECT MaGV, DinhMuc INTO #DinhMucGiang
FROM DinhMucGiang
WHERE MaNKHK=@maNKHK

CREATE TABLE #chucDanhTemp(
MaChucDanh varchar(5),
TenChucDanh nvarchar(20)
)
INSERT INTO #chucDanhTemp VALUES('GV',N'Giảng viên')
INSERT INTO #chucDanhTemp VALUES('GVC',N'Giảng viên chính')
INSERT INTO #chucDanhTemp VALUES('GVCC',N'Giảng viên cao cấp')
SELECT tttn.MaGV as MaGV, tttn.TenKhoa, tttn.TenBoMon,tttn.TenGiangVien,cd.TenChucDanh as ChucDanh, tttn.TrinhDo, case when tttn.HuongDanTTTNQuiChuan is Null then 0 else tttn.HuongDanTTTNQuiChuan end AS HuongDanTTTNQuiChuan INTO #HuongDanTTTNTemp
FROM func_GetSoTietHuongDanTTTN(@maNKHK) tttn
LEFT JOIN #GiangVien gv
ON gv.MaGiangVien=tttn.MaGV
LEFT JOIN #chucDanhTemp cd
ON tttn.ChucDanh=cd.MaChucDanh

SELECT tttn.*, gv.DonGia INTO #HuongDanTTTN
FROM #HuongDanTTTNTemp tttn
JOIN #GiangVienTemp gv
ON tttn.MaGV=gv.MaGV


--SELECT dm.MaGV, DinhMuc, ThucTeNCKH  INTO #NCKH
--FROM DinhMucNCKH dm, ThucHienNCKH th
--WHERE dm.MaGV=th.MaGV and dm.MaNKHK=th.MaNKHK 
--AND dm.MaNKHK=@maNKHK

DECLARE @GioTroiNCKH float=0
DECLARE @GioTamTru float=0
DECLARE @HocKy int=1
DECLARE @NKHK int
DECLARE @NKHK_TRUOC varchar(20)
SELECT @NKHK=CAST(@maNKHK AS int);
IF(@NKHK%2=0)
	SET @HocKy=2
IF(@HSHocKy IS NULL)
	SET @HSHocKy=1

SELECT * INTO #NCKH FROM NCKH(@maNKHK,@HocKy,@maNKHK_TRUOC)

SELECT case WHEN tt.TenKhoa IS NULL THEN hdtttn.TenKhoa ELSE tt.TenKhoa END AS TenKhoa, CASE WHEN tt.TenBoMon IS NULL THEN hdtttn.TenBoMon ELSE tt.TenBoMon END as TenBoMon, CASE WHEN tt.TenGiangVien IS NULL THEN hdtttn.TenGiangVien ELSE tt.TenGiangVien END AS TenGiangVien, CASE WHEN cd.TenChucDanh IS NULL THEN hdtttn.ChucDanh ELSE cd.TenChucDanh END as ChucDanh, CASE WHEN tt.TrinhDo IS NULL THEN hdtttn.TrinhDo ELSE tt.TrinhDo END as TrinhDo, dm.DinhMuc, tt.ThucTeGiangDay,ISNULL (hdtttn.HuongDanTTTNQuiChuan,0) as HuongDanTTTN, 
( CASE WHEN hdtttn.HuongDanTTTNQuiChuan IS NULL THEN 0 ELSE hdtttn.HuongDanTTTNQuiChuan END +
CASE WHEN tt.ThucTeGiangDay IS NULL THEN 0 ELSE tt.ThucTeGiangDay END)-
CASE WHEN dm.DinhMuc IS NULL THEN 0 ELSE dm.DinhMuc END as GioTroi,CASE WHEN @HocKy=1 THEN ISNULL (NCKH.DINH_MUC_NCKH+NCKH.DINH_MUC_NCKH_HKTRUOC,0) ELSE NCKH.DINH_MUC_NCKH END as DinhMucNCKH, ISNULL (NCKH.TT_NCKH,0) AS TT_NCKH,-1*NCKH.TAM_TRU as GioTamTru,NCKH.GIO_TROI as GioTroiNCKH, 
(CASE WHEN hdtttn.HuongDanTTTNQuiChuan IS NULL THEN 0 ELSE hdtttn.HuongDanTTTNQuiChuan END + 
CASE WHEN tt.ThucTeGiangDay IS NULL THEN 0 ELSE tt.ThucTeGiangDay END)- CASE WHEN dm.DinhMuc IS NULL THEN 0 ELSE dm.DinhMuc  END+ CASE WHEN NCKH.GIO_TROI<0 THEN NCKH.GIO_TROI WHEN NCKH.GIO_TROI>=0 AND NCKH.TAM_TRU<=0 THEN -1*NCKH.TAM_TRU   END as GioTroiChuan, CASE WHEN tt.DonGia*@HSHocKy IS NULL THEN hdtttn.DonGia*@HSHocKy ELSE tt.DonGia*@HSHocKy END AS DonGia, case when ( (CASE WHEN hdtttn.HuongDanTTTNQuiChuan IS NULL THEN 0 ELSE hdtttn.HuongDanTTTNQuiChuan END+CASE WHEN tt.ThucTeGiangDay IS NULL THEN 0 ELSE tt.ThucTeGiangDay END)-CASE WHEN dm.DinhMuc IS NULL THEN 0 ELSE dm.DinhMuc  END+ CASE WHEN NCKH.GIO_TROI>0 THEN 0 ELSE NCKH.GIO_TROI END)*(CASE WHEN tt.DonGia*@HSHocKy IS NULL THEN hdtttn.DonGia*@HSHocKy ELSE tt.DonGia*@HSHocKy END)>0 then  ( ( CASE WHEN hdtttn.HuongDanTTTNQuiChuan IS NULL THEN 0 ELSE hdtttn.HuongDanTTTNQuiChuan END+
CASE WHEN tt.ThucTeGiangDay IS NULL THEN 0 ELSE tt.ThucTeGiangDay END)- CASE WHEN dm.DinhMuc IS NULL THEN 0 ELSE dm.DinhMuc END + CASE WHEN NCKH.GIO_TROI<0 THEN NCKH.GIO_TROI WHEN NCKH.GIO_TROI>=0 AND NCKH.TAM_TRU<=0 THEN -1*NCKH.TAM_TRU  END )*(CASE WHEN tt.DonGia*@HSHocKy IS NULL THEN hdtttn.DonGia*@HSHocKy ELSE tt.DonGia*@HSHocKy END) else null end as DuocNhan, 
case when ( (CASE WHEN hdtttn.HuongDanTTTNQuiChuan IS NULL THEN 0 ELSE hdtttn.HuongDanTTTNQuiChuan END+CASE WHEN tt.ThucTeGiangDay IS NULL THEN 0 ELSE tt.ThucTeGiangDay END)-
CASE WHEN dm.DinhMuc IS NULL THEN 0 ELSE dm.DinhMuc END + CASE WHEN NCKH.GIO_TROI<0 THEN NCKH.GIO_TROI WHEN NCKH.GIO_TROI>=0 AND NCKH.TAM_TRU<=0 THEN -1*NCKH.TAM_TRU  END)*(CASE WHEN tt.DonGia*@HSHocKy IS NULL THEN hdtttn.DonGia*@HSHocKy ELSE tt.DonGia*@HSHocKy END)<0 then  -1*( (CASE WHEN hdtttn.HuongDanTTTNQuiChuan IS NULL THEN 0 ELSE hdtttn.HuongDanTTTNQuiChuan END+CASE WHEN tt.ThucTeGiangDay IS NULL THEN 0 ELSE tt.ThucTeGiangDay END)-
CASE WHEN dm.DinhMuc IS NULL THEN 0 ELSE dm.DinhMuc END + CASE WHEN NCKH.GIO_TROI<0 THEN NCKH.GIO_TROI WHEN NCKH.GIO_TROI>=0 AND NCKH.TAM_TRU<=0 THEN -1*NCKH.TAM_TRU  END )*(CASE WHEN tt.DonGia*@HSHocKy IS NULL THEN hdtttn.DonGia*@HSHocKy ELSE tt.DonGia*@HSHocKy END) else null end as PhaiTra
FROM #GiangVien tt
LEFT JOIN #DinhMucGiang dm ON tt.MaGiangVien=dm.MaGV 
FULL OUTER JOIN #HuongDanTTTN hdtttn ON hdtttn.MaGV=tt.MaGiangVien
LEFT JOIN #NCKH NCKH on tt.MaGiangVien=NCKH.MaGiangVien 
LEFT JOIN #chucDanhTemp cd on tt.ChucDanh= cd.MaChucDanh
WHERE dm.DinhMuc>0 OR NCKH.DINH_MUC_NCKH>0

ORDER BY TenKhoa, TenBoMon
GO
/****** Object:  StoredProcedure [dbo].[updatePK]    Script Date: 25/10/2022 12:36:22 PM ******/
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
