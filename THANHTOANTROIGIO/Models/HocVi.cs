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
}
