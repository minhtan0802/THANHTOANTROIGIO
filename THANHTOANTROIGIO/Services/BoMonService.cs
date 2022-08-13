using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class BoMonService
    {
        private ThanhToanTroiGioEntities _context;
        public BoMonService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public List<BoMon> getListBoMon(string maKhoa)
        {

            var list = _context.BoMons.Where(u => u.MaKhoa == maKhoa).ToList();
            return list;
        }
        public List<BoMon> getAllBoMon(String maBoMon)
        {
            List<BoMon> list = new List<BoMon>();
            list = _context.BoMons.Where(boMon => boMon.MaBoMon != maBoMon).ToList();
            return list;

        }
    }
}
