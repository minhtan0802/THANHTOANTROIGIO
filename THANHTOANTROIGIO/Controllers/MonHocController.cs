using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
namespace THANHTOANTROIGIO.Controllers
{
    [Route("mon-hoc")]
    public class MonHocController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-mon-hoc")]
        [HttpPost]
        public JsonResult getDSMonHoc()
        {
            var data = MonHocDAO.getDSMonHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
