using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editCategory : System.Web.UI.Page
    {
        categoriescls cat = new categoriescls();
        private string mycategory;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                mycategory = categorytextbox.Value;
            }
            string catid = Request.QueryString["catId"].ToString();
            if (catid != null)
            {
                cat.getcategoryDetails(catid);
                categorytextbox.Value = cat.category;
   
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                string catid = Request.QueryString["catId"].ToString();
                cat.category = mycategory;
                if (cat.Update(catid))
                {
                    Response.Redirect("~/categories.aspx");
                }
            }
        }
    }
}