using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
namespace KatMaLea
{
    public class Connection
    {
        public static string getConnectionString() {
            return ConfigurationManager.ConnectionStrings["mainConnection"].ConnectionString;
        }
        public static string getConnectionName() {
            return ConfigurationManager.ConnectionStrings["mainConnection"].Name;
        }
    }
}