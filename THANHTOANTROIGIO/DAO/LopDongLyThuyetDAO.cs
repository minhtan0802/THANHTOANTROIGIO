using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class LopDongLyThuyetDAO
    {
        public static float getHeSo(String maKhoa, int siSo)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.LopDongLyThuyets.Where(x => x.MaKhoa == maKhoa && x.SiSoMin <= siSo && x.SiSoMax >= siSo).OrderByDescending(x=>x.NgayApDung).ToList();
                return (float)list[0].HSLopDong;
            }
        }
    }
}
