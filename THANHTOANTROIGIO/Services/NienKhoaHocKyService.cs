using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class NienKhoaHocKyService
    {
        private ThanhToanTroiGioEntities _context;
        public NienKhoaHocKyService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public IEnumerable<Object> getNienKhoa()
        {

            var list = _context.NienKhoaHocKys.Select(x => new
            {
                x.TenNienKhoa
            }).Distinct().OrderByDescending(x => x.TenNienKhoa).ToList();
            return (IEnumerable<Object>)list;

        }
        public List<NienKhoaHocKy> getHocKy(String tenNienKhoa)
        {

            var list = _context.NienKhoaHocKys.Where(x => x.TenNienKhoa == tenNienKhoa).OrderBy(x => x.TenHocKy).ToList();
            return list;

        }
    }
}
