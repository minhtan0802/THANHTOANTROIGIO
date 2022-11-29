using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("khoa")]
    [AuthorizeUser]
    public class KhoaController :Controller
    {
        private readonly KhoaService _khoaService;
        private readonly IConfiguration _iconfiguration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;
        public KhoaController(KhoaService khoaService, ThanhToanTroiGioEntities context,IConfiguration iconfiguration, AuthService authService)
        {
            _khoaService = khoaService;
            _iconfiguration = iconfiguration;
            _context = context;
            _connectionString = iconfiguration.GetConnectionString("DefaultConnection");
        }
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        [Route("ds-khoa")]
        public JsonResult AjaxMethod_Khoa()
        {
            var data = _khoaService.getListKhoa();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themKhoa(Khoa khoa)
        {
            try
            {
                StringHelper stringHelper = new StringHelper();
                khoa.MaKhoa = stringHelper.ChuanHoa(khoa.MaKhoa, "up");
                khoa.TenKhoa = stringHelper.ChuanHoa(khoa.TenKhoa);
                var checkMaKhoa = _context.Khoas.Where(x => x.MaKhoa == khoa.MaKhoa.Trim()).FirstOrDefault();
                if (checkMaKhoa != null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "pk" }));
                }
                var checkTenKhoa = _context.Khoas.Where(x => x.TenKhoa.ToLower() == khoa.TenKhoa.ToLower().Trim()).FirstOrDefault();
                if (checkTenKhoa != null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "name" }));
                }
                _context.Khoas.Add(khoa);
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = khoa }));

            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lỗi: " + e.InnerException.Message }));
            }
        }

        [Route("edit")]
        [HttpPost]
        public JsonResult editKhoa(String maKhoa, Khoa model)
        {
            try
            {
                StringHelper stringHelper = new StringHelper();
                model.MaKhoa = stringHelper.ChuanHoa(model.MaKhoa, "up");
                model.TenKhoa = stringHelper.ChuanHoa(model.TenKhoa);
                if (maKhoa != model.MaKhoa)
                {
                    var checkMaKhoa = _context.Khoas.Where(x => x.MaKhoa == model.MaKhoa.Trim()).FirstOrDefault();

                    if (checkMaKhoa != null)
                    {
                        return Json(JsonConvert.SerializeObject(new { success = false, message = "pk" }));
                    }
                }

                var checkTenMon = _context.Khoas.Where(x => x.TenKhoa.ToLower() == model.TenKhoa.ToLower().Trim() && x.MaKhoa != maKhoa.Trim()).FirstOrDefault();
                if (checkTenMon != null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "name" }));
                }
                var khoa = _context.Khoas.Where(x => x.MaKhoa == maKhoa.Trim()).FirstOrDefault();
                khoa.TenKhoa = model.TenKhoa.Trim();
                _context.Entry(khoa).State = EntityState.Modified;
                _context.SaveChanges();
                if (maKhoa != model.MaKhoa.Trim())
                {
                    var x = new SQLHelper(_connectionString).ExecuteString("EXEC [dbo].[updatePK] '" + maKhoa + "','" + model.MaKhoa.Trim() + "','Khoa'");
                }
                return Json(JsonConvert.SerializeObject(new { success = true, data = model }));


            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lỗi: " + e.InnerException.Message }));
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteKhoa(String maKhoa)
        {
            try
            {
                var checkPK = _context.BoMons.Where(x => x.MaKhoa == maKhoa.Trim()).FirstOrDefault();
                if (checkPK != null)
                {
                    return Json(new { success = false, message = "Không thể xóa khoa vì đã tồn tại bộ môn thuộc khoa này!" });
                }
                var chucVu = _context.Khoas.Where(x => x.MaKhoa == maKhoa.Trim()).FirstOrDefault();
                _context.Entry(chucVu).State = EntityState.Deleted;
                _context.SaveChanges();
                return Json(new { success = true, data = "Xóa chức vụ thành công!" });

            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }

        }
    }
}
