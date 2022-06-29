using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("LopDongLyThuyet")]
    public class LopDongLyThuyet
    {
        [Key]
        public String MaKhoa { get; set; }
        public DateTime NgayApDung { get; set; }
        public int SiSoMin { get; set; }
        public int SiSoMax { get; set; }
        public double HSLopDong { get; set; }
    }
}
