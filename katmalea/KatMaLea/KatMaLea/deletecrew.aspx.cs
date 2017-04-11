using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deletecrew : System.Web.UI.Page
    {
        crewcls cls = new crewcls();
        protected void Page_Load(object sender, EventArgs e)
        {
           
                if (cls.DeletePosition(Request.QueryString["crewid"].ToString())) {
                    Response.Redirect("~/crewlist.aspx");
                }
            
        }
    }
}