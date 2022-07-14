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
    [Route("chuc-vu")]
    public class ChucVuController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("ds-chuc-vu")]
        public JsonResult AjaxMethod_ChucVu()
        {
            var data = ChucVuDAO.getListChucVu();
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpPost]
        [Route("by-ma-gv")]
        public JsonResult AjaxMethod_getChucVuByMaGV(GiangVien model)
        {
            var data = ChucVuDAO.getChucVuByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themChucVu(ChucVu chucVu)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var checkMaChucVu = context.ChucVus.Where(x => x.MaChucVu == chucVu.MaChucVu.Trim()).FirstOrDefault();
                    if (checkMaChucVu != null)
                    {
                        return Json(new { success = false, message = "pk" });
                    }
                    var checkTenChucVu = context.ChucVus.Where(x => x.TenChucVu.ToLower() == chucVu.TenChucVu.ToLower().Trim()).FirstOrDefault();
                    if (checkTenChucVu != null)
                    {
                        return Json(new { success = false, message = "name" });
                    }
                    context.ChucVus.Add(chucVu);
                    context.SaveChanges();
                    return Json(new { success = true, data = chucVu });
                }
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
                using (var context = new ThanhToanTroiGioEntities())
                {
                    if (maChucVu != model.MaChucVu)
                    {
                        var checkMaChucVu = context.ChucVus.Where(x => x.MaChucVu == model.MaChucVu.Trim()).FirstOrDefault();

                        if (checkMaChucVu != null)
                        {
                            return Json(new { success = false, message = "pk" });
                        }
                    }

                    var checkTenMon = context.ChucVus.Where(x => x.TenChucVu.ToLower() == model.TenChucVu.ToLower().Trim() && x.MaChucVu != maChucVu.Trim()).FirstOrDefault();
                    if (checkTenMon != null)
                    {
                        return Json(new { success = false, message = "name" });
                    }
                    var chucVu = context.ChucVus.Where(x => x.MaChucVu == maChucVu.Trim()).FirstOrDefault();
                    chucVu.TenChucVu = model.TenChucVu.Trim();
                    chucVu.DinhMucGiam = model.DinhMucGiam;
                    context.Entry(chucVu).State = EntityState.Modified;
                    context.SaveChanges();
                    if (maChucVu != model.MaChucVu.Trim())
                    {
                        var x = new SQLHelper().ExecuteString("EXEC [dbo].[updatePK] '" + maChucVu + "','" + model.MaChucVu.Trim() + "','ChucVu'");
                    }
                    return Json(new { success = true, data = chucVu });

                }
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
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var checkPK = context.ThayDoiChucVus.Where(x => x.MaChucVu == maChucVu.Trim()).FirstOrDefault();
                    if (checkPK != null)
                    {
                        return Json(new { success = false, message = "Không thể xóa chức vụ vì đã tồn tại giảng viên thuộc chức vụ này!" });
                    }
                    var chucVu = context.ChucVus.Where(x => x.MaChucVu == maChucVu.Trim()).FirstOrDefault();
                    context.Entry(chucVu).State = EntityState.Deleted;
                    context.SaveChanges();
                    return Json(new { success = true, data = "Xóa chức vụ thành công!" });
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }

        }
    }
}
