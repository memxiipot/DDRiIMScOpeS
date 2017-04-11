using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Audittrail : System.Web.UI.Page
    {
        AudittrailCls cls = new AudittrailCls();
        int count; 
        
        protected void Page_Load(object sender, EventArgs e)
        {
             count = int.Parse(Request.QueryString["countid"].ToString());
             if (count == 0)
             {
                 LinkButton2.Visible = false;
             }
             else { LinkButton2.Visible = true ; }
        }
        protected string getlist(int ct)
        {
            return cls.getList(ct);
        }
        protected int count2()
        {
            return count;
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            count = count + 10;
            
             LinkButton2.Visible = true;
             Response.Redirect("~/Audittrail.aspx?countid=" + count);
            
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            count = count - 10;
            //if (count <= 0)
            //{
               // LinkButton2.Visible = false;
            //}
            //else
            //{
                LinkButton2.Visible = true;
                Response.Redirect("~/Audittrail.aspx?countid=" + count);
            //}
        }
    }
}