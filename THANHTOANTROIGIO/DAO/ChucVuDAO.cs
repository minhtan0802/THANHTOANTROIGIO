using THANHTOANTROIGIO.Controllers;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class ChucVuDAO
    {
        public static List<ChucVu> getListChucVu()
        {  
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list= context.ChucVus.ToList();
                return list;
            }
        }
        public static string getChucVuByMaGV(string maGiangVien)
        {
            ThayDoiChucVu chucVu = new ThayDoiChucVu();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                var ngayThayDoi = ctx.ThayDoiChucVus.Where(s => s.MaGV.Equals(maGiangVien)).Max(o => o.NgayThayDoi);
                chucVu = (ThayDoiChucVu)ctx.ThayDoiChucVus
                              .Where(s => s.MaGV.Equals(maGiangVien.Trim()) && s.NgayThayDoi.Year == ngayThayDoi.Year && s.NgayThayDoi.Month == ngayThayDoi.Month && s.NgayThayDoi.Day == ngayThayDoi.Day).FirstOrDefault();
            }
            return chucVu.MaChucVu;
        }

    }
}
