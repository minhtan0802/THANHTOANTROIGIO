USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[getListGiangVienByBoMon]    Script Date: 12/07/2022 8:37:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getListGiangVienByBoMon]
@maBoMon nvarchar(50)='GD2'
AS
SELECT * FROM GiangVien WHERE MaBoMon=@maBoMon
GO


