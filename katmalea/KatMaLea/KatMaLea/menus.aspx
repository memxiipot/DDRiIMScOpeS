<%@ Page Language="C#"MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="menus.aspx.cs" Inherits="KatMaLea.menus" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1
        {
            width: 713px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <%-- <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  --%>
        <form id="form2" runat="server">
    <div class="container" id="rates">
			<div class="row">
                <%--<input name="menuname" type="text" class="form-control">--%>
                
		<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation"  class="active"><a href="../menus.aspx?countid=0&categoryid=0">Menu Items</a></li>
							  <li role="presentation"><a href="../Ingredient.aspx">Ingredients</a></li>
								<li role="presentation"><a href="../categories.aspx">Categories</a></li>                             
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Menu</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Menu Name</label>
									
                                    <asp:TextBox ID="menuname" name="menuname" runat="server" class="form-control"></asp:TextBox>
                                    
								</div>
                            	<div class="form-group">
									
                     
									 <label for="sel1">select Category</label>
                                      <select class="form-control" id="sel1" name="ingredientcbo">
                                            <%--<%= getHtmlMenu(count2()) %>--%>
                                            <%= getcategorycbo() %>
                                           <option value="0">Uncategorized</option>
                                      </select>
								    </div>
								<div class="form-group">
									<label>Price</label>
									<input name="price" type="number" class="form-control">
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Add Menu"  class="btn btn-primary" OnClick="Button1_Click" />					
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">List of Menus/ Select Category:
                            <asp:DropDownList ID="cbovwCategory" runat="server" Height="25px" Width="245px" OnSelectedIndexChanged="cbovwCategory_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                        </div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>Menu Name</th>
												<th>Price</th>
                                                <th>Category</th>
                                                <th>Actions</th>
											</tr>
                                            <%= getHtmlMenu(count2()) %>
                                            <%-- <script type="text/javascript">
            $(document).ready(function () {
                toastr.options = {
                    "closeButton": true,
                    "positionClass": "toast-bottom-full-width",
                    "onclick": null,
                    "showDuration": "0",
                    "hideDuration": "0",
                    "timeOut": "0",
                    "showMethod": "fadeIn"
                };
                $('#toastr-success').click(function () {
                    toastr.success('This is a success notification from toastr.')
                });

                $('#toastr-info').click(function () {
                    toastr.info('This is an information notification provided by toastr.')
                });

                $('#toastr-warning').click(function () {
                    toastr.warning('This is a warning notification provided by toastr.')
                });

                $('#toastr-error').click(function () {
                    toastr.error('This is an error notification provided by toastr.')
                });
            });
</script>--%>
								
										</table>
									</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
        <div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading"></div>
						<div class="panel-body">
							<div class="table-responsive">
	
									<div class="form-group">
										<table class="table table-striped">
											<tr>
												<th>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">Previous</asp:LinkButton>
                                                </th>
												<th></th>
                                                <th class="auto-style1">&nbsp;</th>
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
			</div>
		</div>
            <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>
 
       <%-- <script type="text/javascript">
            $(document).ready(function () {
                toastr.options = {
                    "closeButton": true,
                    "positionClass": "toast-bottom-full-width",
                    "onclick": null,
                    "showDuration": "0",
                    "hideDuration": "0",
                    "timeOut": "0",
                    "showMethod": "fadeIn"
                };
                $('#toastr-success').click(function () {
                    toastr.success('This is a success notification from toastr.')
                });

                $('#toastr-info').click(function () {
                    toastr.info('This is an information notification provided by toastr.')
                });

                $('#toastr-warning').click(function () {
                    toastr.warning('This is a warning notification provided by toastr.')
                });

                $('#toastr-error').click(function () {
                    toastr.error('This is an error notification provided by toastr.')
                });
            });
</script>--%>
    </form>
</div>  
    </asp:Content>
