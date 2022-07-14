using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    [Route("mon-hoc")]
    public class MonHocController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-mon-hoc")]
        [HttpPost]
        public JsonResult getDSMonHoc()
        {
            var data = MonHocDAO.getDSMonHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("by-ma-mon")]
        [HttpPost]
        public JsonResult getDSMonHocByMaMon(MonHoc model)
        {
            var data = MonHocDAO.getMonHoc(model.MaMonHoc.Trim());
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themMonHoc(MonHoc monHoc)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var checkMaMonHoc = context.MonHocs.Where(x => x.MaMonHoc == monHoc.MaMonHoc.Trim()).FirstOrDefault();
                    if (checkMaMonHoc != null)
                    {
                        return Json(new { success = false, message = "pk" });
                    }
                    var checkTenMon = context.MonHocs.Where(x => x.TenMonHoc == monHoc.TenMonHoc.Trim()).FirstOrDefault();
                    if (checkTenMon != null)
                    {
                        return Json(new { success = false, message = "name" });
                    }
                    context.MonHocs.Add(monHoc);
                    context.SaveChanges();
                    return Json(new { success = true, data = monHoc });

                }
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
                using (var context = new ThanhToanTroiGioEntities())
                {
                    if (maMonHoc != model.MaMonHoc)
                    {
                        var checkMaMonHoc = context.MonHocs.Where(x => x.MaMonHoc == model.MaMonHoc.Trim()).FirstOrDefault();

                        if (checkMaMonHoc != null)
                        {
                            return Json(new { success = false, message = "pk" });
                        }
                    }

                    var checkTenMon = context.MonHocs.Where(x => x.TenMonHoc == model.TenMonHoc.Trim() && x.MaMonHoc != maMonHoc.Trim()).FirstOrDefault();
                    if (checkTenMon != null)
                    {
                        return Json(new { success = false, message = "name" });
                    }
                    var monHoc = context.MonHocs.Where(x => x.MaMonHoc == maMonHoc.Trim()).FirstOrDefault();
                    monHoc.TenMonHoc = model.TenMonHoc.Trim();
                    monHoc.TietLT = model.TietLT;
                    monHoc.TietBT = model.TietBT;
                    monHoc.TietTH = model.TietTH;
                    context.Entry(monHoc).State = EntityState.Modified;
                    context.SaveChanges();
                    if (maMonHoc != model.MaMonHoc.Trim())
                    {
                        var x = new SQLHelper().ExecuteString("EXEC [dbo].[updatePK] '" + maMonHoc + "','" + model.MaMonHoc.Trim() + "','MonHoc'");
                    }
                    return Json(new { success = true, data = monHoc });

                }
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
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var checkPK = context.LopTinChis.Where(x => x.MaMon == maMonHoc.Trim()).FirstOrDefault();
                    if (checkPK != null)
                    {
                        return Json(new { success = false, message = "Không thể xóa môn học vì đã tồn tại lớp tín chỉ của môn học này!" });
                    }
                    var monHon = context.MonHocs.Where(x => x.MaMonHoc == maMonHoc.Trim()).FirstOrDefault();
                    context.Entry(monHon).State = EntityState.Deleted;
                    context.SaveChanges();
                    return Json(new { success = true, message = "Xóa môn học thành công!" });
                }
            }
            catch(Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
   
        }

    }
}
