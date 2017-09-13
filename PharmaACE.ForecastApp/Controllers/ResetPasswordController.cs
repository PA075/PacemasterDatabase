using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class ResetPasswordController : BaseController
    {
        //
        // GET: /ResetPassword/
        
        public ActionResult Index()
        {
            logger.Info("Inside ResetPassword/Index");
            Guid uniqueid = new Guid(Request.QueryString["uid"]);
            string email = Request.QueryString["email"];
            bool result = false;
            bool res = false;
            var model = new LinkDetail();
            model.email = email;
            model.uniqueid = uniqueid;
            try
            {
                logger.Info("checking {0} and link validation", email);
            res = new UserManager(UnitOfWork).CheckValidEmailAndGuid(email, uniqueid);
            //res = new UserManager().CheckValidEmailAndGuid(email, uniqueid);
            if (res)
            {
                    
                result = new UserManager(UnitOfWork).CheckLinkValid(email, uniqueid);
                if (result)
                {
                        logger.Info("valid email and link ");
                        return View();
                }
                else
                {
                        logger.Info("Invalid link");
                        model.errorcode = 1;
                    return View("InvalidLink", model);
                }
            }          
            else
            {
                    logger.Info("Invalid email");
                    model.errorcode = 2;
                return View("InvalidLink", model);
            }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at ResetPassword/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");

            }
        }
        [HttpGet]
        public JsonResult SetNewPassword(string email, string password,string uid)
        {
            logger.Info("Inside ResetPassword/SetNewPassword");
            Guid uniqueid = new Guid(uid);
            var status = false;

            string msg = null;
             var model = new SetNewPassword();
             model.email = email;
             model.password = password;
            int outparam = 0;
            try
            {
                status = new UserManager(UnitOfWork).CheckLinkValid(email, uniqueid);
                if (status)
                {
                    outparam = new UserManager(UnitOfWork).OnForgotPassword(email, password);
                    if (outparam == 1)
                    {
                        logger.Info("Set new password successfully");
                    }
                    else if (outparam == 4)
                    {
                        msg = "New password cannot be same as current";
                        logger.Info(msg);
                    }
                }
                else
                {
                    msg = "Invalid link";
                    logger.Info(msg);
                }
            }
            catch(Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                    return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                else
                    return Json(new { success = false, outparam = outparam, status = status, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

               
        }
        public ActionResult InvalidLink()
        {
            logger.Info("Inside ResetPassword/InvalidLink");
            return View();
        }
    }
}
