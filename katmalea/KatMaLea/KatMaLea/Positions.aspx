<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="Positions.aspx.cs" Inherits="KatMaLea.Positions" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNavigation.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
  <form id="positionform" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		       <%-- <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />--%>
                  		<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation" ><a href="../measurement.aspx">Measurement</a></li>
							  <li role="presentation"  class="active"><a href="../Positions.aspx">Position</a></li>
						  <li role="presentation"><a href="../crewlist.aspx">Crew</a></li>
							</ul>
						</div>
					</div>			
				</div>

				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Add Position</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Position</label>
									<input name="position" id="position" type="text" class="form-control">
								</div>
			                    <div class="form-group">
									<label>Status</label>
									
                                    <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="optionsRadios1" value="1" checked="checked">
                                            Active
                                    </label>
                                    </div>
                                     <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="Radio1" value="0">
                                            InActive    
                                    </label>
                                    </div>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add Position"  class="btn btn-primary" onclick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Positions</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Position</th>
												<th>Status</th>
                                                <th>Actions</th>
											</tr>
										<%= getlistOfPosition() %>
								
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
	
    </asp:content>
