using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("GiangVien")]
    public class GiangVien
    {
        [Key]
        public String MaGiangVien { get; set; }
        public String Ho { get; set; }
        public String Ten { get; set; }
        public String HocVi { get; set; }
        public String ChucVu { get; set; }
        public String ChucDanh { get; set; }
        public Boolean GioiTinh { get; set; }
        public DateTime? NgaySinh { get; set; }
        public String? DiaChi { get; set; }
        public String? Sdt { get; set; }
        public String MaBoMon { get; set; }
        public Boolean GVCoHuu { get; set; }
        public Boolean TrangThaiXoa { get; set; }

    }
}
