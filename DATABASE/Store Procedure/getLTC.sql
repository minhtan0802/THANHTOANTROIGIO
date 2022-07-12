USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[getLTC]    Script Date: 12/07/2022 8:37:15 AM ******/
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


