using PharmaACE.ForecastApp.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PharmaACE.ForecastApp.Models;
namespace PharmaACE.ForecastApp.Controllers
{
    public class PatentDetailsController : BaseController
    {
        //
        // GET: /PatentDetails/
        public ActionResult Index(String ProductCode)
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                IEnumerable<PatentDetail> PatentDetailList = new List<PatentDetail>();
                PatentDetailList = new KnowledgeManager(UnitOfWork).GetPatentDetailByProductCode(ProductCode);
                if (PatentDetailList != null && PatentDetailList.Count()>=1)
                    return View("Index", PatentDetailList);
                else
                    return PartialView("_DataNotFound");
            }
            else
                return RedirectToAction("Index", "Home");
        }
    }
}
