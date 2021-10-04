<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=ks_c_5601-1987" />
    <title>����Ź� SIS | ������Ȳ</title>
    <link type="image/x-icon" rel="shortcut icon" href="images/favicon.ico" />
    <link type="text/css" rel="stylesheet" href="css/login.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            if ($("#id").val() == "") {
                $("#id").focus();
            }
            else {
                $("#pw").focus();
            }
        });

        function Login() {
            if ($("#id").val() == "") {
                alert("����� �Է��� �ּ���.");
                $("#id").focus();
                return false;
            }
            else if ($("#id").val().length != 7) {
                alert("����� Ȯ���� �ּ���.");
                $("#id").focus();
                return false;
            }
            else if ($("#pw").val() == "") {
                alert("��й�ȣ�� �Է��� �ּ���.");
                $("#pw").focus();
                return false;
            }

            return true;
        }
	</script>
</head>

<body>
    <form runat="server">
        <div class="div_top">
        </div>

        <div class="div_bottom">
            <table>
                <colgroup>
                    <col width="68%" />
                    <col width="32%" />
                </colgroup>
                <tr>
                    <td colspan="2">
                        <img src="images/logo.png" alt="����Ź�" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input runat="server" id="id" type="text" placeholder="���" tabindex="1" maxlength="7" />
                    </td>
                    <td rowspan="2">
                        <asp:Button runat="server" ID="login" Text="�α���" OnClientClick="return Login();" OnClick="login_Click"></asp:Button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input runat="server" id="pw" type="password" placeholder="��й�ȣ" tabindex="2" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
