using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("chuc-vu")]
    public class ChucVuController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("ds-chuc-vu")]
        public JsonResult AjaxMethod_ChucVu()
        {
            var data =ChucVuDAO.getListChucVu();
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("by-ma-gv")]
        public JsonResult AjaxMethod_getChucVuByMaGV(GiangVien model)
        {
            var data = ChucVuDAO.getChucVuByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
