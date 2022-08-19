using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class LopDongThucHanhService
    {
        private ThanhToanTroiGioEntities _context;
        public LopDongThucHanhService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public float getHeSo(String connectionString,String maMon, int siSo)
        {
            var sql = new SQLHelper(connectionString);
            var param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaMon", maMon));
            param.Add(new SqlParameter("@SiSo", siSo));
            var heSo = sql.ExecuteQuery("sp_get_HS_LDTH", param).Rows[0][0].ToString();
            if(heSo !="")
            {
                return float.Parse(heSo);
            }
            return 0;
        }
        public DataTable getDSLopDongThucHanh(String connectionString, int all)
        {
            var sql = new SQLHelper(connectionString);
            var param = new List<SqlParameter>();
            param.Add(new SqlParameter("@all", all));
            var data = sql.ExecuteQuery("sp_GetLopDongThucHanh", param);
            return data;
        }
    }
}
