using NLog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
namespace PharmaACE.ForecastApp
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : HttpApplication
    {
        public static Logger logger = LogManager.GetCurrentClassLogger();

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();

            ViewEngines.Engines.Clear();
            IViewEngine webformEngine = new WebFormViewEngine() { FileExtensions = new string[] { "aspx" } };
            ViewEngines.Engines.Add(webformEngine);
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exToLog = Server.GetLastError();
            logger.Error("{0} at {1}: {2}\r\n{3}", "Unhandled Exception", "Application_Error", exToLog.Message, exToLog.StackTrace);
            Server.ClearError();
            Response.Redirect("/Error/Error");
        }
    }
}