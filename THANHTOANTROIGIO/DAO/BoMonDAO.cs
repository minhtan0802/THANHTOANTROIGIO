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
    public class BoMonDAO
    {
        public static List<BoMon> getListBoMon(string maKhoa)
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.BoMons.Where(u => u.MaKhoa == maKhoa).ToList();
                return list;
            }

        }
        public static List<BoMon> getAllBoMon(String maBoMon)
        {
            List<BoMon> list = new List<BoMon>();
            using (var context = new ThanhToanTroiGioEntities())
            {
                list = context.BoMons.Where(boMon => boMon.MaBoMon != maBoMon).ToList();
                return list;
            }
        }
    }
}