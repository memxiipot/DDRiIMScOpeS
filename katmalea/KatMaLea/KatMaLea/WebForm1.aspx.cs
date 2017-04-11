using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Master_default ma = new Master_default();
            ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
        }

        protected void DropDownpayment_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}