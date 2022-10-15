using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.Services
{
    public class ThucHienNCKHService
    {
        private ThanhToanTroiGioEntities _context;
        public ThucHienNCKHService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getThucHienNCKH(String maKhoa, String maNKHK, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaKhoa", maKhoa));
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            var data= new SQLHelper(connectionString).ExecuteQuery("sp_Get_Thuc_Hien_NCKH", param);
            return data;
        }
        public DataTable getThucHienNCKHHocKy(String maNKHK, String connectionString)
        {
            var data = new SQLHelper(connectionString).ExecuteString("SELECT * FROM ThucHienNCKH WHERE MaNKHK='" + maNKHK + "'");
            return data;
        }
    }
}
