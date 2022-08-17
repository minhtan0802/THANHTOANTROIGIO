using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("hoc-vi")]
    [AuthorizeUser]
    public class HocViController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;
        private readonly HocViService _hocViService;
        private readonly AuthService _authService;

        public HocViController(IConfiguration configuration, ThanhToanTroiGioEntities context, HocViService hocViService, AuthService authService)
        {
            _configuration = configuration;
            _context = context;
            _hocViService = hocViService;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
            _authService = authService;
        }

        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [Route("ds-hoc-vi")]
        public JsonResult AjaxMethod_HocVi()
        {
            var data = _hocViService.getListHocVi();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("by-ma-gv")]
        public JsonResult AjaxMethod_getHocViByMaGV(GiangVien model)
        {
            var data = _hocViService.getMaHocViByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }
        [HttpGet]
        [Route("quan-ly-hoc-vi")]
        public JsonResult getDSHocVi(int all)
        {
            var data = _hocViService.GetDSHocVi(_configuration.GetConnectionString("DefaultConnection"), all);
            return Json(JsonConvert.SerializeObject(new { success = true, data = data }));
        }
        [HttpPost]
        [Route("add")]
        public JsonResult themHocVi(HocViAddModel model)
        {
            var existMaHV = _context.HocVis.Where(x => x.MaHocVi == model.MaHocVi.Trim().ToUpper()).FirstOrDefault();
            if (existMaHV != null)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "pk" }));
            }
            var existTenHV = _context.HocVis.Where(x => x.TenHocVi.ToUpper() == model.TenHocVi.Trim().ToUpper()).FirstOrDefault();
            if (existTenHV != null)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "name" }));
            }
            using (var trans = _context.Database.BeginTransaction())
            {
                try
                {
                    var hocVi = new HocVi();
                    hocVi.MaHocVi = model.MaHocVi;
                    hocVi.TenHocVi = model.TenHocVi;
                    _context.Add(hocVi);
                    _context.SaveChanges();
                    var thayDoiGiaHocVi = new ThayDoiGiaHocVi();
                    thayDoiGiaHocVi.DonGia = model.DonGia;
                    thayDoiGiaHocVi.MaHocVi = model.MaHocVi;
                    thayDoiGiaHocVi.MaGVDieuChinh = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user")).MaGiangVien;
                    thayDoiGiaHocVi.MaNKHK= _context.NienKhoaHocKys.OrderByDescending(x => x.MaNKHK).FirstOrDefault().MaNKHK;
                    _context.Add(thayDoiGiaHocVi);
                    _context.SaveChanges();
                    trans.Commit();
                    var gv = _context.GiangViens.Where(x => x.MaGiangVien == thayDoiGiaHocVi.MaGVDieuChinh).FirstOrDefault();
                    var view = new HocViViewModel();
                    view.MaHocVi = model.MaHocVi;
                    view.TenHocVi = model.TenHocVi;
                    view.DonGia = model.DonGia;
                    view.MaNKHK = thayDoiGiaHocVi.MaNKHK;
                    view.GVDieuChinh = gv.Ho + " " + gv.Ten;

                    return Json(JsonConvert.SerializeObject(new { success = true, data = view }));
                }
                catch(Exception ex)
                {
                    trans.Rollback();
                    return Json(JsonConvert.SerializeObject(new {success=false, message=ex.InnerException.Message}));
                }


            }
        }
        [Route("edit")]
        [HttpPost]
        public JsonResult editHocVi(String maHocVi, HocViAddModel model)
        {
            try
            {
                using (var transaction = _context.Database.BeginTransaction())
                {
                    try
                    {
                        if (maHocVi != model.MaHocVi)
                        {
                            var checkMaHocVi = _context.HocVis.Where(x => x.MaHocVi == model.MaHocVi.Trim()).FirstOrDefault();

                            if (checkMaHocVi != null)
                            {
                                return Json(JsonConvert.SerializeObject(new { success = false, message = "pk" }));
                            }
                        }
                        var checkTenHocVi = _context.HocVis.Where(x => x.TenHocVi.ToLower() == model.TenHocVi.ToLower().Trim() && x.MaHocVi != maHocVi.Trim()).FirstOrDefault();
                        if (checkTenHocVi != null)
                        {
                            return Json(JsonConvert.SerializeObject(new { success = false, message = "name" }));
                        }

                        var hocVi = _context.HocVis.Where(x => x.MaHocVi == maHocVi.Trim()).FirstOrDefault();
                        hocVi.TenHocVi = model.TenHocVi.Trim();
                        ThayDoiGiaHocVi thayDoiGiaHocVi = new ThayDoiGiaHocVi();
                        thayDoiGiaHocVi.MaHocVi = hocVi.MaHocVi.Trim();
                        thayDoiGiaHocVi.MaNKHK = _context.NienKhoaHocKys.OrderByDescending(x => x.MaNKHK).FirstOrDefault().MaNKHK;
                        thayDoiGiaHocVi.DonGia = model.DonGia;
                        thayDoiGiaHocVi.MaGVDieuChinh = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user")).MaGiangVien;
                        var checkPKThayDoiGiaHocVi = _context.ThayDoiGiaHocVis.Where(x => x.MaHocVi == hocVi.MaHocVi && x.MaNKHK == thayDoiGiaHocVi.MaNKHK).FirstOrDefault();
                        if (checkPKThayDoiGiaHocVi != null)
                        {
                            return Json(JsonConvert.SerializeObject(new { success = false, message = "Giá của học vị này đã được thay đổi trong học kỳ này!" }));
                        }
                        _context.ThayDoiGiaHocVis.Add(thayDoiGiaHocVi);
                        _context.SaveChanges();
                        _context.Entry(hocVi).State = EntityState.Modified;
                        _context.SaveChanges();
                        transaction.Commit();
                        var gv = _context.GiangViens.Where(x => x.MaGiangVien == thayDoiGiaHocVi.MaGVDieuChinh).FirstOrDefault();
                        var view = new HocViViewModel();
                        view.MaHocVi = model.MaHocVi;
                        view.TenHocVi = model.TenHocVi;
                        view.DonGia = model.DonGia;
                        view.MaNKHK = thayDoiGiaHocVi.MaNKHK;
                        view.GVDieuChinh = gv.Ho + " " + gv.Ten;
                        if (maHocVi != model.MaHocVi.Trim())
                        {
                            var x = new SQLHelper(_connectionString).ExecuteString("EXEC [dbo].[updatePK] '" + maHocVi + "','" + model.MaHocVi.Trim() + "','HocVi'");
                        }

                        return Json(JsonConvert.SerializeObject(new { success = true, data = view }));
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
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteHocVi(String maHocVi)
        {
            try
            {

                var checkPK = _context.ThayDoiHocVis.Where(x => x.MaHocVi == maHocVi.Trim()).FirstOrDefault();
                if (checkPK != null)
                {
                    return Json(new { success = false, message = "Không thể xóa học vị vì đã tồn tại giảng viên có học vị này!" });
                }
                List<SqlParameter> param = new List<SqlParameter>();
                param.Add(new SqlParameter("@maHocVi", maHocVi));
                var ret = new SQLHelper(_connectionString).ExecuteQuery("sp_Delete_HocVi", param);
                return Json(new { success = true, data = "Xóa học vị thành công!" });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }

        }
    }
}
