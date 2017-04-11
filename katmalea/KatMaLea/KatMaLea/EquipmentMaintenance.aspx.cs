using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class EquipmentMaintenance : System.Web.UI.Page
    {
         Maintenance main = new Maintenance();
        protected void Page_Load(object sender, EventArgs e)
        {
            //datetext.Text = "mm/dd/yyyy";
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
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Master_default ma = new Master_default();

            if (Page.IsPostBack)
            {
                if (txtdescription.Text == string.Empty || txtInterval.Text == string.Empty)
                {
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                    Response.Redirect(Request.Url.AbsolutePath);
                }
                else
                {
                    int id;
                    main.Description = txtdescription.Text;
                    main.DateofMaintenance = DateTime.Parse(datetext.Text);
                    main.EquipmentID = int.Parse(DropDownEquipment.SelectedValue);

                    main.MaintenanceInterval = int.Parse(txtInterval.Text);
                    main.Status = int.Parse(DropDownStatus.SelectedItem.Value);
                    main.checkequipmentID(int.Parse(DropDownEquipment.SelectedValue));
                    if (main.checkequipmentID(int.Parse(DropDownEquipment.SelectedValue)))
                    {
                        return;
                    }
                    else
                    {
                        if (main.InsertMaintenance())
                        {
                            ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', '')");
                            Response.Redirect(Request.Url.AbsolutePath);
                        }
                    }
                }
            }
        }
        protected string getHtmlEquipment()
        {
            return main.getEquipmentMaintenance();
        }

    }
}