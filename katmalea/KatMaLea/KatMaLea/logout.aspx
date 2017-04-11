<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="KatMaLea.logout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Logout</title>
        <%
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        Response.Cache.SetNoStore();
        Response.CacheControl = "no-cache";

        if (Session["UserId"] != null)
        {
            Response.Redirect("~/Home.aspx");
            Response.End();
        }
%>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        If the browser doesn't redirect you automatically Click <asp:LinkButton ID="LinkButton1" runat="server">here</asp:LinkButton>
    </div>
    </form>
</body>
</html>
