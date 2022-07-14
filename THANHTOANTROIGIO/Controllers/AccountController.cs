using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    public class AccountController : Controller
    {
        public static String MaGV, TenGV;
        public static String session;
        private AccountService accountService = new AccountServiceImpl();

        public AccountController(AccountService accountService)
        {
            accountService = accountService;
        }

        [Route("login")]
        [HttpGet]
        public IActionResult Index()
        {
            if (!String.IsNullOrEmpty(session))
            {
                return Redirect("/");
            }
            Error.isLogin++;
            return View();
        }
        [Route("login/validate")]
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
            /* try
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
             }*/
            var account=accountService.Login(username,password);
            if (account != null)
            {
                HttpContext.Session.SetString("username", username);
                session = HttpContext.Session.GetString("username");
                MaGV = account.MaGV;
                TenGV = account.TenGV;
                ViewBag.username = username;
                return Json(new { success = true, data = "" });
            }
            else
            {
                ViewBag.username = "";
                return Json(new { success = false, message = "Mời bạn xem lại username hoặc mật khẩu!" });
            }    
        }
        [Route("login/user")]
        [HttpGet]
        public JsonResult getUser()
        {
            return Json(new { success = true, data = TenGV+"-"+MaGV });
        }
        [Route("login/ma-gv")]
        [HttpGet]
        public JsonResult getMaGV()
        {
            return Json(new { success = true, data = MaGV });
        }
        [Route("logout")]
        public ActionResult logout()
        {
            HttpContext.Session.Remove("username");
            session = HttpContext.Session.GetString("username");
            return Redirect("login");
        }
        [Route("is-login")]
        public JsonResult isLogin()
        {
            Console.WriteLine("is Login: " + Error.isLogin);
            return Json(Error.isLogin);
        }
      
    }
}
