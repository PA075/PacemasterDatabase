using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class KMController : Controller
    {
        //
        // GET: /KM/
        public ActionResult Index(bool? returnBack,int? searchType)
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["AccessTypeKM"].SafeToNum() != 0))
            {
                Session["returnBack"] = returnBack;
                Session["searchPage"] = "KMIndex";
                Session["DSearchPage"] = "KMIndex";
                Session["searchType"]=searchType;
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }
    }
}
