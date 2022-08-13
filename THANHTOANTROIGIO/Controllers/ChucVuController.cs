using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("chuc-vu")]
    [AuthorizeUser]
    public class ChucVuController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;
        private readonly ChucVuService _chucVuService;

        public ChucVuController(IConfiguration configuration, ThanhToanTroiGioEntities context, ChucVuService chucVuService)
        {
            _configuration = configuration;
            _context = context;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
            _chucVuService = chucVuService;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("ds-chuc-vu")]
        public JsonResult AjaxMethod_ChucVu()
        {
            var data = _chucVuService.getListChucVu();
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("by-ma-gv")]
        public JsonResult AjaxMethod_getChucVuByMaGV(GiangVien model)
        {
            var data = _chucVuService.getChucVuByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themChucVu(ChucVu chucVu)
        {
            try
            {
                var checkMaChucVu = _context.ChucVus.Where(x => x.MaChucVu == chucVu.MaChucVu.Trim()).FirstOrDefault();
                if (checkMaChucVu != null)
                {
                    return Json(new { success = false, message = "pk" });
                }
                var checkTenChucVu = _context.ChucVus.Where(x => x.TenChucVu.ToLower() == chucVu.TenChucVu.ToLower().Trim()).FirstOrDefault();
                if (checkTenChucVu != null)
                {
                    return Json(new { success = false, message = "name" });
                }
                _context.ChucVus.Add(chucVu);
                _context.SaveChanges();
                return Json(new { success = true, data = chucVu });

            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("edit")]
        [HttpPost]
        public JsonResult editChucVu(String maChucVu, ChucVu model)
        {
            try
            {
                if (maChucVu != model.MaChucVu)
                {
                    var checkMaChucVu = _context.ChucVus.Where(x => x.MaChucVu == model.MaChucVu.Trim()).FirstOrDefault();

                    if (checkMaChucVu != null)
                    {
                        return Json(new { success = false, message = "pk" });
                    }
                }

                var checkTenMon = _context.ChucVus.Where(x => x.TenChucVu.ToLower() == model.TenChucVu.ToLower().Trim() && x.MaChucVu != maChucVu.Trim()).FirstOrDefault();
                if (checkTenMon != null)
                {
                    return Json(new { success = false, message = "name" });
                }
                var chucVu = _context.ChucVus.Where(x => x.MaChucVu == maChucVu.Trim()).FirstOrDefault();
                chucVu.TenChucVu = model.TenChucVu.Trim();
                chucVu.DinhMucGiam = model.DinhMucGiam;
                _context.Entry(chucVu).State = EntityState.Modified;
                _context.SaveChanges();
                if (maChucVu != model.MaChucVu.Trim())
                {
                    var x = new SQLHelper(_connectionString).ExecuteString("EXEC [dbo].[updatePK] '" + maChucVu + "','" + model.MaChucVu.Trim() + "','ChucVu'");
                }
                return Json(new { success = true, data = chucVu });


            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteChucVu(String maChucVu)
        {
            try
            {
                var checkPK = _context.ThayDoiChucVus.Where(x => x.MaChucVu == maChucVu.Trim()).FirstOrDefault();
                if (checkPK != null)
                {
                    return Json(new { success = false, message = "Không thể xóa chức vụ vì đã tồn tại giảng viên thuộc chức vụ này!" });
                }
                var chucVu = _context.ChucVus.Where(x => x.MaChucVu == maChucVu.Trim()).FirstOrDefault();
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
