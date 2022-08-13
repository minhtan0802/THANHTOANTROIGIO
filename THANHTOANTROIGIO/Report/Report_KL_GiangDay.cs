using DevExpress.XtraReports.UI;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using THANHTOANTROIGIO.Controllers;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Report
{
    public partial class Report_KL_GiangDay : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_KL_GiangDay(String connectionString, string maNKHK, ReportService _reportService, String nguoiLap)
        {
            InitializeComponent();
            this.sqlDataSource2.Connection.ConnectionString = "XpoProvider=MSSqlServer;data source=LAPTOP-V0HI7R3V\\SERVER;user id=sa;password=sa;initial catalog=THANHTOANTROIGIO;Persist Security Info=true";
            this.sqlDataSource2.Queries[0].Parameters[0].Value = maNKHK;
            this.label_NguoiLapBang.Text = nguoiLap;
            string tenHocKy = "";
            string tenNienKhoa = "";
            string tpgv = "";
            string pgd = "";
            tenHocKy = _reportService.GetTenHocKy(maNKHK);
            tenNienKhoa = _reportService.GetTenNienKhoa(maNKHK);
            tpgv = _reportService.GetTruongPhongGiaoVu();
            pgd = _reportService.GetPhoGiamDoc();
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.sqlDataSource2.Fill();
        }
    }
}
