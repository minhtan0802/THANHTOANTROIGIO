using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    [Route("hoc-vi")]
    public class HocViController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [Route("ds-hoc-vi")]
        public JsonResult AjaxMethod_HocVi()
        {
            var data = HocViDAO.getListHocVi();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("by-ma-gv")]
        public JsonResult AjaxMethod_getHocViByMaGV(GiangVien model)
        {
            var data = HocViDAO.getMaHocViByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
