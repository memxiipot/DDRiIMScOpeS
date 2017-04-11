using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteExpense : System.Web.UI.Page
    {
        ExpenseCls ex = new ExpenseCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            ex.getDetails(Request.QueryString["ExpenseID"].ToString());
            string exid = ex.ExpenseID.ToString();
            if (!IsPostBack)
            {
                ViewState["PreviousPage"] = Request.UrlReferrer;

                if (ex.DeleteExpense(Request.QueryString["ExpenseID"].ToString()))
                {
                    Response.Redirect(ViewState["PreviousPage"].ToString());
                }
            }
        }
    }
}