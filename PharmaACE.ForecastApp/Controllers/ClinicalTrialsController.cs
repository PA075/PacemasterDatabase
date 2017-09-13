using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class ClinicalTrialsController : Controller
    {
        //
        // GET: /ClinicalTrials/
		// git testing
        public ActionResult Index()
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult NCTDetails(string NCT)
        {
            ViewData["NCT"] = null;
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                ViewData["NCT"] = NCT;
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }
    }
}
