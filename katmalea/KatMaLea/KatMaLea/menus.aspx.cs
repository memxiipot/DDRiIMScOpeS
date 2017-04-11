using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class menus : System.Web.UI.Page
    {
        int count = 0;
        
        Menus menu = new Menus();
        categoriescls cls = new categoriescls();
        protected void Page_Load(object sender, EventArgs e)
        {          
            if (!Page.IsPostBack)
            {
                cbovwCategory.DataSource = cls.bindcategoryCboSearch();
                cbovwCategory.DataTextField = "CategoryName";
                cbovwCategory.DataValueField = "CategoryID";
                cbovwCategory.DataBind();
                if (Request.QueryString["categoryid"].ToString() == null)
                {
                    cbovwCategory.SelectedValue = "0";
                }
                else
                {
                    cbovwCategory.SelectedValue = Request.QueryString["categoryid"].ToString();
                }
            }
            
            try
            {
                count = int.Parse(Request.QueryString["countid"].ToString());

                if (int.Parse(Request.QueryString["categoryid"]) == 0)
                {
                    menu.getMenuCounts("");
                }
                else { menu.getMenuCounts(Request.QueryString["categoryid"]); }
                
                if (menu.test < count + 10)
                {
                    LinkButton1.Visible = false;
                }
                else
                {
                    LinkButton1.Visible = true;
                }
                if (count == 0)
                {
                    LinkButton2.Visible = false;
                }
                else { menu.test2 = cbovwCategory.Text;LinkButton2.Visible = true; }
            }
            catch (NullReferenceException)
            {

                return;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Master_default ma = new Master_default();
            
    //        Page.ClientScript.RegisterStartupScript(this.GetType(),
    //"toastr_message", "toastr.error('There was an error', 'Error')", true);

            if (Page.IsPostBack)
            {
                //spanmessage.InnerHtml = string.Empty;
                if (menuname.Text == string.Empty || Request.Form["price"].ToString() == string.Empty)
                {
                   
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                    //menuname.BackColor = ConsoleColor.Cyan.ToString();
                }
                else
                {
                    menu.MenuName = menuname.Text;//Request.Form["menuname"].ToString();
                    menu.Price = Request.Form["price"].ToString();
                    menu.categoryId = Request.Form["ingredientcbo"].ToString();
                    if (menu.ifmenuexist(menuname.Text).Rows.Count == 1)
                    { ma.ShowToastr(this, "toastr_message", "toastr.info('Menu name already exist.', '')"); }
                    else
                    {
                        if (menu.InsertMenu())
                        {
                            //Master_default ma = new Master_default();
                            ma.ShowToastr(this, "toastr_message", "toastr.success('Menu has been successfully saved.', '')");
                            //Response.Redirect("~/menus.aspx?countid=0");
                        }
                    }
                }

            }
            
        }
        protected void ShowToastr(Page page, string caption, string title)
        {
            page.ClientScript.RegisterStartupScript(page.GetType(),
    caption, title, true);
        }
        protected int count2()
        {
            return count;
        }
        protected string getHtmlMenu(int ct) {
            if(cbovwCategory.SelectedValue == "0" || cbovwCategory.SelectedValue == string.Empty)
            {
                return menu.getMenu(ct,"");
            }
            else
            {
                menu.test2 = cbovwCategory.SelectedValue;
                return menu.getMenu(ct, menu.test2);
            }
        }
        protected string getcategorycbo()
        {
            return cls.getcategorycbo();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            
            count = count + 10;
            menu.getMenuCounts(Request.QueryString["categoryid"].ToString());
            menu.test2 = cbovwCategory.SelectedValue;
            Response.Redirect("~/menus.aspx?countid=" + count + "&categoryid=" + menu.test2, true);
            if (count + 10 < menu.test)
            {
                LinkButton1.Visible = false;
            }
            
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {           
            count = count - 10;

            Response.Redirect("~/menus.aspx?countid=" + count + "&categoryid=" + menu.test2);
        }

        protected void cbovwCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (int.Parse(Request.QueryString["categoryid"]) == 0)
            //{
            //    menu.getMenuCounts("");
            //}
            //else { menu.getMenuCounts(Request.QueryString["categoryid"]); }

            //if (menu.test < count + 10)
            //{
            //    LinkButton1.Visible = false;
            //}
            //else
            //{
            //    LinkButton1.Visible = true;
            //}
            //cbovwCategory.SelectedValue = Request.QueryString["categoryid"].ToString();
            //Response.Redirect("~/menus.aspx?countid=" + count + "&categoryid=" + cbovwCategory.SelectedValue.ToString());
        }

        protected void cbovwCategory_TextChanged(object sender, EventArgs e)
        {

        }

    }
}