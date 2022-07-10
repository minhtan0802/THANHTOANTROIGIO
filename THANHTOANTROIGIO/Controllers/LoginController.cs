using Microsoft.AspNetCore.Mvc;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("login")]
    public class LoginController : Controller
    {
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
            return Json(new { success = true, data = "" });

        }
    }
}
