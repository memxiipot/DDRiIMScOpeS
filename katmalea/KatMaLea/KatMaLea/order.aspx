<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="KatMaLea.order" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/ordernav.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container" id="rates">
			<div class="row">
		        <%--<nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />--%>
                  
		<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  class="active"><a href="../order.aspx">New Order</a></li>
							  <li role="presentation"><a href="../editOrder.aspx">Edit/Void Order</a></li>
                                <li role="presentation"><a href="../verifyorder.aspx">Verify Order</a></li>
							 <li role="presentation"><a href="../billout.aspx">BILL OUT</a></li>
                            
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Customer Order</div>
						<div class="panel-body">
                            <span id="SpanMessage" runat="server">
                              
                            </span>
						    <form id="editmenuform" runat="server" method="post">
                                  <div class="form-group">
									 <label for="sel1">Order Type</label>
                                        <asp:DropDownList class="form-control" ID="ordertype" runat="server" >
                                                    <asp:ListItem Value="1">Dine In</asp:ListItem>
                                                    <asp:ListItem Value="0">Take out</asp:ListItem>
                                                </asp:DropDownList>
								    </div>
								<div class="form-group">
									<label>Table Number</label>
									<%--<input id="tableno" name="tableno" type="text" class="form-control" >--%>
                                    <asp:DropDownList  class="form-control" ID="tablenodropdown" runat="server"></asp:DropDownList>
								</div>
                                	<div class="form-group">
									 <label for="sel1">Crew Assisted</label>
                                        <asp:DropDownList class="form-control" ID="crewdropdown" runat="server"></asp:DropDownList>
								    </div>
                                <div class="form-group">
									<label>Customer Name</label>
									<input id="pendingno" name="pendingno" type="text" class="form-control" >
								</div>
                                 <div class="form-group">
									<label>Order Request</label>
									<input id="Text1" name="orderRequest" type="text" class="form-control" >
								</div>
                                
					          
                                <asp:Button ID="Button1" runat="server" Text="Create"  class="btn btn-primary" OnClick="Button1_Click"   />
								</form>
						</div>
					</div>
				</div>
			</div>
	
		</div>

</asp:Content>
