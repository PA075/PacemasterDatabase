using PharmaACE.ForecastApp.Models;
using PharmaACE.ForecastApp.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class IndicationListController : BaseController
    {
        public ActionResult Index( string DiseaseName)
        {
            logger.Info("Inside IndicationList/Index");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                IndicationListModel model = new IndicationListModel();
                model = new KnowledgeManager(UnitOfWork).IndicationIdNameListByDiseaseName(DiseaseName);
                return View(model);
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                logger.Error("Exception at IndicationList/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
    }
}
