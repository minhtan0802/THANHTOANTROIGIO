USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[get_DS_Huong_Dan_TTTN]    Script Date: 12/07/2022 8:36:31 AM ******/
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


