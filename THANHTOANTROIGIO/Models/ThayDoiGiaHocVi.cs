using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiGiaHocVi")]
    public class ThayDoiGiaHocVi 
    {
        public String MaGVDieuChinh { get; set; }
        public String MaHocVi { get; set; }
        public int DonGia { get; set; }
        public String MaNKHK { get; set; }
    }
}
