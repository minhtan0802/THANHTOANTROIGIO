using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class MonHocService
    {
        private ThanhToanTroiGioEntities _context;
        public MonHocService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<MonHoc> getDSMonHoc()
        {

            var list = _context.MonHocs.ToList();
            return list;

        }
        public MonHoc getMonHoc(String MaMonHoc)
        {
            var data = _context.MonHocs.Where(x => x.MaMonHoc == MaMonHoc).FirstOrDefault();
            return data;
        }
    }
}
