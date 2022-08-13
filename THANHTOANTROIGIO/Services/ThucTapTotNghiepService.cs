using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class ThucTapTotNghiepService
    {
        private ThanhToanTroiGioEntities _context;
        public ThucTapTotNghiepService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getDSTTTN(String maNKHK, String maGV, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@maGV", maGV));
            param.Add(new SqlParameter("@maNKHK", maNKHK));
            var data = new SQLHelper(connectionString).ExecuteQuery("get_DS_Huong_Dan_TTTN", param);
            return data;
        }
    }
}
