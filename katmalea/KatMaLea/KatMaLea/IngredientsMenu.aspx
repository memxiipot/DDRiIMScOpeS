<%@ Page Language="C#"MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="IngredientsMenu.aspx.cs" Inherits="KatMaLea.IngredientsMenu" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
      <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menu - <%--<B><select class="form-control" id="sel1" name="ingredientcbo">--%>
                                          <%--  <%= getIngredientsOfMenu %>--%>
                                         
                                     <%-- </select></B></div>--%>
						<div class="panel-body">
						<div class="form-group">
									
                     
									 <label for="sel1">select ingredient</label>
                            <asp:DropDownList ID="DropDownIngredient" runat="server" class="form-control" OnSelectedIndexChanged="DropDownpayment_SelectedIndexChanged" AutoPostBack="True">                                 
                                    </asp:DropDownList>
                                     
								    </div>
								<div class="form-group">
									<label>Quantity</label>
									<input id="quantity" name="quantity" type="text" class="form-control">
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add Ingredient"  class="btn btn-primary" OnClick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Ingredients </div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Ingredient</th>
												<th>Quantity</th>
                                                
											</tr>
										   <%= getIngredientsOfMenu() %>
								
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