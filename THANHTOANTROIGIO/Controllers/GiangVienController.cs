using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("giangvien")]
    [AuthorizeUser]
    public class GiangVienController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly GiangVienService _giangVienService;
        private String _connectionString;
        private readonly ThanhToanTroiGioEntities _context;
        public GiangVienController(IConfiguration configuration, GiangVienService giangVienService, ThanhToanTroiGioEntities context, AuthService authService, IHttpContextAccessor httpContextAccessor)
        {
            _configuration = configuration;
            _giangVienService = giangVienService;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
            _context = context;
        }
        // GET: GiangVien
        [HttpGet]
        [Route("")]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [Route("ds-giang-vien")]
        public JsonResult AjaxMethod_GV(BoMon model)
        {
            var data = _giangVienService.getListGiangVien(model.MaBoMon.Trim(), _connectionString);
            
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("chuc-danh")]
        public JsonResult AjaxMethod_getChucDanhByMaGV(GiangVien model)
        {
            var data = _giangVienService.getChucDanhByMaGV(model.MaGiangVien, _connectionString);
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("loai-gv")]
        public JsonResult AjaxMethod_getLoaiGVByMaGV(GiangVien model)
        {
            var data = _giangVienService.getLoaiGVByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("ds-gv-by-khoa")]
        [HttpPost]
        public JsonResult AjaxMethod_getDSGVByBoMon(Khoa model)
        {
            var data = _giangVienService.getDSGVByBoMon(model.MaKhoa);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("select_khoa")]
        [HttpGet]
        public JsonResult getGVByKhoa(String maKhoa)
        {
            var data = _giangVienService.getListGiangVienByKhoa(maKhoa, _connectionString);
            return Json(JsonConvert.SerializeObject(new { success = true, data = data,count=data.Rows.Count }));
        }
        [HttpPost]
        [Route("add")]
        public JsonResult ThemGV(GiangVien model)
        {
            ThayDoiBoMon thayDoiBoMon = new ThayDoiBoMon();
            ThayDoiChucVu thayDoiChucVu = new ThayDoiChucVu();
            ThayDoiHocVi thayDoiHocVi = new ThayDoiHocVi();
            ThayDoiLoaiGV thayDoiLoaiGV = new ThayDoiLoaiGV();
            if (String.IsNullOrEmpty(model.MaGiangVien) || String.IsNullOrEmpty(model.Ho) || String.IsNullOrEmpty(model.Ten))

            {
                return Json(JsonConvert.SerializeObject(new { result = false, data = "Vui lòng nhập đầy đủ thông tin Mã GV, Họ, Tên" }));
            }
            if (_context.GiangViens.Where(x => x.MaGiangVien == model.MaGiangVien).FirstOrDefault() != null)
            {
                return Json(JsonConvert.SerializeObject(new { result = false, data = "Mã giảng viên đã tồn tại!" }));
            }
            DateTime ngayThem = DateTime.Now;
            StringHelper stringHelper= new StringHelper();
            model.MaGiangVien = stringHelper.ChuanHoa(model.MaGiangVien.Trim(),"up");
            model.Ho = stringHelper.ChuanHoa(model.Ho.Trim());
            model.Ten = stringHelper.ChuanHoa(model.Ten.Trim());
            model.ChucDanh = model.ChucDanh.Trim();
            if (!String.IsNullOrEmpty(model.DiaChi))
            {
                model.DiaChi = stringHelper.ChuanHoa(model.DiaChi.Trim());
            }
            if (!String.IsNullOrEmpty(model.Sdt))
            {
                model.Sdt = model.Sdt.Trim();
            }

            thayDoiBoMon.MaBoMon = model.MaBoMon.Trim();
            //  thayDoiBoMon.MaBoMon = "X";
            thayDoiBoMon.MaGV = model.MaGiangVien.Trim();
            thayDoiBoMon.NgayThayDoi = ngayThem;

            thayDoiChucVu.MaGV = model.MaGiangVien;
            thayDoiChucVu.MaChucVu = model.ChucVu.Trim();
            thayDoiChucVu.NgayThayDoi = ngayThem;

            thayDoiHocVi.MaGV = model.MaGiangVien;
            thayDoiHocVi.MaHocVi = model.HocVi.Trim();
            thayDoiHocVi.NgayThayDoi = ngayThem;

            thayDoiLoaiGV.MaGV = model.MaGiangVien;
            if (model.GVCoHuu)
            {
                thayDoiLoaiGV.MaLoaiGV = "1";
            }
            else
            {
                thayDoiLoaiGV.MaLoaiGV = "0";
            }
            thayDoiLoaiGV.NgayThayDoi = ngayThem;

            model.ChucVu = _context.ChucVus.Where(x => x.MaChucVu == model.ChucVu.Trim()).FirstOrDefault().TenChucVu;
            model.HocVi = _context.HocVis.Where(x => x.MaHocVi == model.HocVi.Trim()).FirstOrDefault().TenHocVi;


            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    _context.GiangViens.Add(model);
                    _context.SaveChanges();
                    _context.ThayDoiBoMons.Add(thayDoiBoMon);
                    _context.SaveChanges();
                    _context.ThayDoiChucVus.Add(thayDoiChucVu);
                    _context.SaveChanges();
                    _context.ThayDoiHocVis.Add(thayDoiHocVi);
                    _context.SaveChanges();
                    _context.ThayDoiLoaiGVs.Add(thayDoiLoaiGV);
                    _context.SaveChanges();
                    transaction.Commit();
                    return Json(JsonConvert.SerializeObject(new { result = true, data = model }));
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return Json(JsonConvert.SerializeObject(new { result = false, data = "Thêm giảng viên thất bại " + ex.Message + " " + ex.InnerException.Message }));
                }
            }


        }
        [HttpPost]
        [Route("edit")]
        public JsonResult ChinhSuaGV(GiangVien model)
        {
            ThayDoiBoMon thayDoiBoMon = new ThayDoiBoMon();
            ThayDoiChucVu thayDoiChucVu = new ThayDoiChucVu();
            ThayDoiHocVi thayDoiHocVi = new ThayDoiHocVi();
            ThayDoiLoaiGV thayDoiLoaiGV = new ThayDoiLoaiGV();
            if (String.IsNullOrEmpty(model.MaGiangVien.Split(' ')[1]) || String.IsNullOrEmpty(model.Ho) || String.IsNullOrEmpty(model.Ten))

            {
                return Json(new { result = false, data = "Vui lòng nhập đầy đủ thông tin Mã GV, Họ, Tên, Chức Danh" });
            }
            DateTime ngayThem = DateTime.Now;
            String maGV = model.MaGiangVien.Split(' ')[0];
            String maGVEdit = model.MaGiangVien.Split(' ')[1];
            model.MaGiangVien = maGV;
            if (maGV != maGVEdit)
            {
                if (_context.GiangViens.Where(x => x.MaGiangVien == maGVEdit).FirstOrDefault() != null)
                {
                    return Json(new { result = false, data = "Mã giảng viên đã tồn tại!" });
                }
            }
            model.Ho = model.Ho.Trim();
            model.Ten = model.Ten.Trim();
            model.ChucDanh = model.ChucDanh.Trim();
            if (!String.IsNullOrEmpty(model.DiaChi))
            {
                model.DiaChi = model.DiaChi.Trim();
            }
            if (!String.IsNullOrEmpty(model.Sdt))
            {
                model.Sdt = model.Sdt.Trim();
            }

            /* thayDoiBoMon.MaBoMon = model.MaBoMon.Trim();
             //  thayDoiBoMon.MaBoMon = "X";
             thayDoiBoMon.MaGV = model.MaGiangVien.Trim();
             thayDoiBoMon.NgayThayDoi = ngayThem;*/

            if (model.ChucVu.Trim() != "false")
            {
                thayDoiChucVu.MaGV = maGV;
                thayDoiChucVu.MaChucVu = model.ChucVu.Trim();
                thayDoiChucVu.NgayThayDoi = ngayThem;
                model.ChucVu = _context.ChucVus.Where(x => x.MaChucVu == model.ChucVu.Trim()).FirstOrDefault().TenChucVu;
            }

            if (model.HocVi.Trim() != "false")
            {
                thayDoiHocVi.MaGV = maGV;
                thayDoiHocVi.MaHocVi = model.HocVi.Trim();
                thayDoiHocVi.NgayThayDoi = ngayThem;
                model.HocVi = _context.HocVis.Where(x => x.MaHocVi == model.HocVi.Trim()).FirstOrDefault().TenHocVi;
            }


            if (model.GVCoHuu != Boolean.Parse(_context.GiangViens.Where(gv => gv.MaGiangVien == maGV).FirstOrDefault().GVCoHuu.ToString()))
            {
                thayDoiLoaiGV.MaGV = maGV;
                if (model.GVCoHuu)
                {
                    thayDoiLoaiGV.MaLoaiGV = "1";
                }
                else
                {
                    thayDoiLoaiGV.MaLoaiGV = "0";
                }
                thayDoiLoaiGV.NgayThayDoi = ngayThem;
            }
            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    var gv = _context.GiangViens.FirstOrDefault(s => s.MaGiangVien == maGV);
                    //context.ThayDoiBoMons.Add(thayDoiBoMon);
                    if (model.ChucVu != "false")
                    {
                        // model.ChucVu = model.ChucVu;
                        _context.ThayDoiChucVus.Add(thayDoiChucVu);
                        _context.SaveChanges();
                    }
                    else
                    {
                        model.ChucVu = gv.ChucVu;
                    }
                    if (model.HocVi != "false")
                    {
                        _context.ThayDoiHocVis.Add(thayDoiHocVi);
                        _context.SaveChanges();
                        //  gv.HocVi = model.HocVi;
                    }
                    else
                    {
                        model.HocVi = gv.HocVi;
                    }
                    if (model.GVCoHuu != Boolean.Parse(_context.GiangViens.Where(gv => gv.MaGiangVien == maGV).FirstOrDefault().GVCoHuu.ToString()))
                    {
                        _context.ThayDoiLoaiGVs.Add(thayDoiLoaiGV);
                        _context.SaveChanges();

                    }
                    if (model.MaBoMon != gv.MaBoMon)
                    {
                        thayDoiBoMon.MaBoMon = model.MaBoMon;
                        thayDoiBoMon.NgayThayDoi = ngayThem;
                        thayDoiBoMon.MaGV = maGV;
                        _context.ThayDoiBoMons.Add(thayDoiBoMon);
                        _context.SaveChanges();
                    }

                    gv.ChucDanh = model.ChucDanh;
                    gv.ChucVu = model.ChucVu;
                    gv.GVCoHuu = model.GVCoHuu;
                    gv.NgaySinh = model.NgaySinh;
                    gv.HocVi = model.HocVi;
                    gv.DiaChi = model.DiaChi;
                    gv.Ho = model.Ho;
                    gv.MaBoMon = model.MaBoMon;
                    gv.GioiTinh = model.GioiTinh;
                    gv.Ten = model.Ten;
                    //     context.GiangViens.Add(model);
                    _context.Entry(gv).State = EntityState.Modified;
                    _context.SaveChanges();
                    model.MaGiangVien = maGVEdit;
                    List<SqlParameter> parameters = new List<SqlParameter>();
                    _context.Database.ExecuteSqlRaw("EXEC [dbo].[updatePK] '" + maGV + "','" + maGVEdit + "','GiangVien'", parameters);
                    transaction.Commit();

                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return Json(new { result = false, data = "Chỉnh sửa giảng viên thất bại " + ex.Message + " " + ex.InnerException.Message });
                }

            }
            return Json(JsonConvert.SerializeObject(new { result = true, data = model }));
        }

        [Route("delete")]
        [HttpPost]
        public JsonResult delete(GiangVien model)
        {

            try
            {
                var gv = _context.GiangViens.FirstOrDefault(s => s.MaGiangVien == model.MaGiangVien);
                gv.TrangThaiXoa = true;
                _context.Entry(gv).State = EntityState.Modified;
                _context.SaveChanges();
                return Json(new { success = true, data = "Xóa giảng viên thành công! " });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, data = "Xóa giảng viên thất bại vì vi phạm khóa ngoại" });
            }
        }
    }
}
