using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("HeLop")]
    public class HeLop
    {
        [Key]
        public String MaHeLop { get; set; }
        public String TenHeLop { get; set; }
    }
    public class HeLopViewModel
    {
        public String MaHeLop { get; set; }
        public String TenHeLop { get; set; }
        public double HeSo { get; set; }
        public DateTime NgayApDung { get; set; }
        public String GVDieuChinh { get; set; }
    }
}
