<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="userslist.aspx.cs" Inherits="KatMaLea.userslist" %>

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
                                <li role="presentation"  class="inactive"><a href="AuditTrail.aspx?countid=0">Audit Trail</a></li>
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
									<input name="usernametxt" id="Text4" type="text" class="form-control"/>
								</div>
                       
			        		 <div class="form-group">
									<label>Password</label>
									<input name="passwordtxt" id="Text1" type="text" class="form-control"/>
								</div>
                        
                            <div class="form-group">
									<label>Firstname</label>
									<input name="firstname" id="position" type="text" class="form-control"/>
								</div>
                            <div class="form-group">
									<label>Lastname</label>
									<input name="lastname" id="Text2" type="text" class="form-control"/>
								</div>
                            <div class="form-group">
									<label>Middlename</label>
									<input name="middlename" id="Text3" type="text" class="form-control"/>
								</div>
                            	<div class="form-group">
									
                     
									 <label for="sel1">User Type</label>
                                    <asp:DropDownList ID="usertypecbo" class="form-control" runat="server"></asp:DropDownList>
								    </div>
			                    <div class="form-group">
									<label>Status</label>
									
                                    <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="optionsRadios1" value="1" checked="checked"/>
                                            Active
                                    </label>
                                    </div>
                                     <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="Radio1" value="0"/>
                                            InActive    
                                    </label>
                                    </div>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add User"  class="btn btn-primary" OnClick="Button1_Click" />
								
						    </form>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Users</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>#</th>
												<th>Username</th>
                                                <th>Fullname</th>
                                                <th>Type</th>
                                                <th>Status</th>
                                                <th>Actions</th>
											</tr>
										<%= getuserlist() %>
								
										</table>
									</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>

</div>
	
    </asp:content>
