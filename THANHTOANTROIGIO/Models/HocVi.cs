using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("HocVi")]
    public class HocVi
    {
        [Key]
        public String MaHocVi { get; set; }
        public String TenHocVi { get; set; }
        
    }
    public class HocViAddModel
    {
        public String MaHocVi { get; set; }
        public String TenHocVi { get; set; }
        public int DonGia { get; set; }
    }
    public class HocViViewModel
    {
        public String MaHocVi { get; set; }
        public String TenHocVi { get; set; }
        public int DonGia { get; set; }
        public String MaNKHK { get; set; }
        public String GVDieuChinh { get; set; }
    }
}
