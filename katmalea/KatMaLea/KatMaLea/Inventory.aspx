<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="KatMaLea.Inventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		       <%-- <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  --%>
                
		<div class="col-lg-3">
						
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  class="active" ><a href="Inventory.aspx">Inventory</a></li>
<%--							  <li role="presentation"><a href="inventorymonitoring.aspx">Monitor</a></li>--%>
								<%--<<li role="presentation"><a href="../categories.aspx">Categories</a></li>--%>
							</ul>
						</div>
					</div>			
					
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menu</div>
						<div class="panel-body">
                            <span id="spanmessage" runat="server"></span>
						<div class="form-group">
									<label>Ingredient</label>
                                         <select class="form-control" id="sel1" name="ingredientcbo">
                                              <%= getIngredients() %>
                                       </select>
                              <asp:Button ID="Button2" runat="server" Text="New"  class="btn btn-success" PostBackUrl="~/Ingredient.aspx" />
								</div>
								<div class="form-group">
									<label>Quantity</label>
									<input name="quantitytext" type="number" class="form-control"/>
								</div>
                            	<div class="form-group">
									<label>Measurement</label>
                                        <asp:DropDownList ID="measurementdropdown" runat="server" class="form-control" OnSelectedIndexChanged="measurementdropdown_SelectedIndexChanged"></asp:DropDownList>
                                     <asp:Button ID="Button1" runat="server" Text="New"  class="btn btn-success" PostBackUrl="~/measurement.aspx" />
								</div>
                            	
                                <asp:Button ID="submitbutton" runat="server" Text="Submit"  class="btn btn-primary" OnClick="submitbutton_Click" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Items/ Status:
                            <asp:DropDownList ID="cboStatus" runat="server" Width="186px" AutoPostBack="True">
                                <asp:ListItem>Good</asp:ListItem>
                                <asp:ListItem>Critical</asp:ListItem>
                                <asp:ListItem>Out of Stock</asp:ListItem>
                            </asp:DropDownList>
                        </div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
											 <th>#</th> <th>Ingredient</th> <th>Used</th> <th>Available</th> <th>Stock</th>  <th>Status</th> <th> Actions</th>
											</tr>
									<%= getlist() %>
								
										</table>
									</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>
    </form>
</div>

  </asp:Content>
