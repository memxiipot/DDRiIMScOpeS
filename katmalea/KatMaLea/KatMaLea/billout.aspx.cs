using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class billout : System.Web.UI.Page
    {
        Menus menu = new Menus();
        Order ordercls = new Order();
        Billoutcls bill = new Billoutcls();
        decimal svcchrge = 0;
        protected string customername = string.Empty;
        string selCustomerval = string.Empty;
        string selTableVal = string.Empty;
        string mytotalamtpaid = string.Empty;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            Label1.Text = string.Empty;
            if (!Page.IsPostBack)
            {
                
                try
                {
                    tabledropdown.DataSource = bill.getPendingTablenoCboDineIn();
                    tabledropdown.DataTextField = "Order_TableNo";
                    tabledropdown.DataValueField = "Order_Id";
                    tabledropdown.DataBind();
                    if (tabledropdown.Items.Count > 0)
                    {
                        tabledropdown.SelectedIndex = 0;
                        //tabledropdown_SelectedIndexChanged(sender, e);
                        customername = tabledropdown.SelectedItem.ToString();
                        bill.getsubtotal2(tabledropdown.SelectedValue, ordertype.SelectedValue);

                        txttotal.Text = "-" + bill.TotalCost.ToString();
                    }
                }
                catch (NullReferenceException)
                {

                    customername = string.Empty;
                }
               
            }
            else {
              
                if (ordertype.SelectedValue == "0")
                {
                    selCustomerval = tabledropdown.SelectedIndex.ToString();
                    tabledropdown.DataSource = bill.getPendingTablenoCboTakeOut();
                    tabledropdown.DataTextField = "Order_PendingNo";
                    tabledropdown.DataValueField = "Order_Id";
                    tabledropdown.DataBind();
                    if (tabledropdown.Items.Count > 0)
                    {
                        tabledropdown.SelectedIndex =int.Parse( selCustomerval);
                        tableno.Text = "Select Customer Name";
                        customername = tabledropdown.SelectedItem.ToString();
                      //  Label1.Text += "Customer " + selCustomerval  +" val:" + tabledropdown.SelectedValue;
                    }
                   
                }
                else
                {
                    selTableVal = tabledropdown.SelectedIndex.ToString();
                    tabledropdown.DataSource = bill.getPendingTablenoCboDineIn();
                    tabledropdown.DataTextField = "Order_TableNo";
                    tabledropdown.DataValueField = "Order_Id";
                    tabledropdown.DataBind();
                    if (tabledropdown.Items.Count > 0)
                    {
                        tabledropdown.SelectedIndex = int.Parse(selTableVal);
                        //tabledropdown_SelectedIndexChanged(sender, e);
                     //   Label1.Text += "table" + selTableVal +" val:"+ tabledropdown.SelectedValue;
                    }
                    tableno.Text = "Select Table Number";
                    customername=Request.Form["customer"].ToString();
                    bill.getListOfOrders(tabledropdown.SelectedValue, ordertype.SelectedValue);
                    
                   
                }
            
               
            }
         
        }
        protected string getListoforderhtml()
        {
            return bill.getListOfOrders(tabledropdown.SelectedValue,ordertype.SelectedValue);
        }
        protected decimal getsubtotal()
        {
            bill.getsubtotal2(tabledropdown.SelectedValue, ordertype.SelectedValue);
            decimal total = bill.TotalCost;
            return total;
        }

        protected void proceedbutton_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                message.InnerHtml=string.Empty;

                if (string.IsNullOrWhiteSpace(renderedamounttextbox.Text.Trim()))
                {
                    message.InnerHtml = messagecls.alertWarning("Rendered Amount cannot be empty");
                    return;
                }
              bill.OrderId = int.Parse(tabledropdown.SelectedValue);
              //  bill.OrderId = int.Parse(tabledropdown.Text.ToString());
                bill.CompanyName=Request.Form["company"].ToString();
                bill.TenderedAmount = decimal.Parse(renderedamounttextbox.Text.Trim());
                bill.TotalCost = decimal.Parse(totalamtpaidlabel.Text);
                bill.Discount = (string.IsNullOrEmpty(discountextbox.Text.Trim()) ? 0 : decimal.Parse(discountextbox.Text.Trim()));
                bill.SvcCharge =decimal.Parse( Request.Form["svccharge"].ToString());
                bill.CustomerName = customername;
                //string temp = bill.InsertORDetails();
                bill.InsertORDetails();
                Billoutcls print = new Billoutcls();
                print.GetOrNO(bill.OrderId);
                //print.Orno;
               // print.OrderId = int.Parse(temp);
              //  temp = OrderId;
               // if (!string.IsNullOrWhiteSpace(temp))
                Response.Redirect("~/printingOr.aspx?orno=" + print.Orno);
                //Response.Redirect(Request.Url.AbsolutePath);
            }
        }

        protected void renderedamounttextbox_TextChanged(object sender, EventArgs e)
        {
            //if (Page.IsPostBack)
            //{
            //    decimal discount = (string.IsNullOrWhiteSpace(discountextbox.Text.Trim())) ? 0 : decimal.Parse(discountextbox.Text.Trim());
            //    decimal render = (string.IsNullOrWhiteSpace(renderedamounttextbox.Text.Trim())) ? 0 : decimal.Parse(renderedamounttextbox.Text.Trim());
            //    decimal totalamt = (string.IsNullOrWhiteSpace(Request.Form["totalamtpaid"].ToString())) ? 0 : decimal.Parse(Request.Form["totalamtpaid"].ToString());
            //    changelabels.Text = Server.HtmlEncode((render - (totalamt - discount)).ToString());
            //    totalamtpaidlabel.Text = Server.HtmlEncode((totalamt - discount).ToString());
            //}
         
        }

        protected void computebutton_Click(object sender, EventArgs e)
        {
            message.InnerHtml = string.Empty;
            if (string.IsNullOrWhiteSpace(renderedamounttextbox.Text.Trim()))
            {
                message.InnerHtml = messagecls.alertWarning("Rendered Amount cannot be empty");
                return;
            }
         
            decimal discount = 0; decimal render = 0; decimal totalamt = 0;
            try
            {
                 discount = (string.IsNullOrWhiteSpace(discountextbox.Text.Trim())) ? 0 : decimal.Parse(discountextbox.Text.Trim());
                 render = (string.IsNullOrWhiteSpace(renderedamounttextbox.Text.Trim())) ? 0 : decimal.Parse(renderedamounttextbox.Text.Trim());
                 totalamt = (string.IsNullOrWhiteSpace(Request.Form["totalamtpaid"].ToString())) ? 0 : decimal.Parse(Request.Form["totalamtpaid"].ToString());
              
                changelabels.Text = Server.HtmlEncode((render - (totalamt - discount)).ToString());
                if (render < (totalamt - discount))
                {
                    message.InnerHtml = messagecls.alertWarning("Amount rendered cannot be less than the total ");
                    totalamtpaidlabel.Text = "00.00";
                    changelabels.Text = "00.00";
                    return;
                }
               mytotalamtpaid= totalamtpaidlabel.Text = Server.HtmlEncode((totalamt - discount).ToString());
            }
            catch (FormatException)
            {

                message.InnerHtml = messagecls.alertWarning("Please input valid number format");
                return;
            }
           
        }

        protected void discountextbox_TextChanged(object sender, EventArgs e)
        {
            bill.getsubtotal2(tabledropdown.SelectedValue, ordertype.SelectedValue);
            totalamtpaidlabel.Text = (bill.TotalCost - decimal.Parse(discountextbox.Text)).ToString();
        }
    }
}