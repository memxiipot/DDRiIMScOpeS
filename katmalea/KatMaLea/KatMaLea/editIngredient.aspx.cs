using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editIngredient : System.Web.UI.Page
    {
        clsIngredients ingred = new clsIngredients();
        private string myingredient;
        private string mystat;
        private string mylimit;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                myingredient = ingredienttextox.Value;
                mystat = (activeradio.Value == "1") ? "1" : "2";
                mylimit = limitid.Value;
            }
            string ingredid = Request.QueryString["ingredientId"].ToString();
            if (ingredid != null)
            {
                ingred.getDetails(ingredid);
                ingredienttextox.Value = ingred.IngredientName;
                inactiveradio.Checked=(ingred.Status==2)? true:false;
                activeradio.Checked = (ingred.Status == 1) ? true : false;
                limitid.Value = ingred.limit;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            if (Page.IsPostBack)
            {
                string ingredid = Request.QueryString["ingredientId"].ToString();
                ingred.IngredientName = myingredient;
                ingred.Status =int.Parse( mystat);
                string menuid = Request.QueryString["ingredientId"].ToString();
                ingred.limit = mylimit;
                if (ingred.Update(ingredid))
                {
                    Response.Redirect("~/Ingredient.aspx");
                }
            }
        }
    }
}