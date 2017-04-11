<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="Ingredients.aspx.cs" Inherits="KatMaLea.Ingredients" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div>
       <form id="ingredientform" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		      <%--  <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />--%>
                  
		<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation" ><a href="../menus.aspx?countid=0&categoryid=0">Menu Items</a></li>
							  <li role="presentation" class="active"><a href="../Ingredient.aspx">Ingredients</a></li>
								<li role="presentation"><a href="../categories.aspx">Categories</a></li>
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Add Ingredient</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Ingredient</label>
									<input name="ingredient" id="ingredienttextox" type="text" class="form-control">
								</div>
								<div class="form-group">
									<label>Status</label>
									<%--<input name="statustextox" id="statustextbox" type="text" class="form-control">--%>
                                    <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="optionsRadios1" value="1" checked="checked">
                                            Active
                                    </label>
                                    </div>
                                     <div class="radio">
                                    <label>
                                    <input type="radio" name="statusradio" id="Radio1" value="2">
                                            InActive    
                                    </label>
                                    </div>
								</div>
                            <div class="form-group">
									<label>Limit</label>
									<input name="limit" type="number" class="form-control"/>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add Ingredient"  class="btn btn-primary" OnClick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Ingredients</div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Ingredient</th>
												<th>Status</th>
                                                <th>Actions</th>
											</tr>
										  <%= getIngredientsHtml() %>
								
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