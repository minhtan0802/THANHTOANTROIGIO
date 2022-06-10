using Microsoft.AspNetCore.Mvc;
using THANHTOANTROIGIO.DAO;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-tin-chi")]
    public class LopTinChiController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        
    }
}
