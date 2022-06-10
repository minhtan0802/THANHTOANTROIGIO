using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("BoMon")]
    public class BoMon
    {
        [Key]
        public String MaBoMon { get; set; }
        public String TenBoMon { get; set; }
        public String MaKhoa { get; set; } 
    }
}
