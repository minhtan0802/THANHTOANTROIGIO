using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.Services
{
    public class DinhMucNCKHService
    {
        private ThanhToanTroiGioEntities _context;
        public DinhMucNCKHService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getDinhMucNCKH(String maKhoa, String maNKHK, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaKhoa", maKhoa));
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            var data= new SQLHelper(connectionString).ExecuteQuery("sp_Get_Dinh_Muc_NCKH", param);
            return data;
        }
        public DataTable getDinhMucNCKHHocKy(String maNKHK, String connectionString)
        {
            var data = new SQLHelper(connectionString).ExecuteString("SELECT * FROM DinhMucNCKH WHERE MaNKHK='" + maNKHK + "'");
            return data;
        }
    }
}
