using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class IngredientsMenu : System.Web.UI.Page
    {
        Menus menu = new Menus();
        clsIngredients ingred = new clsIngredients();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownIngredient.DataSource = ingred.getIngredientaspCbo();
                DropDownIngredient.DataTextField = "Name";
                DropDownIngredient.DataValueField = "IngredientsID";
                DropDownIngredient.DataBind();
            }
            DropDownpayment_SelectedIndexChanged(sender, e);
        }
        //protected string getIngredients() {
        //    return ingred.getIngredientCbo();
        //}

        protected void Button1_Click(object sender, EventArgs e)
        {
            //int countingredients = ingred.checkingredient(Request.QueryString["menuid"].ToString());
            Master_default ma = new Master_default();
            if (Page.IsPostBack)
	            {
                if (Request.Form["quantity"].ToString() == string.Empty)
                {
                    
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    string menuid = Request.QueryString["menuid"].ToString();
                    //string ingredid=Request.Form["ingredientcbo"].ToString();
                    int ingredid = int.Parse(DropDownIngredient.SelectedValue);
	                menu.Quantity=	 Request.Form["quantity"].ToString();
                    //if (countingredients > 0)
                    //{
                    //    ma.ShowToastr(this, "toastr_message", "toastr.info('Ingredient already exist, please delete them item to proceed', 'Information')");
                    //}
                    //else
                    //{
                        if (menu.InserIngredToMenu(menuid, ingredid))
                        {
                            ma.ShowToastr(this, "toastr_message", "toastr.success('Menu has been successfully saved.', '')");
                            //Response.Redirect(Request.RawUrl);
                        }
                    //}
                }
	            }
    
        }
        protected string getIngredientsOfMenu() {
            return ingred.getIngredientsOfMenu(Request.QueryString["menuid"].ToString());
        }

        protected void DropDownpayment_SelectedIndexChanged(object sender, EventArgs e)
        {
            int countingredients = ingred.checkingredient(Request.QueryString["menuid"].ToString(),DropDownIngredient.SelectedValue.ToString());
            Master_default ma = new Master_default();
            
                if (countingredients > 0)
                {
                    ma.ShowToastr(this, "toastr_message", "toastr.info('Ingredient already exist, please delete the item to proceed', 'Information')");
                    Button1.Enabled = false;
                }
                else
                { Button1.Enabled = true; }
            
        }

    }
}