<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="HomeHealth.Help" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Meta tags updated on 16/02/2023 -->
    <meta charset="UTF-8" />
    <meta name="description" content="This is internal website for Vatsal Healthcare solutions." />
    <%--<meta name="keywords" content="Homehealth Vatsal" />--%>
    <meta name="author" content="Vatsal Healthcare Solutions" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="Assests/Images/favicon.ico" width="80px" />
    <title>Help</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="Assests/CSS/HomeHealthMainCSS.css" rel="stylesheet" type="text/css" />
    <script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <!-- Google Fonts-->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&family=Work+Sans:wght@100;300&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Quicksand:wght@300&family=Work+Sans:wght@100;300&display=swap" rel="stylesheet" />

    <!-- For chats -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.umd.min.js"></script>

    <script>
        $(document).ready(function () {
            $(".hamburger .hamburger__inner").click(function () {
                $(".wrapper").toggleClass("active")
            })
        })

    </script>
    <style type="text/css">
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        table {
            border-collapse: collapse;
            background-color: #fff;
            width: 100%;
        }

        table th {
            background-color: #251B37;
            color: #ffff;
            font-weight: bold;
        }
        
        table th, table td {
            padding: 5px;
            border: 1px solid #fff;
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
        p > h3 {
            display: inline-block;
        }

        .chartBox {
            width: 100%;
            height: 100%;
            padding: 20px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="mainContainer">
            <%--Header start--%>
            <article>
                <header class="navbar ">
                    <div id="HomeHealthLogo" style="float: left; background-color: #fff; height: 4rem;">
                        <div style="margin-top: 7px;">
                            <a href="http://sunrisedomsvr/Intranet" style="padding: 11px;">
                                <asp:Image runat="server" ImageUrl="~/Assests/Images/LogoNewSize.png" /></a>
                        </div>
                    </div>
                    <center>
                        <div class="Heading" style="color: #000; margin-top: 20px;">
                            <h2 style="font-family: 'Comfortaa', cursive; font-size: 25px;">Physician Association Value Based Contract Management Dashboard</h2>
                        </div>
                    </center>
                    <div id="eHealthcareLogo" style="float: right; margin-top: -50px; margin-right: 8px; background-color: #fff; height: 9rem;">
                        <div style="margin-top: 17px;">
                            <a href="http://sunrisedomsvr/Intranet">
                                <asp:Image runat="server" ImageUrl="~/Assests/Images/eHealthcareLogo.png" Width="100px" Height="40px" /></a>
                        </div>
                    </div>
                    <nav>
                        <ul></ul>
                    </nav>

                </header>
            </article>
            <%--Header End--%>

            <%--Middle Items Start--%>
            <div class="wrapper">
                <div class="top_navbar" style="margin-top: 4rem">

                    <div class="menu">
                        <div class="logo">
                            <div class="secondBar" style="margin-left: 95vh;font-family: 'Comfortaa', cursive; font-size: 1.1vw;">HELP </div>
                        </div>
                        <div class="right_menu">
                     
                            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" CssClass="btn" />
                        </div>
                    </div>
                </div>
                <div class="main_container">
                    <div class="middleContainer">
                        <div id="information" style="margin-left: -70px; margin-top: 130px; display: flex; width: 104%; height: auto; border: 1px solid #eee;border-radius:13px;box-shadow:5px 5px 6px #eee">
                            <div id="bullets" style="margin-left: 7%; margin-right: 7%; padding: 12px; font-size: 20px;">
                                <p>1.  On initial launch of dashboard, you will see the side bar in blue color which have categories as Membership, Clinical Quality and Utilization, also there is a pushpin 
                                    &nbsp; <asp:Image ID="pushpinImg" runat="server" ImageUrl="~/Assests/Images/pushpin.png" Width="40px" />&nbsp; 
                                    which is used to pin the side bar in expanded form so you can see the names of respective category with their icons.</p><br />
                                <p>2.	By default, The MEMBERSHIP (
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Assests/Images/membership_icon.png" Width="40px" />
                                    ) category will be rendered of Insurance “Simply” and year 2023.</p><br />
                                <p>3.	From the insurance dropdown &nbsp; <asp:Image ID="Image2" runat="server" ImageUrl="~/Assests/Images/insurance_dd.png" Width="250px" />&nbsp;  we can change the insurance to see the trend of different insurances.</p><br />
                                <p> 4.	Also, we can see the trend according to year by selecting the particular year from the year dropdown. </p><br />
                                <p>5.	Like wise year dropdown &nbsp; <asp:Image ID="Image3" runat="server" ImageUrl="~/Assests/Images/year_dd.png" Width="120px" />&nbsp; can be used to see the records year wise.</p><br />
                                <p>6.	In analysis block there is a link (“click here for detailed …”) to see complete information about the patient.</p><br />
                                <p>7.	From that link you will be rendered to new roaster page, where all the demographic information related to patient is shown, but the information available in that page depends on which month’s bar user has clicked.</p><br />
                                <p>8.	Also, you can save that data into excel file by just clicking on the  <asp:Image ID="Image4" runat="server" ImageUrl="~/Assests/Images/save_as_xls_btn.png" Width="70px" />   button in roaster page.</p><br />
                                <p>9.	When user click on second category “CLINICAL QUALITY” ( <asp:Image ID="Image5" runat="server" ImageUrl="~/Assests/Images/clinical_quality_icon.png" Width="40px" /> ), then its respective graph will be shown. Also, it has its four-sub category called “Measure”. Their name are Vital/Labs, Medication, Process Measure and Tracking Measures.</p><br />
                                <p>10.	By default, in Clinical Quality category Vital/labs graph is shown. But we can change it selecting the measure from the radio button list.</p><br />
                                <p>11.	When we click on the “UTILIZATION” ( <asp:Image ID="Image6" runat="server" ImageUrl="~/Assests/Images/utilization_icon.png" Width="40px" /> ) Category its sub-category Cost graph will be loaded, actually it has two sub-categories Cost and MLR but by default Cost Graph will be loaded.</p><br />
                                <p>12.	Also, from the cost and MLR radio button list item user can toggle between those.</p><br />
                                <p>13.	By clicking on the bars of cost their respective analysis will be shown in analysis block by the side of graph.</p><br />
                                <p>14.	In the analysis of Utilization there is Membership count on the top, Part-A cost, Part-B cost, Part-D cost, other and their total cost, also we have mentioned the revenue</p><br />
                                <p>15.	In the second table of Utilization cost analysis consists of other sub- categories as Ancillary, Dental, OTC, Other.</p><br />
                                <p>16.	In Utilization’s MLR sub category when user click on the bar then one table will be shown by the side of graph which shows year, month and their respective MLR.</p><br />
                                <p><b>Few more features of graph.</b></p><br />
                                <p>1.	By clicking on the labels of graph we can eliminate and see the particular stack in stacked bar graph.</p><br />
                                <p>2.	Also, we can show or hide the particular stack by clicking on that particular label of stack.</p><br />
                                <p>3.	Along with these we can download graph by clicking on the  <asp:Image ID="Image7" runat="server" ImageUrl="~/Assests/Images/export_to_pdf.png" Width="100px" />  button.</p><br />
                                <p>4.	And by clicking on  <asp:Image ID="Image8" runat="server" ImageUrl="~/Assests/Images/help_icon.png" Width="30px" /> you can access the help document. </p><br />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--Middle Items End--%>

            <%--Footer Start--%>
            <footer class="footer" style="margin-top: 40rem;">
                <center>
                    <p style="align-items: center;">
                        &#169; eHealthcare Registry: All Rights Reservered v 1.1
                        <asp:Label ID="lblDate" runat="server">04202023</asp:Label>
                    </p>
                </center>
            </footer>
            <%--Footer End--%>
        </div>
    </form>
</body>
</html>
