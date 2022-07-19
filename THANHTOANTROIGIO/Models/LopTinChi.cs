using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("LopTinChi")]
    public class LopTinChi
    {
        [Key]
        public int MaLTC { get; set; }
        public String TenLTC { get; set; }
        public int SiSo { get; set; }
        public int SoNhomTH { get; set; }
        public double TietBTQD  { get; set; }
        public double TietBTTD{ get; set; }
        public double TietLTQD { get; set; }
        public double TietLTTD { get; set; }
        public double TietTHQD { get; set; }
        public double TietTHTD { get; set; }
        public int DonGia { get; set; }
        public double HSMonMoi { get; set; }
        public double HSNgoaiGio { get; set; }
        public double HSLopDongLT { get; set; }
        public double HSLopDongTH { get; set; }
        public double HSLTC { get; set; }
        public double HSHocKy { get; set; }
        public double HSNhomTH { get; set; }
        public String MaMon { get; set; }
        public double HSBac { get; set; }
        public String MaBac { get; set; }
        public double HSHeLop { get; set; }
        public String MaHeLop { get; set; }
        public String MaGV { get; set; }
        public String MaNKHK { get; set; }

        public LopTinChi(int maLTC, string tenLTC, int siSo, int soNhomTH, double tietBTQD, double tietBTTD, double tietLTQD, double tietLTTD, double tietTHQD, double tietTHTD, int donGia, double hSMonMoi, double hSNgoaiGio, double hSLopDongLT, double hSLopDongTH, double hSLTC, double hSHocKy, double hSNhomTH, string maMon, double hSBac, string maBac, double hSHeLop, string maHeLop, string maGV, string maNKHK)
        {
            MaLTC = maLTC;
            TenLTC = tenLTC;
            SiSo = siSo;
            SoNhomTH = soNhomTH;
            TietBTQD = tietBTQD;
            TietBTTD = tietBTTD;
            TietLTQD = tietLTQD;
            TietLTTD = tietLTTD;
            TietTHQD = tietTHQD;
            TietTHTD = tietTHTD;
            DonGia = donGia;
            HSMonMoi = hSMonMoi;
            HSNgoaiGio = hSNgoaiGio;
            HSLopDongLT = hSLopDongLT;
            HSLopDongTH = hSLopDongTH;
            HSLTC = hSLTC;
            HSHocKy = hSHocKy;
            HSNhomTH = hSNhomTH;
            MaMon = maMon;
            HSBac = hSBac;
            MaBac = maBac;
            HSHeLop = hSHeLop;
            MaHeLop = maHeLop;
            MaGV = maGV;
            MaNKHK = maNKHK;
        }
        public LopTinChi()
        {
        }
    }

    public class LopTinChiViewModel
    {
        [Key]
        public int MaLTC { get; set; }
        public String TenLTC { get; set; }
        public String TenMonHoc { get; set; }
        public int SiSo { get; set; }
        public double HSLopDongLT { get; set; }
        public int SoNhomTH { get; set; }
        public double HSLopDongTH { get; set; }
        public double TietLTTD { get; set; }
        public double TietBTTD { get; set; }
        public double TietTHTD { get; set; }
        public double TietLTQD { get; set; }
        public double TietBTQD { get; set; }
        public double TietTHQD { get; set; }
        public int DonGia { get; set; }
        public String TenHeLop { get; set; }
        public String TenBac { get; set; }


    }
}
