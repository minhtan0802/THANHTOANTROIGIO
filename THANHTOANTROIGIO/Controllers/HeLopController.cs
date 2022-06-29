using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("he-lop")]
    public class HeLopController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-he-lop")]
        [HttpPost]
        public JsonResult getDSHeLop()
        {
            var data = HeLopDAO.getDSHeLop();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("he-so")]
        [HttpPost]
        public JsonResult getHeSoHeLop(HeLop model)
        {
            var data = HeLopDAO.getHeSoHeLopByMaHeLop(model.MaHeLop);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
