<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master_default.Master" CodeBehind="ChartFoodOrder.aspx.cs" Inherits="ChartFoodOrder.Charts" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

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
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table>
            <td>
                From:
            </td>
            <td>
                <asp:TextBox ID="txtfrom" runat="server" Width="350"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtfrom" FirstDayOfWeek="Sunday" />
            </td>
            <td>
                To:
            </td>
            <td>
                <asp:TextBox ID="txtto" runat="server" Width="350"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtto" />
            </td>
            <td>
                Select: 
            </td>            
            <td>                
                <asp:DropDownList ID="DropDownList3" runat="server" 
        Width="110px" onselectedindexchanged="DropDownList2_SelectedIndexChanged" 
        ontextchanged="DropDownList2_TextChanged">
        <asp:ListItem>&quot;&quot;</asp:ListItem>
        <asp:ListItem>Daily</asp:ListItem>
        <asp:ListItem>Weekly</asp:ListItem>
        <asp:ListItem>Monthly</asp:ListItem>
        <asp:ListItem>Yearly</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td>
<asp:Button ID="Button2" runat="server" onclick="Button1_Click" 
        Text="Preview" />    
            </td>
        </table>
    <%--<br />
    Inventory<br />
    <br />
    <br />
    <br />
    To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <table>
<asp:Calendar ID="dtpTo" runat="server"  > </asp:Calendar>
    <br />
    <br />
    From<br />
    <asp:Calendar ID="dtpFrom" runat="server"></asp:Calendar>
   
    <br />
    Select 
    <asp:DropDownList ID="DropDownList2" runat="server" 
        Width="110px" onselectedindexchanged="DropDownList2_SelectedIndexChanged" 
        ontextchanged="DropDownList2_TextChanged">
        <asp:ListItem>&quot;&quot;</asp:ListItem>
        <asp:ListItem>Daily</asp:ListItem>
        <asp:ListItem>Weekly</asp:ListItem>
        <asp:ListItem>Monthly</asp:ListItem>
        <asp:ListItem>Yearly</asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                       <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Preview" />
    <br />
    <br />--%>
    <table> 
        <%--style="border: 1px solid black; font-family: Arial">--%>
<tr>
<%--<br>
SAMPLE
</br>--%>
<%--<br></br>--%>

    <div>
    
        <br />
        <td>
        <b>Select Chart Type:</b>
            <br />&nbsp; To
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
&nbsp;From
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
    </td>
    <td>
        <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server"
            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td colspan="2">
        <table style="border: 1px solid black; font-family: Arial">
        <asp:Chart ID="Chart1" runat="server" Width="800px" Height="540px" >
            
            <Titles>
                <asp:Title Text="Chart of Food Order">
                </asp:Title>
            </Titles>
            <Series>
               
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Title="Name">
                    </AxisX>
                    <AxisY Title="Total Qty">
                    </AxisY>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
        
        </table>
    </td>
    <td>
        <table style="border: 1px solid black; font-family: Arial">
            <tr>
                <td>
                    <asp:Chart ID="Chart2" runat="server" Width="400px" Height="180px" >
            
            <Titles>
                <asp:Title Text="Chart of Income">
                </asp:Title>
            </Titles>
            <Series>
               
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Title="Name">
                    </AxisX>
                    <AxisY Title="Total Qty">
                    </AxisY>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Chart ID="Chart3" runat="server" Width="400px" Height="180px" >
            
            <Titles>
                <asp:Title Text="Chart of Inventory">
                </asp:Title>
            </Titles>
            <Series>
               
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Title="Name">
                    </AxisX>
                    <AxisY Title="Total Qty">
                    </AxisY>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Chart ID="Chart4" runat="server" Width="400px" Height="180px" >
            
            <Titles>
                <asp:Title Text="Chart of Maintenance">
                </asp:Title>
            </Titles>
            <Series>
               
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Title="Name">
                    </AxisX>
                    <AxisY Title="Total Qty">
                    </AxisY>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
    <br />
    <br />
    </div>
    </form>
</asp:Content>
