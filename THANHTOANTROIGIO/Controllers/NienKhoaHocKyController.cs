using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{

    [Route("nien-khoa-hoc-ky")]
    [AuthorizeUser]
    public class NienKhoaHocKyController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly NienKhoaHocKyService _nienKhoaHocKyService;
        private readonly ThanhToanTroiGioEntities _context;
        public NienKhoaHocKyController(IConfiguration configuration, NienKhoaHocKyService nienKhoaHocKyService,ThanhToanTroiGioEntities context,AuthService authService)
        {
            _configuration = configuration;
            _nienKhoaHocKyService = nienKhoaHocKyService;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }
        [Route("nien-khoa")]
        [HttpGet]
        public JsonResult getNienKhoa()
        {
            var listNK = _nienKhoaHocKyService.getNienKhoa();
            return Json(JsonConvert.SerializeObject(listNK));
        }
        [Route("ds")]
        [HttpGet]
        public JsonResult getDSNienKhoa()
        {
            var listNK = _nienKhoaHocKyService.GetDSNKHK();
            return Json(JsonConvert.SerializeObject(new { sucess = true, data = listNK }));
        }

        [Route("hoc-ky")]
        [HttpPost]
        public JsonResult getHocKy(NienKhoaHocKy model)
        {
            var listNK = _nienKhoaHocKyService.getHocKy(model.TenNienKhoa);
            return Json(JsonConvert.SerializeObject(listNK));
        }

        [Route("add")]
        [HttpPost]
        public JsonResult ThemNKHK(NienKhoaHocKy model)
        {
            if (model.TenNienKhoa.Split('-').Length < 2)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Tên Niên Khóa không đúng cú pháp" }));
            }
            model.TenNienKhoa = model.TenNienKhoa.Split('-')[0].Trim() + "-" + model.TenNienKhoa.Split("-")[1].Trim();
            model.MaNKHK = model.TenNienKhoa.Split('-')[0].Trim()+model.TenHocKy.Split(' ')[2];
            var checkExist = _context.NienKhoaHocKys.Where(x => x.MaNKHK == model.MaNKHK).FirstOrDefault();
            if (checkExist != null)
            {
                return Json(JsonConvert.SerializeObject(new {success=false,message="Đã tồn tại NKHK này" }));
            }
            _context.NienKhoaHocKys.Add(model);
            _context.SaveChanges();
            return Json(JsonConvert.SerializeObject(new { success = true, data = model }));
        }

        [Route("delete")]
        [HttpPost]
        public JsonResult XoaNKHK(String MaNKHK)
        {
            try
            {
                var checkExist = _context.NienKhoaHocKys.Where(x => x.MaNKHK == MaNKHK).FirstOrDefault();
                if (checkExist == null)
                {
                    return Json(JsonConvert.SerializeObject(new { success = false, message = "Không tồn tại NKHK này, mời bạn load lại trang" }));
                }
                _context.Entry(checkExist).State = EntityState.Deleted;
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, message = "Xóa NKHK thành công!" }));

            }
            catch(Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message=ex.InnerException.Message}));

            }     
        }

        [Route("goi-y")]
        [HttpGet]
        public JsonResult GoiYNKHK()
        {
            var data = _nienKhoaHocKyService.GoiYNKHK();
            if (data == null)
            {
                return Json(JsonConvert.SerializeObject(new { TenNienKhoa = "", TenHocKy = "" }));
            }
            else
            {
                var hocKy = int.Parse(data.MaNKHK) % 2 == 0 ? 2 : 1;
                var tenHocKy = hocKy == 1 ? 2 : 1;
                var tenNienKhoa = hocKy == 1 ? data.TenNienKhoa: data.TenNienKhoa.Split('-')[1].Trim()+"-"+(int.Parse(data.TenNienKhoa.Split('-')[1])+1)+"";
                return Json(JsonConvert.SerializeObject(new { TenNienKhoa =tenNienKhoa, HocKy = tenHocKy }));
            }    
        }
        [Route("nam")]
        [HttpGet]
        public JsonResult LayCacNam()
        {
            var listNK = _nienKhoaHocKyService.GetDSNKHK();
            var data = new List<int>();
            foreach(var item in listNK)
            {
                var nam1 = int.Parse(item.TenNienKhoa.Split('-')[0]);
                var nam2 = int.Parse(item.TenNienKhoa.Split('-')[1]);

                if (!data.Contains(nam1))
                {
                    data.Add(nam1);
                }
                if (!data.Contains(nam2))
                {
                    data.Add(nam2);
                }
                
            }
            data.Reverse();
            return Json(JsonConvert.SerializeObject(new {success=true, data=data}));
        }
    }
}
