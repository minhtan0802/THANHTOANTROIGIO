USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[getDonGiaGV]    Script Date: 12/07/2022 8:36:44 AM ******/
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


