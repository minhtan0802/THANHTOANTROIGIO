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
                var list = context.GiangViens.FromSqlRaw("EXEC getLTC", param).ToList();
                return list;
            }
        }
    }
}
