using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;
using System;
using System.Web.UI;
namespace PharmaACE.ForecastApp.Controllers
{
    public class DrugsController : BaseController
    {
        //
        // GET: /Drugs/

        public ActionResult Index(bool? returnBack)
        {
            logger.Info("Inside Drugs/Index");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && ( Session["AccessTypeKM"].SafeToNum() != 0))
            {
                Session["returnBack"] = returnBack;
                Session["SearchPage"] = "DrugsIndex";
               AutocompleteListData data = new KnowledgeManager(UnitOfWork).GetAutocompleteListData();
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                logger.Error("Exception at Drugs/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        [HttpGet]
     [OutputCache(Duration = 7200, Location = OutputCacheLocation.Server, VaryByParam = "searchModule;searchKey;searchParam;searchCondition;switchView;category")]
        public ActionResult GetDrugs(string searchKey, DrugSearchContext searchParam, SearchCondition searchCondition, bool switchView, DrugSearchModule searchModule, int? category)
        {
            logger.Info("Inside Drugs/GetDrugs");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["AccessTypeKM"].SafeToNum() != 0))
            {
                Session["searchKey"] = searchKey;
                Session["searchParam"] = searchParam;
                Session["searchCondition"] = searchCondition;
                Session["switchView"] = switchView;
                Session["searchModule"] = searchModule;
                ViewData["searchKey"] = searchKey;
                ViewData["searchParam"] = searchParam;
                DrugSearchList searchResult = new DrugSearchList();
                try
                {
                    byte productCategory = 0;
                    if (category != null)
                    
                        productCategory = byte.Parse(category.ToString());
                        searchResult = new KnowledgeManager(UnitOfWork).GetDrugSearchResult(searchKey, searchParam, searchCondition, searchModule, productCategory);
               
                    
                }
                catch (Exception ex)
                {
                    string e_msg = ex.Message;
                    logger.Error("Exception at Drugs/GetDrugs: {0} \r\n {1}", ex.Message, ex.StackTrace);
                    return RedirectToAction("Error", "Error");
                }
                if (searchResult != null)
                {
                    if (searchResult != null && searchResult.DrugsList !=null)
                    {
                        if (switchView)
                        {

                            return View("DrugSearchView", searchResult);
                        }
                        else
                            return View(searchResult);
                    }
                    else
                        return PartialView("_DataNotFound");
                }
                else
                    return PartialView("_DataNotFound");
            }
            else
                return RedirectToAction("Index", "Home");
        }
        public ActionResult ProductDetail(string productName, string companyName, int searchModule,string dosageForm)
        {
            logger.Info("Inside Drugs/ProductDetail");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["AccessTypeKM"].SafeToNum() != 0))
            {
                ProductDetail product = new ProductDetail();
                product = new KnowledgeManager(UnitOfWork).GetProductDetailByProductName(productName, companyName,dosageForm);
                product.Module = searchModule;
       
                ViewData["productName"] = productName;
                if (product != null)
                    return View(product);
                else
                    return PartialView("_DataNotFound");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at Drugs/ProductDetail: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        public ActionResult PipeLineProductDetail(string productName, string companyName, string phase)
        {
            logger.Info("Inside Drugs/PipeLineProductDetail");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["AccessTypeKM"].SafeToNum() != 0))
            {
                List< PipelineProductDetail> product = new List<PipelineProductDetail>();
                product = new KnowledgeManager(UnitOfWork).GetPipeLineProductDetailByProductName(productName, companyName, phase).ToList();
                ViewData["productName"] = productName;
                if (product != null)
                    return View(product);
                else
                    return PartialView("_DataNotFound");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at Drugs/PipeLineProductDetail: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        //[HttpPost]
        //public JsonResult GetProductNameList()
        //{
        //    BusinessLayer bal = new BusinessLayer();

        //    ProductNameListItem[] data = bal.GetAutocompleteListData();


        //    return Json(data, JsonRequestBehavior.AllowGet);
        //    // return data.ToArray();
        //}

        [HttpPost]
        public JsonResult GetAutocompleteListData()
        {
            logger.Info("Inside Drugs/GetAutocompleteListData");
            string msg = String.Empty;
            try
            {
            AutocompleteListData data = new KnowledgeManager(UnitOfWork).GetAutocompleteListData();
            return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Drugs/GetAutocompleteListData: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

            }
        }

        public ActionResult RenderSearch()
        {
            logger.Info("Inside Drugs/RenderSearch");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                AutocompleteListData data = new KnowledgeManager(UnitOfWork).GetAutocompleteListData();
                return View(data);
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                logger.Error("Exception at Drugs/RenderSearch: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }

       
        public JsonResult AddInlineDurgs(Drug dr)
        {
            logger.Info("Inside Drugs/AddInlineDurgs");
            string msg = String.Empty;
            int result = 0;
            try
            {
               result = new KnowledgeManager(UnitOfWork).AddInlineDurgs(dr);
                if (result==1)
                {
                    logger.Info("successfully");
                }
                else
                {
                    msg = "fail";
                    logger.Info(msg);
                }
               
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Drugs/GetAutocompleteListData: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true}, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetExclusivityData()
        {

            logger.Info("Inside Drug/GetExclusivityData");
            string msg = String.Empty;
            List<ExclusivityData> result = new List<ExclusivityData>();
            try
            {
                result = new KnowledgeManager(UnitOfWork).GetExclusivityListData();
                if (result != null)
                {
                    logger.Info("exclusivity Details successfully");
                }
                else
                {
                    msg = "getting exclusivity Details fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at DiseaseArea/GetExclusivityData: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }


        public JsonResult AddPatentDetails(PatentData createdDealData)
        {
            logger.Info("Inside Drugs/AddPatentDetails");
            string msg = String.Empty;
            int result = 0;
            try
            {
                result = new KnowledgeManager(UnitOfWork).AddPatentDetails(createdDealData);
                if (result == 1)
                {
                    logger.Info("successfully");
                }
                else
                {
                    msg = "fail";
                    logger.Info(msg);
                }

            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Drugs/GetAutocompleteListData: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FetchPatentDetails(int inlineTransId)
        {

            logger.Info("Inside Drug/FetchPatentDetails");
            string msg = String.Empty;
            PatentData result = new PatentData();
            try
            {
                 result = new KnowledgeManager(UnitOfWork).FetchPatentDetails(inlineTransId);
                if (result != null)
                {
                    logger.Info("exclusivity Details successfully");
                }
                else
                {
                    msg = "getting exclusivity Details fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at DiseaseArea/GetExclusivityData: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }


    }
}
