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

    <script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.4.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <!-- Google Fonts-->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&family=Work+Sans:wght@100;300&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Quicksand:wght@300&family=Work+Sans:wght@100;300&display=swap" rel="stylesheet" />

    <!-- For charts -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.umd.min.js"></script>

    <script>
        $(document).ready(function () {
            $(".hamburger .hamburger__inner").click(function () {
                $(".wrapper").toggleClass("active")
            })
        })
        /* Purpose  : This is an AJAX method which is used to retrive data from JSON object.
         * Params   : insurance,month,year
         * Return   : void
         * It is left unimplemented because now data is shown in gridview.
         */
        function ShowMembershipRoaster(insurance_, year_, month_) {

            $.ajax({
                type: "POST",
                url: "NewRoasterPage.aspx/GetMembershipByMonth",
                data: '{insurance: "' + insurance_ + '",year:"' + year_ + '",month:"' + month_ + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnMembershipRoasterSucces,
                failure: function (response) {
                    console.log(response.d)
                },
                error: function (response) {
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
            var comments = [];
            var provider_id = [];
            var patient_admission_in_hospital = [];
            var insurance = [];
            var insurance_plan = [];
            var network_code = [];
            var network_name = [];
            var month = [];
            var year = [];
            var opv1 = [];
            var opv2 = [];
            var opv3 = [];
            var value = response["d"];
            var obj = JSON.parse(value);
        }
        function PrintGrid() {
           
            var printContents = document.getElementById("Container").innerHTML;
            var a = window.open('', '', 'height=800, width=1000');
            const queryParams = new URLSearchParams(window.location.search);
            const insurance = queryParams.get('Insurance');
            const month = queryParams.get('month');
            const year = queryParams.get('Year');
            a.document.write('<html>');
            a.document.write(`<body ><h1>` + insurance + ` ` + month + ` ` + year + `</h1><br><br>`);
            a.document.write(printContents);
            a.document.write(`<br><br><table>
                                <tr>
                                    <td>Active Patient</td>
                                    <td>120</td>
                                </tr>
                               <tr>
                                <td>New Patient</td>
                                    <td>6</td>
                               </tr>
                              <tr>
                                   <td>Disenrolled Patient</td>
                                   <td>3</td>
                              </tr>
                                <tr>
                                   <td>Not seen in last more than 3 month</td>
                                   <td>25</td>
                              </tr>
                                <tr>
                                   <td>Next Appointment not fixed</td>
                                   <td>10</td>
                              </tr>
                           </table>`
                        );
            a.document.write('</body></html>');
            a.document.close();
            a.print();
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

        p > h3 {
            display: inline-block;
        }

        .chartBox {
            width: 100%;
            height: 100%;
            padding: 20px;
        }

        .ddl {
            height: 30px;
            width: auto;
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

                            <%--<asp:Button ID="btnSaveAsExcel" runat="server" Text="Save as xls" OnClick="btnSaveAsExcel_Click" CssClass="btn" style="width:80px;margin-right:3px" />--%>
                            <asp:DropDownList ID="SaveFile" runat="server" OnSelectedIndexChanged="SaveFile_SelectedIndexChanged" AutoPostBack="true" CssClass="ddl">
                                <asp:ListItem>Select to save ></asp:ListItem>
                                <asp:ListItem>Save as xls</asp:ListItem>
                                <asp:ListItem>Save as pdf</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="btnDownload" runat="server" Text="Download" OnClick="btnDownload_Click" CssClass="btn" />
                            <asp:Button ID="btnBack" runat="server" Text="Home" OnClick="btnBack_Click" CssClass="btn" />
                        </div>
                    </div>
                </div>
                <div class="main_container">
                    <!-- Updated the gridview elements and sizes to adjust data accordingly on 04202023 by Utpal-->
                    <div class="middleContainer">
                        <div id="PatientData" style="margin-left: -300px; margin-top: 130px; height: 780px; overflow-x: hidden; overflow-y: auto; text-align: center;">
                            <div class="container" id="Container" style="margin-top: -30px;" runat="server" >

                                <asp:GridView ID="grdvRoaster" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeader="true" AutoGenerateColumns="false" EmptyDataText="Oops! No data found.">
                                    <RowStyle BackColor="#EFF3FB" />
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <AlternatingRowStyle BackColor="White" />
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
<script>
    /* Purpose  : This function is used to pin and unpin the blue side bar in dashboard.
     * Params   : N/A
     * Return   : void
     */
    function ChangePin() {
        var pushpin = document.getElementById("pushPinBlock");//.style.transform = 'rotate(-90deg)';
        var sidebar = document.getElementById("sidebar_");//.style.transform = 'rotate(-90deg)';

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

