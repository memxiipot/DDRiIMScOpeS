using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea.controls
{
    public partial class Navigation : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string userNavigationType() {
            string result = string.Empty;
            if(Session["UserType"]!=null)
            try
            {
                result += "<li><a href=\"../ChartFoodOrder.aspx\">Dashboard</a></li>";
                result += "<li><a href=\"#\">Welcome! " + Session["Username"].ToString()+"</a></li>";
                result +="<li><a href=\"../logout.aspx\">Logout</a></li>";
                

            }
            catch (NullReferenceException)
            {

                return result;
            }
  
           
            return result;
        }
    }
}