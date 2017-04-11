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
    public class clsIngredients
    {
        
        private int mystat;

        public int Status
        {
            get { return mystat; }
            set { mystat = value; }
        }
        
        private String  myIngredient;

        public String IngredientName
        {
            get { return myIngredient; }
            set { myIngredient = value; }
        }
        private String _limit;

        public String limit
        {
            get { return _limit; }
            set { _limit = value; }
        }
        public bool Insert()
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
                    cmd.CommandText = "insertingredients";
                    cmd.Parameters.Add(new SqlParameter("@ingredname", myIngredient));
                    cmd.Parameters.Add(new SqlParameter("@stat", mystat));
                    cmd.Parameters.Add(new SqlParameter("@limit", _limit));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public string getIngredient()
        {
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from refIngredients order by Name asc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string stat = (reader["Ing_Status"].ToString()=="1")?"Active":"InActive";
                            result += "<tr><td> " + reader["Name"].ToString() + "</td> " +
                                " <td>" + stat + "</td>" +
                                 "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editIngredient.aspx?ingredientId=" + reader["IngredientsID"].ToString() + "'\">EDIT</button>" +
                                 "<button type=\"button\" class=\"btn btn-danger\" disabled=\"disabled\" onClick=\"window.location='/deleteIngredient.aspx?ingredientId=" + reader["IngredientsID"].ToString() + "'\">DELETE</button></td>" +
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
        public bool Delete(string id) {
            bool result = false;
            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "delete from refIngredients where IngredientsID="+ id;

                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public void getDetails(string id) {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from refIngredients where IngredientsID=" + id;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                           myIngredient=reader["Name"].ToString();
                          mystat=int.Parse( reader["Ing_Status"].ToString());
                          limit = reader["limit"].ToString();
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool Update(string id) {
            bool result = false;
            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "updateIngredient";
                    cmd.Parameters.Add(new SqlParameter("@name", myIngredient));
                    cmd.Parameters.Add(new SqlParameter("@stat", mystat));
                    cmd.Parameters.Add(new SqlParameter("@Limit", limit));
                    cmd.Parameters.Add(new SqlParameter("@id",int.Parse( id)));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public string getIngredientCbo()
        {
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select IngredientsID,Name from refIngredients where Ing_Status=1 order by Name asc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<option value=\" " + reader["IngredientsID"].ToString() +"\">" + reader["Name"].ToString() +"</option> ";
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
        public DataTable getIngredientaspCbo()
        {
            DataTable dt;
            //string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select IngredientsID,Name from refIngredients where Ing_Status=1";
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    adapter.Fill(dt);

                }
            }
            catch (Exception)
            {
                throw;
            }
            return dt;
            //        using (SqlDataReader reader = cmd.ExecuteReader())
            //        {
            //            while (reader.Read())
            //            {
            //                result += "<option value=\" " + reader["IngredientsID"].ToString() +"\">" + reader["Name"].ToString() +"</option> ";
            //            }
            //        }

            //    }
            //}
            //catch (Exception)
            //{

            //    throw;
            //}
            //return result;
        }
        public string getIngredientsOfMenu(string menuid) {
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "getIngredientsofMenu";
                    cmd.Parameters.Add(new SqlParameter("@menuId",int.Parse(menuid)));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<tr><td> " + reader["Name"].ToString() + "</td> " +
                                " <td>" + reader["Quantity"].ToString() + "</td>" +
                                 "<td><button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteMenuIngredients.aspx?id=" + reader["ID"].ToString() + "'\">DELETE</button></td>" +
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
        public int checkingredient(string menuid,string ingid){
            int count;
            DataTable dting = GetDataTable(menuid,ingid);

            count = int.Parse(dting.Rows.Count.ToString());
            return count;
        }
        public static DataTable GetDataTable(params object[] ParamValue)
        {
            SqlConnection conn = new SqlConnection(Connection.getConnectionString());
            DataTable _DataTable = new DataTable();
            SqlCommand _CommandGetDataTable = new SqlCommand("[getIngredientsofMenuExist]", conn);
            _CommandGetDataTable.CommandType = CommandType.StoredProcedure;
            _CommandGetDataTable.Parameters.Clear();
            _CommandGetDataTable.Parameters.Add("@menuId", SqlDbType.VarChar).Value = ParamValue[0];
            _CommandGetDataTable.Parameters.Add("@IngredientsID", SqlDbType.VarChar).Value = ParamValue[1];
            try
            {
                conn.Open();
                _CommandGetDataTable.ExecuteNonQuery();

                SqlDataAdapter _Adapter = new SqlDataAdapter();
                _Adapter.SelectCommand = _CommandGetDataTable;

               
                _Adapter.Fill(_DataTable);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return _DataTable;
        }
        public bool DeleteIngredientsOfMenu(string id)
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
                    cmd.CommandText = "delete from Ingredients_of_menu where Ingredients_ID=" + id + ";delete from Ingredients_of_menu where Ingredients_of_menu.ID=" + id;

                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public DataTable getdatarowcount(string name)
        {
            DataTable dt;
            string sql = "select * from refIngredients where Name='" + name + "' order by Name asc";
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
