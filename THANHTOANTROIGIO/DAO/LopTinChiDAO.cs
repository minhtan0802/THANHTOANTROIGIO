using IdentityModel.Client;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class LopTinChiDAO
    {
        public static IEnumerable<Object> getListLTC(String MaNKHK, String MaGV)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                List<SqlParameter> param = new List<SqlParameter>();
                param.Add(new SqlParameter("@MaNKHK", MaNKHK));
                param.Add(new SqlParameter("@MaGV", MaGV));
                var list = context.LopTinChiViewModels.FromSqlRaw("EXEC [dbo].[getLTC] '" + MaNKHK+"','"+MaGV+"'",param.ToArray()).ToList();
                return list;
            }
        }
        public static LopTinChi getLTC(int maLTC)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var ltc = context.LopTinChis.Where(x => x.MaLTC == maLTC).FirstOrDefault();
                return ltc;
            }
        }

        public static int getDonGia(string maHocVi, string maGV, string tenMon)
        {
            List<SqlParameter> param= new List<SqlParameter>();
            param.Add(new SqlParameter("@maHocVi", maHocVi));
            param.Add(new SqlParameter("@maGV", maGV));
            param.Add(new SqlParameter("@monHoc", tenMon));
            var data = new SQLHelper().ExecuteQuery("getDonGiaGV", param);
            var rountCount = data.Rows.Count;
            return int.Parse(data.Rows[0][0].ToString());
        }
    }
}
