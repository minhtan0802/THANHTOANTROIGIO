using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("nien-khoa-hoc-ky")]
    public class NienKhoaHocKyController : Controller
    {

        public IActionResult Index()
        {
            return View();
        }
        [Route("nien-khoa")]
        [HttpGet]
        public JsonResult getNienKhoa()
        {
            var listNK = NienKhoaHocKyDAO.getNienKhoa();
            return Json(JsonConvert.SerializeObject(listNK));
        }
        [Route("hoc-ky")]
        [HttpPost]
        public JsonResult getHocKy(NienKhoaHocKy model)
        {
            var listNK = NienKhoaHocKyDAO.getHocKy(model.TenNienKhoa);
            return Json(JsonConvert.SerializeObject(listNK));
        }
    }
}
