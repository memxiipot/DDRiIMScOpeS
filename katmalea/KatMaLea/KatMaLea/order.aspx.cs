using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class order : System.Web.UI.Page
    {
        crewcls crew = new crewcls();
        Order orderx = new Order();
      
        protected void Page_Load(object sender, EventArgs e)
        {
            getAvailableTableno();
            if (!Page.IsPostBack)
            {
                crewdropdown.DataSource = crew.crewlistCbo();
                crewdropdown.DataTextField = "Crew_Fullname";
                crewdropdown.DataValueField = "CrewID";
                crewdropdown.DataBind();
            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                int tableno = 0;
                SpanMessage.InnerHtml = string.Empty;            
                //----------------validation-------------------------
                if (ordertype.SelectedValue == "1")
                {
                    if (string.IsNullOrWhiteSpace(tablenodropdown.SelectedItem.ToString()))
                    {
                        SpanMessage.InnerHtml += messagecls.alertWarning("Please enter a valid table number");
                        return;
                    }
                    tableno = int.Parse(tablenodropdown.SelectedItem.ToString());

                    if (orderx.checkOrderStatusByTable(tableno.ToString()) != string.Empty)
                    {
                        if (int.Parse(orderx.checkOrderStatusByTable(tableno.ToString())) <= 2)
                        {
                            SpanMessage.InnerHtml += messagecls.alertInfo("Table number [" + tableno.ToString() + "] is already occupied");
                            return;
                        }
                    }
                }
                
                //-----------------------end of validation------------------------------------
                orderx.tableno = tableno;
                orderx.Requestt = Request.Form["orderRequest"].ToString();
                orderx.PendingNo = Request.Form["pendingno"].ToString();
                orderx.Crew = int.Parse(crewdropdown.SelectedValue);
                orderx.OrderType = ordertype.SelectedValue;
                int id = orderx.InsertOrder();
                if (id!=0)
	                {
		                Response.Redirect("~/insertorder.aspx?orderid="+ id);
	                }
            }
        }
        private void getAvailableTableno() {
            for (int i = 0; i < 50; i++)
            {
                if (i == 0)
                {
                    continue;
                }
                if (!isthere(i))
                {
                    tablenodropdown.Items.Add(i.ToString());
                }
            }
        }
        private bool isthere(int i) {
            List<int> occupied = orderx.getOccupiedTable();

            bool result = false;
            foreach (int item in occupied)
            {
                if (i.Equals(item))
                {
                    result = true;
                    break;

                }
                else
                    result = false;
            }
            return result;
        }


    }
}