using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-dong-thuc-hanh")]
    [AuthorizeUser]
    public class LopDongThucHanhController : Controller
    {
        private readonly LopDongThucHanhService _lopDongThucHanhService;
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;

        public LopDongThucHanhController(LopDongThucHanhService lopDongThucHanhService, IConfiguration configuration, ThanhToanTroiGioEntities context)
        {
            _lopDongThucHanhService = lopDongThucHanhService;
            _configuration = configuration;
            _context = context;
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("he-so")]
        [HttpGet]
        public JsonResult getHeSoThucHanhBySiSo(String maMon, float siSo)
        {
            float heSo = _lopDongThucHanhService.getHeSo(_connectionString, maMon, (int)siSo);
            return Json(JsonConvert.SerializeObject(heSo));
        }
        [HttpPost]
        [Route("add")]
        public JsonResult themLDLT(LopDongThucHanh model)
        {
            var checkExist = _context.LopDongThucHanhs.Where(x => x.SiSoMin == model.SiSoMin && x.SiSoMax == model.SiSoMax).OrderByDescending(x => x.NgayApDung).FirstOrDefault();
            if (checkExist != null)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lớp đông thực hành này đã tồn tại!" }));
            }
            model.NgayApDung = DateTime.Now;
            _context.Add(model);
            _context.SaveChanges();
            return Json(JsonConvert.SerializeObject(new { success = true, data = model }));

        }
        [HttpPost]
        [Route("edit")]
        public JsonResult chinhSuaLDLT(LopDongThucHanh model)
        {
            model.NgayApDung = DateTime.Now;
            _context.Add(model);
            _context.SaveChanges();
            return Json(JsonConvert.SerializeObject(new { success = true, data = model }));

        }
        [Route("delete")]
        [HttpPost]
        public JsonResult xoaLDLT(LopDongThucHanh model)
        {
            var param = new List<SqlParameter>();
            param.Add(new SqlParameter("@SiSoMin", model.SiSoMin));
            param.Add(new SqlParameter("@SiSoMax", model.SiSoMax));
            int x = new SQLHelper(_connectionString).ExecuteNoneQuery("sp_Delete_LDLT", param);
            return Json(JsonConvert.SerializeObject(new { success = true, data = "" }));
        }
        [HttpGet]
        [Route("ds")]
        public JsonResult getDSLDLT(int all)
        {
            var data = _lopDongThucHanhService.getDSLopDongThucHanh(_connectionString, all);
            return Json(JsonConvert.SerializeObject(new { success = true, data = data }));
        }

    }
}
