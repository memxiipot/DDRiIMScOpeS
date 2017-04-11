<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="welcome.aspx.cs" Inherits="KatMaLea.welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
  
	<div class="row">
        <div>   
            <%= menu %>         
      <%--      <a href="order.aspx" >
            <div class="thumbnail">
                
                    <h4>Cashiering</h4>
                    <p>Create/Edit/Void an order</p>
                
                <img src="images/welcome/App-lists-icon.png" alt="...">
            </div></a>--%>
      
    
          
       
        
             
      </div>
        </div>

     </div>
    
	
   <%-- <div class="row" id="row1">
      <div class="col-lg-12">

         
        <button id="btnsched" type="button" class="btn btn-default"onClick="window.location='/schedule.aspx'" >Maintainance</button>
        <button id="btnmanageorder" type="button" class="btn btn-success">MANAGE ORDER DETAILS</button>
        <button id="btnverifyorder" type="button" class="btn btn-primary"  onClick="window.location='/order.aspx'">ORDER</button>
        <button id="btnprocesspayment" type="button" class="btn btn-primary">PROCESS PAYMENT</button>
        <button id="btnmanageinventory" type="button" class="btn btn-info">INVENTORY</button>
        <button id="btnreports" type="button" class="btn btn-warning">REPORTS</button>
        <button id="btnaccnting" type="button" class="btn btn-danger">ACCOUNTING</button>
          <button id="btnprocesspayment" type="button" class="btn btn-danger" onClick="window.location='/menus.aspx'">MENU</button>
          <button id="Button1" type="button" class="btn btn-danger" onClick="window.location='/measurement.aspx'">REFERENCE</button>
       <%-- <button id="btnprofile" type="button" class="btn btn-primary">PROFILE</button>
      </div>
    </div>--%>
 
</asp:Content>
