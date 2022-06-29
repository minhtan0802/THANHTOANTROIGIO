using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("MonHoc")]
    public class MonHoc
    {
        [Key]
        public String? MaMonHoc { get; set; }
        public String? TenMonHoc { get; set; }
        public double TietLT { get; set; }
        public double TietBT { get; set; }
        public double TietTH { get; set; }
    }
}
