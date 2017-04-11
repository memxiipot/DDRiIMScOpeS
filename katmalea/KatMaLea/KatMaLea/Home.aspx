<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="KatMaLea.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        Response.Cache.SetNoStore();
        Response.CacheControl = "no-cache";

        if (Session["UserId"] != null)
        {
            Response.Redirect("~/welcome.aspx");
            Response.End();
        }
%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- login modal -->
        <div class="modal fade" id="loginmodal" tabindex="-1" role="dialog" aria-hidden="true" aria-labelledby="loginmodallabel">
          <div class="modal-dialog">
            <div class="modal-content">x`
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="loginmodallabel">Administrator Login</h4>
              </div>
              <div class="modal-body">
                <form id="loginform" runat="server"  method="post">
                  <div class="form-group">
                    <label for="recipient-name" class="control-label">LOGIN ID:</label>
                  <input type="text" class="form-control" id="loginid" name ="usernametextbox" />
                  </div>
                  <div class="form-group">
                   <label for="recipient-name" class="control-label">PASSWORD</label>
                      <input type ="password" class="form-control" name ="passwordtextbox"  />
                  </div>
                    <div class="modal-footer">

                  <button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
                  <asp:Button ID="loginbutton" runat="server" Text="LOGIN" class="btn btn-primary" OnClick="loginbutton_Click" />
                
                      </div>
                </form>
              </div>
            
            </div>
          </div>
        </div>
          <div id="home-container" class="container">
      <div class="row">
        <div class="col-lg-5">
          <h2>Davao Dencia's Restaurant</h2>
          <p>Been serving davaoeno since 1950 with its finest delicacies.Offers a wide variety of chinese and spanish cuisine good for single orders and for sharing.
              Prides itself with their famous congee and noodles known throughout the city
          </p>
          <button  id="btn-admin-login" type="button" class="btn btn-primary" data-toggle="modal" data-target="#loginmodal">LOGIN</button>
            
        </div>
      </div>
    </div>


</asp:Content>
