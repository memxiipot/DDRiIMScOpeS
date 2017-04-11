using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Web.UI;

namespace KatMaLea
{
    public class Menus
    {
        private Int32 _test;
        public Int32 test { get { return _test; } set { _test = value; } }

        private string _test2;
        public string test2 { get { return _test2; } set { _test2 = value; } }

        private string mymenuname;

        public string MenuName
        {
            get { return mymenuname; }
            set { mymenuname = value; }
        }
        private string myPrice;

        public string Price
        {
            get { return myPrice; }
            set { myPrice = value; }
        }
        private string myquantity;

        public string Quantity
        {
            get { return myquantity; }
            set { myquantity = value; }
        }
        private string mycatid;

        public string categoryId
        {
            get { return mycatid; }
            set { mycatid = value; }
        }
        public bool InsertMenu()
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
                    cmd.CommandText = "insertMenu";
                    cmd.Parameters.Add(new SqlParameter("@menuname", mymenuname));
                    cmd.Parameters.Add(new SqlParameter("@price", decimal.Parse(myPrice)));
                    cmd.Parameters.Add(new SqlParameter("@cat", int.Parse(mycatid)));
                    cmd.Parameters.Add(new SqlParameter("@userid", (userid)));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }
        public string getMenu(int rowcount,string catid)
        {
            string result = string.Empty;
            string sql = "SELECT     dbo.Menu.Menu_Name, dbo.refCategory.CategoryName, dbo.Menu.Menu_Price, dbo.Menu.MenuID" +
                        " FROM         dbo.refCategory RIGHT OUTER JOIN " +
                      " dbo.Menu ON dbo.refCategory.CategoryID = dbo.Menu.Menu_Category where refCategory.CategoryID like '%" + catid + "%'" +
                        " order by Menu_Name  asc OFFSET " + rowcount + " ROWS FETCH NEXT 10 ROWS ONLY";
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
                            
                            int count = 0;
                            count = count + 1;
                            result += "<tr><td> " + reader["Menu_Name"].ToString() + "</td> " +
                                                " <td>" + reader["Menu_Price"].ToString() + "</td>" +
                                                " <td>" + reader["CategoryName"].ToString() + "</td>" +
                                                "<td><button type=\"button\" class=\"btn btn-primary\" onClick=\"window.location='/editMenu.aspx?menuid=" + reader["MenuID"].ToString() + "'\">EDIT</button>" +
                                                "<button type=\"button\" class=\"btn btn-danger\"disabled=\"disabled\" onClick=\"window.location='/deleteMenu.aspx?menuid=" + reader["MenuID"].ToString() + "'\">DELETE</button>" +
                                                 "<button type=\"button\" class=\"btn btn-success\" onClick=\"window.location='/IngredientsMenu.aspx?menuid=" + reader["MenuID"].ToString() + "&menu=" + reader["Menu_Name"].ToString() + "'\">INGREDIENTS</button></td>" +
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
        public void getDetails(string menuid)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from Menu where MenuId=" + menuid;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            mymenuname = reader["Menu_Name"].ToString();
                            myPrice = reader["Menu_Price"].ToString();
                            mycatid = reader["Menu_Category"].ToString();
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public void getMenuCounts(string catid)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;

                    cmd.CommandText = "SELECT  count(*) OVER (Order by Menu_Name) as NumALL FROM  dbo.refCategory RIGHT OUTER JOIN dbo.Menu ON dbo.refCategory.CategoryID = dbo.Menu.Menu_Category where refCategory.CategoryID like '%" + catid + "%' order by Menu_Name  desc OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY ";
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            test = int.Parse(reader["NumALL"].ToString());
                        }
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool EditMenu(int menuid)
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
                    cmd.CommandText = "updateMenu";
                    cmd.Parameters.Add(new SqlParameter("@menuname", mymenuname));
                    cmd.Parameters.Add(new SqlParameter("@price", myPrice));
                    cmd.Parameters.Add(new SqlParameter("@menuId", menuid));
                    cmd.Parameters.Add(new SqlParameter("@cat", int.Parse(mycatid)));
                    cmd.Parameters.Add(new SqlParameter("@userid", (userid)));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        public bool DeleteMenu(string menuID)
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
                    cmd.CommandText = "delete from Ingredients_of_menu where MenuID=" + menuID + "; delete from Menu where MenuID=" + menuID;
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());

                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        public bool InserIngredToMenu(string menuid, int ingredid)
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
                    cmd.CommandText = "insertIngredToMenu";
                    cmd.Parameters.Add(new SqlParameter("@ingredId", (ingredid)));
                    cmd.Parameters.Add(new SqlParameter("@quantity", decimal.Parse(myquantity)));
                    cmd.Parameters.Add(new SqlParameter("@menuid", int.Parse(menuid)));
//                    cmd.Parameters.Add(new SqlParameter("@cat", int.Parse(mycatid)));
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        public string getMenuCategory(string catid)
        {
            string result = string.Empty;
            string sql = "SELECT     TOP (100) PERCENT Menu_Name,MenuID " +
                            " FROM         dbo.Menu " +
                            " WHERE     (Menu_Category = " + catid + ") " +
                                " ORDER BY MenuID DESC;";
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
                            result += "<tr><td> " + reader["Menu_Name"].ToString() + "</td> " +
                                                "<td><button type=\"button\" class=\"btn btn-danger\" onClick=\"window.location='/removeMenu.aspx?menuid=" + reader["MenuID"].ToString() + "'\">REMOVE</button></td>" +
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

        public bool RemoveMenuFromCategory(string menuid)
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
                    cmd.CommandText = "removeMenuFromCategory";
    
                    cmd.Parameters.Add(new SqlParameter("@menuid", int.Parse(menuid)));
         
                    result = Convert.ToBoolean(cmd.ExecuteNonQuery());
                }

            }
            catch (Exception)
            {

                throw;
            }
            return result;
        }

        public DataTable getMenuCbo() { 
            DataTable dt;
                   try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select MenuID,Menu_Name from Menu order by Menu_Name asc";
                    dt=new DataTable();
                    SqlDataAdapter adapter=new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }
            catch (Exception)
            {

                throw;
            }
            return dt;
        }
        public DataTable getMenuIngredients(int menuid,int qty)
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
                    cmd.CommandText = "select Inv_IngredientsID,(SELECT SUM(Inv_Quantity) AS Expr1 FROM dbo.Inventory AS i2 WHERE (Inv_IngredientsID = i.Inv_IngredientsID)GROUP BY Inv_IngredientsID) - [dbo].[FcnGetQuantity](Inv_IngredientsID) as Available from Inventory i inner join Ingredients_of_menu on Ingredients_of_menu.Ingredients_ID = Inv_IngredientsID where ((SELECT SUM(Inv_Quantity) AS Expr1 FROM dbo.Inventory AS i2 WHERE (Inv_IngredientsID = i.Inv_IngredientsID)GROUP BY Inv_IngredientsID) -  case when [dbo].[FcnGetQuantity](Inv_IngredientsID) is null then 0  else [dbo].[FcnGetQuantity](Inv_IngredientsID) end)  -((select Quantity from Ingredients_of_menu im where im.Ingredients_ID = i.Inv_IngredientsID and im.MenuID = " + menuid + ")*" + qty + ")<0 and MenuID = " + menuid + " group by Inv_IngredientsID";
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
        public DataTable ifmenuexist(string menuname)
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
                    cmd.CommandText = "select * from Menu where Menu_Name = '"+ menuname + "'";
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
        public DataTable getdatarowcount(int rowcount, string catid)
        {
            DataTable dt;
            string sql = "SELECT     dbo.Menu.Menu_Name, dbo.refCategory.CategoryName, dbo.Menu.Menu_Price, dbo.Menu.MenuID" +
                        " FROM         dbo.refCategory RIGHT OUTER JOIN " +
                      " dbo.Menu ON dbo.refCategory.CategoryID = dbo.Menu.Menu_Category where refCategory.CategoryID like '%" + catid + "%'" +
                        " order by MenuID  asc OFFSET " + rowcount + " ROWS FETCH NEXT 10 ROWS ONLY";
            try
            {
                using (SqlConnection conn = new SqlConnection(Connection.getConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;
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
        public int checkingredient(int menuid,int qty)
        {
            int count;
            DataTable dting = getMenuIngredients(menuid,qty);

            count = int.Parse(dting.Rows.Count.ToString());
            return count;
        }
        
        
    }
}