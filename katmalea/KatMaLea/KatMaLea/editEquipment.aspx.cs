using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editEquipment : System.Web.UI.Page
    {
        EquipmentCls eq = new EquipmentCls();
        string EquipmentName;
        string remarks;
        int statusid = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownStatus.DataSource = eq.bindStatusCbo();
                DropDownStatus.DataTextField = "Main_StatusName";
                DropDownStatus.DataValueField = "Main_StatusID";
                DropDownStatus.DataBind();

                string eqid = Request.QueryString["EquipmentID"].ToString();
                if (eqid != null)
                {
                    eq.getDetails(eqid);
                    equipmentnametextbox.Value = eq.EquipmentName;
                    remarkstextbox.Value = eq.Remarks;
                    DropDownStatus.SelectedValue = eq.EquipmentStatus.ToString();
                }

            }
            //if (Page.IsPostBack)
            //{
                
            //}
            
        }
        //protected string getStatuscbo()
        //{
        //    return eq.getEquipmentStatus();
        //}

        protected void Button1_Click(object sender, EventArgs e)
        {
            EquipmentName = equipmentnametextbox.Value;
            remarks = remarkstextbox.Value;
            statusid = int.Parse(DropDownStatus.SelectedValue);
            if (Page.IsPostBack)
            {
                eq.EquipmentName = EquipmentName;
                eq.Remarks = remarks;

                eq.EquipmentStatus = int.Parse(DropDownStatus.SelectedValue); //int.Parse(Request.QueryString["equipmentcbo"].ToString());
                string eqid = Request.QueryString["EquipmentID"].ToString();
                if (eq.EditEquipment(int.Parse(eqid)))
                {
                    Response.Redirect("~/Equipment.aspx");
                }
            }
        }
    }
}