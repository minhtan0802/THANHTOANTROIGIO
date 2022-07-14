using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    [Route("lop-dong-ly-thuyet")]
    public class LopDongLyThuyetController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("he-so")]
        [HttpGet]
        public JsonResult getHeSoBySiSo(String maKhoa, int siSo)
        {
            float heSo = LopDongLyThuyetDAO.getHeSo(maKhoa, siSo);
            return Json(JsonConvert.SerializeObject(heSo));
        }
    }

}
