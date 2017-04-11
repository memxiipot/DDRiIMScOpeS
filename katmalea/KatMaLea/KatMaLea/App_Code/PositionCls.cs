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
    public class PositionCls
    {
        private string myposition;

        public string PositionName
        {
            get { return myposition; }
            set { myposition = value; }
        }
        private string mystatus;

        public string Status
        {
            get { return mystatus; }
            set { mystatus = value; }
        }

        public bool InsertPosition()
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
                    cmd.CommandText = "insertPosition";
                    cmd.Parameters.Add(new SqlParameter("@position", myposition));
                    cmd.Parameters.Add(new SqlParameter("@IsActive", int.Parse( mystatus)));
                    cmd.Parameters.Add(new SqlParameter("@createdby", userid));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }
            }
            catch (Exception)
            {
                throw;
              
            }
      
            return result;
        }
        public string getPosition() {
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from refPosition order by PositionID desc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string stat=(reader["IsActive"].ToString()=="True")?"Active":"InActive";
                            result += "<tr><td> " + reader["PositionName"].ToString() + "</td> " +
                                                " <td>" +  stat + "</td>" +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editPosition.aspx?posId=" + reader["PositionID"].ToString() + "'\">EDIT</button>" +
                                                "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deletePosition.aspx?posId=" + reader["PositionID"].ToString() + "'\">DELETE</button></td>" +
                                                
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
        public void getPositonDetails(string posid) {
           
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from refPosition where PositionID=" +posid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            myposition=reader["PositionName"].ToString();
                            mystatus = reader["IsActive"].ToString();
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
       
        }
        public bool Update(string posid) {
            bool result = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "updatePosition";
                    cmd.Parameters.Add(new SqlParameter("@position", myposition));
                    cmd.Parameters.Add(new SqlParameter("@stat", int.Parse(mystatus)));
                    cmd.Parameters.Add(new SqlParameter("@posid", int.Parse(posid)));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }
            }
            catch (Exception)
            {
                throw;

            }

            return result;
        }
        public bool DeletePosition(string posid)
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
                    cmd.CommandText = "delete from refPosition where PositionID=" + posid;
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
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