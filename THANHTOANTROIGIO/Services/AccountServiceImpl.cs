using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class AccountServiceImpl : AccountService
    {
        public static String MaGV, TenGV;
        public Account Login(string username, string password)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                context.Database.GetDbConnection().ConnectionString = "Server=LAPTOP-V0HI7R3V\\SERVER;Database=THANHTOANTROIGIO;User Id=" + username + ";Password=" + password + ";";
                try
                {
                    context.Database.OpenConnection();
                    List<SqlParameter> param = new List<SqlParameter>();
                    param.Add(new SqlParameter("@TENLOGIN", username));
                    var dataTable = new SQLHelper().ExecuteQuery("sp_DangNhap", param);
                    MaGV = dataTable.Rows[0][0].ToString();
                    TenGV = dataTable.Rows[0][1].ToString();
                }
                catch (Exception ex)
                {
                    return null;
                }

                ThanhToanTroiGioEntities.connectionString = "Server=LAPTOP-V0HI7R3V\\SERVER;Database=THANHTOANTROIGIO;User Id=" + username + ";Password=" + password + ";";
                return new Account(username, "",MaGV,TenGV);
            }

        }
    }
}
