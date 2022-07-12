USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[getNameByID]    Script Date: 12/07/2022 8:37:29 AM ******/
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


