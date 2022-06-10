using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ChucVu")]
    public class ChucVu
    {
        [Key]
        public String MaChucVu { get; set; }
        public String TenChucVu { get; set; }
        public double DinhMucGiam { get; set; }
    }
}
