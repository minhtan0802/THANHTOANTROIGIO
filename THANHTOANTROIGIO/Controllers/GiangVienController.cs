using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("giangvien")]
    public class GiangVienController : Controller
    {


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
            var data = GiangVienDAO.getListGiangVien(model.MaBoMon);
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("chuc-danh")]
        public JsonResult AjaxMethod_getChucDanhByMaGV(GiangVien model)
        {
            var data = GiangVienDAO.getChucDanhByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("loai-gv")]
        public JsonResult AjaxMethod_getLoaiGVByMaGV(GiangVien model)
        {
            var data = GiangVienDAO.getLoaiGVByMaGV(model.MaGiangVien);
            return Json(JsonConvert.SerializeObject(data));
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
                return Json(new { result = false, data = "Vui lòng nhập đầy đủ thông tin Mã GV, Họ, Tên" });
            }
            if (Helpers.SQLHelper.checkFK("MaGiangVien", model.MaGiangVien, "GiangVien") == 1)
            {
                return Json(new { result = false, data = "Mã giảng viên đã tồn tại!" });
            }
            DateTime ngayThem = DateTime.Now;

            model.MaGiangVien = model.MaGiangVien.Trim();
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

            model.ChucVu = Helpers.SQLHelper.getNameByID(model.ChucVu.Trim(), "ChucVu");
            model.HocVi = Helpers.SQLHelper.getNameByID(model.HocVi.Trim(), "HocVi");

            using (var context = new ThanhToanTroiGioEntities())
            {
                using (var transaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        context.GiangViens.Add(model);
                        context.ThayDoiBoMons.Add(thayDoiBoMon);
                        context.ThayDoiChucVus.Add(thayDoiChucVu);
                        context.ThayDoiHocVis.Add(thayDoiHocVi);
                        context.ThayDoiLoaiGVs.Add(thayDoiLoaiGV);

                        context.SaveChanges();
                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        return Json(new { result = false, data = "Thêm giảng viên thất bại " + ex.Message + " " + ex.InnerException.Message });
                    }
                }
            }
            return Json(new { result = true, data = "Thêm giảng viên thành công" });
        }

        [HttpPost]
        [Route("edit")]
        public JsonResult ChinhSuaGV(GiangVien model)
        {
            ThayDoiBoMon thayDoiBoMon = new ThayDoiBoMon();
            ThayDoiChucVu thayDoiChucVu = new ThayDoiChucVu();
            ThayDoiHocVi thayDoiHocVi = new ThayDoiHocVi();
            ThayDoiLoaiGV thayDoiLoaiGV = new ThayDoiLoaiGV();
            if (String.IsNullOrEmpty(model.MaGiangVien.Split(' ')[1])||String.IsNullOrEmpty(model.Ho) || String.IsNullOrEmpty(model.Ten))

            {
                return Json(new { result = false, data = "Vui lòng nhập đầy đủ thông tin Mã GV, Họ, Tên, Chức Danh" });
            }
            DateTime ngayThem = DateTime.Now;
            String maGV = model.MaGiangVien.Split(' ')[0];
            String maGVEdit = model.MaGiangVien.Split(' ')[1];
            model.MaGiangVien = maGV;
            if (maGV != maGVEdit)
            {
                if (Helpers.SQLHelper.checkFK("MaGiangVien", maGVEdit, "GiangVien") == 1)
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
                model.ChucVu = Helpers.SQLHelper.getNameByID(model.ChucVu.Trim(), "ChucVu");
            }

            if (model.HocVi.Trim() != "false")
            {
                thayDoiHocVi.MaGV = maGV;
                thayDoiHocVi.MaHocVi = model.HocVi.Trim();
                thayDoiHocVi.NgayThayDoi = ngayThem;
                model.HocVi = Helpers.SQLHelper.getNameByID(model.HocVi.Trim(), "HocVi");
            }


            if (model.GVCoHuu != Helpers.SQLHelper.checkGVCoHuu(maGV))
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
            using (var context =new ThanhToanTroiGioEntities())
            {
                using (var transaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        var gv = context.GiangViens.FirstOrDefault(s => s.MaGiangVien == maGV);
                        //context.ThayDoiBoMons.Add(thayDoiBoMon);
                        if (model.ChucVu != "false")
                        {
                            // model.ChucVu = model.ChucVu;
                            context.ThayDoiChucVus.Add(thayDoiChucVu);
                        }
                        else
                        {
                            model.ChucVu = gv.ChucVu;
                        }
                        if (model.HocVi != "false")
                        {
                            context.ThayDoiHocVis.Add(thayDoiHocVi);
                            //  gv.HocVi = model.HocVi;
                        }
                        else
                        {
                            model.HocVi = gv.HocVi;
                        }
                        if (model.GVCoHuu != Helpers.SQLHelper.checkGVCoHuu(maGV))
                        {
                            context.ThayDoiLoaiGVs.Add(thayDoiLoaiGV);
                        }
                        if (model.MaBoMon != gv.MaBoMon)
                        {
                            thayDoiBoMon.MaBoMon = model.MaBoMon;
                            thayDoiBoMon.NgayThayDoi = ngayThem;
                            thayDoiBoMon.MaGV = maGV;
                            context.ThayDoiBoMons.Add(thayDoiBoMon);
                        }

                        //     context.GiangViens.Add(model);
                        context.Entry(model).State = EntityState.Modified;
                        context.SaveChanges();
                        List<SqlParameter> parameters = new List<SqlParameter>();
                        context.Database.ExecuteSqlRaw("EXEC [dbo].[updateMaGV] '"+maGV+"','"+maGVEdit+"'",parameters);
                        transaction.Commit();
                 
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        return Json(new { result = false, data = "Chỉnh sửa giảng viên thất bại " + ex.Message + " " + ex.InnerException.Message });
                    }
                }
            }
            return Json(new { result = true, data = "Chỉnh sửa giảng viên thành công" });
        }

        [Route("delete")]
        [HttpPost]
        public JsonResult delete(GiangVien model)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                try
                {
                    var gv = context.GiangViens.FirstOrDefault(s => s.MaGiangVien == model.MaGiangVien);
                    gv.TrangThaiXoa = true;
                    context.Entry(gv).State = EntityState.Modified;
                    context.SaveChanges();
                    return Json(new { result = true, data = "Xóa giảng viên thành công! " });
                }
                catch (Exception ex)
                {
                    return Json(new { result = false, data = "Xóa giảng viên thất bại vì vi phạm khóa ngoại" });
                }

            }
        }
    }
}
