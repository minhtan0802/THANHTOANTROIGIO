using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class HocViService
    {
        private ThanhToanTroiGioEntities _context;
        public HocViService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<HocVi> getListHocVi()// form giang vien
        {
            List<HocVi> list = new List<HocVi>();
            list = _context.HocVis.ToList();
            return list;
        }
        public string getMaHocViByMaGV(String maGV)
        {
            ThayDoiHocVi hocVi = new ThayDoiHocVi();
            var ngayThayDoi = _context.ThayDoiHocVis.Where(s => s.MaGV.Equals(maGV)).Max(o => o.NgayThayDoi);
            hocVi = (ThayDoiHocVi)_context.ThayDoiHocVis
                          .Where(s => s.MaGV.Equals(maGV.Trim()) && s.NgayThayDoi == ngayThayDoi).FirstOrDefault();
            return hocVi.MaHocVi;
        }
        public DataTable GetDSHocVi(String connectionString, int all)// them, xoa, sua hoc vi
        {
            var Sql = new SQLHelper(connectionString);
            var param = new List<SqlParameter>();
            param.Add(new SqlParameter("@all", all));
            var data = Sql.ExecuteQuery("sp_get_Hoc_Vi", param);
            return data;
        }
    }
}
