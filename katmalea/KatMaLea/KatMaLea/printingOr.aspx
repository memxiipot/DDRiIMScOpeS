<%@ Page Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="printingOr.aspx.cs" Inherits="KatMaLea.printingOr" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="626px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="672px" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="Reports\rptOrReceipt.rpt">
            </Report>
        </CR:CrystalReportSource>
    </div>
    </form>
</body>
</html>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <form id="form1" runat="server" method="post" >
    <div class="container" id="rates">
        <div class="row">
            	<div class="col-lg-3">
		 <asp:Button ID="Button1" class="btn btn-info btn-lg" runat="server" Text="Go Back" OnClick="computebutton_Click" />
				</div>
		 <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="626px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="672px" DisplayToolbar="False" ToolPanelView="None" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="Reports\rptOrReceipt.rpt">
            </Report>
        </CR:CrystalReportSource>
             
		</div>
        </div>
    </form>
</div>

  </asp:Content>
