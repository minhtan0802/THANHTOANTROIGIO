using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("bo-mon")]
    public class BoMonController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("ds-bo-mon")]
        public JsonResult AjaxMethod_BoMon(Khoa model)
        {
            var data = BoMonDAO.getListBoMon(model.MaKhoa);
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("all-bo-mon")]
        public JsonResult AjaxMethod_AllBoMon(BoMon model)
        {
            var data = BoMonDAO.getAllBoMon(model.MaBoMon);
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
                using (var context = new ThanhToanTroiGioEntities())
                {
                    if (context.BoMons.Where(x => x.MaBoMon == model.MaBoMon).FirstOrDefault() != null)
                    {
                        return Json(new { success = false, message = "pk" });
                    }
                    if (context.BoMons.Where(x => x.TenBoMon.ToLower() == model.TenBoMon.ToLower()).FirstOrDefault() != null)
                    {
                        return Json(new { success = false, message = "name" });
                    }
                    context.BoMons.Add(model);
                    context.SaveChanges();
                }
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
                using (var context = new ThanhToanTroiGioEntities())
                {
                    if (context.BoMons.Where(x => x.MaBoMon == model.MaBoMon && x.MaBoMon != maBoMon.Trim()).FirstOrDefault() != null)
                    {
                        return Json(new { success = false, message = "pk" });
                    }
                    if (context.BoMons.Where(x => x.TenBoMon.ToLower() == model.TenBoMon.ToLower() && x.MaBoMon != maBoMon.Trim()).FirstOrDefault() != null)
                    {
                        return Json(new { success = false, message = "name" });
                    }
                    var boMon = context.BoMons.Where(x => x.MaBoMon == maBoMon.Trim()).FirstOrDefault();
                    boMon.TenBoMon = model.TenBoMon;
                    context.Entry(boMon).State = EntityState.Modified;
                    context.SaveChanges();
                    if (maBoMon.Trim() != model.MaBoMon.Trim())
                    {
                        List<SqlParameter> parameters = new List<SqlParameter>();
                        context.Database.ExecuteSqlRaw("EXEC [dbo].[updatePK] '" + maBoMon + "','" + model.MaBoMon + "','BoMon'", parameters);
                    }
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
            using (var context = new ThanhToanTroiGioEntities())
            {
                try
                {
                    if (context.ThayDoiBoMons.Where(x => x.MaBoMon == maBoMon.TrimEnd()).FirstOrDefault() != null)
                    {
                        return Json(new { success = false, message = "Xóa bộ môn thất bại vì vi phạm khóa ngoại" });
                    }
                    var boMon = context.BoMons.FirstOrDefault(s => s.MaBoMon == maBoMon.Trim());
                    context.Entry(boMon).State = EntityState.Deleted;
                    context.SaveChanges();
                    return Json(new { success = true, data = "Xóa bộ môn thành công! " });
                }
                catch (Exception ex)
                {
                    return Json(new { success = false, message = "Xóa bộ môn thất bại vì vi phạm khóa ngoại" });
                }

            }
        }
    }
}
