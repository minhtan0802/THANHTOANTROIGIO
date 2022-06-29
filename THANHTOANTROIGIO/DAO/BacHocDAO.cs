using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class BacHocDAO
    {
        public static List<BacHoc> getDSBacHoc()
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.BacHocs.ToList();
                return list;
            }
        }
        public static float getHeSoBacHocByMaBacHoc(String maBacHoc)
        {
            ThayDoiHSBac bacHoc = new ThayDoiHSBac();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                var ngayApDung = ctx.ThayDoiHSBacs.Where(s => s.MaBac.Equals(maBacHoc)).Max(o => o.NgayApDung);
                 bacHoc= (ThayDoiHSBac)ctx.ThayDoiHSBacs
                              .Where(s => s.MaBac.Equals(maBacHoc.Trim()) && s.NgayApDung== ngayApDung).FirstOrDefault();
            }
            return (float)bacHoc.HeSo;
        }
    }
}
