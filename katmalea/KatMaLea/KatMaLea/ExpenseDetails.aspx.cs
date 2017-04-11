using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class ExpenseDetails1 : System.Web.UI.Page
    {
        ExpenseDetailsCls exd = new ExpenseDetailsCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownList1.DataSource = exd.bindaccountCbo();
                DropDownList1.DataTextField = "AccountName";
                DropDownList1.DataValueField = "AccountID";
                DropDownList1.DataBind();
            }
            DropDownList1_SelectedIndexChanged(sender, e);
        }
        protected string getHtmlExpense()
        {
            return exd.getExpensedetails();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Master_default ma = new Master_default();
            if (Page.IsPostBack)
            {
                if (txtCredit.Text == string.Empty || txtdebit.Text == string.Empty)
                {
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    exd.AccountID = int.Parse(DropDownList1.SelectedValue);
                    exd.Credit = decimal.Parse(txtCredit.Text);
                    exd.Debit = decimal.Parse(txtdebit.Text);
                    exd.ExpenseID = int.Parse(Request.QueryString["ExpenseID"].ToString());
                    if (exd.InsertExpensedetails())
                    {
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', '')");
                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            //if (!IsPostBack)
            //{
            if (int.Parse(DropDownList1.SelectedValue) == 2 || int.Parse(DropDownList1.SelectedValue) == 1)
            {
                //
                txtCredit.Text = "0.00";
                txtCredit.ReadOnly = true;
                txtdebit.ReadOnly = false;
                
            }
                else
                {
                    txtdebit.Text = "0.00";
                    //
                    txtCredit.ReadOnly = false;
                    txtdebit.ReadOnly = true;
                    
                }
            //}

        }


    }
}