using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using OfficeOpenXml;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("lop-tin-chi")]
    [AuthorizeUser]
    public class LopTinChiController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ThanhToanTroiGioEntities _context;
        private readonly LopTinChiService _lopTinChiService;
        private readonly String _connectionString;

        public LopTinChiController(IConfiguration configuration, ThanhToanTroiGioEntities context, LopTinChiService lopTinChiService)
        {
            _configuration = configuration;
            _context = context;
            _lopTinChiService = lopTinChiService;
            _connectionString = _configuration.GetConnectionString("DefaultConnection");
        }

        [Route("")]
        [HttpGet]
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
        [Route("")]
        [HttpPost]
        public JsonResult getLTC(LTCGetModel model)
        {
            var data = _lopTinChiService.getListLTC(model.MaNKHK, model.MaGV, _connectionString);
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("ma-ltc")]
        [HttpPost]
        public JsonResult getLTCByMaLTC(int maLTC)
        {
            var data = _lopTinChiService.getLTC(maLTC);
            return Json(JsonConvert.SerializeObject(data));
        }

        [Route("don-gia")]
        [HttpGet]
        public JsonResult getDonGiaGV(String maGV, String tenMon)
        {
            var hocVi = _context.ThayDoiHocVis.Where(x => x.MaGV == maGV).OrderByDescending(x => x.NgayThayDoi).FirstOrDefault();
            var chucDanh = _context.GiangViens.Where(x => x.MaGiangVien == maGV).FirstOrDefault().ChucDanh;
            var data = _lopTinChiService.getDonGia(hocVi.MaHocVi, chucDanh, tenMon.Trim(), _connectionString);
            return Json(new { success = true, data = data });
        }
        [Route("add")]
        [HttpPost]
        public JsonResult themLTC(LopTinChi model)
        {
            StringHelper stringHelper = new StringHelper();
            model.TenLTC = model.TenLTC.Trim();
            var exist=_context.LopTinChis.Where(x=>x.MaMon==model.MaMon && x.MaGV==model.MaGV && x.TenLTC==model.TenLTC && x.MaNKHK==model.MaNKHK && x.MaBac==model.MaBac).FirstOrDefault();
            if (exist != null)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Đã tồn tại lớp tín chỉ này" }));
            }
            try
            {
                _context.LopTinChis.Add(model);
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = model }));
            }
            catch (Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new
                {
                    success = false,
                    message = "Thêm lớp tín chỉ thất bại!" + ex.InnerException.Message
                }));
            }
        }

        [Route("edit")]
        [HttpPost]
        public JsonResult editLTC(LopTinChi model)
        {
            StringHelper stringHelper = new StringHelper();
            model.TenLTC = model.TenLTC.Trim();
            try
            {
                _context.Entry(model).State = EntityState.Modified;
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = model }));
            }
            catch (Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new
                {
                    success = false,
                    message = "Chỉnh sửa lớp tín chỉ thất bại!" + ex.InnerException.Message
                }));
            }
        }
        [Route("delete")]
        [HttpPost]
        public JsonResult delete(int maLTC)
        {

            try
            {
                var ltc = _context.LopTinChis.FirstOrDefault(s => s.MaLTC == maLTC);
                _context.Entry(ltc).State = EntityState.Deleted;
                _context.SaveChanges();
                return Json(JsonConvert.SerializeObject(new { success = true, data = "Xóa lớp tín chỉ thành công! " }));
            }
            catch (Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = "Xóa lớp tín chỉ thất bại vì vi phạm khóa ngoại" }));
            }


        }
        [Route("preview")]
        [HttpPost]
        public JsonResult preview(MultipartFormDataContent formTTTN)
        {
            try
            {
                var rq = HttpContext.Request.Form;
                var file = rq.Files.Count() > 0 ? rq.Files[0] : null;
                var listImport = new List<LopTinChiImport>();
                var maNKHK = rq["maNKHK"].ToString();
                var hsHK =double.Parse(rq["hsHocKy"].ToString());
                string hocKy = "I";
                if (int.Parse(maNKHK) % 10 == 2)
                {
                    hocKy = "II";
                }
                var maSheet = int.Parse(rq["maSheet"].ToString());
                if (file != null)
                {
                    var filePath = Path.GetTempFileName();

                    using (var stream = System.IO.File.Create(filePath))
                    {
                        // The formFile is the method parameter which type is IFormFile
                        // Saves the files to the local file system using a file name generated by the app.
                        file.CopyTo(stream);
                    }
                    using (var package = new ExcelPackage(filePath))
                    {
                        StringHelper stringHelper = new StringHelper();
                        ExcelPackage.LicenseContext = LicenseContext.Commercial;
                        var workbook = package.Workbook;
                        var worksheet = workbook.Worksheets[maSheet];
                        int beginCol = 1;
                        int beginRow = 1;
                        int colCount = worksheet.Dimension.End.Column;  //get Column Count
                        int rowCount = worksheet.Dimension.End.Row;

                        int rowStart = 0, colStart = 0;

                        int rowEnd = 0;
                        bool flagEnd = false;
                        bool flagChange = false;

                        for (int i = beginRow; i <= rowCount; i++)
                        {
                            flagChange = false;
                            for (int j = beginCol; j <= colCount; j++)
                            {
                                if (worksheet.Cells[i, j].Value == null)
                                {
                                    flagEnd = true;
                                    continue;
                                }
                                else
                                {
                                    flagEnd = false;
                                    flagChange = true;
                                    if ((bool)(worksheet.Cells[i, j].Value?.ToString().Contains("MÃ GV")))
                                    {
                                        rowStart = i;
                                        colStart = j;
                                        flagEnd = false;
                                        flagChange = false;
                                        break;
                                    }
                                }
                            }
                        }

                        for (int i = rowStart; i <= rowCount; i++)
                        {
                            flagChange = false;
                            for (int j = beginCol; j <= colCount; j++)
                            {
                                if (worksheet.Cells[i, j].Value == null)
                                {
                                    flagEnd = true;
                                    continue;
                                }
                                else
                                {
                                    flagEnd = false;
                                    flagChange = true;
                                }
                            }
                            if (flagEnd = true && !flagChange)
                            {
                                rowEnd = i;
                                Console.Write("Row end: " + rowEnd);
                                break;
                            }
                        }

                        rowStart += 2;
                        List<LopTinChiImport> list = new List<LopTinChiImport>();
                        List<LopTinChiImportModel> listView = new List<LopTinChiImportModel>();
                        try
                        {
                            for (int row = rowStart; row < rowEnd; row++)
                            {

/*                                if (worksheet.Cells[row, 12].Value == null)
                                {
                                    return Json(JsonConvert.SerializeObject(new { success = false, message = "Mời bạn xem lại sheet đã chọn đúng chưa?" }));
                                }*/
                                
                                if (worksheet.Cells[row, 12].Value is null ||!worksheet.Cells[row, 12].Value.Equals(hocKy))
                                {
                                    continue;
                                }
                                else
                                {

                                    var model = new LopTinChiImport();
                                    var modelView = new LopTinChiImportModel();
                                    modelView.Stt = row;
                                    model.HSHocKy = hsHK;
                                    modelView.TenLTC = model.TenLTC = worksheet.Cells[row, 13].Value.ToString().Trim();
                                    modelView.SiSo = model.SiSo = Int32.Parse(worksheet.Cells[row, 14].Value.ToString());
                                    int int_x;
                                    double double_x;
                                    modelView.SoNhomTH = model.SoNhomTH = Int32.TryParse(worksheet.Cells[row, 15].Value?.ToString(), out int_x) ? int_x : 0;
                                    modelView.TietLTTD = model.TietLTQD = Math.Round(Double.TryParse(worksheet.Cells[row, 17].Value?.ToString(), out double_x) ? double_x : 0, 2);

                                    modelView.TietBTTD = model.TietBTQD = Math.Round(Double.TryParse(worksheet.Cells[row, 18].Value?.ToString(), out double_x) ? double_x : 0, 2);

                                    modelView.TietTHTD = model.TietTHQD = Math.Round(Double.TryParse(worksheet.Cells[row, 20].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    model.DinhMuc = Math.Round(Double.TryParse(worksheet.Cells[row, 6].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    var dinhMucChucDanh = Math.Round(Double.TryParse(worksheet.Cells[row, 4].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    model.MoTa = Math.Round((model.DinhMuc / dinhMucChucDanh) * 100,2);
                                    model.MoTaNCKH = 0;
                                    model.DinhMucNCKH = Math.Round(Double.TryParse(worksheet.Cells[row, 7].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    model.TenMH = worksheet.Cells[row, 8].Value.ToString();
                                    model.MaMH = worksheet.Cells[row, 9].Value.ToString();
                                    var maHocVi = worksheet.Cells[row, 2].Value.ToString().Split('.')[0];
                                    model.HocVi = maHocVi;
                                    var maGV = worksheet.Cells[row, 1].Value.ToString();
                                    var monHoc = worksheet.Cells[row, 8].Value.ToString();
                                    modelView.TenMonHoc = monHoc;
                                    modelView.TenGiangVien = worksheet.Cells[row, 2].Value.ToString();
                                    String tenGV = new GetTenGV().getTenGV(modelView.TenGiangVien);
                                    var tenGVArray = tenGV.Split('.');
                                    model.HoGV = tenGVArray[0];
                                    model.TenGV = tenGVArray[1];

                                    List<SqlParameter> param = new List<SqlParameter>();
                                    param.Add(new SqlParameter("@maHocVi", maHocVi));
                                    param.Add(new SqlParameter("@maGV", maGV));
                                    param.Add(new SqlParameter("@monHoc", monHoc));

                                    modelView.HSMonMoi = model.HSMonMoi = Math.Round(Double.TryParse(worksheet.Cells[row, 26].Value?.ToString(), out double_x) ? double_x : 1, 2);
                                    modelView.HSNgoaiGio = model.HSNgoaiGio = Math.Round(Double.TryParse(worksheet.Cells[row, 25].Value?.ToString(), out double_x) ? double_x : 1, 2);
                                    modelView.HSLopDongLT = model.HSLopDongLT = Math.Round(Double.TryParse(worksheet.Cells[row, 24].Value?.ToString(), out double_x) ? double_x : 1, 2);
                                    modelView.HSLopDongTH = model.HSLopDongTH = Math.Round(Double.TryParse(worksheet.Cells[row, 27].Value?.ToString(), out double_x) ? double_x : 1, 2);
                                    modelView.HSLTC = model.HSLTC = Math.Round(Double.TryParse(worksheet.Cells[row, 28].Value?.ToString(), out double_x) ? double_x : 1, 2);

                                    model.HSNhomTH = 0.5;
                                    modelView.MaMonHoc = modelView.MaMonHoc = model.MaMH = worksheet.Cells[row, 9].Value.ToString();
                                    model.MaBac = "DH";
                                    modelView.TietLTQD = model.TietLTQD = Math.Round(Double.TryParse(worksheet.Cells[row, 17].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    modelView.TietBTQD = model.TietBTQD = Math.Round(Double.TryParse(worksheet.Cells[row, 18].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    modelView.TietTHQD = model.TietTHQD = Math.Round(Double.TryParse(worksheet.Cells[row, 20].Value?.ToString(), out double_x) ? double_x : 0, 2);
                                    param.Clear();
                                    param.Add(new SqlParameter("@maBacHoc", model.MaBac));
                                    //    model.HSBac = Double.Parse(new SQLHelper(_connectionString).ExecuteQuery("sp_Get_HSBacHoc", param).Rows[0][0].ToString());

                                    modelView.MaHeLop = model.HeLop = worksheet.Cells[row, 10].Value.ToString();
                                    /*          param.Clear();
                                              param.Add(new SqlParameter("@maHeLop", model.MaHeLop));*/
                                    //  model.HSHeLop = Double.Parse(new SQLHelper(_connectionString).ExecuteQuery("sp_Get_HSHeLop", param).Rows[0][0].ToString());
                                    model.MaGV = maGV;
                                    modelView.MaGV = maGV;
                                    model.MaNKHK = maNKHK;
                                    modelView.ChucDanh = model.ChucDanh = worksheet.Cells[row, 3].Value.ToString();
                                    list.Add(model);
                                    listView.Add(modelView);
                                }
                            }
                            listImport = list;
                            return Json(JsonConvert.SerializeObject(new { success = true, data = list, dataView = listView }));
                        }
                        catch (Exception ex1)
                        {
                            return Json(new { success = false, message = "Lỗi: " + ex1.Message });
                        }
                    }
                }
                else
                {
                    return Json(new { success = false, message = "File null" });
                }
            }
            catch (Exception ex)
            {
                return Json(JsonConvert.SerializeObject(new { success = false, message = ex.Message }));
            }
        }
        [Route("import-file")]
        [HttpPost]
        public JsonResult import([FromBody] List<LopTinChiImport> model)
        {
            var convert = new ListToDataTableConverter();
            var dataTable = convert.ToDataTable(model);
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@LopTinChi", dataTable));
            var i = new SQLHelper(_connectionString).ExecuteQuery("Import_LopTinChi_Full", param);
            return Json(JsonConvert.SerializeObject(new { success = true, data = dataTable }));
        }

    }
}
