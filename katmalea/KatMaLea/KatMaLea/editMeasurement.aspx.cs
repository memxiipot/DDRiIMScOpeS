using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editMeasurement : System.Web.UI.Page
    {
        measurementcls cls = new measurementcls();
        private string myunit;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                myunit = unitTextbox.Value;
             
            }
            string unitid = Request.QueryString["unitId"].ToString();
            if (unitid != null)
            {
                cls.getUnitDetails(unitid);
                unitTextbox.Value = cls.Unit;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {  string unitid = Request.QueryString["unitId"].ToString();
            cls.Unit = myunit;
                if (cls.UpdateUnit(unitid))
                {
                    Response.Redirect("~/measurement.aspx");
                }
            }
        }
    }
}