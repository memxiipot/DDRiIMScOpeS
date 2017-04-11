<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="linechefview.aspx.cs" Inherits="KatMaLea.linechefview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
     <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
    <div>
    <!-- Modal -->
        <div class="container">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick"></asp:Timer>
            <%--<table><div><id="brand-name" class="navbar-brand" href="#"onClick="window.location='/welcome.aspx'">DAVAODENCIA'S</div></table>
            --%>
    <div class="row">
      <div class="col-lg-6">         
         <div role="tabpanel">
          <!-- Nav tabs -->
          <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="#" onClick ="window.location='/welcome.aspx'" aria-controls="createorder" role="tab" data-toggle="tab">HOME</a></li>  
            <li role="presentation" class="active"><a href="#createorder" aria-controls="createorder" role="tab" data-toggle="tab">LIST OF ORDER</a></li>              
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="createorder" runat ="server" UpdateMode="Conditional">
                
                <table class="table table-hover">
                    <tr>
                       <th>Table No</th> 
                        <th>Customer</th>
                        <th>Time Ordered</th>  
                         <th>Actions</th> 
                    </tr>
                    <%= getOrderlist() %>
               </table>
              <button id="btnorder" type="submit" class="btn btn-default btn-lg">REFRESH</button>
            </div>

          </div>
        </div>
      </div>
      <div id="tbllistoforder" class="col-lg-6">
        <p class="bg-primary">LIST OF ORDERS</p> <p class="text-danger"><B>FOR TABLE #</B></p> <h1 align="right"><%= getselTableno()
                                                %></h1>
        <table class="table table-striped">
          <tr>
            <th>#</th>
            <th>Menu</th>
            <th>Quantity</th>
            <th>Is Done</th>
          </tr>
        <%= getlistofmenu() %>
        </table>
      </div>
    </div>
  </div>
    
        <script type="text/javascript">
            //for modal dialogs bootstrap dont delet
            $('#myModal').on('shown.bs.modal', function () {
                $('#myInput').focus()
            })
</script>
        <script src="js/jquery-2.1.3.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>

        </div>
    </form>
</body>
</html>
