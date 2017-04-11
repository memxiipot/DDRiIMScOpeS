<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="listreports.aspx.cs" Inherits="KatMaLea.listreports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Report Option"></asp:Label>
&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="cboReportOption" runat="server" AutoPostBack="True"  OnSelectedIndexChanged="cboReportOption_SelectedIndexChanged">
                <asp:ListItem>EXPENSE</asp:ListItem>
                <asp:ListItem>INCOME</asp:ListItem>
                <asp:ListItem>INGREDIENTS</asp:ListItem>
                <asp:ListItem>DISHES</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Preview" />
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Report Option"></asp:Label>
&nbsp;:
            <asp:DropDownList ID="cboReportType" runat="server">
            </asp:DropDownList>
        </p>
        <p>
            From&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <asp:Calendar ID="Calendar1" runat="server" NextPrevFormat="ShortMonth"></asp:Calendar>
        </p>
        <p>
            To 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Calendar ID="Calendar2" runat="server" NextPrevFormat="ShortMonth"></asp:Calendar>
        </p>
    </form>

  </asp:Content>
