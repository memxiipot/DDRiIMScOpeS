using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteordermenu : System.Web.UI.Page
    {
        Order ordex = new Order();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["PreviousPage"] = Request.UrlReferrer;

                if (ordex.DeleteMenuOrder(Request.QueryString["orderdetailsid"].ToString()))
                {
                    Response.Redirect(ViewState["PreviousPage"].ToString());
                }
            }
        }
    }
}