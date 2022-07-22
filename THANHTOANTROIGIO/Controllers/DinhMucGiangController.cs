using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    [Route("dinh-muc-giang")]
    public class DinhMucGiangController : Controller
    {
        [HttpGet]
        [Route("")]
        public IActionResult Index()
        {

            return View();
        }
        [Route("ds")]
        [HttpGet]
        public JsonResult getDinhMucGiang(String MaKhoa, String MaNKHK)
        {
            var data = DinhMucGiangDAO.getDinhMucGiang(MaKhoa, MaNKHK);
            return Json(JsonConvert.SerializeObject(new { success = true, data = data, count = data.Rows.Count }));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult addDinhMucGiang(DinhMucGiang model)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var checkExist = context.DinhMucGiangs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK).FirstOrDefault();
                    if (checkExist != null)
                    {
                        return Json(new { success = false, message = "Đã tồn tại định mức của giảng viên này trong học kỳ này!" });
                    }
                    context.Add(model);
                    context.SaveChanges();
                    return Json(JsonConvert.SerializeObject(new { success = true, data = "" }));
                }
            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = e.InnerException.Message }));
            }
        }
        [Route("edit")]
        [HttpPost]
        public JsonResult editDinhMucGiang(DinhMucGiang model)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var exist = context.DinhMucGiangs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK).FirstOrDefault();
                    exist.DinhMuc = model.DinhMuc;
                    exist.MoTa = model.MoTa;
                    context.Entry(exist).State = EntityState.Modified;
                    context.SaveChanges();
                    return Json(JsonConvert.SerializeObject(new { success = true, data = model }));
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.InnerException.Message });
            }

        }
        [HttpPost]
        [Route("sao-chep")]
        public JsonResult saoChepDMG(String maNKHK, String maNKHKTo)
        {
            var dataTable = new SQLHelper().ExecuteString("SELECT * FROM DinhMucGiang WHERE MaNKHK='" + maNKHK + "'");

            for (int j = 0; j < dataTable.Rows.Count; j++)
            {
                dataTable.Rows[j]["MaNKHK"] = maNKHKTo;
            }
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@DinhMucGiang", dataTable));
            var i = new SQLHelper().ExecuteQuery("SaoChep_DinhMucGiang", param);
            return Json(JsonConvert.SerializeObject(new { success = true, data = dataTable }));

        }

        [Route("copy")]
        [HttpPost]
        public JsonResult canCopy(String maHocKy)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                try
                {
                    var list = context.DinhMucGiangs.Where(s => s.MaNKHK == maHocKy).ToList();
                    if (list.Count == 0)
                    {
                        return Json(JsonConvert.SerializeObject(new { success = true, data = false }));
                    }
                    else
                    {
                        return Json(new { success = true, data = true });
                    }    
                }
                catch (Exception ex)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "Xóa định mức giảng thất bại: " + ex.InnerException.Message }));
                }

            }
        }


        [Route("delete")]
        [HttpPost]
        public JsonResult delete(String maGV, String maNKHK)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                try
                {
                    var model = context.DinhMucGiangs.Where(s => s.MaGV == maGV && s.MaNKHK == maNKHK).FirstOrDefault();
                    context.Entry(model).State = EntityState.Deleted;
                    context.SaveChanges();
                    return Json(new { success = true, data = "Xóa định mức giảng thành công! " });
                }
                catch (Exception ex)
                {
                    return Json(new { success = false, message = "Xóa định mức giảng thất bại: " + ex.InnerException.Message });
                }

            }
        }
    }
}
