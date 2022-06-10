using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace THANHTOANTROIGIO.Helpers
{
    public class SQLHelper
    {
        public static int checkFK(string fk, string id, string obj)
        {
            if (obj.Equals("GiangVien"))
            {
                using(var context=new ThanhToanTroiGioEntities())
                {
                    var gv = context.GiangViens.Where(g => g.MaGiangVien.Trim() == id).FirstOrDefault();
                    return gv == null ? 0 : 1;
                }
               
            }
            return 0;
           
        }
        public static string getNameByID(string id, string table_name)
        {
            if (table_name.Equals("ChucVu"))
            {
                var name = new ThanhToanTroiGioEntities().ChucVus.Where(cv => cv.MaChucVu == id).FirstOrDefault().TenChucVu.ToString();
                return name;
            }
            if (table_name.Equals("HocVi"))
            {
                var name = new ThanhToanTroiGioEntities().HocVis.Where(hv => hv.MaHocVi == id).FirstOrDefault().TenHocVi.ToString();
                return name;
            }
            return "";
        }

        public static bool checkGVCoHuu(string maGV)
        {
            using(var context=new ThanhToanTroiGioEntities())
            {
                var GVCoHuu = context.GiangViens.Where(gv => gv.MaGiangVien == maGV).FirstOrDefault().GVCoHuu.ToString();
                return Boolean.Parse(GVCoHuu);

            }
           
        }
    }
}