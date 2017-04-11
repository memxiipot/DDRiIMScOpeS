using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace KatMaLea
{
    public partial class Master_default : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public void ShowToastr(Page page, string caption, string title)
        {
            page.ClientScript.RegisterStartupScript(page.GetType(),
            caption, title, true);
        }
        //public static void NumberOnly(KeyPressEventArgs e)
        //{
        //    if (char.IsDigit(e.KeyChar) || char.IsControl(e.KeyChar))
        //    {
        //        e.Handled = false;
        //    }
        //    else
        //    {
        //        e.Handled = true;
        //    }
        //}
    }
}