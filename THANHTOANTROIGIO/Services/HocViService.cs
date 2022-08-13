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
        public List<HocVi> getListHocVi()
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
    }
}
