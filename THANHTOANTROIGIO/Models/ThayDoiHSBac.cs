using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiHSBac")]
    public class ThayDoiHSBac
    {
        public String MaBac { get; set; }
        public String MaGVDieuChinh { get; set; }
        public double HeSo { get; set; }
        public DateTime NgayApDung { get; set; }
    }
}
