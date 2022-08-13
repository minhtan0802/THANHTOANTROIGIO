using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("bac-hoc")]
    [AuthorizeUser]
    public class BacHocController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly BacHocService _bacHocService;
        private String _connectionString;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly AuthService _authService;
        public BacHocController(IConfiguration configuration, BacHocService bacHocService, ThanhToanTroiGioEntities context, AuthService authService)
        {
            _configuration = configuration;
            _bacHocService = bacHocService;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
            _context = context;
            _authService=authService;
        }

        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-bac-hoc")]
        [HttpPost]
        public JsonResult getDSBacHoc()
        {
            var data = _bacHocService.getDSBacHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("ds-bac-hoc-full")]
        [HttpGet]
        public JsonResult getDSBacHocFull(int all)
        {
            var data = _bacHocService.getDSBacHocFull(all, _connectionString);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("he-so")]
        [HttpPost]
        public JsonResult getHeSoBac(BacHoc model)
        {
            var data = _bacHocService.getHeSoBacHocByMaBacHoc(model.MaBac);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themBacHoc(BacHoc bacHoc, float heSo)
        {
            try
            {

                using (var transaction = _context.Database.BeginTransaction())
                {
                    try
                    {
                        var checkMaBacHoc = _context.BacHocs.Where(x => x.MaBac == bacHoc.MaBac.Trim()).FirstOrDefault();
                        if (checkMaBacHoc != null)
                        {
                            return Json(new { success = false, message = "pk" });
                        }
                        var checkTenBacHoc = _context.BacHocs.Where(x => x.TenBac.ToLower() == bacHoc.TenBac.ToLower().Trim()).FirstOrDefault();
                        if (checkTenBacHoc != null)
                        {
                            return Json(new { success = false, message = "name" });
                        }

                        ThayDoiHSBac thayDoiHSBac = new ThayDoiHSBac();
                        thayDoiHSBac.MaBac = bacHoc.MaBac.Trim();
                        thayDoiHSBac.NgayApDung = DateTime.Now;
                        thayDoiHSBac.HeSo = heSo;
                        thayDoiHSBac.MaGVDieuChinh = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user").ToString()).MaGiangVien;

                        _context.BacHocs.Add(bacHoc);
                        _context.SaveChanges();
                        _context.ThayDoiHSBacs.Add(thayDoiHSBac);
                        _context.SaveChanges();
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
            catch (Exception e)
            {
                return Json(new
                {
                    success = false,
                    message = "Lỗi: " + e.InnerException.Message
                });
            }
        }
        [Route("edit")]
        [HttpPost]
        /*public JsonResult editBacHoc(String maBacHoc, BacHoc model, double heSo)
        {
            try
            {
                using (var transaction = _context.Database.BeginTransaction())
                {
                    try
                    {
                        if (maBacHoc != model.MaBac)
                        {
                            var checkmaBacHoc = _context.BacHocs.Where(x => x.MaBac == model.MaBac.Trim()).FirstOrDefault();

                            if (checkmaBacHoc != null)
                            {
                                return Json(new { success = false, message = "pk" });
                            }
                        }
                        var checkTenBac = _context.BacHocs.Where(x => x.TenBac.ToLower() == model.TenBac.ToLower().Trim() && x.MaBac != maBacHoc.Trim()).FirstOrDefault();
                        if (checkTenBac != null)
                        {
                            return Json(new { success = false, message = "name" });
                        }

                        var bacHoc = _context.BacHocs.Where(x => x.MaBac == maBacHoc.Trim()).FirstOrDefault();
                        bacHoc.TenBac = model.TenBac.Trim();
                        ThayDoiHSBac thayDoiHSBac = new ThayDoiHSBac();
                        thayDoiHSBac.MaBac = bacHoc.MaBac.Trim();
                        thayDoiHSBac.NgayApDung = DateTime.Now;
                        thayDoiHSBac.HeSo = heSo;
                        thayDoiHSBac.MaGVDieuChinh = AccountController.MaGV;
                        _context.ThayDoiHSBacs.Add(thayDoiHSBac);
                        _context.SaveChanges();
                        _context.Entry(bacHoc).State = EntityState.Modified;
                        _context.SaveChanges();
                        transaction.Commit();
                        if (maBacHoc != model.MaBac.Trim())
                        {
                            var x = new SQLHelper(_connectionString).ExecuteString("EXEC [dbo].[updatePK] '" + maBacHoc + "','" + model.MaBac.Trim() + "','BacHoc'");
                        }
                        return Json(JsonConvert.SerializeObject(new { success = true, data = thayDoiHSBac.NgayApDung }));
                    }
                    catch (Exception e)
                    {
                        transaction.Rollback();
                        return Json(new { success = false, message = "Chỉnh sửa bậc học thất bại " + e.InnerException.Message });
                    }
                }

            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }
        }*/
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteChucVu(String maBac)
        {
            try
            {
  
                    var checkPK = _context.LopTinChis.Where(x => x.MaBac == maBac.Trim()).FirstOrDefault();
                    if (checkPK != null)
                    {
                        return Json(new { success = false, message = "Không thể xóa bậc học vì đã tồn tại lớp tín chỉ thuộc bậc học này!" });
                    }
                    List<SqlParameter> param = new List<SqlParameter>();
                    param.Add(new SqlParameter("@maBac", maBac));
                    var ret = new SQLHelper(_connectionString).ExecuteQuery("sp_Delete_BacHoc", param);
                    return Json(new { success = true, data = "Xóa chức vụ thành công!" });  
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }

        }
    }
}
