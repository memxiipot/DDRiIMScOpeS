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

    public class categoriescls
    {
        private string mycategory;

        public string category
        {
            get { return mycategory; }
            set { mycategory = value; }
        }
        
          public bool Insert()
        {
            bool result = false;
            int userid;
            try
            {
                userid = int.Parse(HttpContext.Current.Session["UserId"].ToString());
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
                    cmd.CommandText = "insertcategory";
                    cmd.Parameters.Add(new SqlParameter("@category", mycategory));
                    cmd.Parameters.Add(new SqlParameter("@userId", userid));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
          public string getcategory()
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
                      cmd.CommandText = "select * from refCategory order by CategoryID desc";

                      using (SqlDataReader reader = cmd.ExecuteReader())
                      {
                          while (reader.Read())
                          {
                              result += "<tr><td> " + reader["CategoryName"].ToString() + "</td> " +
                                                  "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editCategory.aspx?catId=" + reader["CategoryID"].ToString() + "'\">EDIT</button>" +
                                                  "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteCategory.aspx?catId=" + reader["CategoryID"].ToString() + "'\">DELETE</button>" +
                                                   "<button type=\"button\" class=\"btn btn-success\" onClick=\"window.location='/categoryMenu.aspx?catId=" + reader["CategoryID"].ToString() + "&menu=" + reader["CategoryName"].ToString() + "'\">MENUS</button></td>" +
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
          public string getcategoryDetails(string catId)
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
                      cmd.CommandText = "select CategoryName from refCategory where CategoryID=" + catId;

                      using (SqlDataReader reader = cmd.ExecuteReader())
                      {
                          while (reader.Read())
                          {
                              mycategory = reader[0].ToString();
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
          public bool Update(string catid)
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
                      cmd.CommandText = "updatecategory";
                      cmd.Parameters.Add(new SqlParameter("@catname", mycategory));
                      cmd.Parameters.Add(new SqlParameter("@catid", int.Parse(catid)));
                      result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                  }
              }
              catch (Exception)
              {

                  throw;
              }
              return result;
          }
          public bool Delete(string catid)
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
                      cmd.CommandText = "delete from refCategory where CategoryID=" + catid;
                      result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                  }

              }
              catch (Exception)
              {

                  throw;
              }
              return result;
          }
          public string getcategorycbo()
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
                      cmd.CommandText = "select CategoryID,CategoryName from refCategory";

                      using (SqlDataReader reader = cmd.ExecuteReader())
                      {
                          while (reader.Read())
                          {
                              result += "<option value=\" " + reader["CategoryID"].ToString() + "\">" + reader["CategoryName"].ToString() + "</option> ";
                          }
                      }

                  }
              }
              catch (Exception) {
                  throw;
              }
              return result;
          }
          public DataTable bindcategoryCbo()
          {
              DataTable dt;
              string result = string.Empty;
              try
              {
                  using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                  {
                      conn.Open();
                      SqlCommand cmd = new SqlCommand();
                      cmd.Connection = conn;
                      cmd.CommandType = CommandType.Text;
                      cmd.CommandText = "select CategoryID,CategoryName from refCategory";
                      SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                      dt = new DataTable();
                      adapter.Fill(dt);
                      dt.Rows.Add("0","Uncategorized");
                  }
              }
              catch (Exception)
              {
                  throw;
              }
              return dt;
          }
          public DataTable bindcategoryCboSearch()
          {
              DataTable dt;
              string result = string.Empty;
              try
              {
                  using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                  {
                      conn.Open();
                      SqlCommand cmd = new SqlCommand();
                      cmd.Connection = conn;
                      cmd.CommandType = CommandType.Text;
                      cmd.CommandText = "select CategoryID,CategoryName from refCategory";
                      SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                      dt = new DataTable();
                      adapter.Fill(dt);
                      dt.Rows.Add("0", "All");
                  }
              }
              catch (Exception)
              {
                  throw;
              }
              return dt;
          }
          public string getMenuUnderCategory(string catid)
          {
              string result = string.Empty;
              string sql = "SELECT     TOP (100) PERCENT Menu_Name ";
              sql += " FROM         dbo.Menu";
              sql += " WHERE     (Menu_Category = @catid)";
              sql +=" ORDER BY MenuID DESC;";
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
                              result += "<tr><td> " + reader["Menu"].ToString() + "</td> " +
                                                "<td><button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteCategory.aspx?catId=" + reader["CategoryID"].ToString() + "'\">DELETE</button> </td>" +        
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