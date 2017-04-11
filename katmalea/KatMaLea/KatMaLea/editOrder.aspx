<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="editOrder.aspx.cs" Inherits="KatMaLea.editOrder" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/ordernav.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <form id="form1" runat="server" method="post"  >
    <div class="container" id="rates">
			<div class="row">
		      <%--  <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  --%>
                
		<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation" ><a href="../order.aspx">New Order</a></li>
							  <li role="presentation"  class="active"><a href="../editOrder.aspx">Edit/Void Order</a></li>
                                <li role="presentation"><a href="../verifyorder.aspx">Verify Order</a></li>
							 <li role="presentation"><a href="../billout.aspx">BILL OUT</a></li>
                            
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menu</div>
						<div class="panel-body">
		
                            	<div class="form-group">
									
                     
									 <label for="sel1">Select Table Number</label>
                                    <asp:DropDownList  class="form-control" ID="tabledropdown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="tabledropdown_SelectedIndexChanged"></asp:DropDownList>
								    </div>

                                <asp:Button ID="Button1" runat="server" Text="Additional"  class="btn btn-primary" OnClick="Button1_Click"  />
								<asp:Button ID="Button2" runat="server" Text="Void"  class="btn btn-danger" OnClick="Button2_Click"
                                    OnClientClick="return confirm('Are you sure you want to submit ?')"
                                      />
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">Order List</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
                                                <th>#</th>
											<th>Menu</th>
												<th>Price</th>
                                                <th>Quantity</th>
                                                 <th>Total</th>
                                                <th>Is Served</th>
                                                <th>Actions</th>
											</tr>
										<%= getListoforderhtml() %>
								
										</table>
									</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
    </form>
</asp:Content>

