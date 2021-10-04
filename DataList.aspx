<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataList.aspx.cs" Inherits="DataList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=ks_c_5601-1987" />
    <title>����Ź� SIS | ������Ȳ</title>
    <link type="image/x-icon" rel="shortcut icon" href="images/favicon.ico" />
    <link type="text/css" rel="stylesheet" href="css/style.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
    <script type="text/javascript" src="js/func.js"></script>
    <script type="text/javascript"> 
        var sum = 60; // ���ΰ�ħ �ð�(��)  

        $(document).ready(function () {
            // ������, ��(����) ����
            $("input").change(function () {
                Search();
            });

            // ��ü, �� ����
            $("select").change(function () {
                Search();
            });

            // ��(����) ���ð�
            $("input[name='view']")[<%= strView %>].checked = true;  

            // ����ð�
            runClock();       
            
            // ���ΰ�ħ
            setInterval(function () {
                $(".refresh").html("(" + --sum + "�� �� ���ΰ�ħ..)");

                if (sum == 0)
                    Search();
            }, 1000);
        });        

        function pad(n, width) {
            n = n + '';
            return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
        }

        function runClock() {
            now = new Date();
            hours = now.getHours();
            minutes = now.getMinutes();
            seconds = now.getSeconds();
            time = pad(parseInt(hours), 2) + ":" + pad(parseInt(minutes), 2) + ":" + pad(parseInt(seconds), 2);

            $("input[name='lblRealTime']").val(time);

            setTimeout("runClock();", 1000);
        }      

        // �˻� ��ư Ŭ��
        function Search() {
            var url = '';
            url += 'DataList.aspx?media=' + $("#media").val();
            url += '&date=' + $("#date").val();
            url += '&pan=' + $("#pan").val();
            url += '&view=' + $("input[name='view']:checked").val();
            url += '&random=<%= new Random().Next() %>';

            location.href = url;
        }
    </script>
</head>

<body>
    <form runat="server" id="PublishView" method="POST">
        <input type="hidden" name="tmpColor" value="<%=tmpColor%>" />

        <div class="div_top">
            ��ü :
			<asp:DropDownList runat="server" ID="media" />&nbsp;
            ������ :
            <asp:TextBox runat="server" ID="date" TextMode="Date" />&nbsp;
            �� :
			<asp:DropDownList runat="server" ID="pan" />&nbsp;           

            <input type="button" onclick="Search();" value="���ΰ�ħ" />&nbsp;
            <span class="refresh">(60�� �� ���ΰ�ħ..)</span>

            <div class="info_color">
                <span></span>
                ����&nbsp;
                <span></span>
                �̰���&nbsp;
                <span></span>
                �۾���&nbsp;
                <span></span>
                �ڵ�      
            </div>
        </div>

        <div class="div_left">
            <table class="tb_title">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th colspan="4" style="font-size: 17px; font-weight: bold; padding: 3px;">
                        <asp:Label runat="server" ID="lblMonth" />��
					    <asp:Label runat="server" ID="lblDay" />����
					    <asp:Label runat="server" ID="lblPan" />��
					    <asp:Label runat="server" ID="lblMaeche" />
                    </th>
                </tr>
                <tr>
                    <th>����ð�</th>
                    <td>
                        <input type="text" name="lblRealTime" readonly /></td>
                    <th>���Žð�</th>
                    <td>
                        <asp:Label runat="server" ID="lblUpdateTime" /></td>
                </tr>
                <tr>
                    <th>���Ǹ��</th>
                    <td>
                        <asp:Label runat="server" ID="lblPubKpang" /></td>
                    <th>�̰��Ǹ��</th>
                    <td>
                        <asp:Label runat="server" ID="lblPubNoKpang" /></td>
                </tr>
                <tr>
                    <th>�ʼ�ð�</th>
                    <td>
                        <asp:Label runat="server" ID="lblStartPrint" ForeColor="#cccccc" />
                    </td>
                    <th>����ð�</th>
                    <td>
                        <asp:Label runat="server" ID="lblEndPrint" ForeColor="#cccccc" /></td>
                </tr>
            </table>

            <table class="tb_view">
                <tr>
                    <td>
                        <asp:RadioButtonList runat="server" ID="view" RepeatDirection="Horizontal">
                            <asp:ListItem Value="0" />
                            <asp:ListItem Value="1" />
                            <asp:ListItem Value="2" />
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>

            <table class="tb_time_header">
                <colgroup>
                    <col width="27px" />
                    <col width="55px" />
                    <col width="*" />
                    <col width="55px" />
                    <col width="55px" />
                    <col width="55px" />
                    <col width="55px" />
                </colgroup>
                <tr>
                    <th>��</th>
                    <th>����</th>
                    <th>����</th>
                    <th>����ð�</th>
                    <th>���ǽð�</th>
                    <th>����ð�</th>
                    <th>CTP��� </th>
                </tr>
            </table>

            <div class="div_time">
                <asp:DataList runat="server" ID="DataList1" DataKeyField="myun_id">
                    <ItemTemplate>
                        <table id="imageTable" class="tb_time" onclick='fncPhotoClick(this, <%# DataBinder.Eval(Container.DataItem, "myun_id") %><%# DataBinder.Eval(Container.DataItem, "m_myun") %><%# DataBinder.Eval(Container.DataItem, "m_jibang") %>)'>
                            <colgroup>
                                <col width="27px" />
                                <col width="55px" />
                                <col width="*" />
                                <col width="55px" />
                                <col width="55px" />
                                <col width="55px" />
                                <col width="55px" />
                            </colgroup>
                            <tr>
                                <td style="color: #000;">
                                    <span <%# DataBinder.Eval(Container.DataItem, "myun_Id").ToString().Equals("888888") ? "style='background: lightgreen;'" : "style='background-color: #b4e0f0;'" %>>
                                        <%# DataBinder.Eval(Container.DataItem, "m_myun") %>
                                    </span>
                                </td>
                                <td>
                                    <%# fncCodeConvert(DataBinder.Eval(Container.DataItem, "m_jibang").ToString(), DataBinder.Eval(Container.DataItem, "myun_Id").ToString()) %>
                                </td>
                                <td>
                                    <%# KPanCount(Convert.ToInt16(DataBinder.Eval(Container.DataItem, "dj_kpan_count"))) %>
                                </td>
                                <td>
                                    <%# getDateToString(DataBinder.Eval(Container.DataItem, "ad_kpan_date").ToString(), DataBinder.Eval(Container.DataItem, "myun_Id").ToString()) %>
                                </td>
                                <td>
                                    <%# getDateToString1(DataBinder.Eval(Container.DataItem, "dj_kpan_date").ToString()) %>
                                </td>
                                <td>
                                    <%# getDateToString1(DataBinder.Eval(Container.DataItem, "dj_kpan_date").ToString()).Length == 0 ? "" : getDateToString2(DataBinder.Eval(Container.DataItem, "PrintTime").ToString(), DataBinder.Eval(Container.DataItem, "dj_kpan_date").ToString()) %>
                                </td>
                                <td>
                                    <%# getDateToString3(DataBinder.Eval(Container.DataItem, "prtTime_B").ToString(), DataBinder.Eval(Container.DataItem, "dj_kpan_date").ToString(), DataBinder.Eval(Container.DataItem, "myun_Id").ToString(), DataBinder.Eval(Container.DataItem, "m_myun").ToString(), DataBinder.Eval(Container.DataItem, "m_jibang").ToString()) %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>

        <div class="div_right">
            <embed id="embed" src="DataView.aspx?media=<%= strMediaNum %>&date=<%= strDate %>&pan=<%= strPan %>&view=<%= strView %>&random=<%= new Random().Next() %>" />
        </div>
    </form>
</body>
</html>
