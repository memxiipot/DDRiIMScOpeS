<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmRptExpenseWeeklyMonthly.aspx.cs" Inherits="WebApplication2.WebForm7" %><%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="940px" ReportSourceID="CrystalReportSource1" ReuseParameterValuesOnRefresh="True" ToolbarImagesFolderUrl="" ToolPanelView="ParameterPanel" ToolPanelWidth="200px" Width="1411px" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="reports\rptWeeklyMonthlyExpense.rpt">
            </Report>
        </CR:CrystalReportSource>
    </form>
</body>
</html>
