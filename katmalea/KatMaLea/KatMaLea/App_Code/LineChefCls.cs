using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Caching;


namespace KatMaLea
{
    public class LineChefCls
    {
        public string getPendingOrders() {
            string[] arrcls = new string[] { "active", "success", "warning", "danger", "info" };
            int x = 0;
            string result = string.Empty;
            string sql = "SELECT   Order_TableNo ,Order_PendingNo, Order_Id,Order_Request,CONVERT(VARCHAR(9),RIGHT(Order_CreatedDate,8),108) as Order_CreatedDate FROM         dbo.Order_Form   WHERE     Order_Status=1 order by Order_Id desc ";
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
                                result += "<form name=\"form1\" method=\"post\" action=\"linechefview.aspx\">"+

                                   " <tr class=\"" + arrcls[x]+"\"> " +
                                   "<td><h1>" + ((reader["Order_TableNo"].ToString() == "0") ? "Take out" : reader["Order_TableNo"].ToString()) + "</h1> " +
                                           "<td>" + ((reader["Order_PendingNo"].ToString()=="0") ? string.Empty : reader["Order_PendingNo"].ToString()) +
                                           "<td>" + ((reader["Order_CreatedDate"].ToString() == "0") ? string.Empty : reader["Order_CreatedDate"].ToString()) +
                                            "<input type=\"hidden\" name=\"order_id\" value=\""+ reader["Order_Id"].ToString()+"\"> "+
                                              "<input type=\"hidden\" name=\"tableno\" value=\"" + reader["Order_TableNo"].ToString() + "\"> " +                                             
                                          " </td> " +
                                   " <td><button type=\"submit\" class=\"btn btn-success btn-lg\">SELECT</button>";
                                if (!string.IsNullOrWhiteSpace(reader["Order_Request"].ToString()))
                                {
                                   // result += "<button type=\"button\" class=\"btn btn-primary btn-lg\" data-toggle=\"modal\" data-target=\"#myModal\">   REQUEST </button></td></tr>";
                                    result += "<a class=\"btn btn-primary btn-lg\" data-toggle=\"collapse\" href=\"#collapseExample" + reader["Order_Id"].ToString() + "\" aria-expanded=\"false\" aria-controls=\"collapseExample\">" +
                                              "REQUEST"+
                                           " </a>"+
                                           " <div class=\"collapse\" id=\"collapseExample" + reader["Order_Id"].ToString() + "\">" +
                                            "  <div class=\"well\">"+
                                            reader["Order_Request"].ToString() +
                                             " </div>"+
                                            "</div>";
                                }
                                x++;
                                if (x == arrcls.Length)
                                    x = 0;
                                result += "</form>";
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
        
        public string getListOfOrders(string orderno)
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
                            result += "<tr><td>" + i +"</td> " +
                                       "<td> " + reader["Menu_Name"].ToString() + "</td>"+
                                                "<td>" + reader["Quantity"].ToString() + "</td>";
                                              
                            if (reader["IsServed"].ToString() == "False")
                            {

                                result += "<td><button type=\"button\" class=\"btn btn-warning\" onClick=\"window.location='/menuOrderStat.aspx?orderdetailsid=" + reader["Order_DetailsID"].ToString() + "&orderid=" + orderno +"'\">DONE?</button></td>";
                            }

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
        public void Page_Load()
        {
            string cache1 = "Cache Refresh: " +
            DateTime.Now.ToLongTimeString();
            string sql = "SELECT   Order_TableNo ,Order_PendingNo, Order_Id,Order_Request FROM         dbo.Order_Form   WHERE     Order_Status=1 order by Order_Id asc ";
            
            // Create a dependency connection to the database.
            SqlDependency.Start(Connection.getConnectionString());

            using (SqlConnection connection =
                new SqlConnection(Connection.getConnectionString()))
            {
                using (SqlCommand command =
                    new SqlCommand(sql, connection))
                {
                    SqlCacheDependency dependency =
                        new SqlCacheDependency(command);
                    // Refresh the cache after the number of minutes 
                    // listed below if a change does not occur. 
                    // This value could be stored in a configuration file. 
                    int numberOfMinutes = 3;
                    DateTime expires =
                        DateTime.Now.AddMinutes(numberOfMinutes);

                    HttpContext.Current.Response.Cache.SetExpires(expires);
                    HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Public);
                    HttpContext.Current.Response.Cache.SetValidUntilExpires(true);

                    HttpContext.Current.Response.AddCacheDependency(dependency);

                    connection.Open();

                }
            }
        }
        
    }
}