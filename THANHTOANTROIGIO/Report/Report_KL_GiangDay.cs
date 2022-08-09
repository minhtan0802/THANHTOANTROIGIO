using DevExpress.XtraReports.UI;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using THANHTOANTROIGIO.Controllers;

namespace THANHTOANTROIGIO.Report
{
    public partial class Report_KL_GiangDay : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_KL_GiangDay(String connectionString, string maNKHK)
        {
            InitializeComponent();
            this.sqlDataSource2.Connection.ConnectionString = "XpoProvider=MSSqlServer;data source=LAPTOP-V0HI7R3V\\SERVER;user id=sa;password=sa;initial catalog=THANHTOANTROIGIO;Persist Security Info=true";
            this.sqlDataSource2.Queries[0].Parameters[0].Value = maNKHK;
            this.label_NguoiLapBang.Text = AccountController.TenGV;
            string tenHocKy = "";
            string tenNienKhoa = "";
            string tpgv = "";
            using(var context=new ThanhToanTroiGioEntities())
            {
                tenHocKy = context.NienKhoaHocKys.Where(x => x.MaNKHK == maNKHK).FirstOrDefault().TenHocKy;
                tenNienKhoa = context.NienKhoaHocKys.Where(x => x.MaNKHK == maNKHK).FirstOrDefault().TenNienKhoa;
                var gv = context.GiangViens.Where(x => x.ChucDanh == "Trưởng phòng giáo vụ").FirstOrDefault();
                if (gv == null)
                {
                    tpgv = "";
                }
                else
                {
                    tpgv = gv.Ho + " " + gv.Ten;
                }    
                
            }
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.sqlDataSource2.Fill();
        }
    }
}
