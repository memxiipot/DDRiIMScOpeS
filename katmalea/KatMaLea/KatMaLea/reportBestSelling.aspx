<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="reportBestSelling.aspx.cs" Inherits="KatMaLea.reportBestSelling" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
    <form id="form2" runat="server" method="post" >
    <div class="container" id="Div1">
        <div class="row">
            	<div class="col-lg-3">
		
				</div>
	<CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" DisplayToolbar="False" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" GroupTreeImagesFolderUrl="" Height="815px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" ToolPanelView="None" ToolPanelWidth="200px" Width="238px" />
             
		        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                    <Report FileName="Reports\rptBestSellingDishes.rpt">
                    </Report>
                </CR:CrystalReportSource>
             
		</div>
        </div>
    </form>
</div>
 

  </asp:Content>
