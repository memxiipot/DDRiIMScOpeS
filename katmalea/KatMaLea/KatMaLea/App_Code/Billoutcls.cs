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
    public class Billoutcls
    {

        private int myorderid;

        public int OrderId
        {
            get { return myorderid; }
            set { myorderid = value; }
        }
        private string mycompanyname;

        public string CompanyName
        {
            get { return mycompanyname; }
            set { mycompanyname = value; }
        }
        private string mycustomername;

        public string CustomerName
        {
            get { return mycustomername; }
            set { mycustomername = value; }
        }
            private Decimal mytenderedamount;

        public Decimal TenderedAmount
        {
            get { return mytenderedamount; }
            set { mytenderedamount = value; }
        }
        private Decimal mytotalcost;

        public Decimal TotalCost
        {
            get { return mytotalcost; }
            set { mytotalcost = value; }
        }
        private Decimal mydiscount;

        public Decimal Discount
        {
            get { return mydiscount; }
            set { mydiscount = value; }

        }

        private string  myOrno;
        public string  Orno
        {
            get { return myOrno; }
            set { myOrno = value; }
        }

        private decimal  Cash;
        public decimal  Cash1
        {
            get { return Cash; }
            set { Cash = value; }
        }
        private Decimal mysvcharge;

        public Decimal SvcCharge
        {
            get { return mysvcharge; }
            set { mysvcharge = value; }
        }
        public DataTable getPendingTablenoCboDineIn( )
        {
            DataTable dt;
            string sql = "SELECT   Order_TableNo , Order_Id FROM         dbo.Order_Form   WHERE     (Order_Status =2) and Order_Type=1";
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;
                    dt = new DataTable();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception)
            {

                throw;
            }
            return dt;
        }
        public DataTable getPendingTablenoCboTakeOut()
        {
            DataTable dt;
            string sql = "SELECT   Order_PendingNo , Order_Id FROM         dbo.Order_Form   WHERE     (Order_Status =2) and Order_Type=0"; ;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;
                    dt = new DataTable();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception)
            {

                throw;
            }
            return dt;
        }
        public string getListOfOrders(string orderno,string ordertype)
        {
            string result = string.Empty;
            if (string.IsNullOrWhiteSpace(orderno))
            {
                return result;
            }
            int i = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "getListofOrder";
                    cmd.Parameters.Add(new SqlParameter("@orderID", int.Parse(orderno)));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            i++;
                            result += "<tr><td> " + i + "</td>" +
                              "  <td> " + reader["Menu_Name"].ToString() + "</td> " +
                                                " <td>" + reader["Menu_Price"].ToString() + "</td>" +
                                                " <td>" + reader["Quantity"].ToString() + "</td>" +
                                                " <td>" + reader["Total"].ToString() + "</td>" ;
                            result += "</tr>";
                            TotalCost = decimal.Parse(reader["Total"].ToString());
                    
                        }
                        result += getsubtotal(orderno, ordertype);
                    }


                }
            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        private string getsubtotal(string orderno,string ordertype) {
            string result = string.Empty;
            if (string.IsNullOrWhiteSpace(orderno))
            {
                return result;
            }
      
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "getordersubtotal";
                    cmd.Parameters.Add(new SqlParameter("@orderid", int.Parse(orderno)));
                    cmd.Parameters.Add(new SqlParameter("@ordertype",Convert.ToBoolean(int.Parse(ordertype))));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {

                        if (reader.Read()) {
                            //total cost
                            result += "<tr><td></td>" +
                                "  <td></td> " +
                                                  " <td><input type=\"hidden\" name=\"totalcost\" value=\"" + reader[0].ToString() + "\"/></td>" +
                                                  " <td><i><b>TOTAL COST</b></i></td>" +
                                                  " <td><b>" + reader[0].ToString() + "</b></td>";
                            result += "</tr>";
                            //vat
                            result += "<tr><td></td>" +
                               "  <td></td> " +
                                                 " <td><input type=\"hidden\" name=\"vatamt\" value=\"" + reader[1].ToString() + "\"/></td>" +
                                                 " <td><i><b>Vatable Amt.(12%)</b></i></td>" +
                                                 " <td><b>" + reader[1].ToString() + "</b></td>";
                            result += "</tr>";
                            //servicecharge
                            result += "<tr><td></td>" +
                         "  <td></td> " +
                                           " <td><input type=\"hidden\" name=\"svccharge\" value=\"" + reader[2].ToString() + "\"/></td>" +
                                           " <td><i><b>Service Charge</b></i></td>" +
                                           " <td><b>" + reader[2].ToString() + "</b></td>";
                            result += "</tr>";
                            result += "<tr><td></td>" +
                       "  <td></td> " +
                                         " <td><input type=\"hidden\" name=\"totalamtpaid\" value=\"" + reader[3].ToString() + "\"/></td>" +
                                         " <td><h3>TOTAL AMT. PAID</h3></td>" +
                                         " <td><h3>" + reader[3].ToString() + "</h3></td>";
                            result += "</tr>";
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
        
        public string InsertORDetails() {

            string result = string.Empty;
            int userid;
            string fullname = string.Empty;
            try
            {
                userid = int.Parse(HttpContext.Current.Session["UserType"].ToString());
                fullname = HttpContext.Current.Session["Fullname"].ToString();

            }
            catch (NullReferenceException)
            {

                userid = 1;
            }
            SqlCommand cmd;
            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                   cmd= new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "InsertOrOrder";
                    cmd.Parameters.Add(new SqlParameter("@orderid", myorderid));
                    cmd.Parameters.Add(new SqlParameter("@companyname", mycompanyname));
                    cmd.Parameters.Add(new SqlParameter("@cashrendered", mytenderedamount));
                    cmd.Parameters.Add(new SqlParameter("@totalcost", mytotalcost));
                    cmd.Parameters.Add(new SqlParameter("@discount", mydiscount));
                    cmd.Parameters.Add(new SqlParameter("@servicecharge", mysvcharge));
                    cmd.Parameters.Add(new SqlParameter("@customername", mycustomername));
                    cmd.Parameters.Add(new SqlParameter("@issuedby", fullname));
                    cmd.Parameters.Add(new SqlParameter("@createdby", userid));
                    SqlParameter outPutVal = new SqlParameter("@orid", SqlDbType.VarChar,10);

                    outPutVal.Direction = ParameterDirection.Output;

                    cmd.Parameters.Add(outPutVal);
                    if (cmd.ExecuteNonQuery() >= 1) {
                        if (outPutVal.Value != DBNull.Value)
                        {
                            result = outPutVal.Value.ToString();
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

        public void GetOrNO(params object[] Params)
    {
        DataTable GetORno = new DataTable();
        GetORno = GetORno1(Params[0]);

        if (GetORno.Rows.Count > 0)
        {

            Orno = GetORno.Rows[0]["ReceiptNo"].ToString();
           // myOrno = int.Parse(GetORno.Rows[0]["OrderID"].ToString());
            Cash = decimal.Parse(GetORno.Rows[0]["CashRendered"].ToString());
        }
    }
        public DataTable GetORno1(params object[] Params)
        {
            DataTable dt;
            string sql = "SELECT * from Order_Receipt   WHERE OrderID = " + Params[0] + "    ";
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;
                    dt = new DataTable();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);

                  
                }
            }
            catch (Exception)
            {

                throw;
            }
            return dt;
        }
        public void getsubtotal2(string orderno, string ordertype)
        {
            DataTable dt = getTotal(orderno, ordertype);
            this.TotalCost = decimal.Parse(dt.Rows[0]["Total"].ToString());
        }
        public DataTable getTotal(string orderno, string ordertype)
        {
            DataTable dt = new DataTable();
            //string sql = "SELECT * from Order_Receipt   WHERE OrderID = " + Params[0] + "    ";
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "getordersubtotal";
                    cmd.Parameters.Add(new SqlParameter("@orderid", int.Parse(orderno)));
                    cmd.Parameters.Add(new SqlParameter("@ordertype", Convert.ToBoolean(int.Parse(ordertype))));
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception)
            {

                throw;
            }
            return dt;
        }
        
    }
}