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
    public partial class Report_ThanhToanGioGiang_HK1 : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_ThanhToanGioGiang_HK1(String connectionString, String reportConnectionString, string maNKHK, string hocKyTruoc, ReportService _reportService)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = reportConnectionString;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maNKHK;
            this.sqlDataSource1.Queries[0].Parameters[1].Value = hocKyTruoc;
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
            tpgv = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "PGD"));
            pgd = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "NLB"));
            nguoiLapBang = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            param.Clear();
            param.Add(new SqlParameter("@MaNKHK", maNKHK));
            param.Add(new SqlParameter("@KyHieu", "TPKTTC"));
            tpkttc = Sql.ExecuteQuery("sp_Get_NguoiKy", param).Rows[0][3].ToString();
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.label_tpkttc.Text = tpkttc;
            this.label_NguoiLapBang.Text = nguoiLapBang;
            int namHoc = int.Parse(maNKHK.Substring(0, 4));
            this.label_NCKH.Text = "NCKH năm " + (namHoc) + " (Học kỳ II năm học "+(namHoc-1)+"-"+(namHoc)+"; Học kỳ I năm học "+(namHoc)
                +"-"+(namHoc+1)+")";
            //NCKH chưa fix vì chưa rõ nghiệp vụ
            this.sqlDataSource1.Fill();
        }
    }
}
