using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PharmaACE.ForecastApp.Controllers
{
    public class PatentController : BaseController
    {
       
        public ActionResult Index()
        {


            logger.Info("Inside Patent/Index");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                try
                {
                    Patent patentInfo = new Patent();
                    patentInfo = new KnowledgeManager(UnitOfWork).GetPatentData();
                   

                    return View(patentInfo);
                }
                catch (Exception ex)
                {
                    logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                    return RedirectToAction("Error", "Error");
                }

            }
            else
                return RedirectToAction("Index", "Home");
        }


        public JsonResult GetPatentInfo(int inlineTransId)
        {

            logger.Info("Inside Drug/GetPatentInfo");
            string msg = String.Empty;
            PatentData result = new PatentData();
            try
            {
                result = new KnowledgeManager(UnitOfWork).GetPatentInfo(inlineTransId);
                if (result != null)
                {
                    logger.Info("patent Details successfully");
                }
                else
                {
                    msg = "getting patent Details fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Patent/GetPatentInfo: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }


    }
}
