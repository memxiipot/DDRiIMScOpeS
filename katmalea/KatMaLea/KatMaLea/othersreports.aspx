<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="othersreports.aspx.cs" Inherits="KatMaLea.othersreports" %>
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
							  <li role="presentation" ><a href="listreports.aspx">Inventory Report</a></li>
							  <li role="presentation"><a href="#">Expense Reports</a></li>
                                 <li role="presentation"  class="active" ><a href="othersreports.aspx">Others</a></li>
								<%--<<li role="presentation"><a href="../categories.aspx">Categories</a></li>--%>
							</ul>
						</div>
					</div>			
					
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Other Reports</div>
						<div class="panel-body">
                            <span id="spanmessage" runat="server"></span>
                            	<div class="form-group">
									<label>Best Selling Menus</label>
								
								</div>
                                <asp:Button ID="submitbutton" runat="server" Text="Preview"  class="btn btn-primary" OnClick="submitbutton_Click"  />
						</div>
					</div>
             
				</div>
			</div>

		</div>
    </form>
</div>

  </asp:Content>
