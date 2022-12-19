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
    public partial class Report_ThanhToanGioGiang : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_ThanhToanGioGiang(String connectionString,String reportConnectionString, string maNKHK,string hocKyTruoc, ReportService _reportService)
        {
            InitializeComponent();
            this.sqlDataSource2.Connection.ConnectionString = reportConnectionString;
            this.sqlDataSource2.Queries[0].Parameters[0].Value = maNKHK;
            this.sqlDataSource2.Queries[0].Parameters[1].Value = hocKyTruoc;
            string tenHocKy = "";
            string tenNienKhoa = "";
            string tpgv = "";
            string pgd = "";
            string tpkttc = "";
            string nguoiLapBang = "";
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
            param.Add(new SqlParameter("@KyHieu", "PGD"));
            var pgdDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            pgd = pgdDataTable.Rows.Count > 0 ? pgdDataTable.Rows[0][3].ToString() : "";

            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "NLB"));
            var nlbDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            nguoiLapBang = nlbDataTable.Rows.Count > 0 ? nlbDataTable.Rows[0][3].ToString() : "";
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "TPKTTC"));

            var tpkttcDataTable = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            tpkttc = tpkttcDataTable.Rows.Count > 0 ? tpkttcDataTable.Rows[0][3].ToString() : "";
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.label_tpkttc.Text= tpkttc;
            this.label_NguoiLapBang.Text = nguoiLapBang;
            this.label_NCKH.Text = "NCKH năm " + (int.Parse(maNKHK.Substring(0, 4)) + 1)+ "";
            //NCKH chưa fix vì chưa rõ nghiệp vụ
            this.sqlDataSource2.Fill();
        }
    }
}
