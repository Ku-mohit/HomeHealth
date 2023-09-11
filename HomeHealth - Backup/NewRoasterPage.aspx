<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewRoasterPage.aspx.cs" Inherits="HomeHealth.NewRoasterPage" %>

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

    <title>Membership Roaster</title>


    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="Assests/CSS/HomeHealthMainCSS.css" rel="stylesheet" type="text/css" />
    <script src="Assests/JavaScript/HomeJS.js" type="text/javascript"></script>


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

            //$(".top_navbar .fas").click(function () {
            //    $(".profile_dd").toggleClass("active");
            //});
        })


        function ShowMembershipRoaster(insurance_, year_, month_) {
       
            $.ajax({
                type: "POST",
                url: "NewRoasterPage.aspx/GetMembershipByMonth",
                //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
                data: '{insurance: "' + insurance_ + '",year:"' + year_ + '",month:"' + month_ + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnMembershipRoasterSucces,
                failure: function (response) {
                    console.log(response.d)
                },
                error: function (response) {
                    //alert(resonse.d);
                    alert("You caught error");
                }

            });
        }
        function OnMembershipRoasterSucces(response) {
            let myChart = null;
            var first_name = [];
            var middle_name = [];
            var last_name = [];
            var date_of_birth = [];
            var gender = [];
            var age = [];
            var phone_number = [];
            var member_email = [];
            var patient_start_date = [];
            var pcp_start_date = [];
            var pcp_term_date = [];
            var last_visit = [];
            var next_visit = [];
            var comments= [];
            var provider_id= [];
            var patient_admission_in_hospital= [];
            var insurance = [];
            var insurance_plan = [];
            var network_code= [];
            var network_name= [];
            var month= [];
            var year = [];
            var opv1 = [];
            var opv2 = [];
            var opv3 = [];
     


            //console.log(response.d);
            var value = response["d"];
           // console.log(value);

            var obj = JSON.parse(value);
            //console.log(obj);
        }


    </script>


    <style type="text/css">
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        table {
            /*border: 1px solid #fff;*/
            border-collapse: collapse;
            background-color: #fff;
            width: 100%;
        }

            table th {
                background-color: #251B37;
                /*border: 1px solid #fff;*/
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
        /*  .FixedHeader {
            position:absolute;
            font-weight: bold;
            
        } ----------->>>  */ /* HeaderStyle-CssClass="FixedHeader"*/
        p > h3 {
            display: inline-block;
        }

        .chartBox {
            width: 100%;
            height: 100%;
            padding: 20px;
            /*border-radius: 20px;
            border: solid 3px rgba(54, 162, 235, 1);
            background: white;*/
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
                        <%--<h2 style="color: #FFCACA">Logo</h2>--%>
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
                        <%--<h2 style="color: #FFCACA">Logo</h2>--%>
                        <div style="margin-top: 17px;">
                            <a href="http://sunrisedomsvr/Intranet">
                                <asp:Image runat="server" ImageUrl="~/Assests/Images/eHealthcareLogo.png" Width="100px" Height="40px" /></a>
                        </div>
                    </div>
                    <nav>
                        <ul>
                            <%--<li style="display: inline; color: white;"><a href="#">About</a></li>
                            <li style="display: inline; color: white;"><a href="#">Work</a></li>
                            <li style="display: inline; color: white;"><a href="Contact.aspx">Contact</a></li>
                            <li style="display: inline; color: white;"><a href="#">Careers</a></li>--%>
                        </ul>
                    </nav>

                </header>
            </article>
            <%--Header End--%>

            <%--Middle Items Start--%>
            <div class="wrapper">
                <div class="top_navbar" style="margin-top: 4rem">
                    <%--<div class="hamburger">
                        <div class="hamburger__inner">
                            <div class="one"></div>
                            <div class="two"></div>
                            <div class="three"></div>
                        </div>
                    </div>--%>
                    <div class="menu">
                        <div class="logo">
                            <%--Coding Market--%>

                            <div class="secondBar" style="margin-top: 0rem; margin-left: 10rem; display: flex; justify-content: center">
                                Membership roster of:&nbsp;&nbsp;
                                <asp:Label ID="lblInsurance" runat="server" Font-Bold="false"></asp:Label>
                                &nbsp; &nbsp;
                                          <asp:Label ID="lblMonth" runat="server" Font-Bold="false"></asp:Label>
                                &nbsp; &nbsp;
                                          <asp:Label ID="lblYear" runat="server" Font-Bold="false"></asp:Label>
                                &nbsp; &nbsp;
                                          <asp:Label ID="lblCategory" runat="server" Font-Bold="false"></asp:Label>

                            </div>
                        </div>
                        <div class="right_menu">
                            <%--<ul>
                                <li><i class="fas fa-user"></i>
                                    <div class="profile_dd">
                                        <div class="dd_item">Profile</div>
                                        <div class="dd_item">Change Password</div>
                                        <div class="dd_item">Logout</div>
                                    </div>
                                </li>
                            </ul>--%>
                            <asp:Button ID="btnSaveAsExcel" runat="server" Text="Save as xls" OnClick="btnSaveAsExcel_Click" CssClass="btn" style="width:80px;margin-right:3px" />
                            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" CssClass="btn" />
                        </div>
                    </div>
                </div>
                <div class="main_container">
                    <!-- Updated the gridview elements and sizes to adjust data accordingly on 04202023 by Utpal-->
                    <div class="middleContainer">
                        <div id="PatientData" style="margin-left: -300px; margin-top: 130px; height: 780px; overflow-x: hidden; overflow-y: auto; text-align: center;">
                            <div class="container" style="margin-top:-30px;" runat="server">
                                <asp:GridView ID="grdvRoaster" runat="server"  CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeader="true" AutoGenerateColumns="false" EmptyDataText="Oops! No data found.">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Member Full Name</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("FirstName") + " " + Eval("MiddleName") + " " + Eval("LastName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Date of Birth</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("DateOfBirth")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Sex</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Gender") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Age</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Age") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Phone Number</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("PhoneNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Member Email</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("MemberEmail") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Patient Start Date</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("PatientStartDate")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>PCP Start Date</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("PatientStartDate")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>PCP Term Date</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("PCPTermDate")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Last Visit</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("LastVisit")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Next Visit</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("NextVisit")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Comments</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Comments") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Admission in Hospital</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("PatientAdmissionInHospital") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:BoundField HeaderText="FirstName" DataField="FirstName" />
                                        <asp:BoundField HeaderText="MiddleName" DataField="MiddleName" />
                                        <asp:BoundField HeaderText="LastName" DataField="LastName" />
                                        <asp:BoundField HeaderText="Date of Birth" DataField="DateOfBirth" />
                                        <asp:BoundField HeaderText="Sex" DataField="Gender" />
                                        <asp:BoundField HeaderText="Age" DataField="Age" />
                                        <asp:BoundField HeaderText="Phone Number" DataField="PhoneNumber" />
                                        <asp:BoundField HeaderText="Member Email" DataField="MemberEmail" />
                                        <asp:BoundField HeaderText="Patient Start Date" DataField="PatientStartDate" />
                                        <asp:BoundField HeaderText="PCP Start Date" DataField="PCPStartDate" />
                                        <asp:BoundField HeaderText="PCP Term Date" DataField="PCPTermDate" />
                                        <asp:BoundField HeaderText="Last Visit" DataField="LastVisit" />
                                        <asp:BoundField HeaderText="Next Visit" DataField="NextVisit" />
                                        <asp:BoundField HeaderText="Comments" DataField="Comments" />
                                        <asp:BoundField HeaderText="Admission in Hospital" DataField="PatientAdmissionInHospital" />--%>
                                    </Columns>
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                        </div>
                        </div>
                        

                    </div>

                </div>




            </div>
            <%--Middle Items End--%>

            <%--Footer Start--%>
            <footer class="footer" style="margin-top: 160px;">
                <center>
                    <%--<nav>
                        <p style="align-content: center; color: white">
                            <%--<a href="#">About Us</a>| 
                            <a href="#">Privacy Policy</a>| 
                            <a href="#">Careers</a>--%>
                        <%--</p>
                    </nav>--%>

                    <p style="align-items: center;">
                        &#169; eHealthcare Registry: All Rights Reservered v 1.1
                        <asp:Label ID="lblDate" runat="server">04202023</asp:Label>
                    </p>
                    <%--<asp:Image ID="Image1" ImageUrl="~/Assests/Images/vector1.png" runat="server" Style="margin-top: -7.5rem; margin-right: -42rem; display: flex; float: right; width: 200px" />--%>
                </center>
            </footer>
            <%--Footer End--%>
        </div>
    </form>
</body>
<script>





    function ChangePin() {
        var pushpin = document.getElementById("pushPinBlock");//.style.transform = 'rotate(-90deg)';
        var sidebar = document.getElementById("sidebar_");//.style.transform = 'rotate(-90deg)';
        //document.getElementById("sidebar").className = "sticked";
        //pushpin.style.transform = 'rotate(-90deg)';
        //pushpin.className = 'pushPinSticked';
        if (pushpin.className == 'pushPin') {
            pushpin.className = 'pushPinSticked';
            sidebar.className = 'sidebarSticked';
        }
        else {
            pushpin.className = 'pushPin';
            sidebar.className = 'sidebar';

        }
    }

</script>

</html>

