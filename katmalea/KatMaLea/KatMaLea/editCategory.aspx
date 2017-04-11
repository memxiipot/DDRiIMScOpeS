﻿<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="editCategory.aspx.cs" Inherits="KatMaLea.editCategory" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
    <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Categories</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Category</label>
									<input name="category" id="categorytextbox" runat="server" type="text" class="form-control">
								</div>

                                <asp:Button ID="Button1" runat="server" Text="Confirm Changes"  class="btn btn-primary" OnClick="Button1_Click"  />
								
						
						</div>
					</div>
				</div>
			</div>

		</div>
    </form>
</div>
	<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
    </asp:Content>
