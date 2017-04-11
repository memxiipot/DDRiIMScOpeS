<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="edituser.aspx.cs" Inherits="KatMaLea.edituser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
  
    <div class="container" id="rates">
			<div class="row">
		        <div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  class="active"><a href="userslist.aspx">Users</a></li>
							<%--  <li role="presentation"><a href="../Positions.aspx">Position</a></li>--%>
							</ul>
						</div>
					</div>			
				</div>
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Add new User</div>
                          <span runat="server" id="spanmessage"></span>
						<div class="panel-body">
                          
						<form id="positionform" runat="server" method="post" >
                            <div class="form-group">
									<label>Username</label>
									<input name="usernametxt" id="usernametextbox" runat="server" type="text" class="form-control"/>
								</div>
                       
			        		 <div class="form-group">
									<label>Password</label>
									<input name="passwordtxt" runat="server" id="passwordtextbox" type="text" class="form-control"/>
								</div>
                        
                            <div class="form-group">
									<label>Firstname</label>
									<input name="firstname" runat="server" id="firstnametextbox" type="text" class="form-control"/>
								</div>
                            <div class="form-group">
									<label>Lastname</label>
									<input name="lastname" runat="server" id="lastnametextbox" type="text" class="form-control"/>
								</div>
                            <div class="form-group">
									<label>Middlename</label>
									<input name="middlename" runat="server" id="middlenametextbox" type="text" class="form-control"/>
								</div>
                            	<div class="form-group">
									
                     
									 <label for="sel1">User Type</label>
                                    <asp:DropDownList ID="usertypecbo" class="form-control" runat="server"></asp:DropDownList>
								    </div>
			                    <div class="form-group">
									<label>Status</label>
									
                                    <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="optionsRadios1" value="1" runat="server"/>
                                            Active
                                    </label>
                                    </div>
                                     <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="Radio1" value="0" runat="server"/>
                                            InActive    
                                    </label>
                                    </div>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Submit Changes"  class="btn btn-primary" OnClick="Button1_Click" />
								
						    </form>
						</div>
					</div>
				</div>
			</div>

		</div>

</div>
	
    </asp:content>
