using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("HuongDanTTTN")]
    public class HuongDanTTTN
    {
        public String MaGV { get; set; }
        public String MaNKHK { get; set; }
        public double HSPhanBien { get; set; }
        public double SoSinhVienPB { get; set; }
        public String Lop { get; set; }
        public double SoSinhVienHD { get; set; }
        public int SoTuan { get; set; }
        public double HSHuongDan { get; set; }

        public HuongDanTTTN() { }
        public HuongDanTTTN(string maGV, string maNKHK, double hSPhanBien, double soSinhVienPB, string lop, double soSinhVienHD, int soTuan, double hSHuongDan)
        {
            MaGV = maGV;
            MaNKHK = maNKHK;
            HSPhanBien = hSPhanBien;
            SoSinhVienPB = soSinhVienPB;
            Lop = lop;
            SoSinhVienHD = soSinhVienHD;
            SoTuan = soTuan;
            HSHuongDan = hSHuongDan;
        }
    }
}
