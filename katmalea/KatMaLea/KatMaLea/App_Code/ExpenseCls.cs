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
    public class ExpenseCls
    {
        private Int32 _ExpenseID;
        public Int32 ExpenseID { get { return _ExpenseID; } set { _ExpenseID = value; } }
        private String _Payee;
        public String Payee { get { return _Payee; } set { _Payee = value; } }
        private String _Remarks;
        public String Remarks { get { return _Remarks; } set { _Remarks = value; } }
        private Int32 _ModeofPayment;
        public Int32 ModeofPayment { get { return _ModeofPayment; } set { _ModeofPayment = value; } }
        private Decimal _Total;
        public Decimal Total { get { return _Total; } set { _Total = value; } }
        private Int32 _Createdby;
        public Int32 Createdby { get { return _Createdby; } set { _Createdby = value; } }
        private DateTime _CreatedDate;
        public DateTime CreatedDate { get { return _CreatedDate; } set { _CreatedDate = value; } }
        
        public bool InsertExpense()
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
                    cmd.CommandText = "insertExpense";
                    cmd.Parameters.Add(new SqlParameter("@Payee", Payee));
                    cmd.Parameters.Add(new SqlParameter("@Remarks", Remarks));
                    cmd.Parameters.Add(new SqlParameter("@ModeofPayment", int.Parse(ModeofPayment.ToString())));
                    cmd.Parameters.Add(new SqlParameter("@Createdby", int.Parse(userid.ToString())));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public string getExpense()
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
                    cmd.CommandText = "select Expense.ExpenseID,Payee,Remarks,sum(debit) as debit,SUM(credit) as Total, case when ModeofPayment = 0 then 'Cash' else 'Check' end as mop, case when Status = 0 then 'Unpost' else 'Post' end as Status from Expense inner join ExpenseDetails on Expense.ExpenseID = ExpenseDetails.ExpenseID group by Expense.ExpenseID,Payee,Remarks,ModeofPayment,Status order by Expense.ExpenseID desc";

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += "<tr><td> " + reader["ExpenseID"].ToString() + "</td> " +
                                                " <td>" + reader["Payee"].ToString() + "</td>" +
                                                " <td>" + reader["Remarks"].ToString() + "</td>" +
                                                " <td>" + reader["mop"].ToString() + "</td>" +
                                                " <td>" + reader["Total"].ToString() + "</td>" +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editExpense1.aspx?ExpenseID=" + reader["ExpenseID"].ToString() + "'\">EDIT</button>" +
                                                "<button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/deleteExpense.aspx?ExpenseID=" + reader["ExpenseID"].ToString() + "'\">DELETE</button>" +
                                                "<button type=\"button\" class=\"btn btn-success\" onClick=\"window.location='/ExpenseDetails.aspx?ExpenseID=" + reader["ExpenseID"].ToString() + "&Payee=" + reader["Payee"].ToString() + "'\">DETAILS</button></td>" +                                                
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
        public bool EditExpense(int expenseid)
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
                    cmd.CommandText = "updateExpense";
                    cmd.Parameters.Add(new SqlParameter("@ExpenseID", expenseid));
                    cmd.Parameters.Add(new SqlParameter("@Payee", Payee));
                    cmd.Parameters.Add(new SqlParameter("@Remarks", Remarks));
                    cmd.Parameters.Add(new SqlParameter("@ModeofPayment", ModeofPayment));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

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
                    cmd.CommandText = "select * from Expense where ExpenseID=" + eqid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ExpenseID = int.Parse(reader["ExpenseID"].ToString());
                            Payee = reader["Payee"].ToString();
                            Remarks = reader["Remarks"].ToString();
                            ModeofPayment = int.Parse(reader["ModeofPayment"].ToString());
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool DeleteExpense(string ExpenseID)
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
                    cmd.CommandText = "delete from Expense where ExpenseID=" + ExpenseID + "; delete from ExpenseDetails where ExpenseID=" + ExpenseID;
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