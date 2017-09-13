using PharmaACE.ForecastApp.Models;
using PharmaACE.ForecastApp.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PharmaACE.ForecastApp.Controllers
{
    public class DiseaseListController : BaseController
    {
        public ActionResult Index()
        {
            logger.Info("Inside DiseaseList/Index");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                DiseaseListModel model = new DiseaseListModel();
                model = new KnowledgeManager(UnitOfWork).GetDiseaseNameList();
                return View(model);
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                logger.Error("Exception at DiseaseList/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
    }
}
