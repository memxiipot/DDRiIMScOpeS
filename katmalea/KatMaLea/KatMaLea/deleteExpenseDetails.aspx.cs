using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteExpenseDetails : System.Web.UI.Page
    {
        ExpenseDetailsCls exd = new ExpenseDetailsCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            exd.getDetails(Request.QueryString["ExpenseDetailsID"].ToString());
            string exid = exd.ExpenseID.ToString();
            if (!IsPostBack)
            {
                ViewState["PreviousPage"] = Request.UrlReferrer;

                if (exd.DeleteExpenseDetails(Request.QueryString["ExpenseDetailsID"].ToString(),exid ))
                {
                    Response.Redirect(ViewState["PreviousPage"].ToString());
                }
            }
        }
    }
}