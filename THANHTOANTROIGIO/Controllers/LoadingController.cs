using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("loading")]
    public class LoadingController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [Route("giang-vien")]
        public JsonResult getLoadingGiangVien()
        {
            Loading.flagGiangVien++;
            return Json(JsonConvert.SerializeObject(Loading.flagGiangVien));
        }
        [Route("lop-tin-chi")]
        public JsonResult getLoadingLTC()
        {
            Loading.flagLTC++;
            return Json(JsonConvert.SerializeObject(Loading.flagLTC));
        }
        [Route("bo-mon")]
        public JsonResult getLoadingBoMon()
        {
            Loading.flagBoMon++;
            return Json(JsonConvert.SerializeObject(Loading.flagBoMon));
        }
    }
}
