using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class editcrew : System.Web.UI.Page
    {
        crewcls crew = new crewcls();
        private string mycrewname;
        private string myposition;
        private string mystatus;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
               

                if (positioncbo.Items.Count > 0)
                {
                    myposition = positioncbo.SelectedValue;
                }
                mycrewname = crewtextbox.Value;
                mystatus = (optionsRadios1.Checked == true) ? "1" : "0";
            }
            else {
                positioncbo.DataSource = crew.getPositionCbo();
                positioncbo.DataTextField = "PositionName";
                positioncbo.DataValueField = "PositionID";
                positioncbo.DataBind();
            }
              string crewid = Request.QueryString["crewid"].ToString();
              if (crewid != null)
            {
                crew.getCrewDetails(crewid);
                crewtextbox.Value = crew.CrewName;
                positioncbo.SelectedValue = crew.Position;
                optionsRadios1.Checked = (crew.Stat == "True") ? true : false;
                Radio1.Checked = (crew.Stat == "True") ? false : true;

            }
        }
        protected string getPositions()
        {
            return crew.getPosition();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                crew.CrewName = mycrewname;
                crew.Position = myposition;
                crew.Stat = mystatus;
                if (crew.update(Request.QueryString["crewid"].ToString()))
                {
                    Response.Redirect("~/crewlist.aspx");
                }
            }
        }
    }
}