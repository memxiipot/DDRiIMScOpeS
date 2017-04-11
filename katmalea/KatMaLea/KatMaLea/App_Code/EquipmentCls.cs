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
    public class EquipmentCls
    {
        private String _EquipmentName;
        public String EquipmentName { get { return _EquipmentName; } set { _EquipmentName = value; } }
        private Int32 _EquipmentStatus;
        public Int32 EquipmentStatus { get { return _EquipmentStatus; } set { _EquipmentStatus = value; } }
        private String _Remarks;
        public String Remarks { get { return _Remarks; } set { _Remarks = value; } }

        public bool InsertEquipment()
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
                    cmd.CommandText = "insertEquipment";
                    cmd.Parameters.Add(new SqlParameter("@EquipmentName",EquipmentName ));
                    cmd.Parameters.Add(new SqlParameter("@Remarks", Remarks));
                    cmd.Parameters.Add(new SqlParameter("@EquipmentStatus", int.Parse(EquipmentStatus.ToString())));
                    cmd.Parameters.Add(new SqlParameter("@Addedby", int.Parse(userid.ToString())));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public bool EditEquipment(int eqid)
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
                    cmd.CommandText = "updateEquipment";                    
                    cmd.Parameters.Add(new SqlParameter("@EquipmentName", EquipmentName));
                    cmd.Parameters.Add(new SqlParameter("@EquipmentStatus", EquipmentStatus));
                    cmd.Parameters.Add(new SqlParameter("@Remarks", Remarks));
                    cmd.Parameters.Add(new SqlParameter("@EquipmentID", eqid));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public DataTable bindStatusCbo()
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
                    cmd.CommandText = "select Main_StatusID,Main_StatusName from refEqMaintenanceStatus";
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
        public string getEquipments()
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
                    cmd.CommandText = "select * from Equipments eq inner join refEqMaintenanceStatus eqs on eqs.Main_StatusID = eq.EquipmentStatus order by EquipmentID desc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<tr><td> " + reader["EquipmentName"].ToString() + "</td> " +
                                                " <td>" + reader["Remarks"].ToString() + "</td>" +
                                                " <td>" + reader["Main_StatusName"].ToString() + "</td>" +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editEquipment.aspx?EquipmentID=" + reader["EquipmentID"].ToString() + "'\">EDIT</button>" +
                                                "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteEquipment.aspx?EquipmentID=" + reader["EquipmentID"].ToString() + "'\">DELETE</button>" +                                                 
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
                    cmd.CommandText = "select * from Equipments where EquipmentID=" + eqid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            EquipmentName = reader["EquipmentName"].ToString();
                            Remarks = reader["Remarks"].ToString();
                            EquipmentStatus = int.Parse(reader["EquipmentStatus"].ToString());
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool DeleteEquipment(string EquipmentID)
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
                    cmd.CommandText = "delete from Equipments where EquipmentID=" + EquipmentID + "; delete from Equipment_Maintenance where EquipmentID=" + EquipmentID;
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