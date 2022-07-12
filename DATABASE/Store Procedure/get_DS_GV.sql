USE [THANHTOANTROIGIO]
GO

/****** Object:  StoredProcedure [dbo].[get_DS_GV]    Script Date: 12/07/2022 8:35:23 AM ******/
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


