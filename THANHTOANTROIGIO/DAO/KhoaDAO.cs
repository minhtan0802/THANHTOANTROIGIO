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
    public class KhoaDAO
    {
        public static List<Khoa> getListKhoa()
        {
            using (var context = new ThanhToanTroiGioEntities())
            {
                var list = context.Khoas.ToList();
                return list;
            }
        }
    }
}