using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class categories : System.Web.UI.Page
    {
        categoriescls cls = new categoriescls();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                Master_default ma = new Master_default();
                if (Request.Form["category"].ToString() == string.Empty)
                {                   
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    cls.category = Request.Form["category"].ToString();
                    if (cls.Insert())
                    {
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', '')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
            }
        }
        protected string getcategoryhtml() {
          return  cls.getcategory();
        }
      
    }
}