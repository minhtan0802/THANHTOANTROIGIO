using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("ThayDoiBoMon")]
    public class ThayDoiBoMon
    {
        public String MaBoMon { get; set; }
        public String MaGV { get; set; }
        public DateTime NgayThayDoi { get; set; }
    }
}
