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
    public class NguoiKyViewModel
    {
        public int id { get; set; }
        public String NKHK { get; set; }
        public String ChucVu { get; set; }
        public String HoTen { get; set; }
        public String MaNKHK { get; set; }
        public String TenNienKhoa { get; set; }
        public String MaChucVu { get; set; }
    }
}
