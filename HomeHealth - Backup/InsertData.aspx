<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertData.aspx.cs" Inherits="HomeHealth.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblConfirm" runat="server" ></asp:Label>
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
            <asp:GridView ID="GridView2" runat="server"></asp:GridView>
        </div>
    </form>
</body>
</html>
