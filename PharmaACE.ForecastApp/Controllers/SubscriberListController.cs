using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class SubscriberListController : BaseController
    {
        // GET: /SubscriberList/
        public ActionResult Index()
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                SubscriberListModel subscriberInfo = new SubscriberListModel();                
                subscriberInfo = new UserManager(UnitOfWork).GetSubscriberList();
                return View(subscriberInfo);
            }
            else
                return RedirectToAction("Index", "Home");
        }
    }
}
