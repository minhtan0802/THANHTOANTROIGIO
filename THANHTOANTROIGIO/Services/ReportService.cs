namespace THANHTOANTROIGIO.Services
{
    public class ReportService
    {
        private readonly ThanhToanTroiGioEntities _context;
        public ReportService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public String GetTruongPhongGiaoVu()
        {
            var tpgv= _context.GiangViens.Where(x => x.ChucDanh == "Trưởng phòng giáo vụ").FirstOrDefault();
            if(tpgv == null)
            {
                return "NGUYỄN XUÂN KHÁNH";
            }    
            var name = tpgv.Ho + " " + tpgv.Ten;
            return name;
        }
        public String GetPhoGiamDoc()
        {
            var tpgv = _context.GiangViens.Where(x => x.ChucDanh == "Phó giám đốc").FirstOrDefault();
            if (tpgv == null)
            {
                return "TÂN HẠNH";
            }
            var name = tpgv.Ho + " " + tpgv.Ten;
            return name;
        }
        public String GetTPKTTC()
        {
            var tpgv = _context.GiangViens.Where(x => x.ChucDanh == "trưởng phòng kinh tế tài chính").FirstOrDefault();
            if (tpgv == null)
            {
                return "PHAN THỊ BÍCH DIỄM";
            }
            var name = tpgv.Ho + " " + tpgv.Ten;
            return name;
        }
        public String GetTenHocKy(String maNKHK)
        {
            return _context.NienKhoaHocKys.Where(x => x.MaNKHK == maNKHK).FirstOrDefault().TenHocKy;
        }
        public String GetTenNienKhoa(String maNKHK)
        {
            return _context.NienKhoaHocKys.Where(x => x.MaNKHK == maNKHK).FirstOrDefault().TenNienKhoa;
        }
    }
}
