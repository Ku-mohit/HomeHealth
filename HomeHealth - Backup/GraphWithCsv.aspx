<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GraphWithCsv.aspx.cs" Inherits="HomeHealth.GraphWithCsv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Stack Column Chart</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: sans-serif;
        }

        /*  .chartMenu {
             width: 100vw;
             height: 40px;
             background: #1A1A1A;
             color: rgba(54, 162, 235, 1);
         }*/

        .chartMenu p {
            padding: 10px;
            font-size: 20px;
        }

        .chartCard {
            width: 100vw;
            height: calc(100vh - 40px);
            /*background:yellowgreen;*/
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .chartBox {
            width: 810px;
            padding: 20px;
            border-radius: 20px;
            border: solid 3px rgba(54, 162, 235, 1);
            background: white;
        }

        .auto-style1 {
            margin-left: 30px;
            margin-top: 10px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.2.1/dist/chart.umd.min.js"></script>
    <script src="path/to/chartjs/dist/chart.umd.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <center>
            <div>

                <asp:Label ID="lbl" runat="server"></asp:Label>
            </div>
        </center>
    </form>
</body>

</html>
