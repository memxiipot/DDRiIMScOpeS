using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{

	
    public partial class manageorder : System.Web.UI.Page
    {

        private int myorderNum;

        public int ordernum
        {
            get { return myorderNum; }
            set { myorderNum = value; }
        }

        Order order = new Order();
        string authorKey = "authors";
        private static string msg = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // If the session variable is empty, initialize an 
                // empty list as the datasource
                if (Session[authorKey] == null)
                {
                    Session[authorKey] = new List<Menu>();
                }
                BindList();
            }
            else
                Session[authorKey] = null;
        }

        protected void orderbutton_Click(object sender, EventArgs e)
        {

            //if (Page.IsPostBack)
            //{
            //    order.tableno = int.Parse(tabledropdown.SelectedValue);
            //    order.Crew = 1;
            //    order.Requestt = (string.IsNullOrWhiteSpace(Request.Form["request"].ToString()) ? string.Empty : Request.Form["request"].ToString());
            //    if (order.InsertOrder())
            //    {
            //        msg = "Successfully created new order";
            //        Response.Redirect("~/orderlist.aspx");
            //    }
            //}
	        
        }
        protected static string message() {
            if (string.IsNullOrEmpty(msg)) return string.Empty;
            return "<div class=\"alert alert-success\" role=\"alert\"> "+ msg +"</div>";
        }

        protected void addmenu_Click(object sender, EventArgs e)
        {
            List<Menu> authors = (List<Menu>)Session[authorKey];
            authors.Add(new Menu(menudropdown.SelectedValue));
            BindList();
        }
        private void BindList()
        {
            GridView1.DataSource = (List<Menu>)Session[authorKey];
            GridView1.DataBind();
        }

        // Basic author object, used for databinding
        private class Menu
        {
            public String myMenu { get; set; }

            public Menu(string name)
            {
                myMenu = name;
            }
        }

  


      

       

     
    }
}