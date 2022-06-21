using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace THANHTOANTROIGIO.Models
{
    [Table("LopTinChi")]
    public class LopTinChi
    {
        [Key]
        public int MaLTC { get; set; }
        public String TenLTC { get; set; }
        public double SiSo { get; set; }
        public int SoNhomTH { get; set; }
        public double TietBTQD  { get; set; }
        public double TietBTTD{ get; set; }
        public double TietLTQD { get; set; }
        public double TietLTTD { get; set; }
        public double TietTHQD { get; set; }
        public double TietTHTD { get; set; }
        public double DonGia { get; set; }
        public double HSMonMoi { get; set; }
        public double HSNgoaiGio { get; set; }
        public double HSLopDongLT { get; set; }
        public double HSLopDongTH { get; set; }
        public double HSLTC { get; set; }
        public String MaMon { get; set; }
        public double HeSoBac { get; set; }
        public String MaBac { get; set; }
        public double HeSoHeLop { get; set; }
        public double MaHeLop { get; set; }
        public String MaGV { get; set; }
        public String MaNKHK { get; set; }
    }
    public class LopTinChiViewModel
    {
        public String MaLTC { get; set; }
        public String TenLTC { get; set; }
        public String TenMonHoc { get; set; }
        public double SiSo { get; set; }
        public double HSLopDongLT { get; set; }
        public int SoNhomTH { get; set; }
        public double HeSoLopDongTH { get; set; }
        public double TietLTTD { get; set; }
        public double TietBTTD { get; set; }
        public double TietTHTD { get; set; }
        public double TietLTQD { get; set; }
        public double TietBTQD { get; set; }
        public double TietTHQD { get; set; }
        public double DonGia { get; set; }
        public String TenHeLop { get; set; }
        public String TenBac { get; set; }


    }
}
