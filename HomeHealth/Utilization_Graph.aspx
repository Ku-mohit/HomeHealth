<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Utilization_Graph.aspx.cs" Inherits="HomeHealth.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- For chart -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.umd.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="chartBox">
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </form>
    <script>
        const DATA_COUNT = 7;
        const NUMBER_CFG = { count: DATA_COUNT, min: -100, max: 100 };

        const labels = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
        ];
        const data = {
            labels: labels,
            datasets: [
                {
                    label: 'Dataset 1',
                    data: [34,65,26,12,10,4,83],
                    backgroundColor: "#FF6969",
                    stack: 'Stack 0',
                },
                {
                    label: 'Dataset 2',
                    data: [10, 43, 71, 91, 18, 16, 26],
                    backgroundColor:"#05BFDB",
                    stack: 'Stack 0',
                },
                {
                    label: 'Dataset 3',
                    data: [5, 73, 23, 14, 42, 18, 67],
                    backgroundColor:"#F7D060",
                    stack: 'Stack 1',
                },
            ]
        }; const bgColor = {
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
        //Config

        const config = {
            type: 'bar',
            data: data,
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: 'Chart.js Bar Chart - Stacked'
                    },
                },
                responsive: true,
                interaction: {
                    intersect: false,
                },
                scales: {
                    x: {
                        stacked: true,
                    },
                    y: {
                        stacked: true
                    }
                }
            }
        };
        const context = document.getElementById('myChart').getContext('2d');

        if (Chart.getChart("myChart")) {
            Chart.getChart("myChart").destroy();
        }
        myChart = new Chart(context, config);

    </script>
</body>
</html>
