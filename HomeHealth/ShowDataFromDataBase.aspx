<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowDataFromDataBase.aspx.cs" Inherits="HomeHealth.ShowDataFromDataBase" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests" />
    <title></title>
    <style>
        .chartBox {
            height: 500px;
            width: 800px;
            border: 1px solid #808080;
            border-radius: 10px;
            padding: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ul id="categories">
            <li>
                <span>
                    <a href="?Category=Membership" id="mem">
                        <span class="title" id="membership" runat="server">Membership</span>
                    </a>
                </span>
            </li>
            <li>
                <span>
                    <a href="?Category=Hedis" id="hed">
                        <span class="title" id="hedis" runat="server">Clinical Quality</span>
                    </a>
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
        <center>
            <div>
                <asp:DropDownList ID="ddlInsurance" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlInsurance_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:Label ID="lblCategory" runat="server"></asp:Label>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>

                <div class="chartBox">
                    <canvas id="myChart" style="height: 100%; width: 100%"></canvas>
                    <button onclick="printGraph()" style="margin: 30px; padding: 10px; border-radius: 10px;">Export to PDF</button>
                </div>
                <%--<asp:GridView ID="DataGrid" runat="server"></asp:GridView>--%>
            </div>
        </center>
    </form>
</body>
<%--To use ajax in webform/webpage--%>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%--To use charts in webpage--%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.min.js" integrity="sha512-v3ygConQmvH0QehvQa6gSvTE2VdBZ6wkLOlmK7Mcy2mZ0ZF9saNbbk19QeaoTHdWIEiTlWmrwAL4hS8ElnGFbA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--To show values in bars | To show datalabels--%>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0/dist/chartjs-plugin-datalabels.min.js"></script>

<script>
    //function CallFunction(year_) {
      
        $(document).ready(function () {
            var active_member = [];
            var new_member = [];
            var disenrolled_member = [];
            var month = [];
            var year = [];
            var disenrolled_analysis = [];

            //var year_ = document.getElementById(<%=ddlYear.ClientID%>).value;
            jQuery.ajax({
                url: 'ShowDataFromDataBase.aspx/GetData',
                //data: "{'year'"+ 2023 + "}",
                data: "{year:'" + 2021 + "'}",
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    //console.log(data);
                    var value = data["d"];
                    // console.log(value);

                    var obj = JSON.parse(value);
                    //console.log(obj);

                    for (var item in obj) {
                        month.push((obj[item]['Month']));
                        year.push((obj[item]['year']));
                        disenrolled_analysis.push((obj[item]['DisenrolledAnalysis']));
                        active_member.push((obj[item]['ActivePatient']));
                        new_member.push((obj[item]['NewPatient']));
                        disenrolled_member.push((obj[item]['DisenrolledPatient']));
                    }
                    //console.log(month)
                    //console.log(year)
                    //console.log(active_member)
                    //console.log(new_member)
                    //console.log(disenrolled_member)
                    //console.log(disenrolled_analysis)


                    // Chat section


                    const ctx = document.getElementById('myChart');

                    const bgColor = {
                        id: 'bgColor',
                        beforeDraw: (chart, options) => {
                            const { ctx, width, height } = chart;
                            ctx.fillStyle = 'white';
                            ctx.fillRect(0, 0, width, height)
                            ctx.restore();
                        }
                    }
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: month,
                            datasets: [{
                                label: 'Active Patient',
                                data: active_member,
                                borderWidth: 1
                            },
                            {
                                label: 'New Patient',
                                data: new_member,
                                borderWidth: 1
                            },
                            {
                                label: 'Disenrolled Patient',
                                data: disenrolled_member,
                                borderWidth: 1
                            },
                            ]
                        },

                        options: {
                            responsive: true,
                            scales: {
                                x: {
                                    stacked: true,
                                    title: {
                                        display: true,
                                        //text: 'Months of ' + data.year
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    stacked: true,
                                    title: {
                                        display: true,
                                        //   text: 'Membership Counts( in numbers ) '
                                    }

                                },
                            },
                            //    plugins: {
                            //        title: {
                            //            display: true,
                            //            //text: data.Insurance + " " + data.year,
                            //            //color: '#911',
                            //            font: {
                            //                family: 'Comic Sans MS',
                            //                size: 20,
                            //                weight: 'bold',
                            //                lineHeight: 1.2
                            //            }
                            //        }
                            //    }
                        },
                        plugins: [bgColor],
                    });



                }

            })

        });
    //}
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
<script>
    function printGraph() {

        const canvas = document.getElementById('myChart');

        // create image 
        const canvasImage = canvas.toDataURL('image/jpeg', 1.0);
        console.log(canvasImage)

        let pdf = new jsPDF('landscape');
        pdf.setFontSize(20);
        pdf.addImage(canvasImage, 'JPEG', 15, 15, 250, 120);

        pdf.save('mychar.pdf');


    }


</script>
</html>
