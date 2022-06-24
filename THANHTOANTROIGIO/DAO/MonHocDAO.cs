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
    }
}

