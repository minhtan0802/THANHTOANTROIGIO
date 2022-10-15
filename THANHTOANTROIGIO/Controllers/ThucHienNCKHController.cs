using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
/*using THANHTOANTROIGIO.DAO;*/
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;
/*using THANHTOANTROIGIO.Services;*/

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    [Route("thuc-hien-nckh")]
    public class ThucHienNCKHController : Controller
    {
        private readonly ThucHienNCKHService _thucHienNCKHService;
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        public ThucHienNCKHController(ThucHienNCKHService thucHienNCKHService, IConfiguration configuration, ThanhToanTroiGioEntities context)
        {
            _thucHienNCKHService = thucHienNCKHService;
            _configuration = configuration;
            _context = context;
        }
        [HttpGet]
        [Route("")]
        public IActionResult Index()
        {

            return View();
        }
        [Route("ds")]
        [HttpGet]
        public JsonResult getThucHienNCKH(String MaKhoa, String MaNKHK)
        {
            var data = _thucHienNCKHService.getThucHienNCKH(MaKhoa, MaNKHK, _configuration.GetConnectionString("DefaultConnection"));
            var dmg = _thucHienNCKHService.getThucHienNCKHHocKy(MaNKHK, _configuration.GetConnectionString("DefaultConnection"));
            return Json(JsonConvert.SerializeObject(new { success = true, data = data, count = dmg.Rows.Count }));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult addThucHienNCKH(ThucHienNCKH model)
        {
            try
            {

                var checkExist = _context.ThucHienNCKHs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK).FirstOrDefault();
                if (checkExist != null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "Đã tồn tại định mức của giảng viên này trong học kỳ này!" }));
                }
                _context.Add(model);
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = "" }));
            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = e.InnerException.Message }));
            }
        }
        [Route("edit")]
        [HttpPost]
        public JsonResult editThucHienNCKH(ThucHienNCKH model)
        {
            try
            {
                StringHelper stringHelper = new StringHelper();
                if (model.GhiChu != null)
                {
                    model.GhiChu = stringHelper.ChuanHoa(model.GhiChu);
                }
                var exist = _context.ThucHienNCKHs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK).FirstOrDefault();
                exist.ThucTeNCKH = model.ThucTeNCKH;
                exist.GhiChu = model.GhiChu;
                _context.Entry(exist).State = EntityState.Modified;
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = model }));
            }
            catch (Exception e)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = e.InnerException.Message }));
            }

        }
        [HttpPost]
        [Route("sao-chep")]
        public JsonResult saoChepDMNCKH(String maNKHK, String maNKHKTo)
        {
            var dataTable = new SQLHelper(_configuration.GetConnectionString("DefaultConnection")).ExecuteString("SELECT * FROM ThucHienNCKH WHERE MaNKHK='" + maNKHK + "'");

            for (int j = 0; j < dataTable.Rows.Count; j++)
            {
                dataTable.Rows[j]["MaNKHK"] = maNKHKTo;
            }
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@ThucHienNCKH", dataTable));
            var i = new SQLHelper(_configuration.GetConnectionString("DefaultConnection")).ExecuteQuery("SaoChep_ThucHienNCKH", param);
            return Json(JsonConvert.SerializeObject(new { success = true, data = dataTable }));

        }

        [Route("copy")]
        [HttpPost]
        public JsonResult canCopy(String maHocKy)
        {
            try
            {
                var list = _context.ThucHienNCKHs.Where(s => s.MaNKHK == maHocKy).ToList();
                if (list.Count == 0)
                {
                    return Json(JsonConvert.SerializeObject(new { success = true, data = false }));
                }
                else
                {
                    return Json(JsonConvert.SerializeObject(new { success = true, data = true }));
                }
            }
            catch (Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Xóa định mức giảng thất bại: " + ex.InnerException.Message }));
            }


        }


        [Route("delete")]
        [HttpPost]
        public JsonResult delete(String maGV, String maNKHK)
        {
            try
            {
                var model = _context.ThucHienNCKHs.Where(s => s.MaGV == maGV && s.MaNKHK == maNKHK).FirstOrDefault();
                _context.Entry(model).State = EntityState.Deleted;
                _context.SaveChanges();
                return Json(new { success = true, data = "Xóa định mức giảng thành công! " });
            }
            catch (Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Xóa định mức giảng thất bại: " + ex.InnerException.Message }));
            }


        }
    }
}
