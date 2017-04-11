using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
namespace KatMaLea
{
    public class verifiyordercls
    {
        private string mycustomername;

        public string CustomerName
        {
            get { return mycustomername; }
            set { mycustomername = value; }
        }
        
        private string myCompanyName;

        public string CompanyName
        {
            get { return myCompanyName; }
            set { myCompanyName = value; }
        }

        private string myCashRendered;

        public string CashRendered
        {
            get { return myCashRendered; }
            set { myCashRendered = value; }
        }

        private string mytotalcost;

        public string TotalCost
        {
            get { return mytotalcost; }
            set { mytotalcost = value; }
        }

        private string myDiscount;

        public string Discount
        {
            get { return myDiscount; }
            set { myDiscount = value; }
        }

        private string mysvcharge;

        public string SvcCharge
        {
            get { return mysvcharge; }
            set { mysvcharge = value; }
        }

        private string myIssuedBy;

        public string IssuedBy
        {
            get { return myIssuedBy; }
            set { myIssuedBy = value; }
        }

        private string myIssuedDate;

        public string IssuedDate
        {
            get { return myIssuedDate; }
            set { myIssuedDate = value; }
        }

        public void getOrDetails(string orno) {
            string sql="SELECT     Received_By, CompanyName, CashRendered, Total_Cost, Discount, Service_Charge, IssuedBy, IssuedDate "+
                    " FROM         dbo.Order_Receipt WHERE     (ReceiptNo = '" +orno +"')";
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            mycustomername=reader["Received_By"].ToString();
                            myCompanyName = reader["CompanyName"].ToString();
                            myCashRendered = reader["CashRendered"].ToString();
                            mytotalcost = reader["Total_Cost"].ToString();
                            myDiscount = reader["Discount"].ToString();
                            mysvcharge = reader["Service_Charge"].ToString();
                            myIssuedBy = reader["IssuedBy"].ToString();
                            myIssuedDate = reader["IssuedDate"].ToString();
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
            }
        public string getOrderedMenu( string orno)
        {
            string result = string.Empty;
            string sql="SELECT     dbo.Menu.Menu_Name, dbo.Menu.Menu_Price, dbo.OR_Details.Quantity, dbo.OR_Details.Item_Cost"+
                            " FROM         dbo.Order_Receipt INNER JOIN "+
                      " dbo.OR_Details ON dbo.Order_Receipt.ORID = dbo.OR_Details.ORID INNER JOIN "+
                      " dbo.Menu ON dbo.OR_Details.MenuID = dbo.Menu.MenuID "+
                            " WHERE     (dbo.Order_Receipt.ReceiptNo = '" + orno+"')";
            int i = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            i++;
                            result += "<tr><td>" +i +"</td> " +
                                                " <td>" + reader["Menu_Name"].ToString() + "</td>" +
                                                " <td>" + reader["Menu_Price"].ToString() + "</td>" +
                                                  " <td>" + reader["Quantity"].ToString() + "</td>" +
                                                    " <td>" + reader["Item_Cost"].ToString() + "</td>" +
                                            "</tr>";
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
    }
}