using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteMeasurement : System.Web.UI.Page
    {
        measurementcls cls = new measurementcls();
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["unitId"].ToString();
            if (cls.Delete(id))
            {
                Response.Redirect("~/measurement.aspx");
            }
        }
    }
}