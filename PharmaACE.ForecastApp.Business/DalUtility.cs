using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace PharmaACE.ForecastApp.Business
{
    public static class DALUtility
    {
        public static string Tenantconnectionstringurl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["TenantConnectionString"];
            }
        }

        public static string PaceMasterconnectionstringurl
        {
            get
            {
                return System.Configuration.ConfigurationManager.ConnectionStrings["PaceMasterConnectionString"].ConnectionString;
               // return System.Configuration.ConfigurationManager.AppSettings["PaceMasterConnectionString"];
            }
        }

        public static string mailForm
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["MailSender"];
            }
        }

        public static string MailSenderPassword
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["MailSenderPassword"];
            }
        }

        public static string SMTPMailingHost
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["SMTPMailingHost"];
            }
        }
        public static string SMTPMailingPort
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["SMTPMailingPort"];
            }
        }
        


        public static string ConnectionStringBuilder(string dbServer, string dataBase, string dbUser, string dbPassword)
        {
            return "Data Source=" + dbServer + ";Initial Catalog=" + dataBase + ";Persist Security Info=True;User ID=" + dbUser + ";Password=" + dbPassword + ";";

        }
    }

    


}

