using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-dong-thuc-hanh")]
    public class LopDongThucHanhController : Controller
    {
        private readonly LopDongThucHanhService _lopDongThucHanhService;
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;

        public LopDongThucHanhController(LopDongThucHanhService lopDongThucHanhService, IConfiguration configuration, ThanhToanTroiGioEntities context)
        {
            _lopDongThucHanhService = lopDongThucHanhService;
            _configuration = configuration;
            _context = context;
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("he-so")]
        [HttpGet]
        public JsonResult getHeSoThucHanhBySiSo(String maKhoa, int siSo)
        {
            float heSo = _lopDongThucHanhService.getHeSo(maKhoa, siSo);
            return Json(JsonConvert.SerializeObject(heSo));
        }
    }
}
