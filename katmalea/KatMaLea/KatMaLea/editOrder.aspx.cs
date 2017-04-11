using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editOrder : System.Web.UI.Page
    {
        Order ordercls = new Order();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                tabledropdown.DataSource = ordercls.getPendingTablenoCbo();
                tabledropdown.DataTextField = "Order_TableNo";
                tabledropdown.DataValueField = "Order_Id";
                tabledropdown.DataBind();
                if (tabledropdown.Items.Count > 0)
                {
                    tabledropdown.SelectedIndex = 0;
                    tabledropdown_SelectedIndexChanged(sender, e);
                }
            }
        }
        protected string getListoforderhtml()
        {
            return ordercls.getListOfOrders(tabledropdown.SelectedValue);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/insertorder.aspx?orderid=" + tabledropdown.SelectedValue);
           
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                if (ordercls.deleteOrder(tabledropdown.SelectedValue))
                {
                    Response.Redirect(Request.RawUrl);
                }
            }
        }

        protected void tabledropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tabledropdown.SelectedValue == string.Empty) return;
            if (ordercls.isOrderHasAlreadyServed(tabledropdown.SelectedItem.ToString()))
            {
                Button2.Visible = false;
            }
            else
                Button2.Visible = true;
        }
    }
}