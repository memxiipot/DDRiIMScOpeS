<%@ Page Language="C#"MasterPageFile="~/Master_default.Master"  AutoEventWireup="true" CodeBehind="editPosition.aspx.cs" Inherits="KatMaLea.editPosition" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/referenceNavigation.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div>
       <form id="positionform" runat="server" method="post" >

    <div class="container" id="rates">
			<div class="row">
		          <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />
              	<div class="col-lg-9">
					<div class="panel panel-info">
						<div class="panel-heading">Add Position</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Position</label>
									<input name="position" runat="server" id="positiontextbox" type="text" class="form-control">
								</div>
			                    <div class="form-group">
									<label>Status</label>
									
                                    <div class="radio">
                                    <label>
                                    <input type="radio"   runat="server" name="statusradio" id="statusradiobutton" value="1" >
                                            Active
                                    </label>
                                    </div>
                                     <div class="radio">
                                    <label>
                                    <input type="radio" runat="server" name="statusradio" id="Radio1" value="0">
                                            InActive    
                                    </label>
                                    </div>
								</div>
                                <asp:Button ID="Button1" runat="server" Text="Submit Changes"  class="btn btn-primary" onclick="Button1_Click"/>
								
						
						</div>
					</div>
				</div>
			</div>
	
		</div>
    
           </form>
</div>
	
    </asp:Content>