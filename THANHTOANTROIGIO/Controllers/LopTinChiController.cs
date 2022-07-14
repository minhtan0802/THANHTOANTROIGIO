using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    [Route("lop-tin-chi")]
    public class LopTinChiController : Controller
    {
        [Route("")]
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }
        [Route("import")]
        [HttpGet]
        public IActionResult IndexImport()
        {
            return View();
        }
        [Route("")]
        [HttpPost]
        public JsonResult getLTC(LTCGetModel model)
        {
            var data = LopTinChiDAO.getListLTC(model.MaNKHK, model.MaGV);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("ma-ltc")]
        [HttpPost]
        public JsonResult getLTCByMaLTC(int maLTC)
        {
            var data = LopTinChiDAO.getLTC(maLTC);
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("don-gia")]
        [HttpGet]
        public JsonResult getDonGiaGV(String maHocVi, String maGV, String tenMon)
        {
            var data = LopTinChiDAO.getDonGia(maHocVi.Trim(), maGV.Trim(), tenMon.Trim());
            return Json(new { success = true, data = data });
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themLTC(LopTinChi model)
        {
            LopTinChi ltc = new LopTinChi();
            ltc = model;
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    context.LopTinChis.Add(model);
                    context.SaveChanges();
                } 
                return Json(new { success = true, data = model });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Thêm lớp tín chỉ thất bại!" + ex.InnerException.Message
                });
            }
        }

        [Route("edit")]
        [HttpPost]
        public JsonResult editLTC(LopTinChi model)
        {
            LopTinChi ltc = new LopTinChi();
            ltc = model;
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    context.Entry(ltc).State= EntityState.Modified;
                    context.SaveChanges();
                }

                return Json(new { success = true, data = model });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Chỉnh sửa lớp tín chỉ thất bại!" + ex.InnerException.Message
                });
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult delete(int maLTC)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                try
                {
                    var ltc = context.LopTinChis.FirstOrDefault(s => s.MaLTC ==maLTC);
                    context.Entry(ltc).State = EntityState.Deleted;
                    context.SaveChanges();
                    return Json(new { success = true, data = "Xóa lớp tín chỉ thành công! " });
                }
                catch (Exception ex)
                {
                    return Json(new { success = false, message = "Xóa lớp tín chỉ thất bại vì vi phạm khóa ngoại" });
                }

            }
        }

    }
}
