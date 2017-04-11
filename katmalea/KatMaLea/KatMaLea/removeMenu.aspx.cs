using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class removeMenu : System.Web.UI.Page
    {
        Menus menu = new Menus();
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["PreviousPage"] = Request.UrlReferrer;
            string id = Request.QueryString["menuid"].ToString();
            if (menu.RemoveMenuFromCategory(id))
            {
                Response.Redirect(ViewState["PreviousPage"].ToString());
            }
        }
    }
}