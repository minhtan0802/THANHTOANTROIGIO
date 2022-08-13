using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("mon-hoc")]
    [AuthorizeUser]
    public class MonHocController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly MonHocService _monHocService;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;

        public MonHocController(IConfiguration configuration, MonHocService monHocService, ThanhToanTroiGioEntities context)
        {
            _configuration = configuration;
            _monHocService = monHocService;
            _context = context;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-mon-hoc")]
        [HttpPost]
        public JsonResult getDSMonHoc()
        {
            var data = _monHocService.getDSMonHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("by-ma-mon")]
        [HttpPost]
        public JsonResult getDSMonHocByMaMon(MonHoc model)
        {
            var data = _monHocService.getMonHoc(model.MaMonHoc.Trim());
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themMonHoc(MonHoc monHoc)
        {
            try
            {

                var checkMaMonHoc = _context.MonHocs.Where(x => x.MaMonHoc == monHoc.MaMonHoc.Trim()).FirstOrDefault();
                if (checkMaMonHoc != null)
                {
                    return Json(new { success = false, message = "pk" });
                }
                var checkTenMon = _context.MonHocs.Where(x => x.TenMonHoc == monHoc.TenMonHoc.Trim()).FirstOrDefault();
                if (checkTenMon != null)
                {
                    return Json(new { success = false, message = "name" });
                }
                _context.MonHocs.Add(monHoc);
                _context.SaveChanges();
                return Json(new { success = true, data = monHoc });


            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("edit")]
        [HttpPost]
        public JsonResult editMonHoc(String maMonHoc, MonHoc model)
        {
            try
            {

                if (maMonHoc != model.MaMonHoc)
                {
                    var checkMaMonHoc = _context.MonHocs.Where(x => x.MaMonHoc == model.MaMonHoc.Trim()).FirstOrDefault();

                    if (checkMaMonHoc != null)
                    {
                        return Json(new { success = false, message = "pk" });
                    }
                }

                var checkTenMon = _context.MonHocs.Where(x => x.TenMonHoc == model.TenMonHoc.Trim() && x.MaMonHoc != maMonHoc.Trim()).FirstOrDefault();
                if (checkTenMon != null)
                {
                    return Json(new { success = false, message = "name" });
                }
                var monHoc = _context.MonHocs.Where(x => x.MaMonHoc == maMonHoc.Trim()).FirstOrDefault();
                monHoc.TenMonHoc = model.TenMonHoc.Trim();
                monHoc.TietLT = model.TietLT;
                monHoc.TietBT = model.TietBT;
                monHoc.TietTH = model.TietTH;
                _context.Entry(monHoc).State = EntityState.Modified;
                _context.SaveChanges();
                if (maMonHoc != model.MaMonHoc.Trim())
                {
                    var x = new SQLHelper(_connectionString).ExecuteString("EXEC [dbo].[updatePK] '" + maMonHoc + "','" + model.MaMonHoc.Trim() + "','MonHoc'");
                }
                return Json(new { success = true, data = monHoc });


            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteMonHoc(String maMonHoc)
        {
            try
            {

                var checkPK = _context.LopTinChis.Where(x => x.MaMon == maMonHoc.Trim()).FirstOrDefault();
                if (checkPK != null)
                {
                    return Json(new { success = false, message = "Không thể xóa môn học vì đã tồn tại lớp tín chỉ của môn học này!" });
                }
                var monHon = _context.MonHocs.Where(x => x.MaMonHoc == maMonHoc.Trim()).FirstOrDefault();
                _context.Entry(monHon).State = EntityState.Deleted;
                _context.SaveChanges();
                return Json(new { success = true, message = "Xóa môn học thành công!" });

            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }

        }

    }
}
