using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KatMaLea
{
    public partial class userslist : System.Web.UI.Page
    {
        userscls cls = new userscls();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                usertypecbo.DataSource = cls.bindUserType();
                usertypecbo.DataTextField = "UserTypeName";
                usertypecbo.DataValueField = "UserTypeID";
                usertypecbo.DataBind();
            }
       
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                spanmessage.InnerHtml = string.Empty;
                if (string.IsNullOrWhiteSpace(Request.Form["usernametxt"].ToString()))
                {
                    spanmessage.InnerHtml = messagecls.alertInfo("Username cannot be empty of characters");
                    return;
                }
                if (string.IsNullOrWhiteSpace(Request.Form["passwordtxt"].ToString()))
                {
                    spanmessage.InnerHtml = messagecls.alertInfo("Password is required");
                    return;
                }
                if (string.IsNullOrWhiteSpace(Request.Form["firstname"].ToString()))
                {
                    spanmessage.InnerHtml = messagecls.alertInfo("Firstname cannot be empty of characters");
                    return;
                }
                if (string.IsNullOrWhiteSpace(Request.Form["lastname"].ToString()))
                {
                    spanmessage.InnerHtml = messagecls.alertInfo("Lastname cannot be empty of characters");
                    return;
                }
                if (string.IsNullOrWhiteSpace(Request.Form["middlename"].ToString()))
                {
                    spanmessage.InnerHtml = messagecls.alertInfo("Middlename cannot be empty of characters");
                    return;
                }
                if (cls.isUsernameAvaiable(Request.Form["usernametxt"].ToString()))
                {
                      spanmessage.InnerHtml = messagecls.alertInfo("Username is already taken");
                         return;
                }
                cls.Username = Request.Form["usernametxt"].ToString();
                cls.Password = Request.Form["passwordtxt"].ToString();
                cls.Firstname = Request.Form["firstname"].ToString();
                cls.Lastname = Request.Form["lastname"].ToString();
                cls.Middlename = Request.Form["middlename"].ToString();
                cls.UserType = usertypecbo.SelectedValue;
                cls.Stat = Request.Form["statusradio"].ToString();
                if (cls.Insert())
                {
                    spanmessage.InnerHtml = messagecls.alertSuccess("New User has been added successfully");
                    Response.Redirect(Request.Url.AbsolutePath);
                }
            }
          
        }
        protected string getuserlist() {
            return cls.getListofUsers();
        }
    }
}