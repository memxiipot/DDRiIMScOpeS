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
    public class userscls
    {

         
        private string myusername;

        public string Username
        {
            get { return myusername; }
            set { myusername = value; }
        }
        private string mypassword;

        public string Password
        {
            get { return mypassword; }
            set { mypassword = value; }
        }
         private string myfirstname;

        public string Firstname
        {
            get { return myfirstname; }
            set { myfirstname = value; }
        }
        private string mylastname;

        public string Lastname
        {
            get { return mylastname; }
            set { mylastname = value; }
        }
        private string mymiddlename;

        public string Middlename
        {
            get { return mymiddlename; }
            set { mymiddlename = value; }
        }
        private string myusertype;

        public string UserType
        {
            get { return myusertype; }
            set { myusertype = value; }
        }
        private string mystatus;

        public string Stat
        {
            get { return mystatus; }
            set { mystatus = value; }
        }
        public DataTable bindUserType()
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
                    cmd.CommandText = "select UserTypeID,UserTypeName from refUserType where UserTypeID<>1";
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
                    cmd.CommandText = "insertUser";
              
                    cmd.Parameters.Add(new SqlParameter("@username", myusername));
                    cmd.Parameters.Add(new SqlParameter("@password", mypassword));
                    cmd.Parameters.Add(new SqlParameter("@firstname", myfirstname));
                    cmd.Parameters.Add(new SqlParameter("@lastname", mylastname));
                    cmd.Parameters.Add(new SqlParameter("@middlename", mymiddlename));
                    cmd.Parameters.Add(new SqlParameter("@usertype", int.Parse(myusertype)));
                    cmd.Parameters.Add(new SqlParameter("@stat", Convert.ToBoolean(int.Parse(mystatus))));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public bool isUsernameAvaiable(string username) {

            bool result = false;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Users where UserName='" + username +"'";
                    using (SqlDataReader reader=cmd.ExecuteReader())
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
        public string getListofUsers()
        {
            string result = string.Empty;
            string sql="SELECT     TOP (100) PERCENT dbo.Users.UserID, dbo.Users.UserName, dbo.Users.FirstName + ' ' + dbo.Users.MiddleName + ' ' + dbo.Users.LastName AS Fullname,  "+
                      " dbo.refUserType.UserTypeName, dbo.Users.IsActive "+
                    "FROM         dbo.Users INNER JOIN "+
                      " dbo.refUserType ON dbo.Users.UserTypeID = dbo.refUserType.UserTypeID "+
                        " WHERE     (dbo.Users.UserID <> 1) ORDER BY dbo.Users.UserID DESC";
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
                            string stat = (reader["IsActive"].ToString() == "True") ? "Yes" : "No";
                            result += "<tr>" +
                                   "<td> " + i + "</td> " +
                            "<td> " + reader["UserName"].ToString() + "</td> " +
                             "<td> " + reader["Fullname"].ToString() + "</td> " +
                              "<td> " + reader["UserTypeName"].ToString() + "</td> " +
                                                " <td>" + stat + "</td>" +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/edituser.aspx?userid=" + reader["UserID"].ToString() + "'\">EDIT</button></td>" +

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
        public void getUserDetails(string userid) {
            string result = string.Empty;
            string sql = "select * from Users where UserID=" + userid;
          
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
                            myusername = reader["UserName"].ToString();
                            mypassword = reader["UserPassword"].ToString();
                            myfirstname = reader["FirstName"].ToString();
                            mymiddlename = reader["MiddleName"].ToString();
                            mylastname = reader["LastName"].ToString();
                            myusertype = reader["UserTypeID"].ToString();
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

        public bool updateuser(string userid) {

            bool result = false;


            try
            {

                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "updateuser";
            //            @username varchar(50),@password varchar(50),@firstname varchar(50),
            //@middlename varchar(50),@lastname varchar(50),@usertypeid int,
            //@isactive bit,@UserId int
                    cmd.Parameters.Add(new SqlParameter("@username", myusername));
                    cmd.Parameters.Add(new SqlParameter("@password", mypassword));
                    cmd.Parameters.Add(new SqlParameter("@firstname", myfirstname));
                    cmd.Parameters.Add(new SqlParameter("@lastname", mylastname));
                    cmd.Parameters.Add(new SqlParameter("@middlename", mymiddlename));
                    cmd.Parameters.Add(new SqlParameter("@usertypeid", int.Parse(myusertype)));
                    cmd.Parameters.Add(new SqlParameter("@isactive", Convert.ToBoolean(int.Parse(mystatus))));
                    cmd.Parameters.Add(new SqlParameter("@UserId",int.Parse(userid)));
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