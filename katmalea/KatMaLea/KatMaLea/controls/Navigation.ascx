<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navigation.ascx.cs" Inherits="KatMaLea.controls.Navigation" %>
    <!--navigation-->
    <div class="container">
      <div class="row">
        <nav id="nav-menu" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
          <div class="container-fluid">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcollapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <img class="navbar-brand" src="images/2-logo.png">
              <a id="brand-name" class="navbar-brand" href="#"onClick="window.location='/welcome.aspx'">DAVAODENCIA'S</a>
                <%--<a>|</a>
                <a id="A1" class="navbar-brand" href="#"onClick="window.location='/ChartFoodOrder.aspx'">DASHBOARD</a>--%>
            </div>
            <div class="collapse navbar-collapse" id="navcollapse">
                <ul class="nav navbar-nav navbar-right">
                 
                <%= userNavigationType() %>
               </ul>
            </div>
          </div>
        </nav>
      </div>
    </div>

