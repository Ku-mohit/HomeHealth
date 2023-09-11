<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="temp.aspx.cs" Inherits="HomeHealth.Modals.temp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests" />
    <title>temp</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="../Assests/JavaScript/temp.js"></script>
    <style>
        /*.btnSidebar{

        }*/
        active{
            background-color:yellowgreen;

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblCategory" runat="server"></asp:Label>
            <asp:Label ID="lblStatus" runat="server"></asp:Label>


            <ul id="categories">
                <li>
                    <span>
                        <%--<a href="?Category=Membership" class="active" id="mem">
                            <span class="title" id="membership" runat="server">Membership</span>
                        </a>--%>
                        <asp:LinkButton ID="lnkBtnMembership" runat="server" OnClick="lnkBtnMembership_Click" CssClass="active">
                            <span class="title" id="membership" runat="server">Membership</span>
                        </asp:LinkButton>
                    </span>
                </li>
                <li>
                    <span>
                        <%--<a href="?Category=Hedis" id="hed">
                            <span class="title" id="hedis" runat="server">Clinical Quality</span>
                        </a>--%>
                        <asp:LinkButton ID="lnkBtnHedis" runat="server" OnClick="lnkBtnHedis_Click">
                            <span class="title" id="hedis" runat="server">Hedis</span>
                        </asp:LinkButton>
                    </span>
                </li>
                <li>
                    <span>
                        <a href="?Category=MRA" id="mr">
                            <span class="title" id="mra" runat="server">Medical Risk</span>
                        </a>
                    </span>
                </li>
                <li>
                    <span>
                        <a href="?Category=Utilization" id="util">
                            <span class="title" id="utilization" runat="server">Utilization</span>
                        </a>
                    </span>
                </li>
                <li>
                    <span>
                        <a href="?Category=Report" id="repo">
                            <span class="title" id="reports" runat="server">Reports</span>
                        </a>
                    </span>
                </li>
                <li>
                    <span>
                        <a href="?Category=Help" id="he">
                            <span class="title" id="help" runat="server">Help</span>
                        </a>
                    </span>
                </li>
            </ul>
            <asp:DropDownList ID="ddlInsurance" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlInsurance_SelectedIndexChanged"></asp:DropDownList>
            <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </form>
</body>
<%--To use ajax in webform/webpage--%>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%--To use charts in webpage--%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.min.js" integrity="sha512-v3ygConQmvH0QehvQa6gSvTE2VdBZ6wkLOlmK7Mcy2mZ0ZF9saNbbk19QeaoTHdWIEiTlWmrwAL4hS8ElnGFbA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script>

</script>
</html>
