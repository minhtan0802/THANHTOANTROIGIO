using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;

namespace THANHTOANTROIGIO.Controllers
{
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
