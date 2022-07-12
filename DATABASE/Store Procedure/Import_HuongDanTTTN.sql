USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[Import_HuongDanTTTN]    Script Date: 12/07/2022 8:37:38 AM ******/
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


