using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class measurement : System.Web.UI.Page
    {
        measurementcls cls = new measurementcls();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                if (Request.Form["unitmeasurement"].ToString() == string.Empty)
                {
                    Master_default ma = new Master_default();
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    cls.Unit = Request.Form["unitmeasurement"].ToString();
                    if (cls.InsertUnit())
                    {
                        Master_default ma = new Master_default();
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Menu has been successfully saved.', '')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
            }
        }
        protected string gethtmlunit() {
            return cls.getUnits();
        }
    }
}