using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteIngredient : System.Web.UI.Page
    {
        clsIngredients ingred = new clsIngredients();
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["ingredientId"].ToString();
            if (ingred.Delete(id))
            {
                Response.Redirect("~/Ingredient.aspx");
            }
        }
    }
}