using DocumentFormat.OpenXml.Spreadsheet;
using ExcelDataReader;
using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;

namespace THANHTOANTROIGIO.DAO
{
    public class ThucTapTotNghiepDAO
    {

        public static DataTable getDSTTTN(String maNKHK, String maGV)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@maGV", maGV));
            param.Add(new SqlParameter("@maNKHK", maNKHK));
            var data = new SQLHelper().ExecuteQuery("get_DS_Huong_Dan_TTTN", param);
            return data;
        }
      /*  public static String getSheet(IFormFile file)
        {
            *//*         DataTableCollection tableCollection;
                     using (var stream = File.Open(file.FileName, FileMode.Open, FileAccess.Read))
                     {
                         using (IExcelDataReader reader = ExcelReaderFactory.CreateReader(stream))
                         {
                             DataSet result = reader.AsDataSet(new ExcelDataSetConfiguration()
                             {
                                 ConfigureDataTable = (_) => new ExcelDataTableConfiguration() { UseHeaderRow = true }
                             });
                             tableCollection = result.Tables;
                             return tableCollection.ToString();
                         }

                     }*//*
            Workbook workbook = Workbook.Load();

        }*/
    }
}
