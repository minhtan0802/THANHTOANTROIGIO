using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class HeLopService
    {
        private ThanhToanTroiGioEntities _context;
        public HeLopService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<HeLop> getDSHeLop()
        {

            var list = _context.HeLops.ToList();
            return list;

        }
        public float getHeSoHeLopByMaHeLop(String maHeLop)
        {
            ThayDoiHSHeLop heLop = new ThayDoiHSHeLop();
            var ngayApDung = _context.ThayDoiHSHeLops.Where(s => s.MaHeLop.Equals(maHeLop)).Max(o => o.NgayApDung);
            heLop = (ThayDoiHSHeLop)_context.ThayDoiHSHeLops
                         .Where(s => s.MaHeLop.Equals(maHeLop.Trim()) && s.NgayApDung == ngayApDung).FirstOrDefault();
            return (float)heLop.HeSo;
        }
    }
}
