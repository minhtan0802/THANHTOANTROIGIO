using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("LoaiGiangVien")]
    public class LoaiGiangVien
    {
        [Key]
        public String MaLoaiGV { get; set; }
        public String TenLoaiGV { get; set; }
    }
}
