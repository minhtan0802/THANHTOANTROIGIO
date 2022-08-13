using DevExpress.XtraReports.UI;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;

namespace THANHTOANTROIGIO.Report
{
    public partial class Report_KL_Giang : DevExpress.XtraReports.UI.XtraReport
    {
        public Report_KL_Giang(String connectionString, string maNKHK)
        {
            InitializeComponent();
            this.sqlDataSource1.Connection.ConnectionString = "XpoProvider=MSSqlServer;data source=LAPTOP-V0HI7R3V\\SERVER;user id=sa;password=sa;initial catalog=THANHTOANTROIGIO;Persist Security Info=true";
            this.sqlDataSource1.Queries[0].Parameters[0].Value = maNKHK;
            this.sqlDataSource1.Fill();
        }
    }
}
