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
    public class crewcls
    {
        private string myCrewName;

        public string CrewName
        {
            get { return myCrewName; }
            set { myCrewName = value; }
        }
         private string myposition;

        public string Position
        {
            get { return myposition; }
            set { myposition = value; }
        }
        private string mystat;

        public string Stat
        {
            get { return mystat; }
            set { mystat = value; }
        }

        public DataTable crewlistCbo() {
            DataTable dt;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Crew_List where Crew_Position=4 order by Crew_Fullname asc";

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
        public string getPosition()
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
                    cmd.CommandText = "select PositionName,PositionID from refPosition where IsActive=1";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<option value=\" " + reader["PositionID"].ToString() + "\">" + reader["PositionName"].ToString() + "</option> ";
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
        public string getListOfCrew()
        {
            string result = string.Empty;
            int i = 0;
            try
            {
                string sql = "SELECT   dbo.Crew_List.CrewID,  dbo.Crew_List.Crew_FullName, dbo.refPosition.PositionName, dbo.Crew_List.IsActive " +
                    " FROM         dbo.refPosition INNER JOIN "+
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
                            result += "<tr> "+
                                "  <td> " +i + "</td> " +
                              "  <td> " + reader["Crew_FullName"].ToString() + "</td> " +
                             "  <td> " + reader["PositionName"].ToString() + "</td> " +
                             "  <td> " +stat  + "</td> " +
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
                    cmd.CommandText = "insertCrew";
                    cmd.Parameters.Add(new SqlParameter("@crew", myCrewName));
                    cmd.Parameters.Add(new SqlParameter("@position", int.Parse(myposition)));
                    cmd.Parameters.Add(new SqlParameter("@stat", Convert.ToBoolean(int.Parse(mystat))));
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
        public void getCrewDetails(string crewid) {
          
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Crew_List where CrewID=" + crewid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            myCrewName = reader["Crew_FullName"].ToString();
                            myposition = reader["Crew_Position"].ToString();
                            mystat = reader["IsActive"].ToString();
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
       
        }
        public DataTable getPositionCbo() {
            DataTable dt;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select PositionName,PositionID from refPosition where IsActive=1";
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
        public bool update(string crewid) {
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
                    cmd.CommandText = "updatecrew";
                    cmd.Parameters.Add(new SqlParameter("@crewname", myCrewName));
                    cmd.Parameters.Add(new SqlParameter("@position", int.Parse(myposition)));
                    cmd.Parameters.Add(new SqlParameter("@stat", Convert.ToBoolean(int.Parse(mystat))));
                    cmd.Parameters.Add(new SqlParameter("@crewid", crewid));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }
            }
            catch (Exception)
            {
                throw;

            }

            return result;
        }
        public bool DeletePosition(string crewid)
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
                    cmd.CommandText = "delete from Crew_List where CrewID=" + crewid;
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