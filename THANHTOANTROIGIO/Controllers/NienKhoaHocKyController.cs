using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{

    [Route("nien-khoa-hoc-ky")]
    [AuthorizeUser]
    public class NienKhoaHocKyController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly NienKhoaHocKyService _nienKhoaHocKyService;
        public NienKhoaHocKyController(IConfiguration configuration, NienKhoaHocKyService nienKhoaHocKyService,AuthService authService)
        {
            _configuration = configuration;
            _nienKhoaHocKyService = nienKhoaHocKyService;
        }

        public IActionResult Index()
        {
            return View();
        }
        [Route("nien-khoa")]
        [HttpGet]
        public JsonResult getNienKhoa()
        {
            var listNK = _nienKhoaHocKyService.getNienKhoa();
            return Json(JsonConvert.SerializeObject(listNK));
        }
        [Route("hoc-ky")]
        [HttpPost]
        public JsonResult getHocKy(NienKhoaHocKy model)
        {
            var listNK = _nienKhoaHocKyService.getHocKy(model.TenNienKhoa);
            return Json(JsonConvert.SerializeObject(listNK));
        }
    }
}
