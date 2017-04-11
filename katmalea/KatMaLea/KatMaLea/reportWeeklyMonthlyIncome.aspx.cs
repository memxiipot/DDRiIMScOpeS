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
    public partial class reportWeeklyMonthlyIncome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var connectionString =
new System.Data.SqlClient.SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["mainConnection"].ToString());


            if (Request.QueryString["StartDate"] != null)
            {
                string StartDate = Request.QueryString["StartDate"].ToString();
                string EndDate = Request.QueryString["EndDate"].ToString();
                ParameterFields paramFields = new ParameterFields();
                ParameterField paramField = new ParameterField();
                ParameterDiscreteValue discreteVal = new ParameterDiscreteValue();
                paramField.ParameterFieldName = "@StartDate";// This is how you can send Parameter Value to the Crystal Report
                paramField.ParameterFieldName = "@EndDate";
                discreteVal.Value = StartDate;
                discreteVal.Value = EndDate;
                paramField.CurrentValues.Add(discreteVal);
                paramFields.Add(paramField);
                ReportDocument report = new ReportDocument();
                report.Load(Server.MapPath("~/Reports/rptWeeklyMonthlyIncome.rpt"));//Here you can give the Path of external Server

                report.SetParameterValue("@StartDate", StartDate);
                report.SetParameterValue("@EndDate", EndDate);

                report.OpenSubreport(Server.MapPath("~/Reports/rptWeeklyMonthlyExpense.rpt"));
                report.SetParameterValue("@DateFrom", StartDate);
                report.SetParameterValue("@DateTo", EndDate);

                CrystalReportViewer1.ParameterFieldInfo = paramFields;
                
                report.SetDatabaseLogon(connectionString.UserID, connectionString.Password, connectionString.DataSource, connectionString.InitialCatalog);
                CrystalReportViewer1.ReportSource = report;


            }

        }

    }
}
