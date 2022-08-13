using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class BacHocService
    {
        private ThanhToanTroiGioEntities _context;
        public BacHocService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<BacHoc> getDSBacHoc()
        {
            var list = _context.BacHocs.ToList();
            return list;
        }
        public DataTable getDSBacHocFull(int all, string connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@all", all));
            var data = new SQLHelper(connectionString).ExecuteQuery("sp_get_Bac_Hoc", param);
            return data;
        }
        public float getHeSoBacHocByMaBacHoc(String maBacHoc)
        {
            ThayDoiHSBac bacHoc = new ThayDoiHSBac();

                var ngayApDung = _context.ThayDoiHSBacs.Where(s => s.MaBac.Equals(maBacHoc)).Max(o => o.NgayApDung);
                bacHoc = (ThayDoiHSBac)_context.ThayDoiHSBacs
                             .Where(s => s.MaBac.Equals(maBacHoc.Trim()) && s.NgayApDung == ngayApDung).FirstOrDefault();
            
            return (float)bacHoc.HeSo;
        }
    }
}
