using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editInventory : System.Web.UI.Page
    {
        InventoryCls ex = new InventoryCls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string exid = Request.QueryString["Inv_IngredientsID"].ToString();
                if (exid != null)
                {
                    ex.getDetails(exid);
                    //txtpayee.Text = ex.Quantity;
                    txtInvID.Text = ex.InvItemID ; 
                   // txtremarks.Text = ex.Remarks;
                   // DropDownpayment.SelectedIndex = ex.ModeofPayment;
                }

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
              ex.Quantity = txtpayee.Text;
               // ex.Remarks = txtremarks.Text;
              //  ex.ModeofPayment = DropDownpayment.SelectedIndex;//int.Parse(Request.QueryString["equipmentcbo"].ToString());
             // string eqid = Request.QueryString["Inv_ItemID"].ToString();
              string eqid = txtInvID.Text;
               if (ex.EditInvenory(int.Parse(eqid)))
               {
                    Response.Redirect("~/Inventory.aspx");
                }
            }
        }
    }
}