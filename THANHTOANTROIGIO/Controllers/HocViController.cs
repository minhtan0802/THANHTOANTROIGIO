using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("hoc-vi")]
    [AuthorizeUser]
    public class HocViController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;
        private readonly HocViService _hocViService;

        public HocViController(IConfiguration configuration, ThanhToanTroiGioEntities context, HocViService hocViService)
        {
            _configuration = configuration;
            _context = context;
            _hocViService = hocViService;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [Route("ds-hoc-vi")]
        public JsonResult AjaxMethod_HocVi()
        {
            var data = _hocViService.getListHocVi();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("by-ma-gv")]
        public JsonResult AjaxMethod_getHocViByMaGV(GiangVien model)
        {
            var data = _hocViService.getMaHocViByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
