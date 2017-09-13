using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class DevelopmentStatusController : BaseController
    {
        //
        // GET: /DevelopmentStatus/
        public ActionResult Index()
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }
        public ActionResult Details(string StatusName)
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                ViewData["Status"] = StatusName;
                IEnumerable<DevelopmentStatus> DevStatusDetailsList = new List<DevelopmentStatus>();
                DevStatusDetailsList = new KnowledgeManager(UnitOfWork).GetProductDetailByStatusName(String.Compare(StatusName, "Inline", true) == 0 ? DrugSearchModule.Inline : DrugSearchModule.Pipeline);
                if (DevStatusDetailsList != null && DevStatusDetailsList.Count() >= 1)
                    return View(DevStatusDetailsList.AsEnumerable());
                else
                    return PartialView("_DataNotFound");
            }
            else
                return RedirectToAction("Index", "Home");
        }
    }
}
