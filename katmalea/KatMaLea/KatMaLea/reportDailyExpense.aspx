<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="reportDailyExpense.aspx.cs" Inherits="KatMaLea.reportDailyExpense" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
            <%--<a href="reportDailyExpense.aspx">reportDailyExpense.aspx</a>--%>
    <form id="form2" runat="server" method="post" >
    <div class="container" id="Div1">
        <div class="row">
            	<div class="col-lg-3">
		
				</div>
	<CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" DisplayToolbar="False" EnableDatabaseLogonPrompt="False" GroupTreeImagesFolderUrl="" Height="1170px" ReportSourceID="CrystalReportSource2" ToolbarImagesFolderUrl="" ToolPanelView="None" ToolPanelWidth="200px" Width="903px" />
             
		        <CR:CrystalReportSource ID="CrystalReportSource2" runat="server">
                    <Report FileName="Reports\rptDailyExpense.rpt">
                    </Report>
                </CR:CrystalReportSource>
             
		        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                    <Report FileName="Reports\rptDailyExpense.rpt">
                    </Report>
                </CR:CrystalReportSource>
             
		</div>
        </div>
    </form>
</div>
 

  </asp:Content>
