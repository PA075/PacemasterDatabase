using Newtonsoft.Json;
using Ninject;
using NLog;
using PharmaACE.ForecastApp.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PharmaACE.ForecastApp.Controllers
{
    public class BaseController : Controller
    {
        public static Logger logger = LogManager.GetCurrentClassLogger();

        [Inject]
        public IUnitOfWork UnitOfWork { get; set; }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.IsTransactional())
            {
                if (!filterContext.IsChildAction)
                    UnitOfWork.BeginTransaction();
            }
        }
        
        protected override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            if (!filterContext.IsChildAction)
            {
                bool success = true;
                try
                {                    
                    var jsonResult = filterContext.Result as JsonResult;
                    if (jsonResult != null)
                    {
                        if (filterContext.Exception != null || filterContext.Canceled)
                            success = false;
                        else
                        {
                            //if jsonresult returns success=true, that ensures controller action worked fine
                            Type type = jsonResult.Data.GetType();
                            var successProp = type.GetProperty("success");
                            if (successProp != null)
                                success = successProp.GetValue(jsonResult.Data).SafeToBool();
                        }
                    }
                }
                catch(Exception ex)
                {
                    //eat it
                }
                if(success)
                    UnitOfWork.Commit();
                else
                    UnitOfWork.Rollback();                
            }
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            UnitOfWork.Rollback();
            //Build of error source.
            string askerUrl = filterContext.RequestContext.HttpContext.Request.RawUrl;
            Exception exToLog = filterContext.Exception;
            exToLog.Source = string.Format("Source : {0} {1}Requested Path : {2} {1}", exToLog.Source, Environment.NewLine, askerUrl);
            //Log the error
            logger.Error("{0} at {1}: {2}\r\n{3}", "Unhandled Exception", askerUrl, exToLog.Message, exToLog.StackTrace);
            //Redirect to error page : you must feed filterContext.Result to cancel already executing Action
            filterContext.ExceptionHandled = true;
            var jsonResult = filterContext.Result as JsonResult;
            if (jsonResult != null)            
                filterContext.Result = Json(new { success = false, error = 100 });
            else
            {
                var actionResult = filterContext.Result as ActionResult;
                if(actionResult != null)
                    filterContext.Result = RedirectToAction("Error", "Error");
            }

            base.OnException(filterContext);            
        }
    }
}
