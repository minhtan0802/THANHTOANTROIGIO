using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("nguoi-ky")]
    public class NguoiKyController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly NguoiKyService _nguoiKyService;
        private readonly ThanhToanTroiGioEntities _context;

        public NguoiKyController(IConfiguration configuration, NguoiKyService nguoiKyService, ThanhToanTroiGioEntities context)
        {
            _configuration = configuration;
            _nguoiKyService = nguoiKyService;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        [Route("ds")]
        public JsonResult GetDSNguoiKy(int all)
        {
            var data = _nguoiKyService.getDSNguoiKy(all, _configuration.GetConnectionString("DefaultConnection"));
            return Json(JsonConvert.SerializeObject(new {success=true, data=data}));
        }
        [HttpPost]
        [Route("add")]
        public JsonResult ThemNguoiKy(NguoiKy model)
        {
            try
            {
                StringHelper stringHelper = new StringHelper();
                model.HoTen = stringHelper.ChuanHoa(model.HoTen,"up");
                var nkhk = _context.NienKhoaHocKys.Where(x => x.MaNKHK == model.MaNKHK).FirstOrDefault();
                var tenHocKy = nkhk.TenHocKy + "-" + nkhk.TenNienKhoa;
                model.ChucVu = model.ChucVu;
                var checkNguoiKy = _context.NguoiKys.Where(x => x.KyHieu == model.KyHieu && x.MaNKHK==model.MaNKHK).FirstOrDefault();
                if (checkNguoiKy != null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "Đã tồn tại người ký cho chức vụ "+model.ChucVu+" ở "+tenHocKy }));
                }
                _context.NguoiKys.Add(model);
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = model }));
            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lỗi: " + e.InnerException.Message }));
            }

        }

        [HttpPost]
        [Route("edit")]
        public JsonResult ChinhSuaNguoiKy(NguoiKy model)
        {
            try
            {
                NguoiKyViewModel viewModel = new NguoiKyViewModel();
                viewModel.MaChucVu = model.KyHieu;
                StringHelper stringHelper = new StringHelper();
               
                model.HoTen = stringHelper.ChuanHoa(model.HoTen, "up");
                var nkhk = _context.NienKhoaHocKys.Where(x => x.MaNKHK == model.MaNKHK).FirstOrDefault();
                var tenHocKy = nkhk.TenHocKy + "-" + nkhk.TenNienKhoa;
                model.ChucVu = model.ChucVu;
                var checkNguoiKy = _context.NguoiKys.Where(x => x.KyHieu == model.KyHieu && x.MaNKHK == model.MaNKHK && x.id!=model.id).FirstOrDefault();
                if (checkNguoiKy != null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "Đã tồn tại người ký cho chức vụ " + model.ChucVu + " ở " + tenHocKy }));
                }
                checkNguoiKy = _context.NguoiKys.Where(x => x.id==model.id).FirstOrDefault();
                checkNguoiKy.ChucVu=model.ChucVu;
                checkNguoiKy.MaNKHK = model.MaNKHK;
                checkNguoiKy.KyHieu = model.KyHieu;
                checkNguoiKy.HoTen = model.HoTen;

                
                viewModel.id = model.id;
                viewModel.MaNKHK = model.MaNKHK;
                viewModel.NKHK = tenHocKy;
                viewModel.HoTen = model.HoTen;
                viewModel.TenNienKhoa = nkhk.TenNienKhoa;
                viewModel.ChucVu = model.ChucVu;

                _context.Entry(checkNguoiKy).State = EntityState.Modified;
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = viewModel }));
            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lỗi: " + e.InnerException.Message }));
            }

        }

        [Route("delete")]
        [HttpPost]
        public JsonResult xoaNguoiKy(int id)
        {
            var nguoiKy = _context.NguoiKys.Where(x => x.id == id).FirstOrDefault();
            var checkChucVuCount = _context.NguoiKys.Where(x => x.KyHieu == nguoiKy.KyHieu).ToList().Count();
            if (checkChucVuCount == 1)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message="Chỉ còn duy nhất 1 người ký thuộc chức vụ "+nguoiKy.ChucVu+" này trong database nên không thể xóa!" }));
            }
            _context.Entry(nguoiKy).State = EntityState.Deleted;
            _context.SaveChanges();
            return Json(JsonConvert.SerializeObject(new { success = true, data = "" }));
        }
    }
}
