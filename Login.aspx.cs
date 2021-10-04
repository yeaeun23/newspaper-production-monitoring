using System;
using System.Data;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : Page
{
    /* ���� ����
     * 1	SUPER
     * 6	����͸� SUPER(����/�б�)
     * 601	���� ����/�б�
     * 602	��ȭ ����/�б�
     * 603	��� �б�
     * 604	���� �б�
     * 605	��ȭ �б�
     */

    /* �α��� ����
    * 0     ����
    * 1	    �������� �ʴ� �����
    * 2	    ������ ���� �����
    * 3	    �α��� ���� �����
    */

    /* ���� ����
     * Blue			���������� ���� ��
     * MidnightBlue	���������� ���� DJ_KPANG�� ���� ��
     * GrayText		���������� ���� DJ_KPANG�� ���� ��
     * Olive		�����۾� ���� ��
     */

    protected void Page_Load(object sender, EventArgs e)
    {
        string strSSO_ID = (Request["sso_ID"] == null) ? "" : Request["sso_ID"];
        string strSSO_PW = (Request["sso_PWD"] == null) ? "" : Request["sso_PWD"];

        if (strSSO_ID + strSSO_PW != "")
        {
            id.Value = strSSO_ID;
            pw.Value = strSSO_PW;

            login_Click(null, null);
        }
        else
        {
            //ClientScript.RegisterClientScriptBlock(GetType(), "alert", "<script>alert('������ ����Ǿ����ϴ�. �ٽ� �α��� ���ּ���.');</script>");
        }
    }

    // �α��� ��ư Ŭ��
    protected void login_Click(object sender, EventArgs e)
    {
        string input_id = id.Value;
        string input_pw = pw.Value;

        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strCMSCOMConn"]);
        SqlCommand cmd = null;

        try
        {
            con.Open();

            cmd = new SqlCommand();
            cmd.Connection = con;

            cmd.Parameters.Add(new SqlParameter("@szUserID", input_id));
            cmd.Parameters.Add(new SqlParameter("@szPassword", input_pw));
            cmd.Parameters.Add(new SqlParameter("@nSWIDCode", "2009"));
            cmd.Parameters.Add(new SqlParameter("@szLoginIP", Request.UserHostAddress.ToString()));
            cmd.Parameters.Add("ReturnValue", SqlDbType.Int);

            cmd.Parameters["ReturnValue"].Direction = ParameterDirection.ReturnValue;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "up_login_v2310";

            SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            if (dr.HasRows)
            {
                dr.Read();

                Session.Add("UserCode", (int)dr.GetValue(0));
                Session.Add("UserID", input_id);
                Session.Add("UserPWD", input_pw);
            }

            dr.Close();

            switch ((int)cmd.Parameters["ReturnValue"].Value)
            {
                case 0:
                    Session.Add("Login", "1");
                    Response.Redirect("DataList.aspx");
                    break;
                case 1:
                    ClientScript.RegisterClientScriptBlock(GetType(), "alert", "<script>alert('�������� �ʴ� ������Դϴ�.');</script>");
                    break;
                case 2:
                    ClientScript.RegisterClientScriptBlock(GetType(), "alert", "<script>alert('��й�ȣ�� ��ġ���� �ʰų� ������ ���� ���̵��Դϴ�.');</script>");
                    break;
                case 3:
                    Logout();
                    Session.Add("Login", "1");
                    Response.Redirect("DataList.aspx");
                    break;
            }
        }
        catch (Exception)
        {
            ClientScript.RegisterClientScriptBlock(GetType(), "alert", "<script>alert('��й�ȣ�� ��ġ���� �ʰų� ������ ���� ���̵��Դϴ�.');</script>");
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    // �α׾ƿ�
    protected void Logout()
    {
        if (Session["UserCode"] == null)
        {
            return;
        }
        else
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand cmd = null;

            try
            {
                con.Open();

                cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.Parameters.Add(new SqlParameter("@nUserCode", Session["UserCode"]));
                cmd.Parameters.Add(new SqlParameter("@nSWCode", 2009));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "up_logout_v2310";

                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                dr.Close();
            }
            catch (Exception)
            {
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}
