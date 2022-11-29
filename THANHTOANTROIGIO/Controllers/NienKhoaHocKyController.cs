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
        [Route("ds")]
        [HttpGet]
        public JsonResult getDSNienKhoa()
        {
            var listNK = _nienKhoaHocKyService.GetDSNKHK();
            return Json(JsonConvert.SerializeObject(new { sucess = true, data = listNK }));
        }

        [Route("hoc-ky")]
        [HttpPost]
        public JsonResult getHocKy(NienKhoaHocKy model)
        {
            var listNK = _nienKhoaHocKyService.getHocKy(model.TenNienKhoa);
            return Json(JsonConvert.SerializeObject(listNK));
        }
        [Route("goi-y")]
        [HttpGet]
        public JsonResult GoiYNKHK()
        {
            var data = _nienKhoaHocKyService.GoiYNKHK();
            if (data == null)
            {
                return Json(JsonConvert.SerializeObject(new { TenNienKhoa = "", TenHocKy = "" }));
            }
            else
            {
                var hocKy = int.Parse(data.MaNKHK) % 2 == 0 ? 2 : 1;
                var tenHocKy = hocKy == 1 ? 2 : 1;
                var tenNienKhoa = hocKy == 1 ? data.TenNienKhoa: data.TenNienKhoa.Split('-')[1].Trim()+"-"+(int.Parse(data.TenNienKhoa.Split('-')[1])+1)+"";
                return Json(JsonConvert.SerializeObject(new { TenNienKhoa =tenNienKhoa, HocKy = tenHocKy }));
            }    
        }
    }
}
