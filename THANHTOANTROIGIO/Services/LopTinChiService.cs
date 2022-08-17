using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class LopTinChiService
    {
        private ThanhToanTroiGioEntities _context;
        public LopTinChiService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getListLTC(String MaNKHK, String MaGV, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaNKHK", MaNKHK));
            param.Add(new SqlParameter("@MaGV", MaGV));
            var list = new SQLHelper(connectionString).ExecuteQuery("getLTC", param);
            return list;

        }
        public LopTinChi getLTC(int maLTC)
        {
            var ltc = _context.LopTinChis.Where(x => x.MaLTC == maLTC).FirstOrDefault();
            return ltc;
        }

        public int getDonGia(string maHocVi, string chucDanh, string tenMon, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@maHocVi", maHocVi));
            param.Add(new SqlParameter("@chucDanh", chucDanh));
            param.Add(new SqlParameter("@monHoc", tenMon));
            var data = new SQLHelper(connectionString).ExecuteQuery("getDonGiaGV", param);
            var rountCount = data.Rows.Count;
            return int.Parse(data.Rows[0][0].ToString());
        }
    }
}
