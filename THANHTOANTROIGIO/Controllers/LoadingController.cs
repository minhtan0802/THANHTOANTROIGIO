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
        [Route("thuc-tap-tot-nghiep")]
        [HttpGet]
        public JsonResult getLoadingTTTN()
        {
            Loading.flagTTTN++;
            return Json(JsonConvert.SerializeObject(Loading.flagTTTN));
        }
        [Route("thuc-tap-tot-nghiep/import")]
        [HttpGet]
        public JsonResult getLoadingTTTNImport()
        {
            Loading.flagTTTNImport++;
            return Json(JsonConvert.SerializeObject(Loading.flagTTTNImport));
        }
    }
}
