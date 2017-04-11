using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class welcome : System.Web.UI.Page
    {
        protected string menu = string.Empty;
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["UserType"] == null) {
                Response.Redirect("~/Home.aspx");
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            int usertype = int.Parse(Session["UserType"].ToString());
            switch (usertype)
            {
                case 2:
                    //CASHIERING
                    menu += "<a href=\"order.aspx\" ><div class=\"thumbnail thumb-div\">" +
                    "<h4>Cashiering</h4> " +
                    "<p>Create | Edit | Void Orders</p>" +
                    "<img src=\"images/welcome/cashiering-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    break;
                case 3:
                    //INVENTORY
                    menu += "<a href=\"Inventory.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Inventory</h4> " +
                    "<p>Re-stock</p> " +
                    "<img src=\"images/welcome/inventory-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //FOOD SETTINGS
                    menu += "<a href=\"menus.aspx?countid=0&categoryid=0\"><div class=\"thumbnail thumb-div\" style=\"text-align: center\">" +
                    "<h4>Food Settings</h4>" +
                    "<p>Ingredients | Menu | Categories</p>" +
                    "<img src=\"images/welcome/menu-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    break;
                case 4:
                case 1:
                    //ORDERING
                    menu += "<a href=\"linechefview.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Ordering</h4>" +
                    "<p>View orders to be cooked</p>" +
                    "<img src=\"images/welcome/chef-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //FOOD SETTINGS
                    menu += "<a href=\"menus.aspx?countid=0&categoryid=0\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Food Settings</h4>" +
                    "<p>Ingredients | Menu | Categories</p>" +
                    "<img src=\"images/welcome/menu-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //MAINTENANCE
                    menu += "<a href=\"Equipment.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Maintenance</h4> " +
                    "<p>Equipment cleaning schedule</p> " +
                    "<img src=\"images/welcome/maintenance-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //REFERENCES
                    menu += "<a href=\"Positions.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>References</h4> " +
                    "<p>Position | Crew | Measurements</p>" +
                    "<img src=\"images/welcome/reference-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //SETTINGS
                    menu += "<a href=\"userslist.aspx\"> <div class=\"thumbnail thumb-div\">" +
                    "<h4>Settings</h4> " +
                    "<p>Audit Trail | Add User</p>" +
                    "<img src=\"images/welcome/settings-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //INVENTORY
                    menu += "<a href=\"Inventory.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Inventory</h4>" +
                    "<p>Re-stock</p> " +
                    "<img src=\"images/welcome/inventory-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //EXPENSE
                    menu += "<a href=\"Expense.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Expenses</h4>" +
                    "<p>Add Expense | Edit Expense</p>" +
                    "<img src=\"images/welcome/expenses-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //CASHIERING
                    menu += "<a href=\"order.aspx\" ><div class=\"thumbnail thumb-div\">" +
                    "<h4>Cashiering</h4> " +
                    "<p>Create | Edit | Void Orders</p>" +
                    "<img src=\"images/welcome/cashiering-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    //REPORTS
                    menu += "<a href=\"listreports.aspx\" ><div class=\"thumbnail thumb-div\">" +
                    "<h4>Reports</h4> " +
                    "<p>Generate Reports</p>" +
                    "<img src=\"images/welcome/reports-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    break;
                case 5:
                    //ORDERING
                    menu += "<a href=\"linechefview.aspx\"><div class=\"thumbnail thumb-div\">" +
                    "<h4>Ordering</h4>" +
                    "<p>Views order to be cooked</p>" +
                    "<img src=\"images/welcome/chef-icon.png\" class=\"flip\" alt=\"...\"></div></a>";
                    break;
                default:
                    break;
            }
             
        }
    }
}