using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteEquipment : System.Web.UI.Page
    {
        EquipmentCls eq = new EquipmentCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["EquipmentID"] != null)
            {
                if (eq.DeleteEquipment(Request["EquipmentID"].ToString()))
                {
                    Response.Redirect("~/Equipment.aspx");
                }
            }
        }
    }
}