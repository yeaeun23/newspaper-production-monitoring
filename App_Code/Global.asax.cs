using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Data;

namespace PaperMonitoring
{
    /// <summary>
    /// Global�� ���� ��� �����Դϴ�.
    /// </summary>
    public class Global : System.Web.HttpApplication
    {
        /// <summary>
        /// �ʼ� �����̳� �����Դϴ�.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        public Global()
        {
            InitializeComponent();
        }

        protected void Application_Start(Object sender, EventArgs e)
        {

        }

        protected void Session_Start(Object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(Object sender, EventArgs e)
        {

        }

        protected void Application_EndRequest(Object sender, EventArgs e)
        {
        }

        protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {

        }

        protected void Application_Error(Object sender, EventArgs e)
        {

        }

        protected void Session_End(Object sender, EventArgs e)
        {
            if (null == Session["UserCode"])
                return;

            string m_strConn = System.Configuration.ConfigurationSettings.AppSettings["strConn"];
            SqlConnection Con = new SqlConnection(m_strConn);

            SqlCommand sCommand = null;

            try
            {
                Con.Open();

                sCommand = new SqlCommand();
                sCommand.Connection = Con;
                sCommand.Parameters.Add(new SqlParameter("@nUserCode", int.Parse(Session["UserCode"].ToString())));
                sCommand.Parameters.Add(new SqlParameter("@nSWCode", 2009));

                sCommand.CommandType = CommandType.StoredProcedure;
                sCommand.CommandText = "up_logout_v2310";

                SqlDataReader ds = sCommand.ExecuteReader(CommandBehavior.CloseConnection);
                ds.Close();
            }
            catch
            {
            }
            finally
            {
                Con.Close();
            }

            Session.RemoveAll();
        }

        protected void Application_End(Object sender, EventArgs e)
        {

        }

        #region Web Form �����̳ʿ��� ������ �ڵ�
        /// <summary>
        /// �����̳� ������ �ʿ��� �޼����Դϴ�.
        /// �� �޼����� ������ �ڵ� ������� �������� ���ʽÿ�.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
        }
        #endregion
    }
}
