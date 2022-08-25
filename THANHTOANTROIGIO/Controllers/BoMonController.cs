using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("bo-mon")]
    [AuthorizeUser]
    public class BoMonController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly BoMonService _boMonService;
        private readonly ThanhToanTroiGioEntities _context;

        public BoMonController(IConfiguration configuration, BoMonService boMonService, ThanhToanTroiGioEntities context)
        {
            _configuration = configuration;
            _boMonService = boMonService;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("ds-bo-mon")]
        public JsonResult AjaxMethod_BoMon(Khoa model)
        {
            var data = _boMonService.getListBoMon(model.MaKhoa);
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("all-bo-mon")]
        public JsonResult AjaxMethod_AllBoMon(BoMon model)
        {
            var data = _boMonService.getAllBoMon(model.MaBoMon);
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("add")]
        public JsonResult themBoMon(BoMon model)
        {
            try
            {
                BoMon boMon = new BoMon();
                boMon = model;

                if (_context.BoMons.Where(x => x.MaBoMon == model.MaBoMon).FirstOrDefault() != null)
                {
                    return Json(new { success = false, message = "pk" });
                }
                if (_context.BoMons.Where(x => x.TenBoMon.ToLower() == model.TenBoMon.ToLower()).FirstOrDefault() != null)
                {
                    return Json(new { success = false, message = "name" });
                }
                _context.BoMons.Add(model);
                _context.SaveChanges();

                return Json(new { success = true, data = boMon });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [HttpPost]
        [Route("edit")]
        public JsonResult chinhSuaBoMon(String maBoMon, BoMon model)
        {
            try
            {

                if (_context.BoMons.Where(x => x.MaBoMon == model.MaBoMon && x.MaBoMon != maBoMon.Trim()).FirstOrDefault() != null)
                {
                    return Json(new { success = false, message = "pk" });
                }
                if (_context.BoMons.Where(x => x.TenBoMon.ToLower() == model.TenBoMon.ToLower() && x.MaBoMon != maBoMon.Trim()).FirstOrDefault() != null)
                {
                    return Json(new { success = false, message = "name" });
                }
                var boMon = _context.BoMons.Where(x => x.MaBoMon == maBoMon.Trim()).FirstOrDefault();
                boMon.TenBoMon = model.TenBoMon;
                boMon.TipDauNguMonHoc = model.TipDauNguMonHoc;
                _context.Entry(boMon).State = EntityState.Modified;
                _context.SaveChanges();
                if (maBoMon.Trim() != model.MaBoMon.Trim())
                {
                    List<SqlParameter> parameters = new List<SqlParameter>();
                    _context.Database.ExecuteSqlRaw("EXEC [dbo].[updatePK] '" + maBoMon + "','" + model.MaBoMon + "','BoMon'", parameters);
                }

                return Json(new { success = true, data = model });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult delete(String maBoMon)
        {

            try
            {
                if (_context.ThayDoiBoMons.Where(x => x.MaBoMon == maBoMon.TrimEnd()).FirstOrDefault() != null)
                {
                    return Json(new { success = false, message = "Xóa bộ môn thất bại vì đã có giảng viên thuộc bộ môn này/ vi phạm khóa ngoại" });
                }
                var boMon = _context.BoMons.FirstOrDefault(s => s.MaBoMon == maBoMon.Trim());
                _context.Entry(boMon).State = EntityState.Deleted;
                _context.SaveChanges();
                return Json(new { success = true, data = "Xóa bộ môn thành công! " });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Xóa bộ môn thất bại vì đã có giảng viên thuộc bộ môn này" });
            }

        }
    }
}
