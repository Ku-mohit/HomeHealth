<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Graphs.aspx.cs" Inherits="HomeHealth.Graphs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.min.js" integrity="sha512-v3ygConQmvH0QehvQa6gSvTE2VdBZ6wkLOlmK7Mcy2mZ0ZF9saNbbk19QeaoTHdWIEiTlWmrwAL4hS8ElnGFbA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>
    <form id="form1" runat="server">
        <center>
            <h1>Graphs </h1>
            <div style="margin-top: 5px; margin-left: 100px; height: 400px; width: 800px">
                <canvas id="myChart" aria-label="" role="img" ></canvas>
            </div>
        </center>

    </form>
</body>
<script>
    // setup 
    const data = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
            label: 'Active',
            data: [18, 12, 6, 9, 12, 3, 9, 8, 3, 15, 19, 23],
            backgroundColor: [
                "rgba(220,220,220,0.5)", 
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)'
            ],
            borderColor: [
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)',
                'rgba(86, 191, 46, 0.8)'

            ],
            borderWidth: 1
        },
        {
            label: 'New',
            data: [18, 12, 6, 9, 12, 3, 9, 2, 8, 5, 11, 10],
            backgroundColor: [
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
            ],
            borderColor: [
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
                'rgba(86, 50, 152, 0.8)',
            ],
            borderWidth: 1
        },
        {
            label: 'Disenrolled',
            data: [18, 12, 6, 9, 12, 3, 9, 11, 7, 16, 14, 23],
            backgroundColor: [
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
            ],
            borderColor: [
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
                'rgba(255, 26, 104, 0.2)',
            ],
            borderWidth: 1
        }]
    };

    // config 
    const config = {
        type: 'bar',
        data,
        options: {
            //title: {
            //    display: true,
            //    text: 'Chart'
            //},
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
                        text: 'Membership Counts '
                    }

                }
            }

        }
    };

    // render init block
    const myChart = new Chart(
        document.getElementById('myChart'),
        config
    );

    // Instantly assign Chart.js version
    const chartVersion = document.getElementById('chartVersion');
    chartVersion.innerText = Chart.version;
</script>
</html>
