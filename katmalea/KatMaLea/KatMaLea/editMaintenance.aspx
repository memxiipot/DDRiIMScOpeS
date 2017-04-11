<%@ Page Language="C#"MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="editMaintenance.aspx.cs" Inherits="KatMaLea.editMaintenance" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/EquipmentNavigation.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
       <form id="equipmententform" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Set Maintenance</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Description</label>
									<%--<input name="description" id="descriptiontextox" type="text" class="form-control">--%>
                                    <asp:TextBox ID="txtdescription" name="txtdesc" runat="server" class="form-control"></asp:TextBox>
								</div><div class="form-group">
									<label>Date</label>
                                     <asp:TextBox ID="datetext" name="txtdate" runat="server" class="form-control"></asp:TextBox>
								</div>
                            <div class="form-group">
									<label>Equipment</label>
                                <asp:DropDownList ID="DropDownEquipment" runat="server" class="form-control"></asp:DropDownList>
								</div>
                            <div class="form-group">
									<label>Interval</label>
									<%--<input name="description" id="descriptiontextox" type="text" class="form-control">--%>
                                    <asp:TextBox ID="txtInterval" runat="server" class="form-control"></asp:TextBox>
								</div>
								<div class="form-group">
									<label>Status</label>
									<%--<input name="statustextox" id="statustextbox" type="text" class="form-control">--%>
                                    <%--<select class="form-control" id="sel1" name="equipmentcbo">
                                            <%= getStatuscbo() %>
                                      </select>--%>
                                    <asp:DropDownList ID="DropDownStatus" class="form-control" runat="server"></asp:DropDownList>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Set"  class="btn btn-primary" OnClick="Button1_Click"/>
								</form>
						
						</div>
					</div>
				</div>
			</div>
        <script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
    </div>
    </div>
</asp:Content>
