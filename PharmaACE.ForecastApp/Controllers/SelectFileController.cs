using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class SelectFileController : Controller
    {
        public ActionResult Index()
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }
    }
}
