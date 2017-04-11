using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class Positions : System.Web.UI.Page
    {
        PositionCls clspos = new PositionCls();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                if (Request.Form["position"].ToString() == string.Empty)
                {
                    Master_default ma = new Master_default();
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    clspos.PositionName = Request.Form["position"].ToString();
                    clspos.Status = Request["statusradio"].ToString();
                    if (clspos.InsertPosition())
                    {
                        Master_default ma = new Master_default();
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Menu has been successfully saved.', '')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
            }
        }
        protected string getlistOfPosition() {
            return clspos.getPosition();
        }
    }
}