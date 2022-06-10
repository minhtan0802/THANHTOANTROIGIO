using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("bo-mon")]
    public class BoMonController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("ds-bo-mon")]
        public JsonResult AjaxMethod_BoMon(Khoa model)
        {
            var data = BoMonDAO.getListBoMon(model.MaKhoa);
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("all-bo-mon")]
        public JsonResult AjaxMethod_AllBoMon(BoMon model)
        {
            var data = BoMonDAO.getAllBoMon(model.MaBoMon);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
