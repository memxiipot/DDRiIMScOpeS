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
    public partial class reportWeeklyMonthlyExpense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var connectionString =
new System.Data.SqlClient.SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["mainConnection"].ToString());


          //  if (Request.QueryString["DateFrom"] != null)
          //  {
                string DateFrom = Request.QueryString["DateFrom"].ToString();
                string DateTo = Request.QueryString["DateTo"].ToString();

                ParameterFields paramFields = new ParameterFields();
                ParameterField paramField = new ParameterField();
                ParameterDiscreteValue discreteVal = new ParameterDiscreteValue();
                paramField.ParameterFieldName = "@DateFrom";// This is how you can send Parameter Value to the Crystal Report
                discreteVal.Value = DateFrom;
                paramField.ParameterFieldName = "@DateTo";// This is how you can send Parameter Value to the Crystal Report
                discreteVal.Value = DateTo;
                paramField.CurrentValues.Add(discreteVal);
                paramFields.Add(paramField);
                ReportDocument report = new ReportDocument();
                report.Load(Server.MapPath("~/Reports/rptWeeklyMonthlyExpense.rpt"));//Here you can give the Path of external Server
                report.SetParameterValue("@DateFrom", DateFrom);
                report.SetParameterValue("@DateTo", DateTo);
                CrystalReportViewer1.ParameterFieldInfo = paramFields;
                report.SetDatabaseLogon(connectionString.UserID, connectionString.Password, connectionString.DataSource, connectionString.InitialCatalog);
                CrystalReportViewer1.ReportSource = report;


          //  }

        }

    }
}
