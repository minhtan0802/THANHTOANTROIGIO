USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[updatePK]    Script Date: 12/07/2022 8:37:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updatePK]
@pk varchar(100)='GV07',
@pkUpdate varchar(10)='GV06',
@tableName varchar(20)='GiangVien'
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

END
GO


