<%@ Page Language="C#"MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="Audittrail.aspx.cs" Inherits="KatMaLea.Audittrail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1
        {
            width: 498px;
        }
        .auto-style2
        {
            width: 137px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">

<div>
  
    <div class="container" id="rates">
			<div class="row">
		        <div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  class="inactive"><a href="userslist.aspx">Users</a></li>
                                <li role="presentation"  class="active"><a href="Audittrail.aspx?countid=0">Audit Trail</a></li>
							<%--  <li role="presentation"><a href="../Positions.aspx">Position</a></li>--%>
							</ul>
						</div>
					</div>			
				</div>
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Event Logs</div>
                          <span runat="server" id="spanmessage"></span>
						<div class="panel-body">
                          
						<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>#</th>
												<th>Action</th>
                                                <th>Description</th>
                                                <th>New Value</th>
                                                <th>Old Value</th>
                                                <th>Module Type</th>
                                                <th>Date</th>
                                                <th>User</th>
											</tr>
										<%= getlist(count2()) %>
								
										</table>
									</div>
						</div>
					</div>
                        <div class="panel panel-default">
						<div class="panel-heading"></div>
                          <span runat="server" id="span1"></span>
						<div class="panel-body">
                          
						<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th class="auto-style2">
                                                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">Previous</asp:LinkButton>
                                                </th>
												<th></th>
                                                <th></th>
                                                <th> </th>
                                                <th> </th>
                                                <th> &nbsp;</th>
                                                <th class="auto-style1"></th>
                                                <th>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Next</asp:LinkButton>
                                                </th>
											</tr>																	
										</table>
									</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
			</div>
		</div>

</div>
	
    </form>
	
    </asp:content>

