using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("NienKhoaHocKy")]
    public class NienKhoaHocKy
    {
        [Key]
        public String MaNKHK { get; set; }
        public String TenHocKy { get; set; }
        public String TenNienKhoa { get; set; }
    }
}
