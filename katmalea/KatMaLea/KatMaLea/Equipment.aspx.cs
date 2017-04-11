using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Equipment : System.Web.UI.Page
    {
        EquipmentCls eq = new EquipmentCls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownStatus.DataSource = eq.bindStatusCbo();
                DropDownStatus.DataTextField = "Main_StatusName";
                DropDownStatus.DataValueField = "Main_StatusID";
                DropDownStatus.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                Master_default ma = new Master_default();
                if (Request.Form["equipment"].ToString() == string.Empty || Request.Form["remarks"].ToString() == string.Empty)
                {
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    eq.EquipmentName = Request.Form["equipment"].ToString();
                    eq.Remarks = Request.Form["remarks"].ToString();
                    eq.EquipmentStatus = int.Parse(DropDownStatus.SelectedValue);
                    if (eq.InsertEquipment())
                    {
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', '')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
            }
        }
        //protected string getStatuscbo()
        //{
        //    //return eq.getEquipmentStatus();
        //}
        protected string getHtmlEquipment()
        {
            return eq.getEquipments();
        }
    }
}