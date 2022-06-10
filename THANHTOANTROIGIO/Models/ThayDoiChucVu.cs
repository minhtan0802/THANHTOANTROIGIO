using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiChucVu")]
    public class ThayDoiChucVu
    {
        public String MaChucVu { get; set; }
        public String MaGV { get; set; }
        public DateTime NgayThayDoi { get; set; }
    }
}
