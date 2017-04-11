<%@ Page Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="ExpenseDetails.aspx.cs" Inherits="KatMaLea.ExpenseDetails1" %>


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
							  <li role="presentation"  class="active"><a href="../Expense.aspx">Expense</a></li>
							  <%--<li role="presentation"><a href="../Ingredient.aspx">Maintenance Scehdule</a></li>--%>
								<%--<li role="presentation"><a href="../EquipmentMaintenance.aspx">Accounts</a></li>--%>
							</ul>
						</div>
					</div>			
				</div>
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Expense No: <B><%=Request.QueryString["ExpenseID"].ToString() %></B> Payee: <B><%=Request.QueryString["Payee"].ToString() %></B></div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Account</label>
                                <asp:DropDownList ID="DropDownList1" runat="server" class="form-control" AutoPostBack="True"  OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"> </asp:DropDownList>
                                    </div>                            
                            <div class="form-group">
									<label>Debit Amount</label>
                                     <asp:TextBox ID="txtdebit" name="txtdate" runat="server" class="form-control" EnableTheming="True" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);">0.00</asp:TextBox>
								</div>
                            <div class="form-group">
									<label>Credit Amount</label>
                                     <asp:TextBox ID="txtCredit" name="txtdate" runat="server" class="form-control" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);">0.00</asp:TextBox>
								</div>                         
                                <asp:Button ID="Button1" runat="server" Text="Add"  class="btn btn-primary" OnClick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">Details</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Account</th>
												<th>Debit</th>
                                                <th>Credit</th>
                                                <th>Actions</th>
											</tr>
										  <% =getHtmlExpense() %>
								
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
