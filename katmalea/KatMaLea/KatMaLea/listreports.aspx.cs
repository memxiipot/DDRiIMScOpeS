using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class listreports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cboReportOption_PreRender(object sender, EventArgs e)
        {

        }

        


        protected void Button1_Click(object sender, EventArgs e)
        {
            // if (string.IsNullOrWhiteSpace(ortextbox.Text.Trim()))
            // {
            //      spanmessage.InnerHtml = messagecls.alertWarning("Or no is empty");
            //      return;
            //  }
            // Response.Redirect("~/WebForm2.aspx?=" + Calendar1.SelectedDate.ToString());
            if (cboReportType.Text == "TOP 10 BEST DISHES")
            {
                Response.Redirect("~/reportBestSelling.aspx?");
            }
            else if (cboReportType.Text == "TOP 10 LEAST DISHES")
            {
                Response.Redirect("~/reportLeastSelling.aspx?");
            }
            else if (cboReportType.Text == "INGREDIENTS MOST USED")
            {
                Response.Redirect("~/reportInv.aspx?");
            }
            else if (cboReportType.Text == "EXPENSE PER DAY")
            {
                Response.Redirect("~/reportDailyExpense.aspx?DateToday=" + Calendar1.SelectedDate.ToString());
            }

            else if (cboReportType.Text == "EXPENSE PER WEEK or MONTH")
            {
                Response.Redirect("~/reportWeeklyMonthlyExpense.aspx?DateFrom=" + Calendar1.SelectedDate.ToString() + "&DateTo=" + Calendar2.SelectedDate.ToString());
                // Response.Redirect("~/reportWeeklyMonthlyExpense.aspx?DateTo=" + Calendar2.SelectedDate.ToString());
            }

            else if (cboReportType.Text == "INCOME PER DAY")
            {
                Response.Redirect("~/reportDailyIncome.aspx?IssuedDate=" + Calendar1.SelectedDate.ToString());
            }

            else if (cboReportType.Text == "INCOME PER WEEK or MONTH")
            {
                Response.Redirect("~/reportWeeklyMonthlyIncome.aspx?StartDate=" + Calendar1.SelectedDate.ToString() + "&EndDate=" + Calendar2.SelectedDate.ToString());
            }





        }

        protected void cboReportOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            cboReportType.Items.Clear();
            if (cboReportOption.Text == "EXPENSE")
            {
                cboReportType.Items.Add("EXPENSE PER DAY");
                cboReportType.Items.Add("EXPENSE PER WEEK or MONTH");

            }
            else if (cboReportOption.Text == "INGREDIENTS")
            {
                cboReportType.Items.Add("INGREDIENTS MOST USED");
            }
            else if (cboReportOption.Text == "DISHES")
            {
                cboReportType.Items.Add("TOP 10 BEST DISHES");
                cboReportType.Items.Add("TOP 10 LEAST DISHES");
            }
            else if (cboReportOption.Text == "INCOME")
            {
                cboReportType.Items.Add("INCOME PER DAY");
                cboReportType.Items.Add("INCOME PER WEEK or MONTH");

            }

            cboReportType.Focus();
        }

          
    }
}