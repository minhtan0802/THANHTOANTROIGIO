using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("khoa")]
    public class KhoaController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        [Route("ds-khoa")]
        public JsonResult AjaxMethod_Khoa()
        {
            var data = KhoaDAO.getListKhoa();
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
