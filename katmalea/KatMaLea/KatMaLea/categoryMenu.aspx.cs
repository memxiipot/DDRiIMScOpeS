using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class categoryMenu : System.Web.UI.Page
    {
        Menus menu = new Menus();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string getMenucategoryhtml() {
            return menu.getMenuCategory(Request.QueryString["catId"].ToString());
        }
    }
}