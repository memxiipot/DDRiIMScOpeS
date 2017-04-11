<%@ Page Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="categoryMenu.aspx.cs" Inherits="KatMaLea.categoryMenu" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menus under <b> <%= Request.QueryString["menu"].ToString() %></b> food category</div>
						<div class="panel-body">
						
								<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Menu</th>
												
                                                <th>Actions</th>
											</tr>
								    <%= getMenucategoryhtml() %>
								
										</table>
									</div>
							  <asp:Button ID="Button1" runat="server" Text="Back"  class="btn btn-primary" PostBackUrl="~/categories.aspx" />
                                     <asp:Button ID="Button2" runat="server" Text="Go to Menus"  class="btn btn-default" PostBackUrl="~/menus.aspx" />
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
    <script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>


    </asp:Content>
	