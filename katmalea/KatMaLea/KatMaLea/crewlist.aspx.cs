using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class crewlist : System.Web.UI.Page
    {
        crewcls crew = new crewcls();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string getPosition() {
            return crew.getPosition();
        }
        protected string getlistofcrew() {
            return crew.getListOfCrew();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Master_default ma = new Master_default();
            if (Page.IsPostBack)
            {
                if (Request.Form["crewname"].ToString() == string.Empty)
                {                    
                    ma.ShowToastr(this, "toastr_message", "toastr.warning('Required field not supplied', 'Information')");
                }
                else
                {
                    crew.CrewName = Request.Form["crewname"].ToString();
                    crew.Position = Request.Form["positioncbo"].ToString();
                    crew.Stat = Request.Form["statusradio"].ToString();
                    if (crew.Insert())
                    {
                        ma.ShowToastr(this, "toastr_message", "toastr.success('Menu has been successfully saved.', '')");
                        //Response.Redirect(Request.Url.AbsolutePath);
                    }
                }
            }
        }
    }
}