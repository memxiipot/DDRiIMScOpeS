<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="verifyorder.aspx.cs" Inherits="KatMaLea.verifyorder" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/ordernav.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <form id="form1" runat="server" method="post"  >
    <div class="container" id="rates">
			<div class="row">
		       <%-- <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />--%>
                  	<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation" ><a href="../order.aspx">New Order</a></li>
							  <li role="presentation"  ><a href="../editOrder.aspx">Edit/Void Order</a></li>
                                <li role="presentation" class="active"><a href="../verifyorder.aspx">Verify Order</a></li>
							 <li role="presentation"><a href="../billout.aspx">BILL OUT</a></li>
                            
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
                    <span id="spanmessage" runat="server"></span>
					<div class="panel panel-default">
						<div class="panel-heading">Menu</div>
						<div class="panel-body">
		
                            	<div class="form-group">
									
                     
									 <label for="sel1">Input OR Number</label>
                             
                                    <asp:TextBox ID="ortextbox" class="form-control" runat="server"></asp:TextBox>
                                    </br>
                                <asp:Button ID="Button1" runat="server" Text="Verify"  class="btn btn-primary"  OnClick="Button1_Click" />
							  <asp:Button ID="Button2" runat="server" Text="Print Preview"  class="btn btn-primary"  OnClick="Button2_Click"  OnClientClick="aspnetForm.target ='_blank';"/>
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">Or Details</div>
						<div class="panel-body">
                         
                            <div class="form-group">
                                	 <label for="sel1">Customer Name</label>
                                    <asp:TextBox ID="customernametextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                               <div class="form-group">
                                	 <label for="sel1">Company Name</label>
                                    <asp:TextBox ID="companynametextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                	 <label for="sel1">Rendered Amount</label>
                                    <asp:TextBox ID="renderedamounttextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                              <div class="form-group">
                                	 <label for="sel1">Discount</label>
                                    <asp:TextBox ID="discounttextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                             <div class="form-group">
                                	 <label for="sel1">Service Charge</label>
                                    <asp:TextBox ID="svchargetextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                             <div class="form-group">
                                	 <label for="sel1">Total Cost</label>
                                    <asp:TextBox ID="totalcosttextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                               <div class="form-group">
                                	 <label for="sel1">Issued by</label>
                                    <asp:TextBox ID="issuedbytextbox" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            <div class="form-group">
                                	 <label for="sel1">Date Issued</label>
                                    <asp:TextBox ID="dateissued" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
                                                <th>#</th>
											<th>Menu</th>
												<th>Price</th>
                                                <th>Quantity</th>
                                                 <th>Total</th>
                                  
											</tr>
										    <%= getOrderedMenu() %>
								
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

