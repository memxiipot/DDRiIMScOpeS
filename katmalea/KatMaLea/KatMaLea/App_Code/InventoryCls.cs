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
    public class InventoryCls
    {

        private string Inv_ItemID;

        public string InvItemID
        {
            get { return Inv_ItemID; }
            set { Inv_ItemID = value; }
        }

        private string myingredient;

        public string Ingredient
        {
            get { return myingredient; }
            set { myingredient = value; }
        }
        private string myquantity;

        public string Quantity
        {
            get { return myquantity; }
            set { myquantity = value; }
        }
        private string myunit;

        public string Unit
        {
            get { return myunit; }
            set { myunit = value; }
        }
        private string mylimit;

        public string InvLimit
        {
            get { return mylimit; }
            set { mylimit = value; }
        }

        public bool Insert()
        {
            bool result = false;
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
                    cmd.CommandText = "InsertInventory";
                    cmd.Parameters.Add(new SqlParameter("@ingredientid", int.Parse(myingredient)));
                    cmd.Parameters.Add(new SqlParameter("@quantity", decimal.Parse(myquantity)));
                    cmd.Parameters.Add(new SqlParameter("@unit", int.Parse(myunit)));
                    //cmd.Parameters.Add(new SqlParameter("@invlimit", mylimit));
                    cmd.Parameters.Add(new SqlParameter("@userid", userid));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;

        }


        public string getItems()
        {
            string result = string.Empty;
            int i = 0;
            try
            {
                string sql = "SELECT   dbo.Crew_List.CrewID,  dbo.Crew_List.Crew_FullName, dbo.refPosition.PositionName, dbo.Crew_List.IsActive " +
                    " FROM         dbo.refPosition INNER JOIN " +
                      " dbo.Crew_List ON dbo.refPosition.PositionID = dbo.Crew_List.Crew_Position order by CrewID desc";
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
                            string stat = (reader["IsActive"].ToString() == "True") ? "Active" : "InActive";
                            result += "<tr> " +
                                "  <td> " + i + "</td> " +
                              "  <td> " + reader["Crew_FullName"].ToString() + "</td> " +
                             "  <td> " + reader["PositionName"].ToString() + "</td> " +
                             "  <td> " + stat + "</td> " +
                                    "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editcrew.aspx?crewid=" + reader["CrewID"].ToString() + "'\">EDIT</button>" +
                    "</td>" +
                                //             "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/crewchangestat.aspx?crewid=" + reader["CrewID"].ToString() + "'\">DELETE</button>
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
        public string InventoryMonitor(string status)
        {
            string sql = "select * from [dbo].[vwGetInventoryMonitory]  where Status = '"+ status +"' order by Name";


            string result = string.Empty;
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
                            string x;

                            // i++; result += "<tr>"+ "<td> " + i + "</td> " + 
                            result += "<tr><td> " + reader["Inv_IngredientsID"].ToString() + "</td> " +
                                " <td>" + reader["Name"].ToString() +
                                "</td>" + " <td>" + reader["used"].ToString() +
                                "</td>" + " <td>" + reader["available"].ToString() +
                                "</td>" + " <td>" + reader["Stock"].ToString() +
                                //"</td>" + " <td>" + reader["Unit"].ToString() +
                                "</td>" + "<td><font color=" + reader["Color"].ToString() + ">" + reader["Status"].ToString() +
                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editInventory.aspx?Inv_IngredientsID=" + reader["Inv_IngredientsID"].ToString() + "'\">EDIT</button> </td>" +
                                 "</font></td>"; // " <td>" + reader[5].ToString() + "</td>" + "</tr>"; } }

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

        public void getDetails(string eqid)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Inventory where Inv_IngredientsID=" + eqid + " order by Inv_ItemID asc ";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Inv_ItemID = reader["Inv_ItemID"].ToString();
                            //myquantity = reader["Inv_Quantity"].ToString();
                            //  Remarks = reader["Remarks"].ToString();
                            // ModeofPayment = int.Parse(reader["ModeofPayment"].ToString());
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool EditInvenory(int invid)
        {
            bool result = false;

            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "updateInventory";
                    cmd.Parameters.Add(new SqlParameter("@InvItemID", invid));
                    cmd.Parameters.Add(new SqlParameter("@Qty", Quantity));
                    //   cmd.Parameters.Add(new SqlParameter("@Remarks", Remarks));
                    //  cmd.Parameters.Add(new SqlParameter("@ModeofPayment", ModeofPayment));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public DataTable Inventoryingcount(int id)
        {
            DataTable dt;
            string sql = "select distinct Inv_IngredientsID from Inventory where Inv_IngredientsID='" + id + "'";
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
         public DataTable InventoryUOMcount(int uomid,int ingid)
        {
            DataTable dt;
            string sql = "select distinct Inv_IngredientsID,Inv_MeasurementID from Inventory where Inv_MeasurementID = "+ uomid +" and Inv_IngredientsID = "+ ingid +"";
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
    }
    }
