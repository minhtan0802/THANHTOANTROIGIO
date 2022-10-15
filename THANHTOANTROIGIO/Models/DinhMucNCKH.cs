using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("DinhMucNCKH")]
    public class DinhMucNCKH
    {
        public String MaGV { get; set; }
        public String MaNKHK { get; set; }
        public double DinhMuc { get; set; }
        public String? GhiChu { get; set; }

        public DinhMucNCKH(string maGV, string maNKHK, double dinhMuc, string ghiChu)
        {
            MaGV = maGV;
            MaNKHK = maNKHK;
            DinhMuc = dinhMuc;
            GhiChu = ghiChu;
        }
        public DinhMucNCKH()
        {
        }
    }
}
