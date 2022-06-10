using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiHocVi")]
    public class ThayDoiHocVi 
    {
        public String MaHocVi { get; set; }
        public String MaGV { get; set; }
        public DateTime NgayThayDoi { get; set; }
    }
}
