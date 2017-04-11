using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteCategory : System.Web.UI.Page
    {
        categoriescls cls = new categoriescls();
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["catId"].ToString();
            if (cls.Delete(id))
            {
                Response.Redirect("~/categories.aspx");
            }
        }
    }
}