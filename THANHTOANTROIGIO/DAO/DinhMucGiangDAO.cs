using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.DAO
{
    public class DinhMucGiangDAO
    {
        public static DataTable getDinhMucGiang(String maKhoa, String maNKHK)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaKhoa", maKhoa));
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            var data = new SQLHelper().ExecuteQuery("sp_Get_Dinh_Muc_Giang",param);
            return data;
        }
    }
}
