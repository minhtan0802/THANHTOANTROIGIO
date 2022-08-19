using DevExpress.XtraReports.UI;
using System;
using System.Collections;
using System.ComponentModel;
using Microsoft.Data.SqlClient;
using System.Drawing;
using THANHTOANTROIGIO.Controllers;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Report
{
    public partial class Report_KL_GiangDay : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_KL_GiangDay(String connectionString, String connectionStringReport,string maNKHK, ReportService _reportService)
        {
            InitializeComponent();
            this.sqlDataSource3.Connection.ConnectionString = connectionStringReport;
            this.sqlDataSource3.Queries[0].Parameters[0].Value = maNKHK;
            string nguoiLapBang = "";
            string tenHocKy = "";
            string tenNienKhoa = "";
            string tpgv = "";
            string pgd = "";
            tenHocKy = _reportService.GetTenHocKy(maNKHK);
            tenNienKhoa = _reportService.GetTenNienKhoa(maNKHK);
            List <SqlParameter> param= new List<SqlParameter>();
            var Sql = new SQLHelper(connectionString);
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "TPGV"));
            tpgv = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "PGD"));
            pgd = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "NLB"));
            nguoiLapBang= Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.label_NguoiLapBang.Text = nguoiLapBang;
            this.sqlDataSource3.Fill();
        }
    }
}
