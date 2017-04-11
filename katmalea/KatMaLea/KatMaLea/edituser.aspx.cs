using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class edituser : System.Web.UI.Page
    {
        userscls cls = new userscls();
        private string myusername;
        private string mypassword;
        private string myfirstname;
        private string mymiddlename;
        private string mylastname;
        private string myusertypeid;
        private string mystatus;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                usertypecbo.DataSource = cls.bindUserType();
                usertypecbo.DataTextField = "UserTypeName";
                usertypecbo.DataValueField = "UserTypeID";
                usertypecbo.DataBind();
                string userid = Request.QueryString["userid"].ToString();
                if (Request.QueryString["userid"] != null)
                {
                    cls.getUserDetails(userid);
                    usernametextbox.Value = cls.Username;
                    passwordtextbox.Value = cls.Password;
                    firstnametextbox.Value = cls.Firstname;
                    middlenametextbox.Value = cls.Middlename;
                    lastnametextbox.Value = cls.Lastname;
                    usertypecbo.SelectedValue = cls.UserType;
                    optionsRadios1.Checked = (cls.Stat == "True") ? true : false;
                    Radio1.Checked = (cls.Stat == "True") ? false : true;

                    //pos.getPositonDetails(ingredid);
                    //positiontextbox.Value = pos.PositionName;
                    //statusradiobutton.Checked = (pos.Status == "True") ? true : false;
                    //Radio1.Checked = (pos.Status == "True") ? false : true;

                }
            }
            else {
                myusername = usernametextbox.Value;
                mypassword = passwordtextbox.Value;
                myfirstname = firstnametextbox.Value;
                mymiddlename = middlenametextbox.Value;
                mylastname = lastnametextbox.Value;
                myusertypeid = usertypecbo.SelectedValue;
                mystatus = (optionsRadios1.Checked == true) ? "1" : "0";
            }
       
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                spanmessage.InnerHtml = string.Empty;

                cls.Username = myusername;
                cls.Password = mypassword;
                cls.Firstname = myfirstname;
                cls.Lastname = mylastname;
                cls.Middlename = mymiddlename;
                cls.UserType = myusertypeid;
                cls.Stat =mystatus;
                if (cls.updateuser(Request.QueryString["userid"].ToString()))
                {
                    spanmessage.InnerHtml = messagecls.alertSuccess("Updating successfull");
                    Response.Redirect("~/userslist.aspx");
                }
            }
         
        }
    }
}