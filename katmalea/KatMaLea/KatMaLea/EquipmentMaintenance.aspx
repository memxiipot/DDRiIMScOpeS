<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="EquipmentMaintenance.aspx.cs" Inherits="KatMaLea.EquipmentMaintenance" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/EquipmentNavigation.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
							  <li role="presentation"  ><a href="../Equipment.aspx">Equipments</a></li>
							  <%--<li role="presentation"><a href="../Ingredient.aspx">Maintenance Scehdule</a></li>--%>
								<li role="presentation" class="active"><a href="../EquipmentMaintenance.aspx">Maintenance</a></li>
							</ul>
						</div>
					</div>			
				</div>

                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Set Maintenance</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Description</label>
									<%--<input name="description" id="descriptiontextox" type="text" class="form-control">--%>
                                    <asp:TextBox ID="txtdescription" name="txtdesc" runat="server" class="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Must not empty character" ControlToValidate="txtdescription" ForeColor="#CC0000"></asp:RequiredFieldValidator>
								</div><div class="form-group">
									<label>Date(mm/dd/yyyy)</label>
                                     <asp:TextBox ID="datetext" name="txtdate" runat="server" class="form-control" AutoPostBack="false" TextMode="DateTime" ></asp:TextBox>

                                    <ajaxToolkit:CalendarExtender runat="server" TargetControlID="datetext" ></ajaxToolkit:CalendarExtender>
                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                   ControlToValidate="datetext" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/((0[1-9])|([1-31]))\/((19|20)\d\d)$" Display="Dynamic" SetFocusOnError="true" ErrorMessage="invalid date" ForeColor="#CC0000">Invalid date format</asp:RegularExpressionValidator>--%>
								</div>
                            <div class="form-group">
									
                                <label>Equipment</label>
                                <asp:DropDownList ID="DropDownEquipment" runat="server" class="form-control"></asp:DropDownList>
								</div>
                            <div class="form-group">
									<label>Interval by days</label>
									<%--<input name="description" id="descriptiontextox" type="text" class="form-control">--%>
                                    <asp:TextBox ID="txtInterval" runat="server" class="form-control" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);"></asp:TextBox>
								    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Must not empty character" ControlToValidate="txtInterval" ForeColor="#CC0000"></asp:RequiredFieldValidator>
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
                            <%--<asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click1" />--%>
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">Schedule</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Description</th>
												<th>Date of Maintenance</th>
                                                <th>Equipment</th>
                                                <th>Next Maintenance</th>
                                                <th>Interval</th>
                                                <th>Status</th>
                                                <th>Actions</th>
											</tr>
										  <% =getHtmlEquipment() %>
								
										</table>
									</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>
		</div>
           <asp:ScriptManager ID="ScriptManager1" runat="server" />  
    </form>
</div>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
    </asp:Content>
