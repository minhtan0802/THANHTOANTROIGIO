using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("NguoiKy")]
    public class NguoiKy
    {
        [Key]
        public int id { get; set; }
        public String KyHieu { get; set; }
        public String ChucVu { get; set; }
        public String HoTen { get; set; }
        public String MaNKHK { get; set; }
    }
}
