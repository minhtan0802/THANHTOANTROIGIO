using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-dong-ly-thuyet")]
    public class LopDongLyThuyetController : Controller
    {
        private readonly LopDongLyThuyetService _lopDongLyThuyetService;
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;

        public LopDongLyThuyetController(LopDongLyThuyetService lopDongLyThuyetService, IConfiguration configuration, ThanhToanTroiGioEntities context)
        {
            _lopDongLyThuyetService = lopDongLyThuyetService;
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
        public JsonResult getHeSoBySiSo(String maKhoa, int siSo)
        {
            float heSo = _lopDongLyThuyetService.getHeSo(maKhoa, siSo);
            return Json(JsonConvert.SerializeObject(heSo));
        }
    }

}
