using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("login")]
    public class LoginController : Controller
    {
        public static String MaGV, TenGV;
        [Route("")]
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }
        [Route("validate")]
        [HttpPost]
        public JsonResult Validate(String username, String password)
        {
            if (username == null || username.Trim() == "")
            {
                return Json(new { success = false, message = "Không được để trống username" });
            }
            if (password == null || password.Trim() == "")
            {
                return Json(new { success = false, message = "Không được để trống mật khẩu" });
            }
            try
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
                    catch(Exception ex)
                    {
                        return Json(new { success = false, message = "Mời bạn xem lại username hoặc mật khẩu!" });
                    }

                    ThanhToanTroiGioEntities.connectionString ="Server=LAPTOP-V0HI7R3V\\SERVER;Database=THANHTOANTROIGIO;User Id=" + username + ";Password=" + password + ";";
                    return Json(new { success = true, data = "" });
                }
            }
            catch(Exception e)
            {
                return Json(new { success = false, data = "Lỗi: "+e.InnerException.Message });
            }
        }
        [Route("user")]
        [HttpGet]
        public JsonResult getUser()
        {
            return Json(new { success = true, data = TenGV+"-"+MaGV });
        }
        [Route("ma-gv")]
        [HttpGet]
        public JsonResult getMaGV()
        {
            return Json(new { success = true, data = MaGV });
        }
    }
}
