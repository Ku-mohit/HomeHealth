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
    <link rel="icon" type="image/x-icon" href="Assests/Images/favicon.ico" width="80px" />
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

        function ShowMembershipGraph(year_, insurance_) {


            $.ajax({
                type: "POST",
                url: "HomePage.aspx/GetMembershipData",
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

            document.getElementById('CategoryTitle').innerHTML = "Membership - " + insurance[0] + " ( Year " + year[0] + " )";  //+ " " + year[0]

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
                                text: 'Months ( ' + year[0] + ' )',
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
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[0] + `<br>New Member: ` + new_member[0] + `<br> Disenrolled Member:` + disenrolled_member[0] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[0]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[0] + `&month=` + month[0] + `&Insurance=` + insurance[0] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 1) {
                            //console.log(disenrolled_analysis[1])
                            html += month[1] + ` ` + year[1] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[1] + `<br>New Member: ` + new_member[1] + `<br> Disenrolled Member:` + disenrolled_member[1] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[1]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[1] + `&month=` + month[1] + `&Insurance=` + insurance[1] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 2) {
                            //console.log(disenrolled_analysis[2])
                            html += month[2] + ` ` + year[2] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[2] + `<br>New Member: ` + new_member[2] + `<br> Disenrolled Member:` + disenrolled_member[2] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[2]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[2] + `&month=` + month[2] + `&Insurance=` + insurance[2] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 3) {
                            //console.log(disenrolled_analysis[2])
                            html += month[3] + ` ` + year[3] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[3] + `<br>New Member: ` + new_member[3] + `<br> Disenrolled Member:` + disenrolled_member[3] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[3]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[3] + `&month=` + month[3] + `&Insurance=` + insurance[3] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 4) {
                            //console.log(disenrolled_analysis[2])
                            html += month[4] + ` ` + year[4] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[4] + `<br>New Member: ` + new_member[4] + `<br> Disenrolled Member:` + disenrolled_member[4] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[4]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[4] + `&month=` + month[4] + `&Insurance=` + insurance[4] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 5) {
                            //console.log(disenrolled_analysis[2])
                            html += month[5] + ` ` + year[5] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[5] + `<br>New Member: ` + new_member[5] + `<br> Disenrolled Member:` + disenrolled_member[5] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[5]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[5] + `&month=` + month[5] + `&Insurance=` + insurance[5] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 6) {
                            //console.log(disenrolled_analysis[2])
                            html += month[6] + ` ` + year[6] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[6] + `<br>New Member: ` + new_member[6] + `<br> Disenrolled Member:` + disenrolled_member[6] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[6]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[6] + `&month=` + month[6] + `&Insurance=` + insurance[6] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 7) {
                            //console.log(disenrolled_analysis[2])
                            html += month[7] + ` ` + year[7] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[7] + `<br>New Member: ` + new_member[7] + `<br> Disenrolled Member:` + disenrolled_member[7] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[7]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[7] + `&month=` + month[7] + `&Insurance=` + insurance[7] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 8) {
                            //console.log(disenrolled_analysis[2])
                            html += month[8] + ` ` + year[8] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[8] + `<br>New Member: ` + new_member[8] + `<br> Disenrolled Member:` + disenrolled_member[8] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[8]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[8] + `&month=` + month[8] + `&Insurance=` + insurance[8] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 9) {
                            //console.log(disenrolled_analysis[2])
                            html += month[9] + ` ` + year[9] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[9] + `<br>New Member: ` + new_member[9] + `<br> Disenrolled Member:` + disenrolled_member[9] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[9]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[9] + `&month=` + month[9] + `&Insurance=` + insurance[9] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 10) {
                            //console.log(disenrolled_analysis[2])
                            html += month[10] + ` ` + year[10] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[10] + `<br>New Member: ` + new_member[10] + `<br> Disenrolled Member:` + disenrolled_member[10] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[10]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[10] + `&month=` + month[10] + `&Insurance=` + insurance[10] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                        else if (item[0]['index'] == 11) {
                            //console.log(disenrolled_analysis[2])
                            html += month[11] + ` ` + year[11] + ` Membership Analysis</h2><br><P style="font-family: 'Quicksand', sans-serif;font-size:18px">Active member of current month = Active member of previous month + New members of current month - Disenrolled of previoius month.</p>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">Active Member:` + active_member[11] + `<br>New Member: ` + new_member[11] + `<br> Disenrolled Member:` + disenrolled_member[11] + ` <br><b> Disenrolled Analysis</b><br/>` + (disenrolled_analysis[11]).replaceAll(";", "<br/>") + `</p><br/>` + `Click <a href='NewRoasterPage.aspx?Year=` + year[11] + `&month=` + month[11] + `&Insurance=` + insurance[11] + `'>here</a>&nbsp;for detailed Membership.`;
                        }
                    }
                },
                plugins: [bgColor, ChartDataLabels], // ChartDataLabels  -- for counts in bars.
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
            //context.onlick = ClickHandler;

        }


        function ShowUtilizationCostGraph(insurance_, year_,) {

            $.ajax({
                type: "POST",
                url: "HomePage.aspx/GetUtilizationCostData",
                //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
                data: '{insurance: "' + insurance_ + '",year:"' + year_ + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnUtilizationCostSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    //alert(resonse.d);
                    alert("You caught error");
                }

            });
        }

        function OnUtilizationCostSuccess(response) {

            let myChart = null;
            var month = [];
            var year = [];
            var membership_count = [];
            var total_revenue = [];
            var total_cost = [];
            var total_cost_with_ibnr = [];
            var partA_cost = [];
            var partB_cost = [];
            var partD_cost = [];
            var ancilliary = [];
            var dental = [];
            var otc = [];
            var other = [];
            var new_other_total = [];


            //console.log(response.d);
            var value = response["d"];
            //console.log(value);

            var obj = JSON.parse(value);
            // console.log(obj);

            for (var item in obj) {
                month.push((obj[item]['Month']));
                year.push((obj[item]['Year']));
                membership_count.push((obj[item]['MembershipCount']));
                total_revenue.push((obj[item]['TotalRevenue']));
                total_cost.push((obj[item]['TotalCost']));
                total_cost_with_ibnr.push((obj[item]['TotalCost_with_IBNR']));
                partA_cost.push((obj[item]['PartA_Cost']));
                partB_cost.push((obj[item]['PartB_Cost']));
                partD_cost.push((obj[item]['PartD_Cost']));
                ancilliary.push((obj[item]['Ancilliary']));
                dental.push((obj[item]['Dental']));
                otc.push((obj[item]['OTC']));
                other.push((obj[item]['Other']));
            }
            //console.log(month)
            //console.log(year)
            //console.log(membership_count)
            //console.log(total_revenue)
            //console.log(total_cost)
            //console.log(total_cost_with_ibnr)
            //console.log(partA_cost)
            //console.log(partB_cost)
            //console.log(partD_cost)
            //console.log(ancilliary)
            //console.log(dental)
            //console.log(otc)
            //console.log(other)

            for (var i = 0; i < month.length; i++) {
                new_other_total.push(parseInt(ancilliary[i]) + parseInt(dental[i]) + parseInt(otc[i]) + parseInt(other[i]))
            }
            // console.log(new_other_total)

            //document.getElementById('CategoryTitle').innerHTML = "Membership - " + insurance[0] + " ( Year " + year[0] + " )";  //+ " " + year[0]

            // Chat section

            const data = {
                labels: month,
                datasets: [
                    //{
                    //    label: "Trend",
                    //    //new option, type will default to bar as that what is used to create the scale
                    //    type: "line",
                    //    data: membership_count,
                    //    backgroundColor: '#579BB1',
                    //    borderColor: '#3A98B9',
                    //    tension: 0.5,

                    //},
                    //{
                    //    label: 'Membership Count',
                    //    data: membership_count,
                    //    borderWidth: 1,
                    //    borderColor: '#E5E0FF',
                    //    backgroundColor: '#E5E0FF',
                    //},

                    //{
                    //    label: 'Total Cost',
                    //    data: total_cost,
                    //    borderWidth: 1,
                    //    borderColor: '#F48484',
                    //    backgroundColor: '#F48484',
                    //},
                    //{
                    //    label: 'Total Cost with IBNR',
                    //    data: total_cost_with_ibnr,
                    //    borderWidth: 1,
                    //    borderColor: '#BACDDB',
                    //    backgroundColor: '#BACDDB',
                    //},
                    {
                        label: 'Part-A Cost Trend',
                        type: 'line',
                        tension: 0.4,
                        data: partA_cost,
                        borderWidth: 1,
                        borderColor: '#010104',
                        backgroundColor: '#010104',
                       // stack: 'Stack 0',
                    },
                    {
                        label: 'Part-A Cost',
                        data: partA_cost,
                        borderWidth: 1,
                        borderColor: '#D5B4B4',
                        backgroundColor: '#D5B4B4',
                        stack: 'Stack 0',
                    },
                    {
                        label: 'Part-B Cost',
                        data: partB_cost,
                        borderWidth: 1,
                        borderColor: '#FAEDCD',
                        backgroundColor: '#FAEDCD',
                        stack: 'Stack 0',
                    },
                    {
                        label: 'Part-D Cost',
                        data: partD_cost,
                        borderWidth: 1,
                        borderColor: '#A084DC',
                        backgroundColor: '#A084DC',
                        stack: 'Stack 0',
                    },
                    {
                        label: 'Total Revenue ',
                        //type: 'line',
                       // tension: 0.4,
                        data: total_revenue,
                        borderWidth: 1,
                        borderColor: "#F7D060",
                        backgroundColor: "#F7D060",
                        stack: 'Stack 1',
                    },
                    {
                        label: 'Other',
                        data: new_other_total,
                        borderWidth: 1,
                        borderColor: '#579BB1',
                        backgroundColor: '#579BB1',
                        stack: 'Stack 0',
                    },
                    //{
                    //    label: 'Total Revenue',
                    //    data: total_revenue,
                    //    borderWidth: 1,
                    //    borderColor: '#C9F4AA',
                    //    backgroundColor: '#C9F4AA',
                    //},
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
            const actions = [
                {
                    name: 'Randomize',
                    handler(chart) {
                        chart.data.datasets.forEach(dataset => {
                            dataset.data = Utils.numbers({ count: chart.data.labels.length, min: 0, max: 100 });
                        });
                        chart.update();
                    }
                },
            ];

            ////Config

            const config = {
                type: 'bar',
                data,
                options: {
                    locale: 'en-US',
                    responsive: true,
                    interaction: {
                        intersect:false,
                    },
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Months ( ' + year[0] + ' )',
                                font: {
                                    family: 'Comic Sans MS',
                                    size: 18,
                                    //weight: 'bold',
                                    lineHeight: 1.2
                                }
                            }
                        },
                        y: {
                            ticks: {
                                callback: (value, index, values) => {
                                    return new Intl.NumberFormat('en-US', {
                                        style: 'currency',
                                        currency: 'USD',
                                        maximumSignificantDigits: 3
                                    }).format(value);
                                }
                            },
                            beginAtZero: true,
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Utilization', //( in dollers ) 
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
                        let html = `<h2 style="font-family: 'Quicksand', sans-serif;color:orangered;display:flex;justify-content:center;">`;
                        if (item[0]['index'] == 0) {
                            // console.log(disenrolled_analysis[0])
                            let other_ = parseInt(ancilliary[0]) + parseInt(dental[0]) + parseInt(otc[0]) + parseInt(other[0]);
                            let total_ = parseInt(partA_cost[0]) + parseInt(partA_cost[0]) + parseInt(partD_cost[0]) + parseInt(ancilliary[0]) + parseInt(dental[0]) + parseInt(otc[0]) + parseInt(other[0]);
                            html += month[0] + ` ` + year[0] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[0] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[0] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[0] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 1) {
                            //console.log(disenrolled_analysis[1])
                            let other_ = parseInt(ancilliary[1]) + parseInt(dental[1]) + parseInt(otc[1]) + parseInt(other[1]);
                            let total_ = parseInt(partA_cost[1]) + parseInt(partA_cost[1]) + parseInt(partD_cost[1]) + parseInt(ancilliary[1]) + parseInt(dental[1]) + parseInt(otc[1]) + parseInt(other[1]);
                            html += month[1] + ` ` + year[1] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[1] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[1] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[1] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 2) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[2]) + parseInt(dental[2]) + parseInt(otc[2]) + parseInt(other[2]);
                            let total_ = parseInt(partA_cost[2]) + parseInt(partA_cost[2]) + parseInt(partD_cost[2]) + parseInt(ancilliary[2]) + parseInt(dental[2]) + parseInt(otc[2]) + parseInt(other[2]);
                            html += month[2] + ` ` + year[2] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[2] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[2] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[2] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 3) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[3]) + parseInt(dental[3]) + parseInt(otc[3]) + parseInt(other[3]);
                            let total_ = parseInt(partA_cost[3]) + parseInt(partA_cost[3]) + parseInt(partD_cost[3]) + parseInt(ancilliary[3]) + parseInt(dental[3]) + parseInt(otc[3]) + parseInt(other[3]);
                            html += month[3] + ` ` + year[3] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[3] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[3] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[3] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 4) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[4]) + parseInt(dental[4]) + parseInt(otc[4]) + parseInt(other[4]);
                            let total_ = parseInt(partA_cost[4]) + parseInt(partA_cost[4]) + parseInt(partD_cost[4]) + parseInt(ancilliary[4]) + parseInt(dental[4]) + parseInt(otc[4]) + parseInt(other[4]);
                            html += month[4] + ` ` + year[4] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[4] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D">Type</th>
                                        <th style=" background-color:#00509D">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[4] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[4] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 5) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[5]) + parseInt(dental[5]) + parseInt(otc[5]) + parseInt(other[5]);
                            let total_ = parseInt(partA_cost[5]) + parseInt(partA_cost[5]) + parseInt(partD_cost[5]) + parseInt(ancilliary[5]) + parseInt(dental[5]) + parseInt(otc[5]) + parseInt(other[5]);
                            html += month[5] + ` ` + year[5] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[5] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[5] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[5] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 6) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[6]) + parseInt(dental[6]) + parseInt(otc[6]) + parseInt(other[6]);
                            let total_ = parseInt(partA_cost[6]) + parseInt(partA_cost[6]) + parseInt(partD_cost[6]) + parseInt(ancilliary[6]) + parseInt(dental[6]) + parseInt(otc[6]) + parseInt(other[6]);
                            html += month[6] + ` ` + year[6] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[6] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[6] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[6] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 7) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[7]) + parseInt(dental[7]) + parseInt(otc[7]) + parseInt(other[7]);
                            let total_ = parseInt(partA_cost[7]) + parseInt(partA_cost[7]) + parseInt(partD_cost[7]) + parseInt(ancilliary[7]) + parseInt(dental[7]) + parseInt(otc[7]) + parseInt(other[7]);
                            html += month[7] + ` ` + year[7] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[7] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[7] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[7] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 8) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[8]) + parseInt(dental[8]) + parseInt(otc[8]) + parseInt(other[8]);
                            let total_ = parseInt(partA_cost[8]) + parseInt(partA_cost[8]) + parseInt(partD_cost[8]) + parseInt(ancilliary[8]) + parseInt(dental[8]) + parseInt(otc[8]) + parseInt(other[8]);
                            html += month[8] + ` ` + year[8] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[8] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[8] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[8] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 9) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[9]) + parseInt(dental[9]) + parseInt(otc[9]) + parseInt(other[9]);
                            let total_ = parseInt(partA_cost[9]) + parseInt(partA_cost[9]) + parseInt(partD_cost[9]) + parseInt(ancilliary[9]) + parseInt(dental[9]) + parseInt(otc[9]) + parseInt(other[9]);
                            html += month[9] + ` ` + year[9] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[9] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[9] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[9] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 10) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[10]) + parseInt(dental[10]) + parseInt(otc[10]) + parseInt(other[10]);
                            let total_ = parseInt(partA_cost[10]) + parseInt(partA_cost[10]) + parseInt(partD_cost[10]) + parseInt(ancilliary[10]) + parseInt(dental[10]) + parseInt(otc[10]) + parseInt(other[10]);
                            html += month[10] + ` ` + year[10] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[10] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[10] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[10] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                        else if (item[0]['index'] == 11) {
                            //console.log(disenrolled_analysis[2])
                            let other_ = parseInt(ancilliary[11]) + parseInt(dental[11]) + parseInt(otc[11]) + parseInt(other[11]);
                            let total_ = parseInt(partA_cost[11]) + parseInt(partA_cost[11]) + parseInt(partD_cost[11]) + parseInt(ancilliary[11]) + parseInt(dental[11]) + parseInt(otc[11]) + parseInt(other[11]);
                            html += month[11] + ` ` + year[11] + ` Utilization Analysis</h2><br><table><tr ><td style:"font-size:18px">Membership Count</td><td style:"font-size:18px">` + membership_count[11] + `</td> </tr></table>`;
                            document.getElementById("info").innerHTML = html + `<br><p style="font-family: 'Quicksand', sans-serif;font-size:16px;">
                                  <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Type</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Part A </td>
                                        <td style="text-align:center" > $`+ partA_cost[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part B</td>
                                        <td style="text-align:center" > $`+ partB_cost[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Part D</td>
                                       <td style="text-align:center" > $`+ partD_cost[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Total</td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ total_ + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black">Revenue</td>
                                      <td style="text-align:center;border-bottom:1px solid black"> $`+ total_revenue[11] + `</td>
                                    </tr>
                                </table>
                                <br><br>Other includes following items.<br><br>
                                <table>
                                    <tr>
                                        <th style=" background-color:#00509D;color:#fff">Other</th>
                                        <th style=" background-color:#00509D;color:#fff">Cost</th>
                                    </tr>

                                    <tr>
                                        <td style="text-align:center" >Ancilliary </td>
                                        <td style="text-align:center" > $`+ ancilliary[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >Dental</td>
                                        <td style="text-align:center" > $`+ dental[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center" >OTC</td>
                                       <td style="text-align:center" > $`+ otc[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black" >Other</td>
                                       <td style="text-align:center;border-bottom:1px solid black" > $`+ other[11] + `</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border-bottom:1px solid black"> </td>
                                        <td style="text-align:center;border-bottom:1px solid black"> $`+ other_ + `</td>
                                    </tr><table>`;
                        }
                    }
                },
                plugins: [bgColor,], // ChartDataLabels  -- for counts in bars.
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
            //context.onlick = ClickHandler;

        }
        function ShowUtilizationMLRGraph(insurance_, year_,) {

            $.ajax({
                type: "POST",
                url: "HomePage.aspx/GetUtilizationMLRData",
                //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
                data: '{insurance: "' + insurance_ + '",year:"' + year_ + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnUtilizationMLRSuccess,
                failure: function (response) {
                    console.log(response.d)
                },
                error: function (response) {
                    //alert(resonse.d);
                    alert("You caught error");
                }

            });
        }
        function OnUtilizationMLRSuccess(response) {

            let myChart = null;
            var month = [];
            var year = [];
            var mlr = [];
            //var membership_count = [];
            //var total_revenue = [];
            //var total_cost = [];
            //var total_cost_with_ibnr = [];
            //var partA_cost = [];
            //var partB_cost = [];
            //var partD_cost = [];
            //var ancilliary = [];
            //var dental = [];
            //var otc = [];
            //var other = [];
            //var new_other_total = [];
            //console.log(response.d);
            var value = response["d"];
            //console.log(value);

            var obj = JSON.parse(value);
            // console.log(obj);

            for (var item in obj) {
                month.push((obj[item]['Month']));
                year.push((obj[item]['Year']));
                mlr.push((obj[item]['MLR']));
                //membership_count.push((obj[item]['MembershipCount']));
                //total_revenue.push((obj[item]['TotalRevenue']));
                //total_cost.push((obj[item]['TotalCost']));
                //total_cost_with_ibnr.push((obj[item]['TotalCost_with_IBNR']));
                //partA_cost.push((obj[item]['PartA_Cost']));
                //partB_cost.push((obj[item]['PartB_Cost']));
                //partD_cost.push((obj[item]['PartD_Cost']));
                //ancilliary.push((obj[item]['Ancilliary']));
                //dental.push((obj[item]['Dental']));
                //otc.push((obj[item]['OTC']));
                //other.push((obj[item]['Other']));
            }
            //console.log(month)
            //console.log(year)
            //console.log(mlr)
            //console.log(membership_count)
            //console.log(total_revenue)
            //console.log(total_cost)
            //console.log(total_cost_with_ibnr)
            //console.log(partA_cost)
            //console.log(partB_cost)
            //console.log(partD_cost)
            //console.log(ancilliary)
            //console.log(dental)
            //console.log(otc)
            //console.log(other)


            // Chat section

            const data = {
                labels: month,
                datasets: [

                    {
                        label: 'MLR Trend',
                        type: 'line',
                        tension: 0.4,
                        data: mlr,
                        borderWidth: 1,
                        borderColor: '#070A52',
                        backgroundColor: '#070A52',
                    },
                    {
                        label: 'MLR',
                        data: mlr,
                        borderWidth: 1,
                        borderColor: '#FA9884',
                        backgroundColor: '#FA9884',
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
                    locale: 'en-US',
                    responsive: true,
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Months ( ' + year[0] + ' )',
                                font: {
                                    family: 'Comic Sans MS',
                                    size: 18,
                                    //weight: 'bold',
                                    lineHeight: 1.2
                                }
                            }
                        },
                        y: {
                            //ticks: {
                            //    callback: (value, index, values) => {
                            //        return new Intl.NumberFormat('en-US', {
                            //            style: 'currency',
                            //            currency: 'USD',
                            //            maximumSignificantDigits: 3
                            //        }).format(value);
                            //    }
                            //},
                            beginAtZero: true,
                            stacked: true,
                            title: {
                                display: true,
                                text: 'MLR (in percentage %)', //( in dollers ) 
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
                        let html = `<h2 style="font-family: 'Quicksand', sans-serif;color:orangered;display:flex;justify-content:center;">`;
                        if (item[0]['index'] == 0) {
                            html += month[0] + ` ` + year[0] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[0] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[0] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[0] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 1) {
                            html += month[1] + ` ` + year[1] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[1] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[1] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[1] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 2) {
                            html += month[2] + ` ` + year[2] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[2] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[2] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[2] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 3) {
                            html += month[3] + ` ` + year[3] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[3] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[3] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[3] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 4) {
                            html += month[4] + ` ` + year[4] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[4] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[4] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[4] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 5) {
                            html += month[5] + ` ` + year[5] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[5] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[5] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[5] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 6) {
                            html += month[6] + ` ` + year[6] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[6] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[6] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[6] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 7) {
                            html += month[7] + ` ` + year[7] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[7] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[7] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[7] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 8) {
                            html += month[8] + ` ` + year[8] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[8] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[8] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[8] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 9) {
                            html += month[9] + ` ` + year[9] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[9] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[9] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[9] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 10) {
                            html += month[10] + ` ` + year[10] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[10] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[10] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[10] + `</td>
                                </tr>
                            </table>`;
                        }
                        else if (item[0]['index'] == 11) {
                            html += month[11] + ` ` + year[11] + ` Utilization MLR  Analysis</h2><br>`;
                            document.getElementById("info").innerHTML = html + `<br>
                            <table>
                                <tr>
                                    <th style="text-align:center; background-color:#00509D;color:#fff">Item</th>
                                    <th style=" text-align:center;background-color:#00509D;color:#fff">Value</th>
                                </tr>
                                <tr>
                                    <td style="text-align:center">Year</td>
                                    <td style="text-align:center">`+ year[11] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black;">Month</td>
                                    <td style="text-align:center;border-bottom:1px solid black;">`+ month[11] + `</td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;border-bottom:1px solid black">MLR (in percent)</td>
                                    <td style="text-align:center;border-bottom:1px solid black">`+ mlr[11] + `</td>
                                </tr>
                            </table>`;
                        }
                    }
                },
                plugins: [bgColor,], // ChartDataLabels  -- for counts in bars.
            }
            const context = document.getElementById('myChart').getContext('2d');
            //Init Block

            if (Chart.getChart("myChart")) {
                Chart.getChart("myChart").destroy();
            }
            myChart = new Chart(context, config);

        }
        function ShowClinicalQualityLabs_Vital_Graph(insurance_, year_, category_) {
            
            //let category_ = "Labs/Vitals";
            $.ajax({
                type: "POST",
                url: "HomePage.aspx/GetClinicalQualityData_Category_Graph",
                //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
                data: '{insurance:"' + insurance_ + '",year:"' + year_ + '",category:"' + category_ + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnClinicalQuality_Labs_VitalSuccess,
                failure: function (response) {
                    console.log(response.d)
                },
                error: function (response) {
                    //alert(resonse.d);
                    alert("You caught error");
                }

            });
        }
        function OnClinicalQuality_Labs_VitalSuccess(response) {
            let myChart = null;
            var month = [];
            var year = [];
            var missing_patient = [];
            var total = [];
            var completed= [];
            var description = [];
            var category = [];
            var measure = [];

            var value = response["d"];
            //console.log(value);

            var obj = JSON.parse(value);
            //console.log(obj);

            for (var item in obj) {
                year.push(obj[item]["Year"]);
                month.push(obj[item]["Month"]);

                missing_patient.push(obj[item]["MissingPatient"]);
                total.push(obj[item]["Total"]);
                description.push(obj[item]["Description"]);
                category.push(obj[item]["Category"]);
                measure.push(obj[item]["Measure"]);

            }
            //let len = parseInt(total.length)
            //console.log(len)
            for (let i = 0; i < total.length; i++) {
                //console.log(total[i])
                //console.log(missing_patient[i])
                completed.push(parseInt(total[i]) - parseInt(missing_patient[i]));
            }
           

            // Chart section

            const data = {
                labels: measure,
                datasets: [
                    {
                        label: 'Missing(Non- Compliant) Patient',
                        data: missing_patient,
                        borderWidth: 1,
                        borderColor: '#070A52',
                        backgroundColor: '#070A52',
                    },
                    {
                        label: 'Compliant Patient',
                        //data: total,
                        data: completed, //Updated on 05/26/2023 to show completed 
                        borderWidth: 1,
                        borderColor: '#FA9884',
                        backgroundColor: '#FA9884',
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
            //topLabels plugin block
            const topLabels = {
                id: 'topLabels',
                afterDatasetsDraw(chart, args, pluginOptions) {
                    const { ctx, scales: { x, y } } = chart;

                    chart.data.datasets[0].data.forEach((datapoint, index) => {
                        const datasetArray = [];
                        chart.data.datasets.forEach((dataset) => {
                            datasetArray.push(dataset.data[index])
                        })
                        //console.log(datasetArray)
                        function totalSum(total, values) {
                            return total + values;
                        };
                        let sum = datasetArray.reduce(totalSum, 0);
                        //console.log(sum)
                        ctx.textAlign = 'center';
                        ctx.style = 'rgba(130, 10, 104, 1)';
                        ctx.font = 'bold 12px sans-sarif';
                        ctx.fillStyle = 'black';
                        ctx.fillText(sum, x.getPixelForValue(index), chart.getDatasetMeta(1).data[index].y - 10);
                        //added for testing 
                       
                        
                    })
                }
            }

            //Config

            const config = {
                type: 'bar',
                data,
                options: {
                    locale: 'en-US',
                    responsive: true,
                    scales: {
                        x: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Measure',
                                font: {
                                    family: 'Comic Sans MS',
                                    size: 18,
                                    //weight: 'bold',
                                    lineHeight: 1.2
                                }
                            }
                        },
                        y: {
                            //ticks: {
                            //    callback: (value, index, values) => {
                            //        return new Intl.NumberFormat('en-US', {
                            //            style: 'currency',
                            //            currency: 'USD',
                            //            maximumSignificantDigits: 3
                            //        }).format(value);
                            //    }
                            //},
                            beginAtZero: true,
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Count (in numbers)', //( in dollers ) 
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
                },
               // plugins: [bgColor, topLabels, ChartDataLabels], // ChartDataLabels  -- for counts in bars.
                plugins: [topLabels, ChartDataLabels, bgColor], // ChartDataLabels  -- for counts in bars.
            }
            const context = document.getElementById('myChart').getContext('2d');
            //Init Block

            if (Chart.getChart("myChart")) {
                Chart.getChart("myChart").destroy();
            }
            myChart = new Chart(context, config);

        }
        //function ShowClinicalQuality_Medication_Graph(insurance_, year_,) {

        //    let category_ = "Medication Related";
        //    $.ajax({
        //        type: "POST",
        //        url: "HomePage.aspx/GetClinicalQualityData_Category_Graph",
        //        //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
        //        data: '{insurance: "' + insurance_ + '",year:"' + year_ + '",category:"' + category_ + '"}',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: OnClinicalQuality_MedicationSuccess,
        //        failure: function (response) {
        //            console.log(response.d)
        //        },
        //        error: function (response) {
        //            //alert(resonse.d);
        //            alert("You caught error");
        //        }

        //    });
        //}
        //function OnClinicalQuality_MedicationSuccess(response) {
        //    let myChart = null;
        //    var month = [];
        //    var year = [];
        //    var missing_patient = [];
        //    var total = [];
        //    var description = [];
        //    var category = [];
        //    var measure = [];

        //    var value = response["d"];
        //    //console.log(value);

        //    var obj = JSON.parse(value);
        //    //console.log(obj);

        //    for (var item in obj) {
        //        year.push(obj[item]["Year"]);
        //        month.push(obj[item]["Month"]);

        //        missing_patient.push(obj[item]["MissingPatient"]);
        //        total.push(obj[item]["Total"]);
        //        description.push(obj[item]["Description"]);
        //        category.push(obj[item]["Category"]);
        //        measure.push(obj[item]["Measure"]);

        //    }
        //    //console.log(year)
        //    //console.log(missing_patient)
        //    //console.log(total)
        //    //console.log(description)
        //    //console.log(category)

        //    // Chat section

        //    const data = {
        //        labels: measure,
        //        datasets: [
        //            {
        //                label: 'Missing Patient',
        //                data: missing_patient,
        //                borderWidth: 1,
        //                borderColor: '#070A52',
        //                backgroundColor: '#070A52',
        //            },
        //            {
        //                label: 'Total Patient',
        //                data: total,
        //                borderWidth: 1,
        //                borderColor: '#FA9884',
        //                backgroundColor: '#FA9884',
        //            },

        //        ]
        //    };
        //    const bgColor = {
        //        id: 'bgColor',
        //        beforeDraw: (chart, options) => {
        //            const { ctx, width, height } = chart;
        //            ctx.fillStyle = 'white';
        //            ctx.fillRect(0, 0, width, height)
        //            ctx.restore();
        //        }
        //    }

        //    //Config

        //    const config = {
        //        type: 'bar',
        //        data,
        //        options: {
        //            locale: 'en-US',
        //            responsive: true,
        //            scales: {
        //                x: {
        //                    stacked: true,
        //                    title: {
        //                        display: true,
        //                        text: 'Months ( ' + year[0] + ' )',
        //                        font: {
        //                            family: 'Comic Sans MS',
        //                            size: 18,
        //                            //weight: 'bold',
        //                            lineHeight: 1.2
        //                        }
        //                    }
        //                },
        //                y: {
        //                    //ticks: {
        //                    //    callback: (value, index, values) => {
        //                    //        return new Intl.NumberFormat('en-US', {
        //                    //            style: 'currency',
        //                    //            currency: 'USD',
        //                    //            maximumSignificantDigits: 3
        //                    //        }).format(value);
        //                    //    }
        //                    //},
        //                    beginAtZero: true,
        //                    stacked: true,
        //                    title: {
        //                        display: true,
        //                        text: 'Count (in numbers)', //( in dollers ) 
        //                        font: {
        //                            family: 'Comic Sans MS',
        //                            size: 18,
        //                            //weight: 'bold',
        //                            lineHeight: 1.2
        //                        }
        //                    }

        //                },
        //            },
        //            plugins: {
        //                //title: {
        //                //    display: true,
        //                //    text: year[0],
        //                //    //color: '#911',
        //                //    font: {
        //                //        family: 'Comic Sans MS',
        //                //        size: 20,
        //                //        weight: 'bold',
        //                //        lineHeight: 1.2
        //                //    }
        //                //}
        //            },
        //        },
        //        plugins: [bgColor, ChartDataLabels], // ChartDataLabels  -- for counts in bars.
        //    }
        //    const context = document.getElementById('myChart').getContext('2d');
        //    //Init Block

        //    if (Chart.getChart("myChart")) {
        //        Chart.getChart("myChart").destroy();
        //    }
        //    myChart = new Chart(context, config);

        //}
        //function ShowClinicalQuality_ProcessMeasure_Graph(insurance_, year_,) {
        //    let category_ = "Process Measures";
        //    $.ajax({
        //        type: "POST",
        //        url: "HomePage.aspx/GetClinicalQualityData_Category_Graph",
        //        //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
        //        data: '{insurance: "' + insurance_ + '",year:"' + year_ + '",category:"' + category_ + '"}',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: OnClinicalQuality_ProcessMeasureSuccess,
        //        failure: function (response) {
        //            console.log(response.d)
        //        },
        //        error: function (response) {
        //            //alert(resonse.d);
        //            alert("You caught error");
        //        }

        //    });
        //}
        //function OnClinicalQuality_ProcessMeasureSuccess(response) {
        //    let myChart = null;
        //    var month = [];
        //    var year = [];
        //    var missing_patient = [];
        //    var total = [];
        //    var description = [];
        //    var category = [];
        //    var measure = [];

        //    var value = response["d"];
        //    //console.log(value);

        //    var obj = JSON.parse(value);
        //    //console.log(obj);

        //    for (var item in obj) {
        //        year.push(obj[item]["Year"]);
        //        month.push(obj[item]["Month"]);

        //        missing_patient.push(obj[item]["MissingPatient"]);
        //        total.push(obj[item]["Total"]);
        //        description.push(obj[item]["Description"]);
        //        category.push(obj[item]["Category"]);
        //        measure.push(obj[item]["Measure"]);

        //    }
        //    //console.log(year)
        //    //console.log(missing_patient)
        //    //console.log(total)
        //    //console.log(description)
        //    //console.log(category)

        //    // Chat section

        //    const data = {
        //        labels: measure,
        //        datasets: [
        //            {
        //                label: 'Missing Patient',
        //                data: missing_patient,
        //                borderWidth: 1,
        //                borderColor: '#070A52',
        //                backgroundColor: '#070A52',
        //            },
        //            {
        //                label: 'Total Patient',
        //                data: total,
        //                borderWidth: 1,
        //                borderColor: '#FA9884',
        //                backgroundColor: '#FA9884',
        //            },

        //        ]
        //    };
        //    const bgColor = {
        //        id: 'bgColor',
        //        beforeDraw: (chart, options) => {
        //            const { ctx, width, height } = chart;
        //            ctx.fillStyle = 'white';
        //            ctx.fillRect(0, 0, width, height)
        //            ctx.restore();
        //        }
        //    }

        //    //Config

        //    const config = {
        //        type: 'bar',
        //        data,
        //        options: {
        //            locale: 'en-US',
        //            responsive: true,
        //            scales: {
        //                x: {
        //                    stacked: true,
        //                    title: {
        //                        display: true,
        //                        text: 'Months ( ' + year[0] + ' )',
        //                        font: {
        //                            family: 'Comic Sans MS',
        //                            size: 18,
        //                            //weight: 'bold',
        //                            lineHeight: 1.2
        //                        }
        //                    }
        //                },
        //                y: {
        //                    //ticks: {
        //                    //    callback: (value, index, values) => {
        //                    //        return new Intl.NumberFormat('en-US', {
        //                    //            style: 'currency',
        //                    //            currency: 'USD',
        //                    //            maximumSignificantDigits: 3
        //                    //        }).format(value);
        //                    //    }
        //                    //},
        //                    beginAtZero: true,
        //                    stacked: true,
        //                    title: {
        //                        display: true,
        //                        text: 'Count (in numbers)', //( in dollers ) 
        //                        font: {
        //                            family: 'Comic Sans MS',
        //                            size: 18,
        //                            //weight: 'bold',
        //                            lineHeight: 1.2
        //                        }
        //                    }

        //                },
        //            },
        //            plugins: {
        //                //title: {
        //                //    display: true,
        //                //    text: year[0],
        //                //    //color: '#911',
        //                //    font: {
        //                //        family: 'Comic Sans MS',
        //                //        size: 20,
        //                //        weight: 'bold',
        //                //        lineHeight: 1.2
        //                //    }
        //                //}
        //            },
        //        },
        //        plugins: [bgColor, ChartDataLabels], // ChartDataLabels  -- for counts in bars.
        //    }
        //    const context = document.getElementById('myChart').getContext('2d');
        //    //Init Block

        //    if (Chart.getChart("myChart")) {
        //        Chart.getChart("myChart").destroy();
        //    }
        //    myChart = new Chart(context, config);

        //}
        //function ShowClinicalQuality_TrackingMeasure_Graph(insurance_, year_,) {
        //    let category_ = "Tracking Measures";
        //    $.ajax({
        //        type: "POST",
        //        url: "HomePage.aspx/GetClinicalQualityData_Category_Graph",
        //        //data: '{insurance: ' + insurance_ + 'year: ' + year_ + '}',
        //        data: '{insurance: "' + insurance_ + '",year:"' + year_ + '",category:"' + category_ + '"}',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: OnClinicalQuality_Tracking_MeasureSuccess,
        //        failure: function (response) {
        //            console.log(response.d)
        //        },
        //        error: function (response) {
        //            //alert(resonse.d);
        //            alert("You caught error");
        //        }

        //    });
        //}
        //function OnClinicalQuality_Tracking_MeasureSuccess(response) {
        //    let myChart = null;
        //    var month = [];
        //    var year = [];
        //    var missing_patient = [];
        //    var total = [];
        //    var description = [];
        //    var category = [];
        //    var measure = [];

        //    var value = response["d"];
        //    //console.log(value);

        //    var obj = JSON.parse(value);
        //    //console.log(obj);

        //    for (var item in obj) {
        //        year.push(obj[item]["Year"]);
        //        month.push(obj[item]["Month"]);

        //        missing_patient.push(obj[item]["MissingPatient"]);
        //        total.push(obj[item]["Total"]);
        //        description.push(obj[item]["Description"]);
        //        category.push(obj[item]["Category"]);
        //        measure.push(obj[item]["Measure"]);

        //    }
        //    //console.log(year)
        //    //console.log(missing_patient)
        //    //console.log(total)
        //    //console.log(description)
        //    //console.log(category)

        //    // Chat section

        //    const data = {
        //        labels: measure,
        //        datasets: [
        //            {
        //                label: 'Missing Patient',
        //                data: missing_patient,
        //                borderWidth: 1,
        //                borderColor: '#070A52',
        //                backgroundColor: '#070A52',
        //            },
        //            {
        //                label: 'Total Patient',
        //                data: total,
        //                borderWidth: 1,
        //                borderColor: '#FA9884',
        //                backgroundColor: '#FA9884',
        //            },

        //        ]
        //    };
        //    const bgColor = {
        //        id: 'bgColor',
        //        beforeDraw: (chart, options) => {
        //            const { ctx, width, height } = chart;
        //            ctx.fillStyle = 'white';
        //            ctx.fillRect(0, 0, width, height)
        //            ctx.restore();
        //        }
        //    }

        //    //Config

        //    const config = {
        //        type: 'bar',
        //        data,
        //        options: {
        //            locale: 'en-US',
        //            responsive: true,
        //            scales: {
        //                x: {
        //                    stacked: true,
        //                    title: {
        //                        display: true,
        //                        text: 'Measure',
        //                        font: {
        //                            family: 'Comic Sans MS',
        //                            size: 18,
        //                            //weight: 'bold',
        //                            lineHeight: 1.2
        //                        }
        //                    }
        //                },
        //                y: {
        //                    //ticks: {
        //                    //    callback: (value, index, values) => {
        //                    //        return new Intl.NumberFormat('en-US', {
        //                    //            style: 'currency',
        //                    //            currency: 'USD',
        //                    //            maximumSignificantDigits: 3
        //                    //        }).format(value);
        //                    //    }
        //                    //},
        //                    beginAtZero: true,
        //                    stacked: true,
        //                    title: {
        //                        display: true,
        //                        text: 'Count (in numbers)', //( in dollers ) 
        //                        font: {
        //                            family: 'Comic Sans MS',
        //                            size: 18,
        //                            //weight: 'bold',
        //                            lineHeight: 1.2
        //                        }
        //                    }

        //                },
        //            },
        //            plugins: {
        //                //title: {
        //                //    display: true,
        //                //    text: year[0],
        //                //    //color: '#911',
        //                //    font: {
        //                //        family: 'Comic Sans MS',
        //                //        size: 20,
        //                //        weight: 'bold',
        //                //        lineHeight: 1.2
        //                //    }
        //                //}
        //            },
        //        },
        //        plugins: [bgColor, ChartDataLabels], // ChartDataLabels  -- for counts in bars.
        //    }
        //    const context = document.getElementById('myChart').getContext('2d');
        //    //Init Block

        //    if (Chart.getChart("myChart")) {
        //        Chart.getChart("myChart").destroy();
        //    }
        //    myChart = new Chart(context, config);


        //}
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
            width: 90%
        }

            /*   table th {
                background-color: #251B37;
                color: #ffff;
                font-weight: bold;
            }*/

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
                            <h2 style="font-family: 'Comfortaa', cursive; font-size: 1.3vw;">Physician Association Value Based Contract Management Dashboard</h2>
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

                            <div class="secondBar" style="margin-top: 0rem; margin-left: 10rem;">

                                <asp:Label ID="lblInsurance" runat="server" Text="Insurance" Font-Bold="false"></asp:Label>
                                <asp:DropDownList runat="server" ID="ddlInsurance" Style="margin-left: 10px; width: 250px" ToolTip="Select Insurance" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlInsurance_SelectedIndexChanged">

                                    <asp:ListItem >Simply</asp:ListItem>
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
                                <%--<asp:Label ID="lbltempcategories" runat="server" Visible="true">Value</asp:Label>--%>
                                <%--<input id="btnGetData" class="btn" style="width:100px;border-radius:5px;margin-left:6px" type="button" value="Show Graph" onclick="ShowGraph()" />--%>
                            </div>

                        </div>
                        <%--<img src="Assests/Images/unknown-1.1s-203px.png" style="width: 34px; display: flex; float: right;" />--%>
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
                        <asp:ImageButton ID="imgbtnHelp" runat="server" ImageUrl="Assests/Images/unknown-1.1s-203px.png" style="width: 30px;height:30px; float: right;margin-top:15px; margin-right:10px;" OnClick="imgbtnHelp_Click" />
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
                            <ul id="categories" runat="server">
                                <li>
                                    <span data-flow="right">
                                        <%--<a  id="mem" runat="server" class="active">
                                            <!--class="active"    >>>  to make it active-->
                                            <span class="icon active"><i class="fas fa-border-all"></i></span>
                                            <span class="title" id="membership" runat="server">Membership</span>
                                        </a>--%>
                                        <asp:LinkButton ID="lnkMembership" runat="server" CssClass="active" OnClick="Membership">
                                            <span class="icon" runat="server"><i class="fas fa-border-all"></i></span>
                                            <span class="title" id="membership" runat="server">Membership</span>
                                        </asp:LinkButton>
                                    </span>
                                </li>
                                <li>
                                    <span data-flow="right">
                                        <%--<a href="?Category=Clinal_Quality" class="" id="hed">

                                            <span class="icon "><i class="fas fa-dice-d6"></i></span>
                                            <span class="title" id="hedis" runat="server">Clinical Quality</span>

                                        </a>--%>
                                        <asp:LinkButton ID="lnkBtnClinicalQuality" runat="server" OnClick="ClinicalQuality" CssClass="">
                                            <span class="icon" runat="server"><i class="fas fa-dice-d6"></i></span>
                                            <span class="title" id="hedis" runat="server">Clinical Quality</span>
                                        </asp:LinkButton>
                                    </span>
                                </li>
                                <%--<li>
                                    <span data-flow="right">
                                        <%--<a href="?Category=Medical_Risk" class="" id="mr">
                                            <span class="icon"><i class="fab fa-delicious"></i></span>
                                            <span class="title" id="mra" runat="server">Medical Risk</span>

                                        </a>
                                        <asp:LinkButton ID="lnkBtnMedicalRisk" runat="server" OnClick="MedicalRisk" CssClass="">
                                            <span class="icon" runat="server"><i class="fab fa-delicious"></i></span>
                                            <span class="title" id="mra" runat="server">Medical Risk</span>
                                        </asp:LinkButton>

                                    </span>
                                </li>--%>
                                <li>
                                    <span data-flow="right">
                                        <%--<a href="?Category=Utilization" class="" id="util">
                                            <span class="icon"><i class="fab fa-elementor"></i></span>
                                            <span class="title" id="utilization" runat="server">Utilization</span>
                                        </a>--%>
                                        <asp:LinkButton ID="lnkBtnUtilization" runat="server" OnClick="Utilization" CssClass="">
                                            <span class="icon" runat="server"><i class="fab fa-elementor"></i></span>
                                            <span class="title" id="utilization" runat="server">Utilization</span>
                                        </asp:LinkButton>
                                    </span>
                                </li>
                                <%--   <li>
                                    <span data-flow="right">
                                        <asp:LinkButton ID="lnkBtnReport" runat="server" OnClick="Report" CssClass="">
                                            <span class="icon" runat="server"><i class="fas fa-chart-pie"></i></span>
                                            <span class="title" id="reports" runat="server">Reports</span>
                                        </asp:LinkButton>
                                    </span>
                                </li>--%>
                                <li>
                                    <span data-flow="right" style="padding: 0px">
                                        <asp:LinkButton ID="lnkBtnHelp" runat="server" OnClick="lnkBtnHelp_Click" CssClass="">
                                            <span class="icon" runat="server">
                                                <img src="Assests/Images/unknown-1.1s-203px.png" style="width: 34px; margin-left: -6px;" />
                                            </span><%-- <i class="fas fa-border-all"></i>--%>
                                            <span class="title" id="help" runat="server">Help</span>
                                        </asp:LinkButton>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="titleBox">
                        <asp:Label ID="CategoryTitle" runat="server" Style="font-family: 'Quicksand', sans-serif; width: 1.1vh;" Font-Bold="true" Text="Membership"></asp:Label>
                    </div>
                    <div class="middleContainer">
                        <asp:Label ID="lblData" runat="server"></asp:Label>
                        <div class="container">
                            <div class="graph">
                                <div class="chartBox">
                                    <%--- For Radio buttons--%>
                                    <asp:RadioButtonList ID="RBL_Subcategory" runat="server" RepeatDirection="Horizontal" Width="30%" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="RBL_Subcategory_SelectedIndexChanged">
                                    </asp:RadioButtonList>

                                    <canvas id="myChart"></canvas>
                                    <asp:Button runat="server" ID="btnSaveGraph" OnClientClick="printGraph()" class="btn" Text="Export to PDF" OnClick="btnSaveGraph_Click"/>
                                </div>
                            </div>
                            <div class="analysisReport">
                                <div id="info"></div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <%--Middle Items End--%>

            <%--Footer Start--%>
            <footer class="footer" style="margin-top: 47px;">
                <center>
                    <nav>
                        <p style="align-content: center; color: white">
                            <%--<a href="#">About Us</a>| 
                            <a href="#">Privacy Policy</a>| 
                            <a href="#">Careers</a>--%>
                        </p>
                    </nav>

                    <p style="align-items: center;">
                        &#169; eHealthcare Registry: All Rights Reserved v 1.1
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






