using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class menuOrderStat : System.Web.UI.Page
    {
        Order ord = new Order();
        protected void Page_Load(object sender, EventArgs e)
        {
           
                string id=Request.QueryString["orderdetailsid"].ToString();
                if (ord.changeOrderDetailsStatus("1",id,Request.QueryString["orderid"].ToString()))
                {
                    
                    ViewState["PreviousPage"] = Request.UrlReferrer;

                        Response.Redirect(ViewState["PreviousPage"].ToString());
                    
                }
            
        }
    }
}