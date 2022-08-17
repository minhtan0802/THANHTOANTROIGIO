using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("BacHoc")]
    public class BacHoc
    {
        [Key]
        public String MaBac { get; set; }
        public String TenBac { get; set; }
    }
    public class BacHocViewModel
    {
        public String MaBac { get; set; }
        public String TenBac { get; set; }
        public double HeSo { get; set; }
        public DateTime NgayApDung { get; set; }
        public String GVDieuChinh { get; set; }
    }
}
