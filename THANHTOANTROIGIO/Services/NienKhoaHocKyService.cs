using System.Data;
using Microsoft.Data.SqlClient;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class NienKhoaHocKyService
    {
        private ThanhToanTroiGioEntities _context;
        private IConfiguration _configuration;
        public NienKhoaHocKyService(ThanhToanTroiGioEntities context,IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
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
        public List<NienKhoaHocKy> GetDSNKHK()
        {
            var data = _context.NienKhoaHocKys.ToList();
            return data;
        }
        public NienKhoaHocKy GoiYNKHK()
        {
            var data = _context.NienKhoaHocKys.OrderByDescending(x => x.MaNKHK).FirstOrDefault();
            return data;
        }
    }
}
