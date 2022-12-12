﻿using DevExpress.XtraReports.UI;
using Microsoft.Data.SqlClient;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Report
{
    public partial class Report_KL_TTTN : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_KL_TTTN(String connectionString, String connectionStringReport, string maNKHK, ReportService _reportService)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = connectionStringReport;
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maNKHK;
            string nguoiLapBang = "";
            string tenHocKy = "";
            string tenNienKhoa = "";
            string tpgv = "";
            string pgd = "";
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
            var pdgDataTale = Sql.ExecuteQuery("sp_Get_NguoiKy", param);
            pgd = pdgDataTale.Rows.Count > 0 ? pdgDataTale.Rows[0][3].ToString() : "";
            tenHocKy += " Năm học " + tenNienKhoa;
            this.label_NKHK.Text = tenHocKy;
            this.label_TPGV.Text = tpgv;
            this.label_PGD.Text = pgd;
            this.sqlDataSource1.Fill();
        }
    }
}
