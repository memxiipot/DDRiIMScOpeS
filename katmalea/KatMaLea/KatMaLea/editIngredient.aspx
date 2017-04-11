<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="editIngredient.aspx.cs" Inherits="KatMaLea.editIngredient" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNav.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
      <form id="ingredientform" runat="server" method="post" >
    <div class="container" id="rates">
			<div class="row">
		        <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
                  
				<div class="col-lg-9">
					<div class="panel panel-default">
						<div class="panel-heading">Add Ingredient</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Ingredient</label>
									<input name="ingredient" runat="server" id="ingredienttextox" type="text" class="form-control">
								</div>
								<div class="form-group">
									<label>Status</label>
									<%--<input name="statustextox" id="statustextbox" type="text" class="form-control">--%>
                                    <div class="radio">
                                    <label>
                                    <input type="radio" runat="server" name="statusradio" id="activeradio" value="1" >
                                            Active
                                    </label>
                                    </div>
                                     <div class="radio">
                                    <label>
                                    <input type="radio" runat="server" name="statusradio" id="inactiveradio" value="2">
                                            InActive    
                                    </label>
                                    </div>
								</div>
                            <div class="form-group">
									<label>Limit</label>
									<input name="limit" runat="server" id ="limitid" type="number" class="form-control"/>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Submit Changes"  class="btn btn-primary" OnClick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>

		</div>
    </form>
</div>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/npm.js"></script>
   </asp:Content>