using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.Services
{
    public class DinhMucGiangService
    {
        private ThanhToanTroiGioEntities _context;
        public DinhMucGiangService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getDinhMucGiang(String maKhoa, String maNKHK, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaKhoa", maKhoa));
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            var data= new SQLHelper(connectionString).ExecuteQuery("sp_Get_Dinh_Muc_Giang", param);
            return data;
        }
        public DataTable getDinhMucGiangHocKy(String maNKHK, String connectionString)
        {
            var data = new SQLHelper(connectionString).ExecuteString("SELECT * FROM DinhMucGiang WHERE MaNKHK='" + maNKHK + "'");
            return data;
        }
    }
}
