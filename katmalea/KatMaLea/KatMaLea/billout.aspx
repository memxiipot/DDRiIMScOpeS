<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="billout.aspx.cs" Inherits="KatMaLea.billout" %>
<%@ Register TagPrefix="nav" TagName="refnav" Src="~/controls/ordernav.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <style type="text/css">
          .auto-style1
          {
              height: 65px;
          }
          .auto-style2
          {
              height: 37px;
          }
      </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <form id="form1" runat="server" method="post"  action ="billout.aspx" >
          <%--<script type="text/javascript">
              //function getval(txtbox) {
              //    var textInput = document.getElementById("tendered").value;
              //   document.getElementById("discount").value = textInput;}         
        </script>--%>
    <script src="//code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //Iterate through each Textbox and add keyup event handler
            $(".clsTxtToCalculate").each(function () {
                $(this).keyup(function () {
                    //Initialize total to 0
                    var total = 0;
                    var total2 =0;
                    
                    $(".clsTxtToCalculate").each(function () {
                        // Sum only if the text entered is number and greater than 0
                        if (!isNaN(this.value) && this.value.length != 0) {
                            total += parseFloat(this.value);
                            total2 -= (parseFloat(this.value));
                        }
                    });
                    //Assign the total to label
                    //.toFixed() method will roundoff the final sum to 2 decimal places
                    $('#<%=changelabels.ClientID %>').html(total.toFixed(2));
                });
            });
        });
    </script>
    <div class="container" id="rates">
			<div class="row">
		      <%--  <nav:refnav id="refnav1" Title="User Control Test" TextColor="green" Padding=10 runat="server" />--%>
                     	<div class="col-lg-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-pills nav-stacked">
							  <li role="presentation" ><a href="../order.aspx">New Order</a></li>
							  <li role="presentation"  ><a href="../editOrder.aspx">Edit/Void Order</a></li>
                                <li role="presentation" ><a href="../verifyorder.aspx">Verify Order</a></li>
							 <li role="presentation" class="active"><a href="../billout.aspx">BILL OUT</a></li>
                            
							</ul>
						</div>
					</div>			
				</div>
				<div class="col-lg-9">
                     <span id="message" runat="server"></span>
					<div class="panel panel-default">
						<div class="panel-heading">LIST OF TABLE READY FOR CHECK OUT</div>
						<div class="panel-body">	
                           
                                <div class="form-group">
                                    <asp:RadioButtonList ID="ordertype" runat="server" AutoPostBack="true">
                                        <asp:ListItem Value="1" Selected="True">Dine In</asp:ListItem>
                                        <asp:ListItem Value="0">Take Out</asp:ListItem>
                                    </asp:RadioButtonList>
								    </div>
                            	<div class="form-group">
                                     <asp:Label ID="Label1" runat="server" Text=""></asp:Label></br>
                                    <asp:Label ID="tableno" runat="server" Text="Select Table #"></asp:Label>
                                    <asp:DropDownList  class="form-control" ID="tabledropdown" runat="server" AutoPostBack="True" ></asp:DropDownList>
								    </div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-9 col-lg-offset-3">
					<div class="panel panel-default">
						<div class="panel-heading">Order List</div>
                       
						<div class="panel-body">
							<div class="table-responsive">
	                
									<div class="form-group">
										<table class="table table-striped">
											<tr>
                                                <th class="auto-style2">#</th>
											<th class="auto-style2">Menu</th>
												<th class="auto-style2">Price</th>
                                                <th class="auto-style2">Quantity</th>
                                                 <th class="auto-style2">Subtotal</th>
                                             
                                            
											</tr>
										<%= getListoforderhtml() %>
                           
                                                  <tr>
                                            <td class="auto-style1"></td><td class="auto-style1"></td><td class="auto-style1"></td>
                                            <td class="auto-style1">Discount</td>
                                            <td class="auto-style1">
                                                <asp:TextBox ID="discountextbox" CssClass="clsTxtToCalculate" class="form-control" runat="server"  TextMode="Number" AutoPostBack="True" OnTextChanged="discountextbox_TextChanged" ></asp:TextBox>
                                                <asp:TextBox ID="txttotal" CssClass="clsTxtToCalculate" class="form-control" runat="server"  TextMode="Number" BorderStyle="None" Enabled="False" Height="0px" Width="0px" ></asp:TextBox>                  
                                                 <%--onkeydown = "return (event.keyCode!=13);--%>
                                                 <%--onkeydown = "return (event.keyCode!=13);--%>
                                            </td>
								        </tr>
								        <tr>
                                            <td></td><td></td><td></td>
                                            <td>Rendered Amount</td>
                                            <td>
                                                <asp:TextBox ID="renderedamounttextbox" CssClass="clsTxtToCalculate" class="form-control" runat="server"  OnTextChanged="renderedamounttextbox_TextChanged" TextMode="Number"
                                                    ></asp:TextBox>
                                            </td>
								        </tr>
                                       
                                             <tr>
                                            <td></td><td></td><td></td>
                                            <td><h3>TOTAL</h3></td>
                                            <td>
                                                <asp:Label ID="totalamtpaidlabel"  runat="server"  ForeColor="Red" Font-Size="XX-Large" Font-Bold="True"></asp:Label>
                                            </td>
								        </tr>
                                               <tr>
                                            <td></td><td></td><td></td>
                                            <td></td>
                                            <td>
                                               
                                            </td>
								        </tr>
                                                <tr>
                                            <td></td><td></td><td></td>
                                            <td><H3>Change</H3></td>
                                            <td>
                                                <asp:Label ID="changelabels" runat="server" ForeColor="Red" Font-Size="XX-Large" Font-Bold="True" Text="00.00"></asp:Label>
                                            </td>
								        </tr>
										</table>
                                        <asp:Button ID="proceedbutton" class="btn btn-danger btn-lg" runat="server" Text="BILL OUT" OnClick="proceedbutton_Click"/>
                                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">INSERT OR DETAILS</button>
                                        
                                        <!-- Modal -->
                                      <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                      <div class="modal-dialog">
                                        <div class="modal-content">
                                          <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="exampleModalLabel">OR DETAILS</h4>
                                          </div>
                                          <div class="modal-body">
                                                
                                                <div class="form-group">
                                                <label for="customer" class="control-label">Customer</label>
                                                <input type="text" class="form-control" id="customer" name="customer" placeholder="Whom reciept will be issued" value="<%= 
                                                    customername
                                               %>" >
                                              </div>
                                              <div class="form-group">
                                                <label for="company" class="control-label">Company</label>
                                                <input type="text" class="form-control" id="company" name="company" placeholder="Please enter a company if required">
                                              </div>
                                          </div>
                                          <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                             
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                             
									</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
    </form>

</asp:Content>

