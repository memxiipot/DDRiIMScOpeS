using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class verifyorder : System.Web.UI.Page
    {
        verifiyordercls clsverify = new verifiyordercls();
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(ortextbox.Text.Trim()))
            {
                spanmessage.InnerHtml = messagecls.alertWarning("Or no is empty");
                return;
            }
            if (Page.IsPostBack)
            {
                clsverify.getOrDetails(ortextbox.Text.Trim());
                customernametextbox.Text = clsverify.CustomerName;
                companynametextbox.Text = clsverify.CompanyName;
                renderedamounttextbox.Text = clsverify.CashRendered;
                totalcosttextbox.Text = clsverify.TotalCost;
                discounttextbox.Text = clsverify.Discount;
                svchargetextbox.Text = clsverify.SvcCharge;
                issuedbytextbox.Text = clsverify.IssuedBy;
                dateissued.Text = clsverify.IssuedDate;
            }
        }
        protected string getOrderedMenu() {
            return clsverify.getOrderedMenu(ortextbox.Text.Trim());
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(ortextbox.Text.Trim()))
            {
                spanmessage.InnerHtml = messagecls.alertWarning("Or no is empty");
                return;
            }
            Response.Redirect("~/printingOr.aspx?orno=" + ortextbox.Text.Trim());
        }
    }
}