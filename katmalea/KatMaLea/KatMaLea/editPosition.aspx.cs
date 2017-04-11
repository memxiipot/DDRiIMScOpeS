using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editPosition : System.Web.UI.Page
    {
        PositionCls pos = new PositionCls();
        private string myposition;
        private string mystatus;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                myposition = positiontextbox.Value;
                mystatus = (statusradiobutton.Checked==true) ? "1" : "0";
            }
            string ingredid = Request.QueryString["posId"].ToString();
            if (ingredid != null)
            {
                pos.getPositonDetails(ingredid);
                positiontextbox.Value = pos.PositionName;
                statusradiobutton.Checked = (pos.Status == "True") ? true : false;
                Radio1.Checked = (pos.Status == "True") ? false : true    ;
               
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                pos.PositionName = myposition;
                pos.Status = mystatus;
                if (pos.Update(Request.QueryString["posId"].ToString()))
                {
                    Response.Redirect("~/Positions.aspx");
                }
            }
        }
    }
}