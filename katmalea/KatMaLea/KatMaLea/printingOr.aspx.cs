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
    public partial class printingOr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var connectionString =
  new System.Data.SqlClient.SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["mainConnection"].ToString());
            
               
                if (Request.QueryString["orno"] != null)
                {
                    string orno = Request.QueryString["orno"].ToString();
                    ParameterFields paramFields = new ParameterFields();
                    ParameterField paramField = new ParameterField();
                    ParameterDiscreteValue discreteVal = new ParameterDiscreteValue();
                    paramField.ParameterFieldName = "@ORNo";// This is how you can send Parameter Value to the Crystal Report
                    discreteVal.Value = orno;
                    paramField.CurrentValues.Add(discreteVal);
                    paramFields.Add(paramField);
                    ReportDocument report = new ReportDocument();
                    report.Load(Server.MapPath("~/Reports/rptOrReceipt.rpt"));//Here you can give the Path of external Server
                    report.SetParameterValue("@ORNo", orno);
                    CrystalReportViewer1.ParameterFieldInfo = paramFields;
                    report.SetDatabaseLogon(connectionString.UserID, connectionString.Password, connectionString.DataSource, connectionString.InitialCatalog);
                    CrystalReportViewer1.ReportSource = report;
                }
            
          
          
        }

        protected void computebutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/billout.aspx");
        }
    }
}