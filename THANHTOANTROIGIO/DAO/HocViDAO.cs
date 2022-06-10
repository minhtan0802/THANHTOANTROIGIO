using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class HocViDAO
    {
        public static List<HocVi> getListHocVi()
        {
            List<HocVi>list=new List<HocVi>();
            using (var context = new ThanhToanTroiGioEntities())
            {
                list = context.HocVis.ToList();
                return list;
            }
        }
        public static string getMaHocViByMaGV(String maGV)
        {
            ThayDoiHocVi hocVi = new ThayDoiHocVi();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                var ngayThayDoi = ctx.ThayDoiHocVis.Where(s => s.MaGV.Equals(maGV)).Max(o => o.NgayThayDoi);
                hocVi = (ThayDoiHocVi)ctx.ThayDoiHocVis
                              .Where(s => s.MaGV.Equals(maGV.Trim()) && s.NgayThayDoi.Year == ngayThayDoi.Year && s.NgayThayDoi.Month == ngayThayDoi.Month && s.NgayThayDoi.Day == ngayThayDoi.Day).FirstOrDefault();
            }
            return hocVi.MaHocVi;
        }
    }
}
