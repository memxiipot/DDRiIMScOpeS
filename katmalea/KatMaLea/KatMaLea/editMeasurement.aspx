<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="editMeasurement.aspx.cs" Inherits="KatMaLea.editMeasurement" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNavigation.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
   <form id="unitform" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Edit measurement</div>
						<div class="panel-body">
								<div class="form-group">
									<label>Unit</label>
									<input name="unitmeasurement" runat="server" id="unitTextbox" type="text" class="form-control">
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Submit Changes"  class="btn btn-primary" OnClick="Button1_Click" />
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