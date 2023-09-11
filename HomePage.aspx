<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="HomeHealth.HomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Meta tags updated on 16/02/2023 -->
    <meta charset="UTF-8" />
    <meta name="description" content="This is internal website for Vatsal Healthcare solutions." />
    <%--<meta name="keywords" content="Homehealth Vatsal" />--%>
    <meta name="author" content="Vatsal Healthcare Solutions" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Dashboard</title>
     <link rel="icon" type="image/x-icon" href="Assests/Images/favicon.ico" width="80px"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="Assests/CSS/HomeHealthMainCSS.css" rel="stylesheet" type="text/css" />
    <script src="Assests/JavaScript/HomeJS.js" type="text/javascript"></script>

    <%--For Icons--%>
    <script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />

    <!-- Google Fonts-->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&family=Work+Sans:wght@100;300&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Quicksand:wght@300&family=Work+Sans:wght@100;300&display=swap" rel="stylesheet" />

    <!-- For chart -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.umd.min.js"></script>

     <script src="https://code.jquery.com/jquery-3.6.4.min.js" type="text/javascript"></script>
    <%--To use charts in webpage--%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.min.js" integrity="sha512-v3ygConQmvH0QehvQa6gSvTE2VdBZ6wkLOlmK7Mcy2mZ0ZF9saNbbk19QeaoTHdWIEiTlWmrwAL4hS8ElnGFbA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <%--To show values in bars | To show datalabels--%>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0/dist/chartjs-plugin-datalabels.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".hamburger .hamburger__inner").click(function () {
                $(".wrapper").toggleClass("active")
            })

            //$(".top_navbar .fas").click(function () {
            //    $(".profile_dd").toggleClass("active");
            //});
        })

         function ShowGraph(year_ ,insurance_) {

             //let year = document.getElementById('ddlYear').value;
             //let insurance = document.getElementById('ddlInsurance').value;
             // console.log(year + " " + insurance);

            

             $.ajax({
                 type: "POST",
                 url: "HomePage.aspx/GetData",
                 data: '{year: "' + year_ + '",insurance:"' + insurance_ + '"}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccess,
                 failure: function (response) {
                     alert(response.d);
                 },
                 error: function (response) {
                     //alert(resonse.d);
                     alert("Your caught error");
                 }

             });

       

         }

         function OnSuccess(response) {
      
             let myChart = null;
             var active_member = [];
             var new_member = [];
             var disenrolled_member = [];
             var month = [];
             var year = [];
             var disenrolled_analysis = [];
             var insurance = [];
            

             //console.log(response.d);
             var value = response["d"];
             //console.log(value);

             var obj = JSON.parse(value);
             //console.log(obj);

             for (var item in obj) {
                 month.push((obj[item]['Month']));
                 year.push((obj[item]['Year']));
                 disenrolled_analysis.push((obj[item]['DisenrolledAnalysis']));
                 active_member.push((obj[item]['ActivePatient']));
                 new_member.push((obj[item]['NewPatient']));
                 disenrolled_member.push((obj[item]['DisenrolledPatient']));
                 insurance.push((obj[item]['Insurance']));
             }
             //console.log(month)
             //console.log(year)
             //console.log(active_member)
             //console.log(new_member)
             //console.log(disenrolled_member)
             //console.log(disenrolled_analysis)

             document.getElementById('CategoryTitle').innerHTML = "Membership - " + insurance[0];  //+ " " + year[0]

             // Chat section

             const data = {
                 labels: month,
                 datasets: [
                     {
                         label: "Trend",
                         //new option, type will default to bar as that what is used to create the scale
                         type: "line",
                         data: active_member,
                         backgroundColor: '#579BB1',
                         borderColor: '#3A98B9',
                         tension: 0.5,

                     },
                     {
                     label: 'Active Patient',
                     data: active_member,
                     borderWidth: 1,
                         borderColor: '#E5E0FF',
                         backgroundColor: '#E5E0FF',
                 },
                 {
                     label: 'New Patient',
                     data: new_member,
                     borderWidth: 1,
                     borderColor: '#C9F4AA',
                     backgroundColor: '#C9F4AA',
                 },
                 {
                     label: 'Disenrolled Patient',
                     data: disenrolled_member,
                     borderWidth: 1,
                     borderColor: '#F48484',
                     backgroundColor: '#F48484',
                 },
               

                 ]
             };
             const bgColor = {
                 id: 'bgColor',
                 beforeDraw: (chart, options) => {
                     const { ctx, width, height } = chart;
                     ctx.fillStyle = 'white';
                     ctx.fillRect(0, 0, width, height)
                     ctx.restore();
                 }
             }
             
             //Config

             const config = {
                 type: 'bar',
                 data,
                 options: {
                     responsive: true,
                     scales: {
                         x: {
                             stacked: true,
                             title: {
                                 display: true,
                                 text: 'Months of '+year[0] ,
                                 font: {
                                     family: 'Comic Sans MS',
                                     size: 18,
                                     //weight: 'bold',
                                     lineHeight: 1.2
                                 }
                             }
                         },
                         y: {
                             beginAtZero: true,
                             stacked: true,
                             title: {
                                 display: true,
                                 text: 'Membership Counts( in numbers ) ',
                                  font: {
                                     family: 'Comic Sans MS',
                                     size: 18,
                                     //weight: 'bold',
                                     lineHeight: 1.2
                                  }
                             }

                         },
                     },
                         plugins: {
                             //title: {
                             //    display: true,
                             //    text: year[0],
                             //    //color: '#911',
                             //    font: {
                             //        family: 'Comic Sans MS',
                             //        size: 20,
                             //        weight: 'bold',
                             //        lineHeight: 1.2
                             //    }
                             //}
                     },
                     'onClick': (evt, item) => {
                         // console.log('CLICK', item[0]['index']);
                         let html = `<h2 style="font-family: 'Quicksand', sans-serif;color:orangered;align-item:center;">`;
                         if (item[0]['index'] == 0) {
                             // console.log(disenrolled_analysis[0])
                             html += month[0] + ` ` + year[0] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[0] + `<br>New Member: ` + new_member[0] + `<br> Disenrolled Member:` + disenrolled_member[0] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[0]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[0] + `&month=` + month[0] + `&Insurance=` + insurance[0] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 1) {
                             //console.log(disenrolled_analysis[1])
                             html += month[1] + ` ` + year[1] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[1] + `<br>New Member: ` + new_member[1] + `<br> Disenrolled Member:` + disenrolled_member[1] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[1]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[1] + `&month=` + month[1] + `&Insurance=` + insurance[1] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 2) {
                             //console.log(disenrolled_analysis[2])
                             html += month[2] + ` ` + year[2] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[2] + `<br>New Member: ` + new_member[2] + `<br> Disenrolled Member:` + disenrolled_member[2] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[2]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[2] + `&month=` + month[2] + `&Insurance=` + insurance[2] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 3) {
                             //console.log(disenrolled_analysis[2])
                             html += month[3] + ` ` + year[3] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[3] + `<br>New Member: ` + new_member[3] + `<br> Disenrolled Member:` + disenrolled_member[3] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[3]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[3] + `&month=` + month[3] + `&Insurance=` + insurance[3] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 4) {
                             //console.log(disenrolled_analysis[2])
                             html += month[4] + ` ` + year[4] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[4] + `<br>New Member: ` + new_member[4] + `<br> Disenrolled Member:` + disenrolled_member[4] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[4]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[4] + `&month=` + month[4] + `&Insurance=` + insurance[4] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 5) {
                             //console.log(disenrolled_analysis[2])
                             html += month[5] + ` ` + year[5] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[5] + `<br>New Member: ` + new_member[5] + `<br> Disenrolled Member:` + disenrolled_member[5] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[5]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[5] + `&month=` + month[5] + `&Insurance=` + insurance[5] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 6) {
                             //console.log(disenrolled_analysis[2])
                             html += month[6] + ` ` + year[6] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[6] + `<br>New Member: ` + new_member[6] + `<br> Disenrolled Member:` + disenrolled_member[6] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[6]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[6] + `&month=` + month[6] + `&Insurance=` + insurance[6] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 7) {
                             //console.log(disenrolled_analysis[2])
                             html += month[7] + ` ` + year[7] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[7] + `<br>New Member: ` + new_member[7] + `<br> Disenrolled Member:` + disenrolled_member[7] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[7]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[7] + `&month=` + month[7] + `&Insurance=` + insurance[7] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 8) {
                             //console.log(disenrolled_analysis[2])
                             html += month[8] + ` ` + year[8] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[8] + `<br>New Member: ` + new_member[8] + `<br> Disenrolled Member:` + disenrolled_member[8] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[8]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[8] + `&month=` + month[8] + `&Insurance=` + insurance[8] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 9) {
                             //console.log(disenrolled_analysis[2])
                             html += month[9] + ` ` + year[9] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[9] + `<br>New Member: ` + new_member[9] + `<br> Disenrolled Member:` + disenrolled_member[9] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[9]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[9] + `&month=` + month[9] + `&Insurance=` + insurance[9] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 10) {
                             //console.log(disenrolled_analysis[2])
                             html += month[10] + ` ` + year[10] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[10] + `<br>New Member: ` + new_member[10] + `<br> Disenrolled Member:` + disenrolled_member[10] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[10]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[10] + `&month=` + month[10] + `&Insurance=` + insurance[10] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                         else if (item[0]['index'] == 11) {
                             //console.log(disenrolled_analysis[2])
                             html += month[11] + ` ` + year[11] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                             document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[11] + `<br>New Member: ` + new_member[11] + `<br> Disenrolled Member:` + disenrolled_member[11] + ` <br><br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[11]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='RoasterFile.aspx?Year=` + year[11] + `&month=` + month[11] + `&Insurance=` + insurance[11] + `'>here</a>&nbsp;for detailed Membership.`;
                         }
                     }
                 },
                 plugins: [bgColor, ], // ChartDataLabels  -- for counts in bars.
             }

             const context = document.getElementById('myChart').getContext('2d');
             //Init Block
             //var myChart = new Chart();
             //if (myChart != null) {
             //    myChart.destroy();
             //}
             if (Chart.getChart("myChart")) {
                 Chart.getChart("myChart").destroy();
             }
             myChart = new Chart(context, config);
             context.onlick = ClickHandler;

        }
        function ClickHandler(click) {
            const points = myChart.getElementsAtEventForMode(click, 'nearest', { intersect: true }, true);
            alert("Hello");
        }


    </script>
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
                color: #ffff;
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

        p > h3 {
            display: inline-block;
        }

        .chartBox {
            width: 100%;
            height: 100%;
            padding: 15px;
            /*border-radius: 20px;
            border: solid 3px rgba(54, 162, 235, 1);
            background: white;*/
        }

        .lbls {
            font-family: 'Quicksand', sans-serif;
            color: orangered;
            /*margin-top: 100px;*/
            font-size: 20px;
            font-weight: bolder;
            /*padding: 15px;*/
        }

        .lblsText {
            font-family: 'Comic Sans MS';
            color: #808080;
            font-size: 20px;
            /*font-weight: bold;*/
            /*line-height: 1.2;*/
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
                            <center>
                                <div class="secondBar" style="margin-top: 0rem; margin-left: 10rem;">
                                    <center>
                                        <asp:Label ID="lblInsurance" runat="server" Text="Insurance" Font-Bold="false"></asp:Label>
                                        <asp:DropDownList runat="server" ID="ddlInsurance" Style="margin-left: 10px; width: 250px" ToolTip="Select Insurance" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlInsurance_SelectedIndexChanged">

                                            <asp:ListItem Selected="True">Simply</asp:ListItem>
                                            <asp:ListItem>Ambetter</asp:ListItem>
                                            <asp:ListItem>Wellmed</asp:ListItem>
                                        </asp:DropDownList>

                                        &nbsp;
                                          <asp:Label ID="lblYear" runat="server" Text="Year" Font-Bold="false"></asp:Label>
                                        <asp:DropDownList runat="server" ID="ddlYear" Style="margin-left: 10px; width: 100px;" ToolTip="Select Year" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">

                                            <asp:ListItem Value="2023" Selected="True">2023</asp:ListItem>
                                            <asp:ListItem>2022</asp:ListItem>
                                            <asp:ListItem>2021</asp:ListItem>
                                            <asp:ListItem>2020</asp:ListItem>
                                            <%--<asp:ListItem>2020</asp:ListItem>--%>
                                        </asp:DropDownList>
                                         <%--<input id="btnGetData" class="btn" style="width:100px;border-radius:5px;margin-left:6px" type="button" value="Show Graph" onclick="ShowGraph()" />--%>
                                    </center>
                                </div>
                            </center>
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
                        </div>
                    </div>
                </div>
                <div class="main_container" style="margin-top: 4rem">
                    <div id="sidebar_" class="sidebar" style="margin-top: 4rem">
                        <%--<div class="pushPin" id="pushPinBlock" onclick="ChangePin()" style="margin-top: 15px; margin-left: 23px; padding: 5px; background-color: white;">--%>
                        <div class="pushPin" id="pushPinBlock" onclick="ChangePin()" style="padding: 2px; background-color: white;">
                            <asp:Image ID="ImgpushPin" runat="server" ImageUrl="~/Assests/Images/pushPin.svg" Width="15px" Height="15" />
                        </div>
                        <div class="sidebar__inner">

                            <%-- <div class="profile">
                                <div class="img">
                                  <img src="https://i.imgur.com/Ctwf8HA.png" alt="profile_pic">
                                </div>
                                <div class="profile_info">
                                   <p>Welcome</p>
                                   <p class="profile_name">Alex John</p>
                                </div>
                              </div>--%>
                            <ul id="categories">
                                <li>
                                    <span data-flow="right">
                                        <a href="?Category=Membership" id="mem" runat="server" class="active">
                                            <!--class="active"    >>>  to make it active-->
                                            <span class="icon active"><i class="fas fa-border-all"></i></span>
                                            <span class="title" id="membership" runat="server">Membership</span>

                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span data-flow="right">
                                        <a href="?Category=Clinal_Quality" class="" id="hed">

                                            <span class="icon "><i class="fas fa-dice-d6"></i></span>
                                            <span class="title" id="hedis" runat="server">Clinical Quality</span>

                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span data-flow="right">
                                        <a href="?Category=Medical_Risk" class="" id="mr">
                                            <span class="icon"><i class="fab fa-delicious"></i></span>
                                            <span class="title" id="mra" runat="server">Medical Risk</span>

                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span data-flow="right">
                                        <a href="?Category=Utilization" class="" id="util">
                                            <span class="icon"><i class="fab fa-elementor"></i></span>
                                            <span class="title" id="utilization" runat="server">Utilization</span>
                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span data-flow="right">
                                        <a href="?Category=Report" class="" id="repo">
                                            <span class="icon"><i class="fas fa-chart-pie"></i></span>
                                            <span class="title" id="reports" runat="server">Reports</span>
                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span data-flow="right">
                                        <a href="?Category=Help" class="" id="he">
                                            <span class="icon"><i class="fas fa-border-all"></i></span>
                                            <span class="title" id="help" runat="server">Help</span>
                                        </a>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="titleBox"><asp:Label ID="CategoryTitle" runat="server" style="font-family:'Quicksand', sans-serif ;" Font-Bold="true" Text="Membership"></asp:Label></div>
                    <div class="middleContainer">
                        <asp:Label ID="lblData" runat="server" ></asp:Label>
                        <div class="container">
                            <div class="graph">
                                <div class="chartBox">
                                    <canvas id="myChart"></canvas>
                                    <%--<asp:Button runat="server" ID="btnSaveGraph" OnClientClick="printGraph()" style="margin: 30px; padding: 10px; border-radius: 10px;" Text="Export to PDF"/>--%>
                                </div>
                            </div>
                            <div class="analysisReport" >
                                <div id="info"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <%--Middle Items End--%>

            <%--Footer Start--%>
            <footer class="footer" style="margin-top:47px;">
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
    function printGraph() {

        const canvas = document.getElementById('myChart');

        // create image 
        const canvasImage = canvas.toDataURL('image/jpeg', 1.0);
        console.log(canvasImage)

        let pdf = new jsPDF('landscape');
        pdf.setFontSize(16);
        pdf.addImage(canvasImage, 'JPEG', 15, 15, 250, 120);
        //pdf.text(15, 15, "We have discovered that our patients are increasing at slower rate.")
        pdf.save('Graph.pdf');
        /*ShowGraph();*/

    }
</script>
</html>






