﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmRptExpenseDaily.aspx.cs" Inherits="WebApplication2.WebForm6" %><%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="1202px" ReportSourceID="CrystalReportSource1" ReuseParameterValuesOnRefresh="True" ToolbarImagesFolderUrl="" ToolPanelView="ParameterPanel" ToolPanelWidth="200px" Width="1104px" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="reports\rptDailyExpense.rpt">
            </Report>
        </CR:CrystalReportSource>
    </form>
</body>
</html>
