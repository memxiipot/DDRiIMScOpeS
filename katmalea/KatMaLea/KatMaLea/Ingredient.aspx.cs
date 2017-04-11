using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Ingredients : System.Web.UI.Page
    {
        clsIngredients ingred = new clsIngredients();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                if (Request["ingredient"].ToString() == string.Empty || Request["limit"].ToString() == string.Empty)
                {
                    Master_default ma = new Master_default();
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                    //menuname.BackColor = ConsoleColor.Cyan.ToString();
                }
                else
                {
                    ingred.IngredientName = Request["ingredient"].ToString();
                    ingred.Status = int.Parse(Request["statusradio"].ToString());
                    ingred.limit = Request["limit"].ToString();
                    if (ingred.getdatarowcount(Request["ingredient"].ToString()).Rows.Count == 0)
                    {
                        if (ingred.Insert())
                        {
                            Master_default ma = new Master_default();
                            ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', '')");
                            //Response.Redirect(Request.Url.AbsolutePath);
                        }
                    }
                    else
                    {
                        Master_default ma = new Master_default();
                        ma.ShowToastr(this, "toastr_message", "toastr.info('ingredient already exist.', '')");
                    }
                }
            }
        }
        protected string getIngredientsHtml() {
            return ingred.getIngredient();
        }
       
    }
}