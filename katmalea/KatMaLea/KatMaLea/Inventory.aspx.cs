using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Inventory : System.Web.UI.Page
    {   
        InventoryCls cls = new InventoryCls();
        clsIngredients ingred = new clsIngredients();
        measurementcls measure = new measurementcls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                measurementdropdown.DataSource = measure.getUnitsCbo();
                measurementdropdown.DataTextField = "Unit";
                measurementdropdown.DataValueField = "MeasurementID";
                measurementdropdown.DataBind();
            }
        }

        protected void submitbutton_Click(object sender, EventArgs e)
        {
            string IngUOMcount;
            if (Page.IsPostBack)
            {
                spanmessage.InnerHtml = string.Empty;
                int mylimit = 0;
                int myquantity = 0;
                if (string.IsNullOrWhiteSpace(Request.Form["quantitytext"].ToString()))
                {
                    Master_default ma = new Master_default();
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                    spanmessage.InnerHtml = messagecls.alertWarning("Please input a quantity");
                    return;
                }
                //try
                //{
                //    mylimit = int.Parse(Request.Form["limit"].ToString());
                //}
                //catch (Exception)
                //{

                //    mylimit = 0;
                //}
                //try
                //{
                //    myquantity = int.Parse(Request.Form["quantitytext"].ToString());
                //}
                //catch (Exception)
                //{
                //    spanmessage.InnerHtml = messagecls.alertWarning("Please input a valid number format");
                //    myquantity = 0;
                //    return;
                //}
                myquantity = int.Parse(Request.Form["quantitytext"].ToString());
                cls.Ingredient = Request.Form["ingredientcbo"].ToString();
                cls.Quantity = myquantity.ToString();
                cls.Unit = measurementdropdown.Text;
                cls.InvLimit = mylimit.ToString();
                IngUOMcount = cls.Inventoryingcount(int.Parse(Request.Form["ingredientcbo"].ToString())).Rows.Count.ToString() + cls.InventoryUOMcount(int.Parse(measurementdropdown.SelectedValue), int.Parse(Request.Form["ingredientcbo"].ToString())).Rows.Count.ToString();
                if (IngUOMcount == "00" || IngUOMcount == "11")
                {
                    if (cls.Insert())
                    {
                        Master_default ma = new Master_default();
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Successfully saved.', 'Save')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
                else
                {
                    return;
                }
            }
            
        }
        protected string getIngredients()
        {
            return ingred.getIngredientCbo();
        }
        protected string getlist() {
            return cls.InventoryMonitor(cboStatus.Text);
        }

        protected void measurementdropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }
    }
}