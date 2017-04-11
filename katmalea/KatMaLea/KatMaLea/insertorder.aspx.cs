using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class insertorder : System.Web.UI.Page
    {
        Menus menu = new Menus();
        Order ordex = new Order();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                menudropdown.DataSource = menu.getMenuCbo();
                menudropdown.DataTextField = "Menu_Name";
                menudropdown.DataValueField = "MenuID";
                menudropdown.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                int qty = int.Parse(Request.Form["quantity"].ToString());
                string orderid=Request.QueryString["orderid"].ToString();
                ordex.OrderId = int.Parse(orderid);
                ordex.MenuId =int.Parse( menudropdown.SelectedValue);
                ordex.Quantity = int.Parse(Request.Form["quantity"].ToString());
                int countingredients = menu.checkingredient(int.Parse(menudropdown.SelectedValue), qty);
                if (countingredients > 0)
                {
                    Master_default ma = new Master_default();
                    ma.ShowToastr(this, "toastr_message", "toastr.info('Selected Item is out of order/quantity item is exceed to ingredients available, Please contact your System Adminitrator', 'Information')");
                    
                }
                else
                {
                    if (ordex.InsertMenuOrder())
                    {
                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
        }
        protected string getListoforderhtml() {
            return ordex.getListOfOrders(Request.QueryString["orderid"].ToString());
        }
        protected string getTableNo() {
            return ordex.getTableNoByOrderId(Request.QueryString["orderid"].ToString());
        }

        protected void menudropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Menus menu = new Menus();
            //int countingredients = menu.checkingredient(int.Parse(menudropdown.SelectedValue));
            //Master_default ma = new Master_default();

            //if (countingredients > 0)
            //{
            //    ma.ShowToastr(this, "toastr_message", "toastr.info('Selected Item is out of order, Please contact your System Adminitrator', 'Information')");
            //    Button1.Enabled = false;
            //}
            //else
            //{ Button1.Enabled = true; }
        }
    }
}