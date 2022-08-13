using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{

    [Route("he-lop")]
    [AuthorizeUser]
    public class HeLopController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly HeLopService _heLopService;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;

        public HeLopController(IConfiguration configuration, HeLopService heLopService, ThanhToanTroiGioEntities context)
        {
            _configuration = configuration;
            _heLopService = heLopService;
            _context = context;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-he-lop")]
        [HttpPost]
        public JsonResult getDSHeLop()
        {
            var data = _heLopService.getDSHeLop();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("he-so")]
        [HttpPost]
        public JsonResult getHeSoHeLop(HeLop model)
        {
            var data = _heLopService.getHeSoHeLopByMaHeLop(model.MaHeLop);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
