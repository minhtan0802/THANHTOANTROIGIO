using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.DAO
{
    public class GiangVienDAO
    {
        public static List<GiangVien> getListGiangVien(String maBoMon)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.GiangViens.Where(gv => gv.MaBoMon == maBoMon && gv.TrangThaiXoa==false).ToList();
                return list;
            }
        }
        public static string getLoaiGVByMaGV(string maGiangVien)
        {
            ThayDoiLoaiGV loaiGV = new ThayDoiLoaiGV();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                var ngayThayDoi = ctx.ThayDoiLoaiGVs.Where(s => s.MaGV.Equals(maGiangVien)).Max(o => o.NgayThayDoi);
                loaiGV = (ThayDoiLoaiGV)ctx.ThayDoiLoaiGVs
                              .Where(s => s.MaGV.Equals(maGiangVien.Trim()) && s.NgayThayDoi.Year == ngayThayDoi.Year && s.NgayThayDoi.Month == ngayThayDoi.Month && s.NgayThayDoi.Day == ngayThayDoi.Day).FirstOrDefault();
            }
            if (loaiGV.MaLoaiGV == "0")
            {
                return "false";
            }
            else
            {
                return "true";
            }
        }

        public static string getChucDanhByMaGV(string maGiangVien)
        {
            GiangVien gv = new GiangVien();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                gv = (GiangVien)ctx.GiangViens
                              .Where(s => s.MaGiangVien.Equals(maGiangVien.Trim())).FirstOrDefault();
            }
            return gv.ChucDanh.Trim();
        }
    }
}