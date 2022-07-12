using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("bac-hoc")]
    public class BacHocController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-bac-hoc")]
        [HttpPost]
        public JsonResult getDSBacHoc()
        {
            var data = BacHocDAO.getDSBacHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("ds-bac-hoc-full")]
        [HttpPost]
        public JsonResult getDSBacHocFull()
        {
            var data = BacHocDAO.getDSBacHocFull();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("he-so")]
        [HttpPost]
        public JsonResult getHeSoBac(BacHoc model)
        {
            var data = BacHocDAO.getHeSoBacHocByMaBacHoc(model.MaBac);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themBacHoc(BacHoc bacHoc, float heSo)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    using (var transaction = context.Database.BeginTransaction())
                    {
                        try
                        {
                            var checkMaBacHoc = context.BacHocs.Where(x => x.MaBac == bacHoc.MaBac.Trim()).FirstOrDefault();
                            if (checkMaBacHoc != null)
                            {
                                return Json(new { success = false, message = "pk" });
                            }
                            var checkTenBacHoc = context.BacHocs.Where(x => x.TenBac.ToLower() == bacHoc.TenBac.ToLower().Trim()).FirstOrDefault();
                            if (checkTenBacHoc != null)
                            {
                                return Json(new { success = false, message = "name" });
                            }

                            ThayDoiHSBac thayDoiHSBac = new ThayDoiHSBac();
                            thayDoiHSBac.MaBac = bacHoc.MaBac.Trim();
                            thayDoiHSBac.NgayApDung = DateTime.Now;
                            thayDoiHSBac.HeSo = heSo;
                            thayDoiHSBac.MaGV = LoginController.MaGV;

                            context.BacHocs.Add(bacHoc);
                            context.ThayDoiHSBacs.Add(thayDoiHSBac);
                            context.SaveChanges();

                            transaction.Commit();
                        }
                        catch (Exception e)
                        {
                            transaction.Rollback();
                            return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
                        }
                        return Json(new { success = true, data = bacHoc });
                    }

                }
            }
            catch (Exception e)
            {

                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("edit")]
        [HttpPost]
        public JsonResult editBacHoc(String maBacHoc, BacHoc model, double heSo)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    using (var transaction = context.Database.BeginTransaction())
                    {
                        try
                        {
                            if (maBacHoc != model.MaBac)
                            {
                                var checkmaBacHoc = context.BacHocs.Where(x => x.MaBac == model.MaBac.Trim()).FirstOrDefault();

                                if (checkmaBacHoc != null)
                                {
                                    return Json(new { success = false, message = "pk" });
                                }
                            }
                            var checkTenBac = context.BacHocs.Where(x => x.TenBac.ToLower() == model.TenBac.ToLower().Trim() && x.MaBac != maBacHoc.Trim()).FirstOrDefault();
                            if (checkTenBac != null)
                            {
                                return Json(new { success = false, message = "name" });
                            }

                            var bacHoc = context.BacHocs.Where(x => x.MaBac == maBacHoc.Trim()).FirstOrDefault();
                            bacHoc.TenBac = model.TenBac.Trim();
                            ThayDoiHSBac thayDoiHSBac = new ThayDoiHSBac();
                            thayDoiHSBac.MaBac = bacHoc.MaBac.Trim();
                            thayDoiHSBac.NgayApDung = DateTime.Now;
                            thayDoiHSBac.HeSo = heSo;
                            thayDoiHSBac.MaGV = LoginController.MaGV;
                            context.ThayDoiHSBacs.Add(thayDoiHSBac);

                            context.Entry(bacHoc).State = EntityState.Modified;
                            context.SaveChanges();
                            transaction.Commit();
                            if (maBacHoc != model.MaBac.Trim())
                            {
                                var x = new SQLHelper().ExecuteString("EXEC [dbo].[updatePK] '" + maBacHoc + "','" + model.MaBac.Trim() + "','BacHoc'");
                            }
                            return Json(new { success = true, data = bacHoc });
                        }
                        catch (Exception e)
                        {
                            transaction.Rollback();
                            return Json(new { success = false, message = "Chỉnh sửa bậc học thất bại " + e.InnerException.Message });
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteChucVu(String maBac)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var checkPK = context.LopTinChis.Where(x => x.MaBac== maBac.Trim()).FirstOrDefault();
                    if (checkPK != null)
                    {
                        return Json(new { success = false, message = "Không thể xóa bậc học vì đã tồn tại lớp tín chỉ thuộc bậc học này!" });
                    }
                    List<SqlParameter> param = new List<SqlParameter>();
                    param.Add(new SqlParameter("@maBac", maBac));
                    var ret = new SQLHelper().ExecuteQuery("sp_Delete_BacHoc", param);
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
