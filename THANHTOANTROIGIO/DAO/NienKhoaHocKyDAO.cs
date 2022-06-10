using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class NienKhoaHocKyDAO
    {
        public static IEnumerable<Object> getNienKhoa()
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.NienKhoaHocKys.Select(x => new
                {
                    x.TenNienKhoa
                }).Distinct().OrderByDescending(x=>x.TenNienKhoa).ToList();
                return (IEnumerable<Object>)list;
            }
        }
        public static List<NienKhoaHocKy> getHocKy(String tenNienKhoa)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.NienKhoaHocKys.Where(x => x.TenNienKhoa == tenNienKhoa).OrderBy(x=>x.TenHocKy).ToList();
                return list;
            }
        }
    }
}
