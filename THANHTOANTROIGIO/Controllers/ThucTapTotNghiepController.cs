﻿using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using OfficeOpenXml;
using System.Data;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("thuc-tap-tot-nghiep")]
    public class ThucTapTotNghiepController : Controller
    {
        public static List<HuongDanTTTN> listImport=null;
        public class selectSheet
        {
            public int id { get; set; }
            public int value { get; set; }
            public string text { get; set; }
            public selectSheet(int id, int value, string text)
            {
                this.id = id;
                this.value = value;
                this.text = text;
            }
        }
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("import")]
        [HttpGet]
        public IActionResult IndexImport()
        {
            return View();
        }
        [Route("ds-tttn")]
        public JsonResult getDSTTTN(String MaNKHK, String MaGV)
        {
            var data = ThucTapTotNghiepDAO.getDSTTTN(MaNKHK, MaGV);
            return Json(JsonConvert.SerializeObject(new { success = true, data = data }));
        }
        [Route("add")]
        [HttpPost]
        public JsonResult addTTTN(HuongDanTTTN model)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var exist = context.HuongDanTTTNs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK && x.Lop == model.Lop).FirstOrDefault();
                    if (exist != null)
                    {
                        return Json(new { success = false, message = "Đã tồn tại lớp hướng dẫn thực tập tốt nghiệp của học kỳ này do GV này HD" });
                    }
                    context.Add(model);
                    context.SaveChanges();
                    return Json(new { success = true, data = model });
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }


        }
        [Route("edit")]
        [HttpPost]
        public JsonResult addTTTN(String lop, HuongDanTTTN model)
        {
            try
            {
                using (var context = new ThanhToanTroiGioEntities())
                {
                    var exist = context.HuongDanTTTNs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK && x.Lop == lop).FirstOrDefault();
                    if (lop == model.Lop)
                    {
                        exist.HSHuongDan = model.HSHuongDan;
                        exist.SoSinhVienHD = model.SoSinhVienHD;
                        exist.SoSinhVienPB = model.SoSinhVienPB;
                        exist.SoTuan = model.SoTuan;
                        exist.HSPhanBien = model.HSPhanBien;
                        context.Entry(exist).State = EntityState.Modified;
                        context.SaveChanges();
                        return Json(new { success = true, data = model });
                    }
                    else
                    {
                        var checkPK = context.HuongDanTTTNs.Where(x => x.MaGV == model.MaGV && x.MaNKHK == model.MaNKHK && x.Lop == model.Lop).FirstOrDefault();
                        if (checkPK != null)
                        {
                            return Json(new { success = false, message = "Đã tồn tại lớp hướng dẫn thực tập tốt nghiệp của học kỳ này do GV này HD" });
                        }
                        else
                        {
                            List<SqlParameter> param = new List<SqlParameter>();
                            param.Add(new SqlParameter("@pk", model.MaGV + " " + model.MaNKHK + " " + lop));
                            param.Add(new SqlParameter("@pkUpdate", model.Lop));
                            param.Add(new SqlParameter("@tableName", "HuongDanTTTN"));
                            new SQLHelper().ExecuteQuery("updatePK", param);
                            return Json(new { success = true, data = model });
                        }
                    }
                    return Json(new { success = true, data = model });
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = "Lỗi: " + e.InnerException.Message });
            }


        }
        [Route("delete")]
        [HttpPost]
        public JsonResult delete(String maGV, String maNKHK, String lop)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                try
                {
                    var exist = context.HuongDanTTTNs.Where(x => x.MaGV == maGV && x.MaNKHK == maNKHK && x.Lop == lop).FirstOrDefault();
                    context.Entry(exist).State = EntityState.Deleted;
                    context.SaveChanges();
                    return Json(new { success = true, data = "Xóa lớp hướng dẫn thực tập tốt nghiệp thành công! " });
                }
                catch (Exception ex)
                {
                    return Json(new { success = false, message = "Xóa lớp hướng dẫn thực tập tốt nghiệp thất bại: " + ex.InnerException.Message });
                }

            }
        }
        [Route("list-sheet")]
        [HttpPost]
        public JsonResult getTenSheet(MultipartFormDataContent formTTTN)
        {
            var rq = HttpContext.Request.Form;
            var file = rq.Files.Count() > 0 ? rq.Files[0] : null;
            var maNKHK = rq["maNKHK"].ToString();
            if (file != null)
            {
                var filePath = Path.GetTempFileName();
                ExcelPackage.LicenseContext = LicenseContext.Commercial;

                using (var stream = System.IO.File.Create(filePath))
                {
                    // The formFile is the method parameter which type is IFormFile
                    // Saves the files to the local file system using a file name generated by the app.
                    file.CopyToAsync(stream);
                }
                using (var package = new ExcelPackage(filePath))
                {
                    ExcelPackage.LicenseContext = LicenseContext.Commercial;
                    var workbook = package.Workbook;
                    var worksheet = workbook.Worksheets;
                    List<selectSheet> listSheet = new List<selectSheet>();
                    foreach (var ws in worksheet)
                    {
                        listSheet.Add(new selectSheet(ws.Index, ws.Index, ws.Name));
                    }
                    return Json(new { success = true, data = listSheet });
                }
            }
            else
            {
                return Json(new { success = false, data = "Lỗi" });
            }
        }

        [Route("preview")]
        [HttpPost]
        public JsonResult preview(MultipartFormDataContent formTTTN)
        {
            var rq = HttpContext.Request.Form;
            var file = rq.Files.Count() > 0 ? rq.Files[0] : null;
            listImport = new List<HuongDanTTTN>();
            var maNKHK = rq["maNKHK"].ToString();
            var maSheet = int.Parse(rq["maSheet"].ToString());
            if (file != null)
            {
                var filePath = Path.GetTempFileName();

                using (var stream = System.IO.File.Create(filePath))
                {
                    // The formFile is the method parameter which type is IFormFile
                    // Saves the files to the local file system using a file name generated by the app.
                    file.CopyToAsync(stream);
                }
                using (var package = new ExcelPackage(filePath))
                {
                    ExcelPackage.LicenseContext = LicenseContext.Commercial;
                    var workbook = package.Workbook;
                    var worksheet = workbook.Worksheets[maSheet];
                    int colCount = worksheet.Dimension.End.Column;  //get Column Count
                    int rowCount = worksheet.Dimension.End.Row;
                    List<HuongDanTTTN> list = new List<HuongDanTTTN>();
                    for (int row = 2; row <= rowCount; row++)
                    {

                        HuongDanTTTN huongDanTTTN = new HuongDanTTTN(
                          worksheet.Cells[row, 1].Value?.ToString().Trim(),
                          maNKHK,
                          double.Parse(worksheet.Cells[row, 7].Value?.ToString().Trim()),
                           double.Parse(worksheet.Cells[row, 6].Value?.ToString().Trim()),
                            worksheet.Cells[row, 2].Value?.ToString().Trim(),
                          double.Parse(worksheet.Cells[row, 4].Value?.ToString().Trim()),
                          int.Parse(worksheet.Cells[row, 3].Value?.ToString().Trim()),
                          double.Parse(worksheet.Cells[row, 5].Value?.ToString().Trim())
                            );
                        list.Add(huongDanTTTN);
                    }
                    listImport = list;
                    return Json(JsonConvert.SerializeObject(new { success = true, data = list }));
                }
            }
            else
            {
                return Json(new { success = false, data = "Lỗi" });
            }
        }
        [Route("import-file")]
        [HttpPost]
        public JsonResult import()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("MaGV",typeof(string));
            dataTable.Columns.Add("MaNKHK", typeof(string));
            dataTable.Columns.Add("HSPhanBien",typeof(double));
            dataTable.Columns.Add("SoSinhVienPB", typeof(double));
            dataTable.Columns.Add("Lop", typeof(string));
            dataTable.Columns.Add("SoSinhVienHD", typeof(double));
            dataTable.Columns.Add("SoTuan", typeof(int));
            dataTable.Columns.Add("HSHuongDan", typeof(double));
            foreach (var item in listImport)
            {
                dataTable.Rows.Add(item.MaGV,item.MaNKHK,item.HSPhanBien,item.SoSinhVienPB,item.Lop,item.SoSinhVienHD,item.SoTuan,item.HSHuongDan);
            }
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@HuongDanTTTN", dataTable));
            var i = new SQLHelper().ExecuteQuery("Import_HuongDanTTTN", param);
            return Json(JsonConvert.SerializeObject(new {success=true, data=dataTable}));
        }
    }
}