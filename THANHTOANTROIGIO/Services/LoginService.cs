using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Models.Cache;

namespace THANHTOANTROIGIO.Services
{
    public class LoginService : ILoginService
    {
        private ThanhToanTroiGioEntities _context;
        public LoginService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public Account Login(string username, string password, string connectionString)
        {
            int id = 0;
            String MaGV = "";
            
            _context.Database.GetDbConnection().ConnectionString = "Server=LAPTOP-V0HI7R3V\\SERVER;Database=THANHTOANTROIGIO;User Id=" + username + ";Password=" + password + ";";
            try
            {
                _context.Database.OpenConnection();
                List<SqlParameter> param = new List<SqlParameter>();
                param.Add(new SqlParameter("@TENLOGIN", username));
                var dataTable = new SQLHelper(connectionString).ExecuteQuery("sp_DangNhap", param);
                MaGV = dataTable.Rows[0][0].ToString();
                id = int.Parse(dataTable.Rows[0][2].ToString());
                var gv = _context.GiangViens.Where(x => x.MaGiangVien == MaGV).FirstOrDefault();
                return new Account(id, username,"",gv);
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
