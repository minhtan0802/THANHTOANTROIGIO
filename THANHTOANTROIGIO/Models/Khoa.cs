using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("Khoa")]
    public class Khoa
    {
        [Key]
        public String MaKhoa { get; set; }
        public String TenKhoa { get; set; }
    }
}
