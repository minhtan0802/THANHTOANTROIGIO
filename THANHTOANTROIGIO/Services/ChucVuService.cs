using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class ChucVuService
    {
        private ThanhToanTroiGioEntities _context;
        public ChucVuService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<ChucVu> getListChucVu()
        {

            var list = _context.ChucVus.ToList();
            return list;

        }
        public string getChucVuByMaGV(string maGiangVien)
        {
            ThayDoiChucVu chucVu = new ThayDoiChucVu();
            var ngayThayDoi = _context.ThayDoiChucVus.Where(s => s.MaGV.Equals(maGiangVien)).Max(o => o.NgayThayDoi);
            chucVu = (ThayDoiChucVu)_context.ThayDoiChucVus
                          .Where(s => s.MaGV.Equals(maGiangVien.Trim()) && s.NgayThayDoi == ngayThayDoi).FirstOrDefault();

            return chucVu.MaChucVu;
        }
    }
}
