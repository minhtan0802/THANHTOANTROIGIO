using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-dong-thuc-hanh")]
    public class LopDongThucHanhController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("he-so")]
        [HttpGet]
        public JsonResult getHeSoThucHanhBySiSo(String maKhoa, int siSo)
        {
            float heSo = LopDongLyThuyetDAO.getHeSo(maKhoa, siSo);
            return Json(JsonConvert.SerializeObject(heSo));
        }
    }
}
