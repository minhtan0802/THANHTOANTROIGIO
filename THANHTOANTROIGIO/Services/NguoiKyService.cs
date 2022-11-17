using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.Services
{
    public class NguoiKyService
    {
        private ThanhToanTroiGioEntities _context;
        public NguoiKyService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getDSNguoiKy(int all, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@all", all));
            var data = new SQLHelper(connectionString).ExecuteQuery("get_NguoiKy", param);
            return data;
        }
    }
}
