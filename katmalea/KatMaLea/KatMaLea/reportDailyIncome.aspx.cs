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
    public partial class reportDailyIncome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var connectionString =
new System.Data.SqlClient.SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["mainConnection"].ToString());


            if (Request.QueryString["IssuedDate"] != null)
            {
                string IssuedDate = Request.QueryString["IssuedDate"].ToString();
                ParameterFields paramFields = new ParameterFields();
                ParameterField paramField = new ParameterField();
                ParameterDiscreteValue discreteVal = new ParameterDiscreteValue();
                paramField.ParameterFieldName = "@IssuedDate";// This is how you can send Parameter Value to the Crystal Report
                
                discreteVal.Value = IssuedDate;
                paramField.CurrentValues.Add(discreteVal);
                paramFields.Add(paramField);
                ReportDocument report = new ReportDocument();
                report.Load(Server.MapPath("~/Reports/rptDailyIncomeStatment.rpt"));//Here you can give the Path of external Server
               
                report.SetParameterValue("@IssuedDate", IssuedDate);
              
                report.OpenSubreport(Server.MapPath("~/Reports/rptDailyExpense1.rpt"));
                report.SetParameterValue("@DateToday", IssuedDate);
                CrystalReportViewer1.ParameterFieldInfo = paramFields;
                
                report.SetDatabaseLogon(connectionString.UserID, connectionString.Password, connectionString.DataSource, connectionString.InitialCatalog);
                CrystalReportViewer1.ReportSource = report;


            }

        }

    }
}
