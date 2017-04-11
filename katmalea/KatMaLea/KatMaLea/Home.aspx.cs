using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Home : System.Web.UI.Page
    {
        Loginx loginx = new Loginx();
        protected void Page_Init(object sender, EventArgs e)
        {
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void loginbutton_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                loginx.Username = Request.Form["usernametextbox"].ToString();
                loginx.Password = Request.Form["passwordtextbox"].ToString();
                if (loginx.isUserOk())
                {
                    Response.Redirect("~/welcome.aspx");
                }
            }
            
        }
    }
}