using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiHSHeLop")]
    public class ThayDoiHSHeLop
    {
        public String MaHeLop { get; set; }
        public String MaGVDieuChinh { get; set; }
        public double HeSo { get; set; }
        public DateTime NgayApDung { get; set; }
    }
}
