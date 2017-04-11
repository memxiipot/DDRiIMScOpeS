using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    
    public partial class editMenu : System.Web.UI.Page
    {
        Menus menu = new Menus();
        categoriescls cls = new categoriescls();
        string mymenuname;
        string myprice;
        string mycategoryId;
        protected void Page_Init(object sender, EventArgs e) { 
        
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                mymenuname = menunametextbox.Value;
                myprice = pricetextbox.Value;
                mycategoryId = categorydropdown.SelectedValue.ToString();
            }
            else {
                string menuid = Request.QueryString["menuid"].ToString();
                if (menuid != null)
                {
                    menu.getDetails(menuid);
                    menunametextbox.Value = menu.MenuName;
                    pricetextbox.Value = menu.Price;
                    mycategoryId = menu.categoryId;
                    categorydropdown.DataSource = cls.bindcategoryCbo();
                    categorydropdown.DataTextField = "CategoryName";
                    categorydropdown.DataValueField = "CategoryID";
                    categorydropdown.DataBind();
                    if (string.IsNullOrWhiteSpace(mycategoryId)) {
                        categorydropdown.SelectedValue = "0"; ;
                    }
                }
            }
               
        }
        protected void bindDropDown()
        {
            //return cls.getcategorycbo();

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {

                menu.MenuName = mymenuname;
                menu.Price = myprice;
                menu.categoryId = mycategoryId;
                string menuid = Request.QueryString["menuid"].ToString();
                if (menu.EditMenu(int.Parse(menuid)))
                {
                    Response.Redirect("~/menus.aspx?countid=0&categoryid=0");
                }
            }
          
            
         
        }
    }
}