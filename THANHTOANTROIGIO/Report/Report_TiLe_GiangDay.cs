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
    public partial class Report_TiLe_GiangDay : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_TiLe_GiangDay(String connectionString, String connectionStringReport, int nam, ReportService _reportService)
        {
            InitializeComponent();
            var hocKy1 = nam + "1";
            var hocKy2 = (nam-1) + "2";
            this.sqlDataSource2.Connection.ConnectionString = connectionStringReport;
            this.sqlDataSource2.Queries[0].Parameters[0].Value = hocKy1;
            this.sqlDataSource2.Queries[0].Parameters[1].Value = hocKy2;

            string nguoiLapBang = "";
            string tenHocKy = "";
            string tpgv = "";
            string pgd = "";
            List<SqlParameter> param = new List<SqlParameter>();
            var Sql = new SQLHelper(connectionString);
            param.Add(new SqlParameter("@MaNKHK", hocKy1));
            param.Add(new SqlParameter("@KyHieu", "TPGV"));

            var tpgvDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            tpgv = tpgvDataTable.Rows.Count > 0 ? tpgvDataTable.Rows[0][3].ToString() : "";

            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", hocKy1));
            param.Add(new SqlParameter("@KyHieu", "PGD"));
            var pgdDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            pgd = pgdDataTable.Rows.Count>0?pgdDataTable.Rows[0][3].ToString():"";
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", hocKy1));
            param.Add(new SqlParameter("@KyHieu", "NLB"));

            var nguoiLapBangDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);

            nguoiLapBang = nguoiLapBangDataTable.Rows.Count > 0?nguoiLapBangDataTable.Rows[0][3].ToString():"";
            this.label_HK2.Text = "HỌC KÌ II NĂM HỌC "+(nam-1)+"-"+nam;
            this.label_HK1.Text = "HỌC KÌ I NĂM HỌC " + nam + "-" + (nam + 1);
            this.label_NKHK.Text = "NĂM "+nam;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.label_NguoiLapBang.Text = nguoiLapBang;
            this.sqlDataSource2.Fill();
        }
    }
}
