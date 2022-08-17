using Microsoft.AspNetCore.Mvc;
using THANHTOANTROIGIO.Report;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("report")]
    [AuthorizeUser]
    public class ReportController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ReportService _reportService;
        private readonly AuthService _authService;
        public ReportController(IConfiguration configuration, ReportService reportService, AuthService authService)
        {
            _configuration = configuration;
            _reportService = reportService;
            _authService = authService;
        }
        [Route("khoi-luong-giang")]
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }
        [Route("khoi-luong-giang")]
        [HttpPost]
        public IActionResult ReportKhoiLuongGiang(string hocKy)
        {
            var user = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user"));
            var report = new Report_KL_GiangDay(_configuration.GetConnectionString("DefaultConnection"),_configuration.GetConnectionString("ReportConnection"), hocKy,_reportService);
            ViewBag.Report = report;
            return View("Index1");
        }

        [Route("thanh-toan-gio-giang")]
        [HttpGet]
        public IActionResult ThanhToanGioGiang()
        {
            return View();
        }
        [Route("thanh-toan-gio-giang")]
        [HttpPost]
        public IActionResult ReportThanhToanGioGiang(string hocKy)
        {
            var user = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user"));
            var report = new Report_ThanhToanGioGiang(_configuration.GetConnectionString("DefaultConnection"), _configuration.GetConnectionString("ReportConnection"), hocKy, _reportService);
            ViewBag.Report = report;
            return View("Report_ThanhToanGioGiang");
        }
    }
}
