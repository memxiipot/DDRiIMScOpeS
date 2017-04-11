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
    public class measurementcls
    {
        private string myUint;

        public string Unit
        {
            get { return myUint; }
            set { myUint = value; }
        }
        
        public bool InsertUnit()
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
                    cmd.CommandText = "insertunit";
                    cmd.Parameters.Add(new SqlParameter("@unit", myUint));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }
            }
            catch (Exception)
            {
                throw;

            }

            return result;
        }
        public string getUnits() {
            string result = string.Empty;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Measurement order by MeasurementID desc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<tr><td> " + reader["Unit"].ToString() + "</td> " +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editMeasurement.aspx?unitId=" + reader["MeasurementID"].ToString() + "'\">EDIT</button>" +
                                                "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteMeasurement.aspx?unitId=" + reader["MeasurementID"].ToString() + "'\">DELETE</button></td>" +

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
        public bool UpdateUnit(string unitid)
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
                    cmd.CommandText = "editmeasurement";
                    cmd.Parameters.Add(new SqlParameter("@unit", myUint));
                    cmd.Parameters.Add(new SqlParameter("@unitid", int.Parse(unitid)));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }
            }
            catch (Exception)
            {
                throw;

            }

            return result;
        }
        public void getUnitDetails(string unitid) {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Measurement where MeasurementId=" +unitid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            myUint=reader["Unit"].ToString();
                        }
                          
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool Delete(string unitid)
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
                    cmd.CommandText = "delete from Measurement where MeasurementID=" + unitid;
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {
                throw;
            }
            return result;
        }
        public DataTable getUnitsCbo()
        {
            DataTable dt;
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Measurement order by MeasurementID asc";
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