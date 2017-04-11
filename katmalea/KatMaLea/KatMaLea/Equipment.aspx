<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="Equipment.aspx.cs" Inherits="KatMaLea.Equipment" %>
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
							  <li role="presentation" class="active" ><a href="../Equipment.aspx">Equipments</a></li>
							  <%--<li role="presentation"><a href="../Ingredient.aspx">Maintenance Scehdule</a></li>--%>
								<li role="presentation" ><a href="../EquipmentMaintenance.aspx">Maintenance</a></li>
							</ul>
						</div>
					</div>			
				</div>

                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Add Equipment</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Equipment</label>
									<input name="equipment" id="equipmenttextox" type="text" class="form-control">
								</div>
                                 <div class="form-group">
									<label>Remarks</label>
									<input name="remarks" id="remarkstextox" type="text" class="form-control">
								</div>
								<div class="form-group">
									<label>Status</label>
									<%--<input name="statustextox" id="statustextbox" type="text" class="form-control">--%>
                                    <%--<select class="form-control" id="sel1" name="equipmentcbo">
                                            <%= getStatuscbo() %>
                                      </select>--%>
                                    <asp:DropDownList ID="DropDownStatus" class="form-control" runat="server"></asp:DropDownList>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add Equipment"  class="btn btn-primary" OnClick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Equipments</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Equipment</th>
												<th>Remarks</th>
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
		</div>
           <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>
    </form>
</div>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
    </asp:Content>
