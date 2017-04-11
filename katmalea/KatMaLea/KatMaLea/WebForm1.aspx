<%--<%@ Page Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="KatMaLea.WebForm1" %>--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="KatMaLea.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //Iterate through each Textbox and add keyup event handler
            $(".clsTxtToCalculate").each(function () {
                $(this).keyup(function () {
                    //Initialize total to 0
                    var total = 0;
                    $(".clsTxtToCalculate").each(function () {
                        // Sum only if the text entered is number and greater than 0
                        if (!isNaN(this.value) && this.value.length != 0) {
                            total += parseFloat(this.value);
                        }
                    });
                    //Assign the total to label
                    //.toFixed() method will roundoff the final sum to 2 decimal places
                    $('#<%=lblTotalPrice.ClientID%>').html(total.toFixed(2)) - $('#<%=txtMilk.ClientID%>');
                });
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <fieldset style="width: 315px;">
            <legend>Running Total of all TextBoxes</legend>
            <table border="1px" cellpadding="5" style="border-collapse: collapse;">
                <tr style="text-align: left;">
                    <th>
                        No.</hd>
                        <th>
                            Item
                        </th>
                        <th>
                            Price
                        </th>
                </tr>
                <tr>
                    <td>
                        1
                    </td>
                    <td>
                        Milk:
                    </td>
                    <td>
                        <asp:TextBox ID="txtMilk" CssClass="clsTxtToCalculate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        2
                    </td>
                    <td>
                        Bread:
                    </td>
                    <td>
                        <asp:TextBox ID="txtBread" CssClass="clsTxtToCalculate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        3
                    </td>
                    <td>
                        Noodles:
                    </td>
                    <td>
                        <asp:TextBox ID="txtNoodles" CssClass="clsTxtToCalculate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        4
                    </td>
                    <td>
                        Cheese:
                    </td>
                    <td>
                        <asp:TextBox ID="txtCheese" CssClass="clsTxtToCalculate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <b>Total Price</b>
                    </td>
                    <td>
                        <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
    </form>
</body>
</html>

