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
    public class AudittrailCls
    {
        public string getList(int rowcount)
        {
            string result = string.Empty;
            string sql = "SELECT  * FROM  AuditTrail order by Historydate  desc OFFSET " + rowcount + " ROWS FETCH NEXT 10 ROWS ONLY";
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
                            result += "<tr>" +
                                   "<td> " + reader["Historyid"].ToString() + "</td> " +
                            "<td> " + reader["HistoryAction"].ToString() + "</td> " +
                             "<td> " + reader["HistoryDescription"].ToString() + "</td> " +
                             "<td> " + reader["New_Value"].ToString() + "</td> " +
                             "<td> " + reader["Old_Value"].ToString() + "</td> " +
                              "<td> " + reader["ModuleType"].ToString() + "</td> " +
                              "<td> " + reader["HistoryDate"].ToString() + "</td> " +
                              "<td> " + reader["UserID"].ToString() + "</td> " +                                                
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