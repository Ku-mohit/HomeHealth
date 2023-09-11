<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ajax_method.aspx.cs" Inherits="HomeHealth.ajax_method" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtFirstName" runat="server" placeholder="Enter Your First Name"></asp:TextBox><br />
            <br />
            <asp:TextBox ID="txtLastName" runat="server" placeholder="Enter Your Last Name"></asp:TextBox><br />
            <br />
            <asp:Button ID="btn" runat="server" Text="Submit" OnClick="btn_Click" />

            <br />
            <br />
            <h2 id="result"></h2>
        </div>
    </form>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#btn').click(function () {
                var fname = $('#txtFirstName').val();
                var lname = $('#txtLastName').val();
                if (fname == "" || lname == "") {
                    alert("All fields are required!");
                }
                else {
                    $.ajax({
                        url: 'ajax_method.aspx/GetData',
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify({ FirstName: fname, LastName: lname }),
                        dataType: 'json',
                        success: function (result, status, xhr) {
                            $('#result').text(result.d);
                        },

                    });
                }


            });
        });
    </script>
</body>
</html>
