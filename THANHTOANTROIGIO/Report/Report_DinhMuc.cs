using DevExpress.XtraReports.UI;
using Microsoft.Data.SqlClient;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Report
{
    public partial class Report_DinhMuc : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_DinhMuc(String connectionString, String connectionStringReport, string maNKHK, ReportService _reportService)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = connectionStringReport;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maNKHK;
            string nguoiLapBang = "";
            string tenHocKy = "";
            string tenNienKhoa = "";
            string tpgv = "";
            string tptc = "";
            tenHocKy = _reportService.GetTenHocKy(maNKHK);
            tenNienKhoa = _reportService.GetTenNienKhoa(maNKHK);
            List<SqlParameter> param = new List<SqlParameter>();
            var Sql = new SQLHelper(connectionString);
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "TPGV"));

            var tpgvDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            tpgv = tpgvDataTable.Rows.Count > 0 ? tpgvDataTable.Rows[0][3].ToString() : "";
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "TPTC"));
            var tptcDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            tptc = tptcDataTable.Rows.Count > 0 ? tptcDataTable.Rows[0][3].ToString() : "";
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPTC.Text = tpgv;
            this.label_TPTC.Text = tptc;
            this.sqlDataSource1.Fill();
        }
    }
}
