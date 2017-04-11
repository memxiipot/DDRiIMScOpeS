<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="editcrew.aspx.cs" Inherits="KatMaLea.editcrew" %>
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
						<div class="panel-heading">Edit Crew</div>
						<div class="panel-body">
						
								<div class="form-group">
									<label>Crew Full name</label>
									<input name="crewname" runat="server" id="crewtextbox" type="text" class="form-control"/>
								</div>
                            	<div class="form-group">
									
                     
									 <label for="sel1">Position</label>
                                  <%--    <select class="form-control" id="sel1" name="positioncbo" runat="server">
                                          <%= getPositions() %>
                                         
                                      </select>--%>
                                    <asp:DropDownList ID="positioncbo" class="form-control" runat="server"></asp:DropDownList>
								    </div>
			                    <div class="form-group">
									<label>Status</label>
									
                                    <div class="radio">
                                    <label>
                                    <input type="radio" runat="server" name="statusradio" id="optionsRadios1" value="1"/>
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
                                <asp:Button ID="Button1" runat="server" Text="Submit Changes"  class="btn btn-primary" OnClick="Button1_Click" />
								
						
						</div>
					</div>
				</div>
			</div>
	
		</div>
    
           </form>
</div>
	
    </asp:Content>