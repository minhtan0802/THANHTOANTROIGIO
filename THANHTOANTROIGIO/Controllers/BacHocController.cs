using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("bac-hoc")]
    public class BacHocController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-bac-hoc")]
        [HttpPost]
        public JsonResult getDSBacHoc()
        {
            var data = BacHocDAO.getDSBacHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("he-so")]
        [HttpPost]
        public JsonResult getHeSoBac(BacHoc model)
        {
            var data = BacHocDAO.getHeSoBacHocByMaBacHoc(model.MaBac);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
