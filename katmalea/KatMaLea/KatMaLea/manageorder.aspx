<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="manageorder.aspx.cs" Inherits="KatMaLea.manageorder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <!-- tab panel -->
          <div role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist" id="manageordertab">
              <li role="presentation" class="active"><a href="#createorder" aria-controls="createorder" role="tab" data-toggle="tab">CREATE ORDER</a></li>
              <%--<li role="presentation"><a href="#editorder" aria-controls="editorder" role="tab" data-toggle="tab">EDIT ORDER</a></li>--%>
            </ul>
             <!-- Tab panes -->
                  <form class="form-horizontal" runat="server" method="post" id="orderform">
            <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="createorder">
              <!-- create order tab content -->
                <div class="panel panel-default">
                  <div class="panel-body">
                         <%= message() %>
                  
                      <!-- goes here--------------------beginning of form---->
                  <div class="form-group">
                        <label for="tableno" class="col-sm-2 control-label">Table No.</label>
                        <div class="col-sm-10">
                           <input type="text" id="tableno" name="tableno" size="50" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Crew</label>
                        <div class="col-sm-10">
                 <asp:DropDownList ID="crewdropdown" CssClass="selectpicker" runat="server" >
   
                  </asp:DropDownList>
                        </div>
                      </div>
                       <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Request</label>
                        <div class="col-sm-10">
                           <input type="text" id="request" name="request" size="50" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">Menu Items</label>
                          <asp:DropDownList ID="menudropdown" runat="server">
                              <asp:ListItem>kean amper</asp:ListItem>
                              <asp:ListItem>carlo ma</asp:ListItem>
                          </asp:DropDownList>
                          <asp:TextBox ID="quantitytextbox" runat="server"></asp:TextBox>
                          <asp:Button ID="addmenu" runat="server" Text="Add" OnClick="addmenu_Click" />
                      </div>
                      <div class="form-group">
                           <div class="col-sm-offset-2 col-sm-10">
                            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                           </div>
                      </div>
                      <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                          <asp:Button ID="orderbutton" runat="server" Text="Create order" class="btn btn-default" OnClick="orderbutton_Click" />
                          <asp:Button ID="Button1" runat="server" Text="View List of orders" class="btn btn-primary" PostBackUrl="~/orderlist.aspx" />
                        </div>
                      </div>
              
                    <!-- goes here--------------------end of form---->
                  </div>
                </div>
            
              </div>
              
            </div>
              </form>
            <!-- tab script -->
            <script>
                $(function () {
                    $('#manageordertab a:last').tab('show')
                })
            </script>
          </div>
        </div>
      </div>
    </div>
        <!-- createorder script dateorder -->
    <script type="text/javascript">
        var datefield = document.createElement("input")
        datefield.setAttribute("type", "date")
        if (datefield.type != "date") { //if browser doesn't support input type="date", load files for jQuery UI Date Picker
            document.write('<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"><\/script>\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"><\/script>\n')
        }
    </script>  
    <script>
        if (datefield.type != "date") { //if browser doesn't support input type="date", initialize date picker widget:
            jQuery(function ($) { //on document.ready
                $('#orderdate').datepicker();
            })
        }
    </script>
       <script type="text/javascript">

           $(document).ready(function () {

               $(".selectpicker").selectpicker();

           });

</script>
</asp:Content>
