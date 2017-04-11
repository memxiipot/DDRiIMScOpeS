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
    public class Order
    {
        private int mytableno;

        public int tableno
        {
            get { return mytableno; }
            set { mytableno = value; }
        }
          private int myCrew;

        public int Crew
        {
            get { return myCrew; }
            set { myCrew = value; }
        }
        private String myRequest;

        public String Requestt
        {
            get { return myRequest; }
            set { myRequest = value; }
        }
        private String mypendingno;

        public String PendingNo
        {
            get { return mypendingno; }
            set { mypendingno = value; }
        }
        private int myorderId;

        public int OrderId
        {
            get { return myorderId; }
            set { myorderId = value; }
        }
        private int mymenuId;

        public int MenuId
        {
            get { return mymenuId; }
            set { mymenuId = value; }
        }
        private int myquantity;

        public int Quantity
        {
            get { return myquantity; }
            set { myquantity = value; }
        }
        private string myordertype;

        public string OrderType
        {
            get { return myordertype; }
            set { myordertype = value; }
        }
        public int InsertOrder() {
            int result = 0;
            int userid;
            try
            {
                userid = int.Parse(HttpContext.Current.Session["UserType"].ToString());
            }
            catch (NullReferenceException)
            {

                userid = 1;
            }
            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "insertOrder";
                    cmd.Parameters.Add(new SqlParameter("@tableno", mytableno));
                    cmd.Parameters.Add(new SqlParameter("@crew", myCrew));
                    cmd.Parameters.Add(new SqlParameter("@orderRequest", myRequest));
                    cmd.Parameters.Add(new SqlParameter("@createdby", userid));
                    cmd.Parameters.Add(new SqlParameter("@pendingno", mypendingno));
                    cmd.Parameters.Add(new SqlParameter("@ordertype", Convert.ToBoolean(int.Parse(myordertype))));
                    SqlParameter outPutVal = new SqlParameter("@orderid", SqlDbType.Int);

                    outPutVal.Direction = ParameterDirection.Output;

                    cmd.Parameters.Add(outPutVal);
                    cmd.ExecuteNonQuery();
                    if (outPutVal.Value != DBNull.Value) 
                        result = Convert.ToInt32(outPutVal.Value);
                }
              
            }
            catch (Exception)
            {
                
                throw;
            }
            return result;
        }
        public string getOrderNumber() {
            string result = string.Empty;
            try
            {
                   using (SqlConnection conn=new SqlConnection(Connection.getConnectionString()))
                    {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType =CommandType.Text;
                    cmd.CommandText = "select Order_Id from Order_Form order by Order_Id desc";

                    using (SqlDataReader reader=cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "  <option value=\" " + reader[0].ToString() + "\">" +reader[0].ToString() + "</option>";
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
        public DataTable getMenus() {
            DataTable dt;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select MenuID,Menu_Name from Menu order by MenuID asc";
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
        public DataTable bindordernumberdropdown() {
            DataTable dt;
            try
            {
                using (SqlConnection conn=new SqlConnection(Connection.getConnectionString()))
                    {
                    conn.Open();
                    //SqlCommand cmd = new SqlCommand();
                    //cmd.Connection = conn;
                    //cmd.CommandType =CommandType.Text;
                    //cmd.CommandText = "select Order_Id from Order_Form order by Order_Id desc";
                    string sql = "select Order_Id from Order_Form order by Order_Id desc";
                    SqlDataAdapter adapter = new SqlDataAdapter(sql,conn);
                    dt = new DataTable();
                    adapter.Fill(dt);
                    
                }
            }
            catch (Exception)
            {
                
                throw;
            }
            return dt;
         
        }
        public string getListOfOrders( string orderno) {
            string result = string.Empty;
            if (string.IsNullOrWhiteSpace(orderno)) {
                return result;
            }
            int i=0;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "getListofOrder";
                    cmd.Parameters.Add(new SqlParameter("@orderID",int.Parse(orderno)));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            i++;
                            result += "<tr><td> " + i + "</td>"+
                              "  <td> " + reader["Menu_Name"].ToString() + "</td> " +
                                                " <td>" + reader["Menu_Price"].ToString() + "</td>" +
                                                " <td>" + reader["Quantity"].ToString() + "</td>" +
                                                " <td>" + reader["Total"].ToString() + "</td>"+
                                                " <td>" + ((reader["IsServed"].ToString()=="True")? "Yes":"No") + "</td>";
                            if (reader["IsServed"].ToString() == "False")
                            {
                              
                                result += "<td><button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteordermenu.aspx?orderdetailsid=" + reader["Order_DetailsID"].ToString() + "'\">Remove</button></td>";
                            }       
                                               
                                    result +=        "</tr>";
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

        public bool InsertMenuOrder() {
            bool result = false;
            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "insertMenuOrder";//sp has validation inside if from completed status to pending---additional order is made
                    cmd.Parameters.Add(new SqlParameter("@orderid", myorderId));
                    cmd.Parameters.Add(new SqlParameter("@menuId", mymenuId));
                    cmd.Parameters.Add(new SqlParameter("@quantity", myquantity));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        public bool DeleteMenuOrder(string orderdetailsId)
        {
            bool result = false;

            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "delete from Order_Details where Order_DetailsID=" + orderdetailsId;
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public string checkOrderStatusByTable(string tableno){
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT Order_Status FROM dbo.Order_Form WHERE  (Order_TableNo = "+ tableno +")";
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader[0].ToString();
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
        public DataTable getPendingTablenoCbo() {
            DataTable dt;
            string sql = "SELECT   Order_TableNo , Order_Id FROM         dbo.Order_Form   WHERE     (Order_Status BETWEEN 1 AND 2) and Order_Type=1";
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
        public string getTableNoByOrderId(string orderid) {
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT Order_TableNo FROM dbo.Order_Form WHERE  (Order_Id = " + orderid + ")";
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            result = reader[0].ToString();
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
        public bool deleteOrder(string orderid)
        {
            bool result = false;

            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "delete from Order_Details where OrderID=" + orderid +"; delete from Order_Form where Order_Id=" + orderid;
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public bool isOrderHasAlreadyServed(string tableno) {
            bool result = false;
            string sql="SELECT     dbo.Order_Details.IsServed FROM         dbo.Order_Details INNER JOIN" +
                    "  dbo.Order_Form ON dbo.Order_Details.OrderID = dbo.Order_Form.Order_Id "+
                    " WHERE     (dbo.Order_Form.Order_TableNo = " + tableno+") AND (dbo.Order_Details.IsServed = 1)";
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
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                result = true;
                            }
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
        public bool changeOrderDetailsStatus(string status,string orderdetailsid,string orderid) {
            bool result =false;

            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "updateOrderDetailsStatus";
                    cmd.Parameters.Add(new SqlParameter("@orderdetailsid", int.Parse(orderdetailsid)));
                    cmd.Parameters.Add(new SqlParameter("@orderid",int.Parse(orderid)));
                    
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }
            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public List<int> getOccupiedTable()
        {
            List<int> lsttemp = new List<int>();
            string sql = "SELECT   Order_TableNo , Order_Id FROM         dbo.Order_Form   WHERE     (Order_Status BETWEEN 1 AND 2) and Order_Type=1";
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;
                    using (SqlDataReader reader=cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                lsttemp.Add(int.Parse( reader[0].ToString()));
                            }
                        }
                        
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return lsttemp;
        }
    }
}