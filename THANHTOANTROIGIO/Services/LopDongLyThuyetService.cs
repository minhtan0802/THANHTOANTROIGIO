using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class LopDongLyThuyetService
    {
        private ThanhToanTroiGioEntities _context;
        public LopDongLyThuyetService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public float getHeSo(int siSo)
        {
            var lopDong = _context.LopDongLyThuyets.Where(x =>x.SiSoMin <= siSo && x.SiSoMax >= siSo).OrderByDescending(x => x.NgayApDung).FirstOrDefault();
            if(lopDong == null)
            {
                return 0;
            }
            return (float)lopDong.HSLopDong;
        }
        public DataTable getDSLopDongLyThuyet(String connectionString, int all)
        {
            var sql = new SQLHelper(connectionString);
            var param = new List<SqlParameter>();
            param.Add(new SqlParameter("@all", all));
            var data = sql.ExecuteQuery("sp_GetLopDongLyThuyet", param);
            return data;
        }
    }
}
