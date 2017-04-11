using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class deleteMaintenance : System.Web.UI.Page
    {
        Maintenance main = new Maintenance();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["EquipmentMaintenanceID"] != null)
            {
                if (main.DeleteEquipmentMaintenance(Request["EquipmentMaintenanceID"].ToString()))
                {
                    Response.Redirect("~/EquipmentMaintenance.aspx");
                }
            }
        }
    }
}