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
}
