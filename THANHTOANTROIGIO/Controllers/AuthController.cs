using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    public class AuthController : Controller
    {
        private readonly AuthSettings _authSettings;
        private readonly IConfiguration _configuration;
        private readonly ILoginService _loginService;
        private readonly AuthService _authService;
        public AuthController(IOptions<AuthSettings> authSettings, IConfiguration configuration, ILoginService loginService,AuthService authService)
        {
            _authSettings = authSettings.Value;
            _loginService = loginService;
            _configuration = configuration;
            _authService = authService;
        }
        [Route("login")]
        [AllowAnonymous]
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("login/validate")]
        public JsonResult Login(String username, String password)
        {
            if (username == null || username.Trim() == "")
            {
                return Json(new { success = false, message = "Không được để trống username" });
            }
            if (password == null || password.Trim() == "")
            {
                return Json(new { success = false, message = "Không được để trống mật khẩu" });
            }
            var account = _loginService.Login(username, password, _configuration.GetConnectionString("DefaultConnection"));
            if (account != null)
            {
                var token = _authService.SaveAuthUser(_authSettings.AuthSecret, account.user, account.id);
                HttpContext.Session.SetString("user",token);
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
            var token = HttpContext.Session.GetString("user");
            var gv = _authService.GetCurrentAuthUser(token);
            var tenGV = gv.Name;
            var maGV = gv.MaGiangVien;
            return Json(new { success = true, data = tenGV + "-" + maGV });
        }
        [Route("logout")]
        public ActionResult logout()
        {
            HttpContext.Session.Remove("user");
            return Redirect("login");
        }
    }
}
