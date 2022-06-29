using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class HeLopDAO
    {
        public static List<HeLop> getDSHeLop()
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.HeLops.ToList();
                return list;
            }
        }
        public static float getHeSoHeLopByMaHeLop(String maHeLop)
        {
            ThayDoiHSHeLop heLop = new ThayDoiHSHeLop();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                var ngayApDung = ctx.ThayDoiHSHeLops.Where(s => s.MaHeLop.Equals(maHeLop)).Max(o => o.NgayApDung);
                heLop = (ThayDoiHSHeLop)ctx.ThayDoiHSHeLops
                             .Where(s => s.MaHeLop.Equals(maHeLop.Trim()) && s.NgayApDung == ngayApDung).FirstOrDefault();
            }
            return (float)heLop.HeSo;
        }
    }
}
