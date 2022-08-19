using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-dong-ly-thuyet")]
    public class LopDongLyThuyetController : Controller
    {
        private readonly LopDongLyThuyetService _lopDongLyThuyetService;
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly String _connectionString;

        public LopDongLyThuyetController(LopDongLyThuyetService lopDongLyThuyetService, IConfiguration configuration, ThanhToanTroiGioEntities context)
        {
            _lopDongLyThuyetService = lopDongLyThuyetService;
            _configuration = configuration;
            _context = context;
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [Route("")]
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        [Route("ds")]
        public JsonResult getDSLDLT (int all)
        {
            var data = _lopDongLyThuyetService.getDSLopDongLyThuyet(_connectionString, all);
            return Json(JsonConvert.SerializeObject(new { success = true, data = data }));
        }
        [HttpPost]
        [Route("add")]
        public JsonResult themLDLT(LopDongLyThuyet model)
        {
            var checkExist = _context.LopDongLyThuyets.Where(x => x.SiSoMin == model.SiSoMin && x.SiSoMax == model.SiSoMax).OrderByDescending(x => x.NgayApDung).FirstOrDefault();
            if (checkExist != null)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Lớp đông lý thuyết này đã tồn tại!" }));
            }
            model.NgayApDung = DateTime.Now;
            _context.Add(model);
            _context.SaveChanges();
            return Json(JsonConvert.SerializeObject(new { success = true, data = model }));

        }
        [HttpPost]
        [Route("edit")]
        public JsonResult chinhSuaLDLT(LopDongLyThuyet model)
        {
            model.NgayApDung = DateTime.Now;
            _context.Add(model);
            _context.SaveChanges();
            return Json(JsonConvert.SerializeObject(new { success = true, data = model }));

        }
        [Route("delete")]
        [HttpPost]
        public JsonResult xoaLDLT(LopDongLyThuyet model)
        {
            var param = new List<SqlParameter>();
            param.Add(new SqlParameter("@SiSoMin", model.SiSoMin));
            param.Add(new SqlParameter("@SiSoMax", model.SiSoMax));
            int x = new SQLHelper(_connectionString).ExecuteNoneQuery("sp_Delete_LDTH",param);
            return Json(JsonConvert.SerializeObject(new { success = true, data = "" }));
        }
        [Route("he-so")]
        [HttpGet]
        public JsonResult getHeSoBySiSo(int siSo)
        {
            float heSo = _lopDongLyThuyetService.getHeSo(siSo);
            return Json(JsonConvert.SerializeObject(heSo));
        }

    }

}
