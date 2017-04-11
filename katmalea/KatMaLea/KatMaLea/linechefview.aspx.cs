using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class linechefview : System.Web.UI.Page
    {
        LineChefCls cls = new LineChefCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            cls.Page_Load();
            Timer1.Enabled = true;
        }
        protected string getOrderlist() {
            return cls.getPendingOrders();
        }
        protected string getlistofmenu() {
            string res = string.Empty;
            try
            {
                res = cls.getListOfOrders(Request.Form["order_id"].ToString());
            }
            catch (NullReferenceException)
            {

                res = string.Empty;
            }
               
           
            return res;
        }
        protected string getselTableno() {
            string res = string.Empty;
            try
            {
                res =Request.Form["tableno"].ToString();
            }
            catch (NullReferenceException)
            {

                res = "NO TABLE SELECTED";
            }


            return res;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsolutePath);
        }
    }
}