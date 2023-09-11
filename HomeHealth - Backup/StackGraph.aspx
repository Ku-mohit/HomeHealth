<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StackGraph.aspx.cs" Inherits="HomeHealth.StackGraph" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Stack Column Chart</title>

    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.umd.min.js"></script>
    <script>
        function GetData(patientData) {
            //alert(patientData);


        }


    </script>
    <style>
        .chartBox {
            /* border:2px solid tomato;
            border-radius:10px;
            height:400px;*/
            width: 720px;
            margin: 30px 25%;
            /* padding:20px;*/
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="chartMenu">
        </div>
        <div class="chartCard">
            <div class="chartBox">
                <canvas id="myChart"></canvas>
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true">
                    <asp:ListItem >2023</asp:ListItem>
                    <asp:ListItem>2022</asp:ListItem>
                    <asp:ListItem>2021</asp:ListItem>
                </asp:DropDownList>
                <asp:Label runat="server" ID="info" Style="color: black;"></asp:Label>
            </div>
        </div>
    </form>
</body>
<script>

    // getData();
    chartIt();
    async function chartIt() {
        const data = await getData();
        //const myArray = [10, 36, 25, 48, 32, 6];
        const ctx = document.getElementById('myChart');

        const myChart = new Chart(ctx, {
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
                }, {
                    label: 'Disenrolled Person',
                    data: data.NewP,
                    borderWidth: 1
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

    async function getData() {
        const xs = [];
        const ActiveP = [];
        const NewP = [];
        const DisenrolledP = [];
        
        var year = <%=ddlYear.SelectedValue%>;
        const response = await fetch('Assests/SampleData/SimplyRoasterMembership'+year+'CSV.csv');
        const data = await response.text();
        const table = data.split('\n').slice(0);  // instead of zero we can put 1 to leave header.
        table.forEach(row => {
            const columns = row.split(',');
            const month = columns[0];
            const ActivePatient = columns[1];
            const NewPatient = columns[2];
            const DisenrolledPatient = columns[3];
            xs.push(month);
            //const temp = columns[1];
            //ys.push(temp);
            ActiveP.push(ActivePatient);
            NewP.push(NewPatient);
            DisenrolledP.push(DisenrolledPatient);
            //console.log(month, temp);
        })
        return { xs, ActiveP, NewP, DisenrolledP };
    }

</script>
</html>
