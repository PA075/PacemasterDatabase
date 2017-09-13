using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PharmaACE.ForecastApp.Business;

namespace PharmaACE.ForecastApp.Controllers
{
    public class DiseaseIndicationMenuController : BaseController
    {
        public ActionResult _DiseaseIndicationMenu()
        {
            logger.Info("Inside _DiseaseIndicationMenu/Index");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                var mapper = new KnowledgeManager(UnitOfWork).GetAllDiseaseAreaIndications();
                if (Request.IsAjaxRequest())
                    return PartialView("_DiseaseIndicationMenu", mapper);
                else
                    return View(mapper);
            }
            else
                return RedirectToAction("Index", "Home"); 
            }
            catch (Exception ex)
            {
                logger.Error("Exception at _DiseaseIndicationMenu/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }

        public JsonResult AddNewDiseaseArea(string newDiseaseAreaName,string newIndName)
        {
            logger.Info("Inside _DiseaseIndicationMenu/AddNewDiseaseArea");
            string msg = String.Empty;
            int result = 0;
            try
            {
                result = new KnowledgeManager(UnitOfWork).AddNewDiseaseArea(newDiseaseAreaName, newIndName);
                if (result > 0)
                {
                    logger.Info("New disease area added successfully");
                }
                else if (result ==-1)
                {
                    msg="Disease area with same name already exists";
                    logger.Info(msg);

                }

                else
                {
                    msg = "Failed to add new Disease area";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at DiseaseArea/AddNewDiseaseArea: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg },result=result }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult AddNewSubIndication(string newSubIndicationName,string primaryIndication,int diseaseAreaId)
        {
            logger.Info("Inside _DiseaseIndicationMenu/addNewSubIndication");
            string msg = String.Empty;
            int result = 1;
            try
            {
                result = new KnowledgeManager(UnitOfWork).AddNewSubIndication(newSubIndicationName, primaryIndication,diseaseAreaId);
                if (result == 0)
                {
                    logger.Info("New sub indication added successfully");
                }
                else if (result == 1)
                {
                    msg="Sub indication with same name already exists";
                    logger.Info(msg);

                }

                else
                {
                    msg = "Failed to add new indication";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at DiseaseArea/AddNewIndication: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }
        

    public JsonResult GetSecondaryIndication(string primaryIndication, int diseaseAreaId)
        {
            logger.Info("Inside _DiseaseIndicationMenu/GetSecondaryIndication");
            string msg = String.Empty;
            List<SecondaryIndication> ListSecondaryIndication = new List<SecondaryIndication>();
            try
            {
                ListSecondaryIndication = new KnowledgeManager(UnitOfWork).GetSecondaryIndication(primaryIndication, diseaseAreaId);
              
            }
            catch (Exception ex)
            {
               
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = ListSecondaryIndication }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }


        public JsonResult AddNewIndication(string newIndicationName,int diseaseAreaId)
        {
            logger.Info("Inside _DiseaseIndicationMenu/AddNewIndication");
            string msg = String.Empty;
            int result = 1;
            try
            {
                result = new KnowledgeManager(UnitOfWork).AddNewIndication(newIndicationName, diseaseAreaId);
                if (result == 0)
                {
                    logger.Info("New indication added successfully");
                }
                else if (result == 1)
                {
                    logger.Info("Indication with same name already exists");


                }

                else
                {
                    msg = "Failed to add new indication";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at DiseaseArea/AddNewIndication: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }
    }
}
