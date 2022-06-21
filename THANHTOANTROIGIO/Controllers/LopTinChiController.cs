using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-tin-chi")]
    public class LopTinChiController : Controller
    {
        [Route("")]
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }
        [Route("")]
        [HttpPost]
        public JsonResult getLTC(LTCGetModel model)
        {
            var data = LopTinChiDAO.getListLTC(model.MaNKHK, model.MaGV);
            return Json(JsonConvert.SerializeObject(data));
        }
        
    }
}
