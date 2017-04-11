<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="insertorder.aspx.cs" Inherits="KatMaLea.insertorder" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/ordernav.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menu: TABLE #[<%= getTableNo() %>]</div>
						<div class="panel-body">
		
                            	<div class="form-group">
									
                     
									 <label for="sel1">select Menu</label>
                                    <%--  <select class="form-control" id="sel1" name="ingredientcbo">
                                        <%= getcategorycbo() %>

                                      </select>--%>
                                    <asp:DropDownList  class="form-control" ID="menudropdown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="menudropdown_SelectedIndexChanged"></asp:DropDownList>
								    </div>
								<div class="form-group">
									<label>Quantity</label>
									<input name="quantity" type="number" class="form-control">
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add Menu"  class="btn btn-primary" onclick="Button1_Click" />
								
						
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
          <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>
    </form>
</asp:Content>
