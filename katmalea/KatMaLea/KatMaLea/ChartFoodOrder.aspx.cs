using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.Data.SqlClient;
using System.Configuration;

namespace ChartFoodOrder
{
    public partial class Charts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                function();
                //GetChartDataDaily();
                GetChartTypes();
            }
           
        }

        //private void GetChartData()
        //{
        //    string cs = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        //    using (SqlConnection con = new SqlConnection(cs))
        //    {
        //        // Command to retrieve Students data from Students table
        //        SqlCommand cmd = new
        //           // SqlCommand("Select Months, Sales from tblSample", con);
        //           SqlCommand("SELECT  sum(Total_Cost) as Total, IssuedDate  FROM     Order_Receipt group by IssuedDate ", con);
        //        con.Open();
        //        SqlDataReader rdr = cmd.ExecuteReader();
        //        Chart1.DataBindTable(rdr, "IssuedDate");

                
        //    }
        //}
        private void GetChartDataDaily()
        {
            string cs = ConfigurationManager.ConnectionStrings["mainConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Command to retrieve Students data from Students table
                SqlCommand cmd = new
                    // SqlCommand("Select Months, Sales from tblSample", con);
                //   SqlCommand("select * from vwIng where TransactDate= '" + DateTime.Now.ToString() + "' ", con);
                 SqlCommand("SELECT  SUM(dbo.Order_Details.Quantity) AS TotalQty, CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101) AS TransactDate,  dbo.Menu.Menu_Name FROM  dbo.Order_Details INNER JOIN  dbo.Order_Form ON dbo.Order_Details.OrderID = dbo.Order_Form.Order_Id INNER JOIN  dbo.Menu ON dbo.Order_Details.MenuID = dbo.Menu.MenuID GROUP BY CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101), dbo.Menu.Menu_Name  ", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                Chart1.DataBindTable(rdr, "Menu_Name");

                
            }
        }
        private void GetChartDataPerDaily(string date1)
        {
            string cs = ConfigurationManager.ConnectionStrings["mainConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Command to retrieve Students data from Students table
                SqlCommand cmd = new
                    // SqlCommand("Select Months, Sales from tblSample", con);
                   SqlCommand("SELECT   SUM(dbo.Order_Details.Quantity) AS TotalQty, CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101) AS TransactDate,  dbo.Menu.Menu_Name FROM    dbo.Order_Details INNER JOIN  dbo.Order_Form ON dbo.Order_Details.OrderID = dbo.Order_Form.Order_Id INNER JOIN  dbo.Menu ON dbo.Order_Details.MenuID = dbo.Menu.MenuID  where  cast(Order_CreatedDate as date) = '" + date1 + "' GROUP BY CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101), dbo.Menu.Menu_Name  ", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                Chart1.DataBindTable(rdr, "Menu_Name");


            }
        }

        private void GetChartWeekly(string date1, string date2)
        {
            string cs = ConfigurationManager.ConnectionStrings["mainConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Command to retrieve Students data from Students table
                SqlCommand cmd = new
                    // SqlCommand("Select Months, Sales from tblSample", con);
                   SqlCommand("SELECT  SUM(dbo.Order_Details.Quantity) AS TotalQty, CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101) AS TransactDate,  dbo.Menu.Menu_Name FROM    dbo.Order_Details INNER JOIN  dbo.Order_Form ON dbo.Order_Details.OrderID = dbo.Order_Form.Order_Id INNER JOIN  dbo.Menu ON dbo.Order_Details.MenuID = dbo.Menu.MenuID GROUP BY CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101), dbo.Menu.Menu_Name HAVING  (CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101) Between '" + date1 + "' and '" + date2 + "') ", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                Chart1.DataBindTable(rdr, "Menu_Name");


            }
        }

        private void GetChartTypes()
        {
            foreach (int chartType in Enum.GetValues(typeof(SeriesChartType)))
            {
                ListItem li = new ListItem(Enum.GetName(typeof(SeriesChartType),
                    chartType), chartType.ToString());
                DropDownList1.Items.Add(li);
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            function();
            //GetChartData();
            this.Chart1.Series[0].ChartType = (SeriesChartType)Enum.Parse(
            typeof(SeriesChartType), DropDownList1.SelectedValue);
        }

        protected void Chart1_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           function();
            
        }

        private void function()
        {

            string strDate = txtto.Text.ToString();//dtpTo.SelectedDate.ToString("MM/dd/yyyy");
            string strDate1 = txtfrom.Text;//dtpFrom.SelectedDate.ToString("MM/dd/yyyy");

            Label1.Text = txtto.Text;//dtpTo.SelectedDate.ToString("MM/dd/yyyy");
            Label2.Text = txtfrom.Text;//dtpFrom.SelectedDate.ToString("MM/dd/yyyy");

            if (strDate == "01/01/0001" || strDate1 == "01/01/0001")
            {
                Label1.Visible = false;
                Label2.Visible = false;
            }
            else
            {
                Label1.Visible = true;
                Label2.Visible = true;
            }
  
            if (DropDownList3.Text == "Daily")
            {

                GetChartDataPerDaily(strDate);
                GetChartTypes();
            }
            else if (DropDownList3.Text == "Weekly")
            {
                GetChartWeekly(strDate, strDate1);

            }
            else if (DropDownList3.Text == "Monthly")
            {
                GetChartWeekly(strDate, strDate1);
            }

            else

            {
                GetChartDataDaily();
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void DropDownList2_TextChanged(object sender, EventArgs e)
        {
           
        }

      
    }
}