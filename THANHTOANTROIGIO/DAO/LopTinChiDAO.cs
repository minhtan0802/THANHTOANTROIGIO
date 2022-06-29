using IdentityModel.Client;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
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
    }
}
