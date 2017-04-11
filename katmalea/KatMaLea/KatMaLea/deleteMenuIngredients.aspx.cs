using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteMenuIngredients : System.Web.UI.Page
    {
        clsIngredients cls = new clsIngredients();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["PreviousPage"] = Request.UrlReferrer;
                
                if (cls.DeleteIngredientsOfMenu(Request.QueryString["id"].ToString()))
                {
                    Response.Redirect(ViewState["PreviousPage"].ToString());
                }
            }
        }
    }
}