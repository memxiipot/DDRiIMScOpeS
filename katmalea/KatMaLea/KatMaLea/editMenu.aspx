<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="editMenu.aspx.cs" Inherits="KatMaLea.editMenu" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menu</div>
						<div class="panel-body">
						    <form id="editmenuform" runat="server" method="post">
                             
								<div class="form-group">
									<label>Menu Name</label>
									<input id="menunametextbox" name="menuname" type="text" class="form-control" runat="server">
								</div>
                                	<div class="form-group">
									 <label for="sel1">select Category</label>
                                        <asp:DropDownList class="form-control" ID="categorydropdown" runat="server"></asp:DropDownList>
                                     
								    </div>
								<div class="form-group">
									<label>Price</label>
									<input id ="pricetextbox" name="price" type="text" class="form-control" runat="server">
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Save Changes"  class="btn btn-primary" OnClick="Button1_Click"   />
								</form>
						</div>
					</div>
				</div>
			</div>
	
		</div>
    

</div>
	<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
    </asp:Content>