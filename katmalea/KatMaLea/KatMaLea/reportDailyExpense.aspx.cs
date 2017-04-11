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
    public partial class reportDailyExpense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var connectionString =
new System.Data.SqlClient.SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["mainConnection"].ToString());


            if (Request.QueryString["DateToday"] != null)
            {
                string DateToday = Request.QueryString["DateToday"].ToString();
                ParameterFields paramFields = new ParameterFields();
                ParameterField paramField = new ParameterField();
                ParameterDiscreteValue discreteVal = new ParameterDiscreteValue();
                paramField.ParameterFieldName = "@DateToday";// This is how you can send Parameter Value to the Crystal Report
                discreteVal.Value = DateToday;
                paramField.CurrentValues.Add(discreteVal);
                paramFields.Add(paramField);
                ReportDocument report = new ReportDocument();
                report.Load(Server.MapPath("~/Reports/rptDailyExpense.rpt"));//Here you can give the Path of external Server
                report.SetParameterValue("@DateToday", DateToday);
                CrystalReportViewer1.ParameterFieldInfo = paramFields;
                report.SetDatabaseLogon(connectionString.UserID, connectionString.Password, connectionString.DataSource, connectionString.InitialCatalog);
                CrystalReportViewer1.ReportSource = report;


            }

        }

    }
}
