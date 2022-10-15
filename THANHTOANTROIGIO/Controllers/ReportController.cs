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
            string hocKyTruoc = "";
            if(int.Parse(hocKy) % 2 == 0)
            {
                hocKyTruoc = int.Parse(hocKy) - 1 + "";
            } 
            else
            {
                hocKyTruoc = int.Parse(hocKy.Substring(0, 4))-1 + "2";
            }
            if (int.Parse(hocKy) % 2 == 0)
            {
                var report = new Report_ThanhToanGioGiang(_configuration.GetConnectionString("DefaultConnection"), _configuration.GetConnectionString("ReportConnection"), hocKy,hocKyTruoc, _reportService);
                ViewBag.Report = report;
                return View("Report_ThanhToanGioGiang");
            }
            else
            {
                var report = new Report_ThanhToanGioGiang_HK1(_configuration.GetConnectionString("DefaultConnection"), _configuration.GetConnectionString("ReportConnection"), hocKy, hocKyTruoc, _reportService);
                ViewBag.Report = report;
                return View("Report_ThanhToanGioGiang");
            }    
           
        }

        [Route("thuc-tap-tot-nghiep")]
        [HttpGet]
        public IActionResult ThucTapTotNghiep()
        {
            return View();
        }
        [Route("thuc-tap-tot-nghiep")]
        [HttpPost]
        public IActionResult ReportTTTN(string hocKy)
        {
            var user = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user"));
            var report = new Report_KL_TTTN(_configuration.GetConnectionString("DefaultConnection"), _configuration.GetConnectionString("ReportConnection"), hocKy, _reportService);
            ViewBag.Report = report;
            return View("Index1");
        }
        [Route("dinh-muc")]
        [HttpGet]
        public IActionResult DinhMuc()
        {
            return View();
        }
        [Route("dinh-muc")]
        [HttpPost]
        public IActionResult ReportDinhMuc(string hocKy)
        {
            var user = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user"));
            var report = new Report_DinhMuc(_configuration.GetConnectionString("DefaultConnection"), _configuration.GetConnectionString("ReportConnection"), hocKy, _reportService);
            ViewBag.Report = report;
            return View("Index1");
        }

    }
}
