using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editMaintenance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Maintenance main = new Maintenance();
             if (!IsPostBack)
            {
                DropDownEquipment.DataSource = main.bindequipmentCbo();
                DropDownEquipment.DataTextField = "EquipmentName";
                DropDownEquipment.DataValueField = "EquipmentID";
                DropDownEquipment.DataBind();

                DropDownStatus.DataSource = main.bindStatusCbo();
                DropDownStatus.DataTextField = "Main_StatusName";
                DropDownStatus.DataValueField = "Main_StatusID";
                DropDownStatus.DataBind();

                string eqid = Request.QueryString["EquipmentMaintenanceID"].ToString();
                if (eqid != null)
                {
                    main.getDetails(eqid);
                    txtdescription.Text = main.Description;
                    datetext.Text = main.DateofMaintenance.ToShortDateString();
                    DropDownEquipment.SelectedValue = main.EquipmentID.ToString();
                    txtInterval.Text = main.MaintenanceInterval.ToString();
                    DropDownStatus.SelectedValue = main.Status.ToString();
                    //equipmentnametextbox.Value = eq.EquipmentName;
                    //remarkstextbox.Value = eq.Remarks;
                    //DropDownStatus.SelectedValue = eq.EquipmentStatus.ToString();
                }

            }
            //if (Page.IsPostBack)
            //{
                
            //}
            
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            
            if (Page.IsPostBack)
            {
                Maintenance main = new Maintenance();
                main.Description = txtdescription.Text;
                main.DateofMaintenance = DateTime.Parse(datetext.Text);
                main.EquipmentID = int.Parse(DropDownEquipment.SelectedValue);
                main.MaintenanceInterval =int.Parse (txtInterval.Text);
                //DropDownStatus.SelectedValue = main.Status.ToString();

                main.Status = int.Parse(DropDownStatus.SelectedValue); //int.Parse(Request.QueryString["equipmentcbo"].ToString());
                string mainid = Request.QueryString["EquipmentMaintenanceID"].ToString();
                if (main.EditEquipmentMaintenance(int.Parse(mainid)))
                {
                    Response.Redirect("~/EquipmentMaintenance.aspx");
                }
            }
        }
    }
}