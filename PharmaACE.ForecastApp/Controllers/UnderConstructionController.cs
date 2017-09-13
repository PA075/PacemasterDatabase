using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaKMWebApp.Controllers
{
    public class UnderConstructionController : Controller
    {
        //
        // GET: /UnderConstruction/
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
