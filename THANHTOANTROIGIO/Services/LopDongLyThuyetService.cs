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
        public float getHeSo(String maKhoa, int siSo)
        {
            var list = _context.LopDongLyThuyets.Where(x => x.MaKhoa == maKhoa && x.SiSoMin <= siSo && x.SiSoMax >= siSo).OrderByDescending(x => x.NgayApDung).ToList();
            return (float)list[0].HSLopDong;

        }
    }
}
