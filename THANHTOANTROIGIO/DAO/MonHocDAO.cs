using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class MonHocDAO
    {
        public static List<MonHoc> getDSMonHoc()
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.MonHocs.ToList();
                return list;
            }
        }
        public static MonHoc getMonHoc(String MaMonHoc)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var data = context.MonHocs.Where(x => x.MaMonHoc == MaMonHoc).FirstOrDefault();
                return data;
            }
        }
    }
}

