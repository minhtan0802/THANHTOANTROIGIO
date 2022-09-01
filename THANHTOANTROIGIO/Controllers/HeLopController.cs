using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{

    [Route("he-lop")]
    [AuthorizeUser]
    public class HeLopController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly HeLopService _heLopService;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;
        private readonly AuthService _authService;

        public HeLopController(IConfiguration configuration, HeLopService heLopService, ThanhToanTroiGioEntities context, AuthService authService)
        {
            _configuration = configuration;
            _heLopService = heLopService;
            _context = context;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
            _authService = authService;
        }
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-he-lop")]
        [HttpPost]
        public JsonResult getDSHeLop()
        {
            var data = _heLopService.getDSHeLop();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("he-so")]
        [HttpPost]
        public JsonResult getHeSoHeLop(HeLop model)
        {
            var data = _heLopService.getHeSoHeLopByMaHeLop(model.MaHeLop);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("ds-he-lop-full")]
        [HttpGet]
        public JsonResult getDSHeLopFull(int all)
        {
            var data = _heLopService.getDSHeLopFull(all, _connectionString);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themHeLop(HeLop heLop, double heSo)
        {
            try
            {
                StringHelper stringHelper = new StringHelper();
                heLop.MaHeLop = stringHelper.ChuanHoa(heLop.MaHeLop, "up");
                heLop.TenHeLop = stringHelper.ChuanHoa(heLop.TenHeLop);

                using (var transaction = _context.Database.BeginTransaction())
                {
                    try
                    {
                        var checkMaHeLop = _context.HeLops.Where(x => x.MaHeLop == heLop.MaHeLop.Trim()).FirstOrDefault();
                        if (checkMaHeLop != null)
                        {
                            return Json(JsonConvert.SerializeObject(new { success = false, message = "pk" }));
                        }
                        var checkTenHeLop = _context.HeLops.Where(x => x.TenHeLop.ToLower() == heLop.TenHeLop.ToLower().Trim()).FirstOrDefault();
                        if (checkTenHeLop != null)
                        {
                            return Json(JsonConvert.SerializeObject(new { success = false, message = "name" }));
                        }

                        ThayDoiHSHeLop thayDoiHSHeLop = new ThayDoiHSHeLop();
                        thayDoiHSHeLop.MaHeLop = heLop.MaHeLop.Trim();
                        thayDoiHSHeLop.NgayApDung = DateTime.Now;
                        thayDoiHSHeLop.HeSo = heSo;
                        thayDoiHSHeLop.MaGVDieuChinh = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user").ToString()).MaGiangVien;

                        _context.HeLops.Add(heLop);
                        _context.SaveChanges();
                        _context.ThayDoiHSHeLops.Add(thayDoiHSHeLop);
                        _context.SaveChanges();
                        transaction.Commit();
                        var view = new HeLopViewModel();
                        var gv = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user").ToString());
                        view.MaHeLop = heLop.MaHeLop;
                        view.TenHeLop = heLop.TenHeLop;
                        view.NgayApDung = thayDoiHSHeLop.NgayApDung;
                        view.HeSo = thayDoiHSHeLop.HeSo;
                        view.GVDieuChinh = gv.Name;
                        return Json(JsonConvert.SerializeObject(new { success = true, data = view }));
                    }


                    catch (Exception e)
                    {
                        transaction.Rollback();
                        return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
                    }

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
        public JsonResult editHeLop(String maHeLop, HeLop model, double heSo)
        {
            StringHelper stringHelper = new StringHelper();
            model.MaHeLop = stringHelper.ChuanHoa(model.MaHeLop,"up");
            model.TenHeLop = stringHelper.ChuanHoa(model.TenHeLop);
            try
            {
                using (var transaction = _context.Database.BeginTransaction())
                {
                    try
                    {
                        if (maHeLop != model.MaHeLop)
                        {
                            var checkmaHeLop = _context.HeLops.Where(x => x.MaHeLop == model.MaHeLop.Trim()).FirstOrDefault();

                            if (checkmaHeLop != null)
                            {
                                return Json(JsonConvert.SerializeObject( new { success = false, message = "pk" }));
                            }
                        }
                        var checkTenHeLop = _context.HeLops.Where(x => x.TenHeLop.ToLower() == model.TenHeLop.ToLower().Trim() && x.MaHeLop != maHeLop.Trim()).FirstOrDefault();
                        if (checkTenHeLop != null)
                        {
                            return Json(JsonConvert.SerializeObject(new { success = false, message = "name" }));
                        }

                        var heLop = _context.HeLops.Where(x => x.MaHeLop == maHeLop.Trim()).FirstOrDefault();
                        heLop.TenHeLop = model.TenHeLop.Trim();
                        ThayDoiHSHeLop thayDoiHSHeLop = new ThayDoiHSHeLop();
                        thayDoiHSHeLop.MaHeLop = heLop.MaHeLop.Trim();
                        thayDoiHSHeLop.NgayApDung = DateTime.Now;
                        thayDoiHSHeLop.HeSo = heSo;
                        thayDoiHSHeLop.MaGVDieuChinh = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user")).MaGiangVien;
                        _context.ThayDoiHSHeLops.Add(thayDoiHSHeLop);
                        _context.SaveChanges();
                        _context.Entry(heLop).State = EntityState.Modified;
                        _context.SaveChanges();
                        transaction.Commit();
                        if (maHeLop != model.MaHeLop.Trim())
                        {
                            var x = new SQLHelper(_connectionString).ExecuteString("EXEC [dbo].[updatePK] '" + maHeLop + "','" + model.MaHeLop.Trim() + "','HeLop'");
                        }
                        var view = new HeLopViewModel();
                        view.MaHeLop = model.MaHeLop;
                        view.TenHeLop = model.TenHeLop;
                        view.HeSo = heSo;
                        view.NgayApDung = thayDoiHSHeLop.NgayApDung;
                        view.GVDieuChinh = _authService.GetCurrentAuthUser(HttpContext.Session.GetString("user")).Name;
                        return Json(JsonConvert.SerializeObject(new { success = true, data = view }));
                    }
                    catch (Exception e)
                    {
                        transaction.Rollback();
                        return Json(JsonConvert.SerializeObject(new { success = false, message = "Chỉnh sửa bậc học thất bại " + e.InnerException.Message }));
                    }
                }

            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lỗi: " + e.InnerException.Message }));
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult deleteHeLop(String maHeLop)
        {
            try
            {

                var checkPK = _context.LopTinChis.Where(x => x.MaHeLop == maHeLop.Trim()).FirstOrDefault();
                if (checkPK != null)
                {
                    return Json(new { success = false, message = "Không thể xóa hệ lớp vì đã tồn tại lớp tín chỉ thuộc hệ lớp này!" });
                }
                List<SqlParameter> param = new List<SqlParameter>();
                param.Add(new SqlParameter("@maHeLop", maHeLop));
                var ret = new SQLHelper(_connectionString).ExecuteQuery("sp_Delete_HeLop", param);
                return Json(new { success = true, data = "Xóa hệ lớp thành công!" });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }

        }
    }
}
