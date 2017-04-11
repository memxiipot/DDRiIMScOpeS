<%@ Page Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="editInventory.aspx.cs" Inherits="KatMaLea.editInventory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 258px
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
       <form id="equipmententform" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		         <div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  class="active"><a href="../Inventory.aspx">Inventory</a></li>
							      <%--<li role="presentation"><a href="../EquipmentMaintenance.aspx">Accounts</a></li>--%>								<%--<input name="description" id="descriptiontextox" type="text" class="form-control">--%>
							</ul>
						</div>
					</div>			
				</div>
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Set Maintenance</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Quantity</label>
									<%--  
                            <div class="form-group">
									<label>Mode of Payment</label>
                                <asp:DropDownList ID="DropDownpayment" runat="server" class="form-control">
                                    <asp:ListItem>Cash</asp:ListItem>
                                    <asp:ListItem>Check</asp:ListItem>
                                    </asp:DropDownList>
								</div>
                           <div class="form-group"> 
							//		<label>Total</label>
                                     <asp:TextBox ID="txttotal" name="txtdate" runat="server" class="form-control" ReadOnly="True">0.00</asp:TextBox>
								</div>--%>
                                    <asp:TextBox ID="txtpayee" name="txtdesc" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                         <div class="form-group">
									<label>Remarks</label>
                                     <asp:TextBox ID="txtInvID" name="txtdate" runat="server" class="form-control"></asp:TextBox>
								</div>
                             <%--  
                            <div class="form-group">
									<label>Mode of Payment</label>
                                <asp:DropDownList ID="DropDownpayment" runat="server" class="form-control">
                                    <asp:ListItem>Cash</asp:ListItem>
                                    <asp:ListItem>Check</asp:ListItem>
                                    </asp:DropDownList>
								</div>
                           <div class="form-group"> 
							//		<label>Total</label>
                                     <asp:TextBox ID="txttotal" name="txtdate" runat="server" class="form-control" ReadOnly="True">0.00</asp:TextBox>
								</div>--%>
                                <asp:Button ID="Button1" runat="server" Text="Save Changes"  class="btn btn-primary" OnClick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
			</div>
		</div>
    </form>
</div>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
    </asp:Content>
