using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Expense : System.Web.UI.Page
    {
        ExpenseCls ex = new ExpenseCls();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string getHtmlExpense()
        {
            return ex.getExpense();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Master_default ma = new Master_default();
            if (Page.IsPostBack)
            {
                if (txtpayee.Text == string.Empty || txtremarks.Text == string.Empty)
                {
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    int id;
                    ex.Payee = txtpayee.Text;
                    ex.Remarks = txtremarks.Text;
                    ex.ModeofPayment = DropDownpayment.SelectedIndex;

                    if (ex.InsertExpense())
                    {
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', '')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
            }
        }

        protected void DropDownpayment_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}