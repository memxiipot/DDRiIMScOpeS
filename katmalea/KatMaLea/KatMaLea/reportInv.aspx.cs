using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Configuration;

namespace KatMaLea
{
    public partial class reportInv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var connectionString =
new System.Data.SqlClient.SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["mainConnection"].ToString());
                ReportDocument report = new ReportDocument();
                //report.Load(Server.MapPath("~/Reports/bestseller.rpt"));//Here you can give the Path of external Server
                report.Load(Server.MapPath("~/Reports/rptMostIngUsed.rpt"));
                report.SetDatabaseLogon(connectionString.UserID, connectionString.Password, connectionString.DataSource, connectionString.InitialCatalog);
                CrystalReportViewer1.ReportSource = report;
            
        }

    }
}