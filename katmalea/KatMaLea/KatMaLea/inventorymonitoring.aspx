<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="inventorymonitoring.aspx.cs" Inherits="KatMaLea.inventorymonitoring" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
		
			<div class="row">
                		<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  ><a href="Inventory.aspx">Inventory</a></li>
							<%--  <li role="presentation" class="active"><a href="inventorymonitoring.aspx">Monitor</a></li>--%>
								<%--<<li role="presentation"><a href="../categories.aspx">Categories</a></li>--%>
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Inventory Monitoring</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>#</th>
												<th>Used</th>
                                                <th>Menu</th>
                                                <th>Available</th>
                                                <th>Ingredient</th>
                                                <th>Original Value</th>
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
    </form>
</div>

  </asp:Content>
