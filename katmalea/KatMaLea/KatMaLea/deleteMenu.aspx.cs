using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteMenu : System.Web.UI.Page
    {
        Menus menu = new Menus();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["menuid"]!=null)
            {
                if (menu.DeleteMenu(Request["menuid"].ToString()))
                {
                    Response.Redirect("~/menus.aspx");
                }
            }
        }
    }
}