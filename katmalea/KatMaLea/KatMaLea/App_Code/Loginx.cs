using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Data.SqlClient;
namespace KatMaLea
{
    public class Loginx
    {
        private int myUserId;

        public int UserId
        {   
            get { return myUserId; }
            set { myUserId = value; }
        }
        private String myUsername;

        public String Username
        {
            get { return myUsername; }
            set { myUsername = value; }
        }
        private String myPassword;

        public String Password
        {
            get { return myPassword; }
            set { myPassword = value; }
        }


        public bool isUserOk() {
            bool result = false;
     
            try
            {
            
                    using (SqlConnection conn=new SqlConnection(Connection.getConnectionString()))
                    {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType =CommandType.StoredProcedure;
                    cmd.CommandText = "isuserloginok";
                    cmd.Parameters.Add(new SqlParameter("@username",myUsername));
                    cmd.Parameters.Add(new SqlParameter("@password", myPassword));
                    using (SqlDataReader reader=cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                             HttpContext.Current.Session["UserId"] = reader["UserID"].ToString();
                             HttpContext.Current.Session["Username"] = reader["UserName"].ToString();
                             HttpContext.Current.Session["UserType"] = reader["UserTypeID"].ToString();
                            HttpContext.Current.Session["Fullname"] =reader["FirstName"].ToString() + " " + reader["MiddleName"].ToString() + " " +reader["LastName"].ToString();
                             return true;
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