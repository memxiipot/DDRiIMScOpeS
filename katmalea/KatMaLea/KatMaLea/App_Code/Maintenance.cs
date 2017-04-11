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
    public class Maintenance
    {
        private Int32 _EquipmentMaintenanceID;
        public Int32 EquipmentMaintenanceID { get { return _EquipmentMaintenanceID; } set { _EquipmentMaintenanceID = value; } }
        private String _Description;
        public String Description { get { return _Description; } set { _Description = value; } }
        private DateTime _DateofMaintenance;
        public DateTime DateofMaintenance { get { return _DateofMaintenance; } set { _DateofMaintenance = value; } }
        private Int32 _EquipmentID;
        public Int32 EquipmentID { get { return _EquipmentID; } set { _EquipmentID = value; } }
        private Int32 _EquipmentID2;
        public Int32 EquipmentID2 { get { return _EquipmentID; } set { _EquipmentID = value; } }
        private Int32 _MaintenanceInterval;
        public Int32 MaintenanceInterval { get { return _MaintenanceInterval; } set { _MaintenanceInterval = value; } }
        private Int32 _Status;
        public Int32 Status { get { return _Status; } set { _Status = value; } }
        private Int32 _CreatedBy;
        public Int32 CreatedBy { get { return _CreatedBy; } set { _CreatedBy = value; } }

        public bool InsertMaintenance()
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
                    cmd.CommandText = "insertMaintenance";
                    cmd.Parameters.Add(new SqlParameter("@Description",Description));
                    cmd.Parameters.Add(new SqlParameter("@DateofMaintenance", DateofMaintenance));
                    cmd.Parameters.Add(new SqlParameter("@EquipmentID", EquipmentID));
                    cmd.Parameters.Add(new SqlParameter("@MaintenanceInterval", MaintenanceInterval));
                    cmd.Parameters.Add(new SqlParameter("@Status", Status));
                    cmd.Parameters.Add(new SqlParameter("@CreatedBy", userid));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        public DataTable bindequipmentCbo()
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
                    cmd.CommandText = "select EquipmentID,EquipmentName from Equipments";
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
        public Boolean checkequipmentID(int eqid)
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
                    cmd.CommandText = "select EquipmentID from Equipment_Maintenance where status =1 and equipmentid ='"+ eqid +"'" ;
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    adapter.Fill(dt);

                }
            }
            catch (Exception)
            {
                throw;
            }
            if ((dt.Rows.Count == 0))
            {
                return false;
            }
            else
            {
                return true;
            }
                

            
        }
        public bool check(int eqid)
        {
            
            if (eqid == 0)
            
            {
                return true;
            }
            else { return false; }
        }
        public string getEquipmentMaintenance()
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
                    cmd.CommandText = "select *,format((DateofMaintenance + MaintenanceInterval),'MMMM,dd yyyy') as NextMaintenance,format(DateofMaintenance,'MMMM,dd yyyy') as Maindate from Equipment_Maintenance eqm inner join refEqMaintenanceStatus eqs on eqs.Main_StatusID = eqm.Status inner join Equipments eq on eq.EquipmentID = eqm.EquipmentID order by EquipmentMaintenanceID desc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<tr><td> " + reader["Description"].ToString() + "</td> " +
                                                " <td>" + reader["Maindate"].ToString() + "</td>" +
                                                " <td>" + reader["EquipmentName"].ToString() + "</td>" +
                                                " <td>" + reader["NextMaintenance"].ToString() + "</td>" +
                                                " <td>" + reader["MaintenanceInterval"].ToString() + "</td>" +
                                                 " <td>" + reader["Main_StatusName"].ToString() + "</td>" +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editMaintenance.aspx?EquipmentMaintenanceID=" + reader["EquipmentMaintenanceID"].ToString() + "'\">EDIT</button>" +
                                                "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteMaintenance.aspx?EquipmentMaintenanceID=" + reader["EquipmentMaintenanceID"].ToString() + "'\">DELETE</button>" +
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
        public bool DeleteEquipmentMaintenance(string EquipmentMaintenanceID)
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
                    cmd.CommandText = "delete from Equipment_Maintenance where EquipmentMaintenanceID=" + EquipmentMaintenanceID;
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public void getDetails(string mainid)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Equipment_Maintenance where EquipmentMaintenanceID =" + mainid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            EquipmentMaintenanceID = int.Parse(reader["EquipmentMaintenanceID"].ToString());
                            Description = reader["Description"].ToString();
                            DateofMaintenance = DateTime.Parse(reader["DateofMaintenance"].ToString());
                            EquipmentID = int.Parse(reader["EquipmentID"].ToString());
                            MaintenanceInterval = int.Parse(reader["MaintenanceInterval"].ToString());
                            Status = int.Parse(reader["Status"].ToString());
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool EditEquipmentMaintenance(int mainid)
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
                    cmd.CommandText = "updateEquipmentMaintenance";
                    cmd.Parameters.Add(new SqlParameter("@EquipmentMaintenanceID", mainid));
                    cmd.Parameters.Add(new SqlParameter("@Description", Description));
                    cmd.Parameters.Add(new SqlParameter("@DateofMaintenance", DateofMaintenance));
                    cmd.Parameters.Add(new SqlParameter("@MaintenanceInterval", MaintenanceInterval));
                    cmd.Parameters.Add(new SqlParameter("@EquipmentID", EquipmentID));
                    cmd.Parameters.Add(new SqlParameter("@Status", Status));
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