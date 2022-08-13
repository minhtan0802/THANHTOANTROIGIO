using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class KhoaService
    {
        private ThanhToanTroiGioEntities _context;
        public KhoaService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<Khoa> getListKhoa()
        {

            var list = _context.Khoas.ToList();
            return list;

        }
    }
}
