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
        public Report_TiLe_GiangDay(String connectionString, String connectionStringReport, string nienKhoa, ReportService _reportService)
        {
            InitializeComponent();
            var nienKhoaSplit = nienKhoa.Split('-')[0];
            var hocKy1 = nienKhoaSplit + '1';
            var hocKy2 = nienKhoaSplit + '2';
            this.sqlDataSource1.Connection.ConnectionString = connectionStringReport;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = hocKy1;
            this.sqlDataSource1.Queries[0].Parameters[1].Value = hocKy2;

            string nguoiLapBang = "";
            string tenHocKy = "";
            string tpgv = "";
            string pgd = "";
            List<SqlParameter> param = new List<SqlParameter>();
            var Sql = new SQLHelper(connectionString);
            param.Add(new SqlParameter("@MaNKHK", hocKy2));
            param.Add(new SqlParameter("@KyHieu", "TPGV"));
            tpgv = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", hocKy2));
            param.Add(new SqlParameter("@KyHieu", "PGD"));
            pgd = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", hocKy2));
            param.Add(new SqlParameter("@KyHieu", "NLB"));
            nguoiLapBang = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            tenHocKy += " NIÊN KHÓA " + nienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.label_NguoiLapBang.Text = nguoiLapBang;
            this.sqlDataSource1.Fill();
        }
    }
}
