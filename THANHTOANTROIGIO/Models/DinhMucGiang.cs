using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("DinhMucGiang")]
    public class DinhMucGiang
    {
        public String MaGV { get; set; }
        public String MaNKHK { get; set; }
        public double DinhMuc { get; set; }

        public DinhMucGiang(string maGV, string maNKHK, double dinhMuc)
        {
            MaGV = maGV;
            MaNKHK = maNKHK;
            DinhMuc = dinhMuc;
        }
    }
}
