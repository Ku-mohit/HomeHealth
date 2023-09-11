<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoasterFile.aspx.cs" Inherits="HomeHealth.Assests.SampleData.RoasterFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Meta tags updated on 16/02/2023 -->
    <meta charset="UTF-8" />
    <meta name="description" content="This is internal website for Vatsal Healthcare solutions." />
    <%--<meta name="keywords" content="Homehealth Vatsal" />--%>
    <meta name="author" content="Vatsal Healthcare Solutions" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />


    <title>Roaster File</title>


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

        //function showactive(numbers) {
        //    //alert(numbers.length);
        //    //alert(numbers1, numbers2, numbers3);
        //    const myArray = numbers.split(" ");
        //    alert("Active : " + myArray);
        //    //alert(myArray.length);
        //}


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
                          
                                <div class="secondBar" style="margin-top: 0rem; margin-left: 10rem; display:flex;justify-content:center">
                                        <asp:Label ID="lblInsurance" runat="server"  Font-Bold="false"></asp:Label>  &nbsp; &nbsp;
                                          <asp:Label ID="lblMonth" runat="server" Font-Bold="false"></asp:Label>  &nbsp; &nbsp;
                                          <asp:Label ID="lblYear" runat="server" Font-Bold="false"></asp:Label>  &nbsp; &nbsp;
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
                            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" CssClass="btn"/>
                        </div>
                    </div>
                </div>
                <div class="main_container">
                    
                    <div class="middleContainer">
                        <div id="PatientData" style="margin-left:-70px;margin-top:130px;height:780px;overflow-x: hidden; overflow-y: auto; text-align: center;" ></div>
                        <div class="container">
                            <%--    <asp:GridView ID="grdvRoaster" runat="server"  CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeader="true">
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
                            </asp:GridView>--%>
                        </div>

                    </div>

                </div>




            </div>
            <%--Middle Items End--%>

            <%--Footer Start--%>
            <footer class="footer" style="margin-top:160px;">
                <center>
                    <nav>
                        <p style="align-content: center; color: white">
                            <%--<a href="#">About Us</a>| 
                            <a href="#">Privacy Policy</a>| 
                            <a href="#">Careers</a>--%>
                        </p>
                    </nav>

                    <p style="align-items: center;">
                        &#169; eHealthcare Registry: All Rights Reservered v 1.1
                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                    </p>
                    <%--<asp:Image ID="Image1" ImageUrl="~/Assests/Images/vector1.png" runat="server" Style="margin-top: -7.5rem; margin-right: -42rem; display: flex; float: right; width: 200px" />--%>
                </center>
            </footer>
            <%--Footer End--%>
        </div>
    </form>
</body>
<script>

    //getData();
    ShowData();
   <%-- chartIt();
    var myChart
    async function chartIt() {
        const data = await getData();
        //const myArray = [10, 36, 25, 48, 32, 6];
        const ctx = document.getElementById('myChart');
        ctx.onclick = clickHandler;
        myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: data.xs,
                datasets: [{
                    label: 'Active Patient',
                    data: data.ActiveP,
                    borderWidth: 1
                },
                {
                    label: 'New Patient',
                    data: data.NewP,
                    borderWidth: 1
                },
                {
                    label: 'Disenrolled Person',
                    data: data.NewP,
                    borderWidth: 1
                },
                {
                    label: 'Trend',
                    data: data.ActiveP,
                    //borderColor: 'rgb(255, 0, 71)',
                    //borderColor: "#084de0",
                    //backgrounColor: "#084de0",
                    tension: 0.4,
                    type: 'line'


                }]
            },
            options: {
                scales: {
                    x: {
                        stacked: true,
                        title: {
                            display: true,
                            text: 'Months of year'
                        }
                    },
                    y: {
                        beginAtZero: true,
                        stacked: true,
                        title: {
                            display: true,
                            text: 'Membership Counts( in numbers ) '
                        }

                    }
                }
            }
        });
    }
    --%>
    async function getData() {
        const MedicareId = [];
        const MedicaidId = [];
        const MemberName= [];
        const Phone= [];
        const DOB= [];
        const PCPStart= [];
        const PCPTerm= [];
        const LastVisit= [];
        const NextVisit = [];

        const params = new Proxy(new URLSearchParams(window.location.search), {
            get: (searchParams, prop) => searchParams.get(prop),
        });
       
        let year = params.Year; // "some_value"
        let month = params.month; // "some_value"
        let insurance = params.Insurance;



        document.getElementById('lblYear').innerHTML = year;
        document.getElementById('lblInsurance').innerHTML = insurance;
        document.getElementById('lblMonth').innerHTML = month;
        document.getElementById('lblCategory').innerHTML = "Membership";

        const response = await fetch('Assests/SampleData/Membership/' + month + year + '.csv');
        //console.log(response);
        const data = await response.text();
        const table = data.split('\n').slice(1);  // instead of zero we can put 1 to leave header.
        table.forEach(row => {
            const columns = row.split(',');
            const medicare_id = columns[0];
            const medicaid_id = columns[1];
            const member_name= columns[2];
            const phone = columns[3];
            const dob = columns[4];
            const pcp_start= columns[5];
            const pcp_term= columns[6];
            const last_visit= columns[7];
            const next_visit = columns[8];
            MedicareId.push(medicare_id);
            //const temp = columns[1];
            //ys.push(temp);
            MedicaidId.push(medicaid_id);
            DOB.push(dob);
            Phone.push(phone);
            PCPStart.push(pcp_start);
            PCPTerm.push(pcp_term);
            LastVisit.push(last_visit);
            NextVisit.push(next_visit);
            MemberName.push(member_name);
            //console.log(month, temp);
        })
        return { MedicareId, MedicaidId, MemberName, Phone, DOB, PCPStart, PCPTerm, LastVisit, NextVisit };
    }
    async function ShowData() {
        const PatientData = await getData()
    
        
        //console.log(PatientData.FirstName);
        var htm = `<table><tr style="top:0;"><th>S.No.</th><th>Medicare ID</th><th>Medicaid ID</th><th>Member Name</th><th>Phone</th><th>DOB</th><th>PCP Start</th><th>PCP Term</th><th>Last Visit</th><th>Next Visit</th><tr>`
        for (let i = 0; i < (PatientData.MemberName).length; i++) {
            htm += `<tr><td>` + (i+1) + `</td><td>` + PatientData.MedicareId[i] + `</td><td>` + PatientData.MedicaidId[i] + `</td><td>` + PatientData.MemberName[i] + `</td><td>` + PatientData.Phone[i] + `</td><td>` + PatientData.DOB[i] + `</td><td>` + PatientData.PCPStart[i] + `</td><td>` + PatientData.PCPTerm[i] + `</td><td>` + PatientData.LastVisit[i] + `</td><td>` + PatientData.NextVisit[i] + `</td></tr>`
        }
        htm += `</table>`;
        document.getElementById("PatientData").innerHTML = htm;
    }

    <%--
    async function clickHandler(click) {
        const points = myChart.getElementsAtEventForMode(click, 'nearest', { intersect: true }, true);
        const PatientData = await getData();
        //console.log(PatientData.DisenrolledA);
        let html = `<h2 style="font-family: 'Quicksand', sans-serif;color:orangered">Analysis Report</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`

        if (points[0].index == '0') {
            //console.log("Hello");
            //console.log(data.ActiveP);
            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;">You are in month of January<br>Active Member:` + PatientData.ActiveP[0] + `<br>New Member: ` + PatientData.NewP[0] + `<br> Disenrolled Member:` + PatientData.DisenrolledPCount[0] + ` <br><b> Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[0]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='` + PatientData.FilePath + `'>here</a>&nbsp;for more information.`;
        }
        else if (points[0].index == '1') {
            //console.log('Hi Good Morning');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of February <br>Active Member: ` + PatientData.ActiveP[1] + `<br>New Member:` + PatientData.NewP[1] + ` <br> Disenrolled Member:  ` + PatientData.DisenrolledPCount[1] + `<br><b> Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[1]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '2') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of March<br>Active Member:` + PatientData.ActiveP[2] + ` <br>New Member:` + PatientData.NewP[2] + ` <br>Disenrolled Member: ` + PatientData.DisenrolledPCount[2] + ` <br> <b> Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[2]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '3') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of April<br>Active Member: ` + PatientData.ActiveP[3] + `<br>New Member: ` + PatientData.NewP[3] + `<br>Disenrolled Member: ` + PatientData.DisenrolledPCount[3] + ` <br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[3]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '4') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of May<br>Active Member: ` + PatientData.ActiveP[4] + `<br>New Member: ` + PatientData.NewP[4] + `<br>Disenrolled Member:  ` + PatientData.DisenrolledPCount[4] + `<br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[4]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '5') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of June<br>Active Member:` + PatientData.ActiveP[5] + ` <br>New Member:` + PatientData.NewP[5] + ` <br>Disenrolled Member: ` + PatientData.DisenrolledPCount[5] + ` <br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[5]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '6') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of July<br>Active Member:` + PatientData.ActiveP[6] + ` <br>New Member:` + PatientData.NewP[6] + ` <br>Disenrolled Member: ` + PatientData.DisenrolledPCount[6] + ` <br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[6]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '7') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of August <br>Active Member:` + PatientData.ActiveP[7] + ` <br>New Member:` + PatientData.NewP[7] + ` <br>Disenrolled Member:  ` + PatientData.DisenrolledPCount[7] + `<br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[7]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '8') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of September <br>Active Member:` + PatientData.ActiveP[8] + ` <br>New Member:` + PatientData.NewP[8] + ` <br>Disenrolled Member:  ` + PatientData.DisenrolledPCount[8] + `<br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[8]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '9') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of October<br>Active Member:` + PatientData.ActiveP[9] + ` <br>New Member:` + PatientData.NewP[9] + ` <br>Disenrolled Member:  ` + PatientData.DisenrolledPCount[9] + `<br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[9]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '10') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of November <br>Active Member:` + PatientData.ActiveP[10] + ` <br>New Member:` + PatientData.NewP[10] + ` <br>Disenrolled Member:  ` + PatientData.DisenrolledPCount[10] + `<br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[10]).replaceAll(";", "<br/>") + `</p>`;
        }
        else if (points[0].index == '11') {
            //console.log('Hi Good Afternon');
            document.getElementById("info").innerHTML = html + ` <br><p style="font-family: 'Quicksand', sans-serif;">You are in month of December <br>Active Member:` + PatientData.ActiveP[11] + ` <br>New Member:` + PatientData.NewP[11] + ` <br>Disenrolled Member:  ` + PatientData.DisenrolledPCount[11] + `<br> <b>Disenrolled Analysis</b><br/>` + (PatientData.DisenrolledA[11]).replaceAll(";", "<br/>") + `</p>`;
        }
    }--%>



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
