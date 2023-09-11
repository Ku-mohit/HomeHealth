<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="HomeHealth.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Health | Contact </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="Assests/CSS/HomeHealthMainCSS.css" rel="stylesheet" />
    <style type="text/css">
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        table {
            border: 1px solid #ccc;
            border-collapse: collapse;
            background-color: #fff;
            width: 100%
        }

            table th {
                background-color: #251B37;
                color: #FFCACA;
                font-weight: bold;
            }

            table th, table td {
                padding: 5px;
                border: 0px solid #ccc;
            }

            table, table table td {
                border: 0px solid #ccc;
            }

        .button {
            background-color: #223c88; /* Blue */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }

        .contact-form {
            border: 1px solid #251B37;
            border-radius: 50px;
            margin-bottom: 10rem;
            height: 350px;
            width: 300px;
            box-shadow: 10px 10px 50px 3px #FFCACA inset;
        }

        .contact-heading {
            height: 20px;
            width: 80px;
            background-color: #4E6C50;
            color: #FAECD6;
            font-size: 20px;
            border-radius: 10px;
            padding: 8px;
            font-family: 'Cambria Math';
        }

        .textBox {
            font-size: 16px;
            width: 100%;
            border-radius: 10px;
            padding: 5px;
        }

        .btn-submit {
            align-self: center;
            margin-left: 2.5rem;
            width: 70%;
            height: 30px;
            border-radius: 10px;
            background-color: #251B37;
            color: #ffff;
            font-size: 16px;
            padding: 4px;
        }
    </style>


</head>

<body>
    <form id="form1" runat="server">
        <div class="mainContainer">
            <%-- <nav class="navbar">
                <div id="HomeHealthLogo">
                    <h2 style="color: #FFCACA">Logo</h2>

                </div>
                <div id="forSearch"></div>
                <div id="">
                </div>
            </nav>--%>

            <%--Header start--%>
            <article>
                <header class="navbar">
                    <div id="HomeHealthLogo">
                        <h2 style="color: #FFCACA">Logo</h2>
                    </div>
                    <nav>
                        <ul>
                            <li style="display: inline"><a href="HomePage.aspx">Home</a></li>
                            <li style="display: inline"><a href="#">About</a></li>
                            <li style="display: inline"><a href="#">Work</a></li>
                            <li style="display: inline"><a href="#">Careers</a></li>
                        </ul>
                    </nav>
                </header>
            </article>
            <%--Header End--%>

            <%--Form Data Start--%>

            <div class="Data" style="margin-top: 10rem; margin-left: 45%; margin-right: 45%;">
                <center>
                    <div class="contact-heading" style="margin-left: 7.5rem; margin-bottom: 2rem">Contact </div>
                </center>
                <div class="contact-form" style="margin-left: 10%; margin-right: 10%; margin-top: 10px;">
                    <%--<table>
                       <tr>
                           <asp:TextBox ID="txtName" runat="server" placeholder="Enter Name"></asp:TextBox>

                       </tr>
                       <tr>
                           <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email"></asp:TextBox>
                       </tr>
                   </table>--%>
                    <div class="form-data" style="padding: 16px; margin-top: 30px; margin-right: 10px">
                        <asp:TextBox ID="txtName" runat="server" placeholder="&nbsp;Enter Name" Font-Size="16px" Width="100%" class="textBox"></asp:TextBox><br />
                        <br />
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="&nbsp;Enter Email" class="textBox" TextMode="Email"></asp:TextBox><br />
                        <br />
                        <asp:TextBox ID="txtPhone" runat="server" placeholder="&nbsp;Enter Mobile Number" class="textBox" TextMode="Number"></asp:TextBox><br />
                        <br />
                        <asp:TextBox ID="txtMessage" runat="server" placeholder="Enter Your Query here!" class="textBox" TextMode="MultiLine" Height="60px" style="resize:none;"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" class="btn-submit" />
                    </div>
                </div>

            </div>
            <%--Form Data End--%>




            <%--Footer Start--%>
            <footer class="footer">
                <center style="margin-top: 50px">
                    <nav>
                        <p style="align-content: center">
                            <a href="#">About Us</a>| <a href="#">Privacy Policy</a>|  <a href="#">Careers</a>
                        </p>
                    </nav>
                    <p style="align-items: center; margin-top: 5px">
                        &#169; eHealthcare Registry: All Rights Reservered v 1.1
                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                    </p>
                    <asp:Image ID="Image1" ImageUrl="~/Assests/Images/vector1.png" runat="server" Style="margin-top: -7.5rem; margin-right: -42rem; display: flex; float: right; width: 200px" />
                </center>
            </footer>
            <%--Footer End--%>
        </div>
    </form>
</body>
</html>

