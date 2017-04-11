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
    public class ExpenseDetailsCls
    {
        private Int32 _ExpenseDetailsID;
        public Int32 ExpenseDetailsID { get { return _ExpenseDetailsID; } set { _ExpenseDetailsID = value; } }
        private Int32 _AccountID;
        public Int32 AccountID { get { return _AccountID; } set { _AccountID = value; } }
        private Decimal _Debit;
        public Decimal Debit { get { return _Debit; } set { _Debit = value; } }
        private Decimal _Credit;
        public Decimal Credit { get { return _Credit; } set { _Credit = value; } }
        private Int32 _ExpenseID;
        public Int32 ExpenseID { get { return _ExpenseID; } set { _ExpenseID = value; } }

        public bool InsertExpensedetails()
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
                    cmd.CommandText = "insertExpenseDetails";
                    cmd.Parameters.Add(new SqlParameter("@AccountID", AccountID));
                    cmd.Parameters.Add(new SqlParameter("@Debit", Debit));
                    cmd.Parameters.Add(new SqlParameter("@Credit", Credit));
                    cmd.Parameters.Add(new SqlParameter("@ExpenseID", ExpenseID));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public DataTable bindaccountCbo()
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
                    cmd.CommandText = "select AccountID,AccountName from ChartofAccounts";
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
        public string getExpensedetails()
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
                    cmd.CommandText = "select * from ExpenseDetails e inner join ChartofAccounts c on c.AccountID = e.AccountID order by ExpenseID desc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<tr><td> " + reader["AccountName"].ToString() + "</td> " +
                                                " <td>" + reader["Debit"].ToString() + "</td>" +
                                                " <td>" + reader["Credit"].ToString() + "</td>" +
                                                //" <td>" + reader["mop"].ToString() + "</td>" +
                                                //" <td>" + reader["Total"].ToString() + "</td>" +
                                //"<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editEquipment.aspx?ExpenseID=" + reader["ExpenseID"].ToString() + "'\">EDIT</button>" +
                                                "<td><button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteExpenseDetails.aspx?ExpenseDetailsID=" + reader["ExpenseDetailsID"].ToString() + "'\">DELETE</button>" +
                                                //"<button type=\"button\" class=\"btn btn-success\" onClick=\"window.location='/ExpenseDetails.aspx?ExpenseID=" + reader["ExpenseID"].ToString() + "&Payee=" + reader["Payee"].ToString() + "'\">DETAILS</button>
                                                "</td>" +
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
        public void getDetails(string exdid)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from ExpenseDetails where ExpenseDetailsID=" + exdid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ExpenseID = int.Parse(reader["ExpenseID"].ToString());
                            
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool DeleteExpenseDetails(string exdid,string expenseid)
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
                    cmd.CommandText = "delete from ExpenseDetails where ExpenseDetailsID=" + exdid +"; update Expense set Total = (select sum(debit) from ExpenseDetails where Expense.ExpenseID ='"+ expenseid +"') where ExpenseID = " + expenseid;
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