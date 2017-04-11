using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deletePosition : System.Web.UI.Page
    {
        PositionCls pos = new PositionCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request["posId"]!=null)
                {
                    if (pos.DeletePosition(Request["posId"].ToString()))
                    {
                        Response.Redirect("~/Positions.aspx");
                    }
                }
               
            }
        }
    }
}