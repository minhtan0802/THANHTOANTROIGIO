using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiLoaiGV")]
    public class ThayDoiLoaiGV
    {
        public String MaLoaiGV { get; set; }
        public String MaGV { get; set; }
        public DateTime NgayThayDoi { get; set; }
    }
}
