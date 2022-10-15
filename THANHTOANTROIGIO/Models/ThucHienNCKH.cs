using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThucHienNCKH")]
    public class ThucHienNCKH
    {
        public String MaGV { get; set; }
        public String MaNKHK { get; set; }
        public double ThucTeNCKH { get; set; }
        public String? GhiChu { get; set; }

        public ThucHienNCKH(string maGV, string maNKHK, double thucTeNCKH, string ghiChu)
        {
            MaGV = maGV;
            MaNKHK = maNKHK;
            ThucTeNCKH = thucTeNCKH;
            GhiChu = ghiChu;
        }
        public ThucHienNCKH()
        {
        }
    }
}
