using Microsoft.AspNetCore.Mvc;
using THANHTOANTROIGIO.Report;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("report")]
    public class ReportController : Controller
    {
        private readonly IConfiguration _configuration;
        public ReportController(IConfiguration configuration)
        {
            _configuration = configuration;
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
            var report = new Report_KL_GiangDay(_configuration.GetConnectionString("DefaultConnection").ToString(), hocKy);
            ViewBag.Report = report;
            return View("Index1");
        }

    }
}
