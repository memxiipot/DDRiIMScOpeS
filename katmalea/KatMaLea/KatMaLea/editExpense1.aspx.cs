using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editExpense1 : System.Web.UI.Page
    {
        ExpenseCls ex = new ExpenseCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string exid = Request.QueryString["ExpenseID"].ToString();
                if (exid != null)
                {
                    ex.getDetails(exid);
                    txtpayee.Text = ex.Payee;
                    txtremarks.Text = ex.Remarks;
                    DropDownpayment.SelectedIndex = ex.ModeofPayment;
                }

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                ex.Payee = txtpayee.Text;
                ex.Remarks = txtremarks.Text;
                ex.ModeofPayment = DropDownpayment.SelectedIndex;//int.Parse(Request.QueryString["equipmentcbo"].ToString());
                string eqid = Request.QueryString["ExpenseID"].ToString();
                if (ex.EditExpense(int.Parse(eqid)))
                {
                    Response.Redirect("~/Expense.aspx");
                }
            }
        }
    }
}