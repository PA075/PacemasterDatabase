using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using PharmaACE.ForecastApp.Models;
using PharmaACE.ForecastApp.Business;
using System.Data;
using System.IO;
using Ionic.Zip;
using NLog;

namespace PharmaACE.ForecastApp.Controllers
{
    public class UserWorkSpaceController : BaseController
    {
        public ActionResult Index()
        {
            logger.Info("Inside UserWorkSpace/Index");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                try
                {
                    if (Session == null)
                        logger.Error("Session is null");
                    
                    int tenantId = int.Parse(Session["CompanyId"].ToString());

                    int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
                    int RoleId = int.Parse(Session["RoleId"].ToString());

                    UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
                    logger.Info("Getting RootFolder values");

                    var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString()));
                    ViewBag.rootFolder = RootFolder;
                    logger.Info("RootFolder values Length :{0}", RootFolder.Count());
                    ViewBag.stageList = new SelectList(userFolders.GetStages(), "Id", "Name");
                    ViewBag.activitiesList = new SelectList(userFolders.GetActivities(), "Id", "Name");


                    List<UserInfo> users = new UserManager(UnitOfWork).GetAllUsersByTenant(tenantId, ForecastModelType.BDL);
                    UserInfo CurrentUser = new UserInfo();
                    CurrentUser.FullName = (Session["FirstName"].ToString() + " " + Session["LastName"].ToString());
                    CurrentUser.Email = Session["User"].ToString();
                    CurrentUser.UserId = Session["UserId"].ToString().SafeToNum();
                  
                  
                    if ((!users.Any(u => u.UserId == CurrentUser.UserId)) && RoleId!=3 && AllFetch!=1  )
                    {
                        users.Insert(0, CurrentUser);
                    }
                    ViewBag.users = users;

                   
                    var ProjPriority = from ProjectPriority e in Enum.GetValues(typeof(ProjectPriority))
                                       select new
                                       {
                                           ID = (int)e,
                                           Name = (int)e
                                       };
                    ViewBag.ProjPriority = new SelectList(ProjPriority, "ID", "Name");
                    // = Enum.GetValues(typeof(Extension)).Cast<Extension>();

                    var CurrencyType = from CurrencyType t in Enum.GetValues(typeof(CurrencyType))
                                       select new
                                       {
                                           ID = (int)t,
                                           Name = GetCurrencySymbol((int)t)
                                       };
                    ViewBag.CurrencyType = new SelectList(CurrencyType, "ID", "Name");



                    return View();
                }
                catch (Exception ex)
                {
                    logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
                    return RedirectToAction("Error", "Error");
                }
                
            }
            else
                return RedirectToAction("Index", "Home");
        }

        private string GetCurrencySymbol(int t)
        {
            string ret = "$";
            switch (t)
            {
                case 1:
                    ret = "$";
                    break;
                case 2:
                    ret = "£";
                    break;
                case 3:
                    ret = "€";
                    break;
                default:
                    ret = "$";
                    break;
            }

            return ret;
        }

        public ActionResult LeftPaneFolderRoot()
        {
            logger.Info("Inside UserWorkSpace/LeftPaneFolderRoot");
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());

            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
            try
            {
            var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString())); 
            ViewBag.rootFolder = RootFolder;
                logger.Info("RootFolder values Length :{0}", RootFolder.Count());
                return PartialView();
            }
            catch (Exception ex)
            {
                logger.Error("Exception at UserWorkSpace/LeftPaneFolderRoot: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
           
        }

        public ActionResult LeftPaneSearchView()
        {
            logger.Info("Inside UserWorkSpace/LeftPaneSearchView");
            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
            try
            {
                  //  var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString()));

                    //var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString()));
                    //ViewBag.rootFolderForSearch = RootFolder;


                    ViewBag.users = (new UserManager(UnitOfWork).GetAllUsersByTenant(int.Parse(Session["CompanyId"].ToString()), ForecastModelType.BDL));

                 
                    List<SelectListItem> models = Enum.GetValues(typeof(ExtensionType)).Cast<ExtensionType>().Select(v => new SelectListItem
                    {
                        Text = v.ToString(),
                        Value = ((int)v).ToString()
                    }).ToList();

                    //ViewBag.Extension = models;
                    ViewBag.ExtensionType = models;
                return PartialView();

            }
            catch (Exception ex)
            {
                logger.Error("Exception at UserWorkSpace/LeftPaneSearchView: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }

        public JsonResult CreateFolder(string parentId, string childName)
        {
            logger.Info("Inside UserWorkSpace/CreateFolder");
            string msg = String.Empty;
            int result = 0;
            int id = Convert.ToInt32(parentId);
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork);
            try
            {
                if (!String.IsNullOrEmpty(childName.Trim()))
                {
                    result = userFolders.AddFolder(id, childName, int.Parse(Session["UserId"].ToString()));
                    if (result == 1)
                    {
                        logger.Info("{0} is created successfully", childName);
                    }
                    else if (result == 2)
                    {
                        logger.Info("{0} name already exist", childName);
                    }
                    else if (result == 0)
                    {
                        msg = "fail to create folder";
                        logger.Info(msg);
                    }
                }
                else
                {
                    msg = "fail to create folder";
                    logger.Info(msg);
                }
                }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/CreateFolder: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, result = result , errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult delete(string objectIdStringForDelete, string lineageStringForDelete)
        {
            logger.Info("Inside UserWorkSpace/delete");
            string msg = String.Empty;
            int result = 0;
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork);
            try
            {
            result = userFolders.delete(objectIdStringForDelete, lineageStringForDelete, int.Parse(Session["UserId"].ToString()));
                if (result==2)
                {
                    logger.Info("Folders/files are deleted Successfully");
                }
                else if (result==1)
                {
                    logger.Info("Folders/files already deleted");
                }
                else
                {
                    msg = "Folders/files unable to delete";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/delete: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        //public JsonResult paste_old(string objectIdsForCopy, string lineagesForCopy, int objectIdForPaste, string lineageForPaste,string arrayOfNamesForCopy)
        //{
        //    logger.Info("Inside UserWorkSpace/paste");
        //    string msg = String.Empty;
        //    int result = 1;
        //    UserWorkspace userFolders = new UserWorkspace(UnitOfWork);
        //    try
        //    {
        //    result = userFolders.paste(objectIdsForCopy, lineagesForCopy, objectIdForPaste, lineageForPaste, int.Parse(Session["UserId"].ToString()), arrayOfNamesForCopy);
        //        if (result==0)
        //        {
        //            logger.Info("Successfully paste");
        //        }
        //        else if (result==2)
        //        {
        //            msg = "some of File/folder are deleted we can not paste";
        //            logger.Info(msg);
        //        }
        //        else
        //        {
        //            msg = "fail to paste file";
        //            logger.Info(msg);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        msg = ex.Message;
        //        logger.Error("Exception at UserWorkSpace/paste: {0} \r\n {1}", ex.Message, ex.StackTrace);
        //    }
        //    if (String.IsNullOrEmpty(msg))
        //        return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
        //    else
        //        return Json(new { success = false, result = result, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //}


        public JsonResult pasteFolder(string objectIdsForCopy, string lineagesForCopy, int objectIdForPaste, string lineageForPaste, string arrayOfNamesForCopy)
        {
            logger.Info("Inside UserWorkSpace/paste");
            string msg = String.Empty;
            int result = 0;
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork);
            try
            {
                result = userFolders.pasteFolder(objectIdsForCopy, lineagesForCopy, objectIdForPaste, lineageForPaste, int.Parse(Session["UserId"].ToString()), arrayOfNamesForCopy);
                if (result == 1)
                {
                    logger.Info("Successfully paste");
                }
                else if (result == 2)
                {
                    msg = "Some of file(s)/folder(s) are not available";
                    logger.Info(msg);
                }
                else if (result == 0)
                {
                    msg = "fail to paste file";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/paste: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, result = result, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult pastefile(string objectIdsForCopy, string lineagesForCopy, int objectIdForPaste, string lineageForPaste, string arrayOfNamesForCopy)
        {
            logger.Info("Inside UserWorkSpace/paste");
            string msg = String.Empty;
            int result = 0;
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork);
            try
            {
                result = userFolders.pastefile(objectIdsForCopy, lineagesForCopy, objectIdForPaste, lineageForPaste, int.Parse(Session["UserId"].ToString()), arrayOfNamesForCopy);
                if (result == 1)
                {
                    logger.Info("Successfully paste");
                }
                else if (result == 2)
                {
                    msg = "some of File/folder are deleted we can not paste";
                    logger.Info(msg);
                }
                else if (result == 0)
                {
                    msg = "fail to paste file";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/paste: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, result = result, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult checkNameForPaste(int objectIdForPaste, string lineageForPaste,string arrayOfNamesForCopy)
        {
            logger.Info("Inside UserWorkSpace/checkNameForPaste");
            string msg = String.Empty;
            int result = 1;
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork);
            try
            {
            result = userFolders.checkNameForPaste( objectIdForPaste, lineageForPaste, int.Parse(Session["CompanyId"].ToString()), int.Parse(Session["UserId"].ToString()), arrayOfNamesForCopy);
           if(result==0)
                {
                    logger.Info("File(s)/Folder(s) name already present");
                }
                else if (result == 1)
                {
                    logger.Info("File(s)/Folder(s) name is not present");
                }
          
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/checkNameForPaste: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult renameObject(string objectId, string newName)
        {
            int result = 0;
            logger.Info("Inside UserWorkSpace/renameFolder");
            string msg = String.Empty;
            int id = Convert.ToInt32(objectId);
            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());


            UserWorkspace userFolders = new UserWorkspace(UnitOfWork,RoleId, AllFetch);
            try
            {
                if (newName.Trim().Length <=255 && newName.Trim().Length!=0)
                {
                    result = userFolders.renameObject(id, newName, int.Parse(Session["CompanyId"].ToString()), int.Parse(Session["UserId"].ToString()));
                    if (result == 3)
                    {
                        logger.Info("file/folder name {0}  is exist", newName);
                    }
                    else if (result == 1)
                    {
                        logger.Info("file/folder name {0} is changed to {1} successfully", objectId, newName);
                    }
                    else if (result == 4)
                    {
                        logger.Info("file/folder for rename is not available");

                    }
                    else if (result == 5)
                    {
                        logger.Info("file/folder for rename is not available");

                    }
                    else if (result == 0)
                    {
                        msg = "fail to rename file/folder";
                        logger.Info(msg);
                    }
                }
                else
                {
                    msg = "file/folder name length is too long";
                    logger.Info(msg);
                } 
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/renameFolder: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, result = result, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult UploadDocuments(string lineage, int parentId)
        {
            logger.Info("Inside UserWorkSpace/UploadDocuments");
            bool isValidExt = true;
            bool isAlreadyPresentName = true;
            string alreadyPresentName = "";
            bool isValidStream = true;
            int uploadedFileCount = 0;
            string msg = String.Empty;
            
            try
            {
                int tenantId = int.Parse(Session["CompanyId"].ToString());
                int userId = int.Parse(Session["UserId"].ToString());

                if (lineage.Trim() == "0")
                {
                    lineage = parentId.ToString();
                }
                //else if (true)
                //{
                //    lineage = lineage+ GenUtil.LINEAGE_SPLITTER +parentId.ToString();


                //}

                for (int i = 0; i < Request.Files.Count; i++)
                {
                    var file = Request.Files[i];
                    logger.Info("checking file filter extension");
                    isValidExt = GenUtil.fileFilterExtensions(file);

                  //  extension = Path.GetExtension(file.FileName);
                    int index = file.FileName.LastIndexOf('.');
                    string fileExtension = file.FileName.Substring(index + 1);
                    if (isValidExt)
                    {

                     // isValidStream = GenUtil.getActualTypeOfFile(file, extension);
                        if (isValidStream == false)
                        {
                            msg = "Invalid file extension " + fileExtension + "!";
                            logger.Info(msg);
                            //  result = false;
                            break;
                        }
                    }

                    if (isValidExt == false)
                    {   
                        msg = "One of selected file has invalid extension!";
                        logger.Info(msg);
                        // result = false;
                        break;
                    }
                    if (isValidStream==true && isValidExt==true)
                    {
                        logger.Info("checking file is already present");
                        isAlreadyPresentName = new UserWorkspace(UnitOfWork).CheckAlreadyPresentName(lineage, file.FileName);

                    if (isAlreadyPresentName)
                    {
                            logger.Info("file is already present");
                            alreadyPresentName  = alreadyPresentName + Path.GetFileName(file.FileName) ;
                        break;
                    }
                }
                }

                if (isAlreadyPresentName==false && isValidStream == true && isValidExt == true)
                {
                    logger.Info("calling upload file function");
                    uploadedFileCount =   new UserWorkspace(UnitOfWork).UploadDocuments(tenantId, userId, lineage, Request.Files);
                    if (uploadedFileCount>0)
                    {
                        logger.Info("{0} file uploaded successfully", uploadedFileCount);
                    }
                    else
                    {
                        msg = "Unable to upload file ";
                        logger.Info(msg);
                    }
                }

                if (alreadyPresentName != "")
                {
                    msg = alreadyPresentName + " is already present.";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                uploadedFileCount = -1;
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/UploadDocuments: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }

            if (String.IsNullOrEmpty(msg) && uploadedFileCount != -1)
                return Json(new { success = true, uploadedFileCount = uploadedFileCount, status = 1 }, JsonRequestBehavior.AllowGet);
            else
            {
                if (uploadedFileCount == -1)
                {
                    return Json(new { success = false, uploadedFileCount = uploadedFileCount, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

                }
                else
                {
                    return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
                }
                
            }
        }

        public ActionResult LeftPaneReportingView()
        {
            logger.Info("Inside UserWorkSpace/LeftPaneReportingView");
            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());

            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);

            try
            {
           // var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString()));

           // var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString()));
          //  ViewBag.rootFolderForSearch = RootFolder;
            }
            catch (Exception ex)
            {
                logger.Error("Exception at UserWorkSpace/LeftPaneReportingView: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            return PartialView("LeftPaneReportingView");
        }


        public ActionResult LeftPaneFolderViewWithIndex(int ObjectId, string lineage, string parentIndex,bool isProject)
        {
            logger.Info("Inside UserWorkSpace/LeftPaneFolderViewWithIndex");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {

                int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
                int RoleId = int.Parse(Session["RoleId"].ToString());

                UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);

               
                List<UWObject> UWFileFolder = new List<UWObject>();

                UWFileFolder = userFolders.GetContentfFolder(int.Parse(Session["UserId"].ToString()), ObjectId, lineage, isProject, parentIndex);

                ViewBag.ContentFolderList = UWFileFolder;

                return PartialView("LeftPaneFolderView");

            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at UserWorkSpace/LeftPaneFolderViewWithIndex: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
            //UserWorkspace userFolders = new UserWorkspace(UnitOfWork);           
            //var RootFolder = userFolders.GetRootFolder(int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
            //ViewBag.rootFolder = RootFolder;
            //return PartialView();
        }


        public JsonResult GetAllUsers(ForecastModelType type)
        {
            logger.Info("Inside UserWorkSpace/GetAllUsers");
            type = ForecastModelType.BDL;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            string msg = null;
            List<UserInfo> users = new List<UserInfo>();
            try
            {
            users = new UserManager(UnitOfWork).GetAllUsersByTenant(tenantId, type);
                if (users != null)
                {
                    logger.Info("Got all Users Successfully");
                }
                else
                {
                    msg = "Getting all Users fail";
                    logger.Info(msg);
                }
                ViewBag.stageList = new SelectList(new UserManager(UnitOfWork).GetAllUsersByTenant(tenantId, type), "Id", "FirstName " + "LastName");
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, users = users }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetActivityDetailJSON(int ObjectId, string lineage)
        {
            logger.Info("Inside UserWorkSpace/GetActivityDetailJSON");
            string msg = String.Empty;
            if (lineage.Trim() == "0")
            {
                lineage = ObjectId.ToString();

            }
            else
            {
                lineage = lineage.Trim() + GenUtil.LINEAGE_SPLITTER + ObjectId;

            }

            UserWorkspace userReportingFile = new UserWorkspace(UnitOfWork);
            List<UWActivityReporting> UWReporting = new List<UWActivityReporting>();
            try
            {
                logger.Info("Fetching activity data");
                UWReporting = userReportingFile.GetContentFileForReporting(int.Parse(Session["UserId"].ToString()), ObjectId, lineage);
                if (UWReporting != null)
                {
                    logger.Info("Fetching activity data successfully");
                }
                else
                {
                    msg = "Fetching activity data fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/GetActivityDetailJSON: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, ContentFileList = UWReporting }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetEditableWorkSpaceJSON(int ObjectId, string lineage)
        {
            logger.Info("Inside UserWorkSpace/GetEditableWorkSpaceJSON");
            string msg = String.Empty;
            if (lineage.Trim() == "0")
            {
                lineage = ObjectId.ToString();

            }
            else
            {
                if (lineage.Contains(ObjectId.ToString()))
                {

                }
                else
                {
                    lineage = lineage.Trim() + GenUtil.LINEAGE_SPLITTER + ObjectId;
                }
            }


            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());

            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
           // UserWorkspace userFolders = new UserWorkspace(UnitOfWork);

            List<UWObject> UWFileFolder = new List<UWObject>();
            try
            {
            UWFileFolder = userFolders.GetContentfFile(int.Parse(Session["UserId"].ToString()), ObjectId, lineage);
                if (UWFileFolder != null)
                {
                    logger.Info("Fetching project  files successfully");
                }
                else
                {
                    msg = "Fetching  project files fail";
                    logger.Info(msg);
                }
                //  ViewBag.ContentFolderList = UWFileFolder;
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/GetEditableWorkSpaceJSON: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, ContentFolderList = UWFileFolder }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            //  return PartialView();

        }


      

        public ActionResult ProjectSummary()
        {
            logger.Info("Inside ProjectSummary/Index");

            return PartialView();
        }

        public JsonResult getActivityData()
        {
            logger.Info("Inside getActivityData/getActivityData");
            string msg = String.Empty;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            int userId = int.Parse(Session["UserId"].ToString());
            TrackerData trackerdata = new TrackerData();

            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());
            logger.Info("Access Type BDL for project={0}\r\n Role ID={1}", AllFetch, RoleId);
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
            try
            {
            trackerdata.screenProfileCounts = userFolders.getCounts("Screen / Profile", userId);
            trackerdata.DilligenceCounts = userFolders.getCounts("Diligence", userId);
            trackerdata.NegotiationCounts = userFolders.getCounts("Negotiation", userId);
            trackerdata.onHoldWithdrwalCounts = userFolders.getCounts("onHoldWithdrwal", userId);
            logger.Info("screenProfileCounts={0},DilligenceCounts={1},NegotiationCounts={2},onHoldWithdrwalCounts={3}", trackerdata.screenProfileCounts, trackerdata.DilligenceCounts, trackerdata.NegotiationCounts, trackerdata.onHoldWithdrwalCounts);

            trackerdata.screenProfileCounts_Price = Convert.ToString(userFolders.getPrices("Screen / Profile", userId));
            trackerdata.Dilligence_Price = Convert.ToString(userFolders.getPrices("Diligence", userId));
            trackerdata.Negotiation_Price = Convert.ToString(userFolders.getPrices("Negotiation", userId));
            trackerdata.onHoldWithdrwal_Price = Convert.ToString(userFolders.getPrices("onHoldWithdrwal", userId));
            trackerdata.Total_Price =Convert.ToString(userFolders.getPrices("Total", userId));
            logger.Info("screenProfileCounts_Price={0},Dilligence_Price={1},Negotiation_Price={2},onHoldWithdrwal_Price={3},Total_Price={4}", trackerdata.screenProfileCounts_Price, trackerdata.Dilligence_Price, trackerdata.Negotiation_Price, trackerdata.onHoldWithdrwal_Price, trackerdata.Total_Price);

            List<ActivityListData> activityListData = userFolders.GetActivitiesList(userId);
            trackerdata.TrackerDataList = activityListData;

            ViewBag.activityListData = trackerdata;
                if (trackerdata != null)
                {
                    logger.Info("Fetching activity List Data  successfully");
                }
                else
                {
                    msg = "Fetching  activity List Data fail ";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/getActivityData: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, trackerdata = trackerdata }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DownloadFile(int objectId)
        {
            logger.Info("Inside UserWorkSpace/DownloadFile");
            string msg = String.Empty;
            UserWorkspace uw = new UserWorkspace(UnitOfWork);
            try
            {
                string Id = uw.GetFilePath(objectId, int.Parse(Session["UserId"].ToString()));
                if (!string.IsNullOrEmpty(Id))
                {
                    Id = Id + GenUtil.lineSeperator + int.Parse(Session["CompanyId"].ToString());
                    string fileName = string.Empty;
                    StorageTypeFactory factory = new ConcreteStorageFactory();
                    StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                    var byteArr = storagefactory.Download(UnitOfWork, Id, StorageContext.WorkSpace);
                    if (byteArr != null)
                    {
                        logger.Info("got byte array for Download file");
                        fileName = uw.GetFileName(objectId, int.Parse(Session["UserId"].ToString()));
                        if (fileName != null)
                        {
                            logger.Info("{0} file Downloaded successfully", fileName);
                            return File(byteArr, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
                        }
                        else
                        {
                            logger.Info("File name not found to download a file");

                        }

                    }
                    else
                    {
                        msg = "byte array not found to download file";
                        logger.Info(msg);
                    }
                }
                else
                {
                    logger.Info("File path not found to download file");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/DownloadFile: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            return RedirectToAction("Error", "Error");
        }

        public ActionResult openFile(int objectId, string extn)
        {
            logger.Info("Inside UserWorkSpace/openFile");
            string msg = String.Empty;
            UserWorkspace uw = new UserWorkspace(UnitOfWork);
            try
            {

                string Id = uw.GetFilePath(objectId, int.Parse(Session["UserId"].ToString()));
                if (!string.IsNullOrEmpty(Id))
                {
                    Id = Id + GenUtil.lineSeperator + int.Parse(Session["CompanyId"].ToString());
                    string fileName = string.Empty;
                    StorageTypeFactory factory = new ConcreteStorageFactory();
                    StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                    var byteArr = storagefactory.Download(UnitOfWork, Id, StorageContext.WorkSpace);
                    if (byteArr != null)
                    {
                        logger.Info("got byte array for open file");

                        fileName = uw.GetFileName(objectId, int.Parse(Session["UserId"].ToString()));
                        if (fileName != null)
                        {
                            if (extn == Extension.PDF.ToString().ToLower())
                            {
                                string mimeType = "application/pdf";
                                Response.AppendHeader("Content-Disposition", "inline; filename" + fileName);
                                logger.Info("{0} file open successfully", fileName);
                                return File(byteArr, mimeType);
                            }

                            else
                            {

                                Response.ContentType = "image/" + extn;
                                Response.BinaryWrite(byteArr);
                                Response.End();

                            }
                        }
                        else
                        {
                            logger.Info("File name not found to open file");

                        }
                    }
                    else
                    {
                        msg = "not get byte array for open file";
                        logger.Info(msg);

                    }


                }
                else
                {
                    logger.Info("File path not found to open a file");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            return RedirectToAction("Error", "Error");
        }

        public ActionResult downloadSelectedFile(string objectIdString)
        {
            logger.Info("Inside UserWorkSpace/downloadSelectedFile");
            string msg = String.Empty;
            var arrOfObjectId = objectIdString.Split('|');
            ZipFile zipFile = new ZipFile();

            for (int i = 0; i < arrOfObjectId.Length - 1; i++)
            {
                int objectId;

                objectId = Convert.ToInt32(arrOfObjectId[i]);
                UserWorkspace uw = new UserWorkspace(UnitOfWork);
                string Id = uw.GetFilePath(objectId, int.Parse(Session["UserId"].ToString()));
                if (!string.IsNullOrEmpty(Id))
                {
                    Id = Id + GenUtil.lineSeperator + int.Parse(Session["CompanyId"].ToString());
                    string fileName = string.Empty;
                    StorageTypeFactory factory = new ConcreteStorageFactory();
                    StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                    var byteArr = storagefactory.Download(UnitOfWork, Id, StorageContext.WorkSpace);
                    if (byteArr != null)
                    {
                        logger.Info("got byte array for downloading selected file");
                        fileName = uw.GetFileName(objectId, int.Parse(Session["UserId"].ToString()));
                        if (fileName == null)
                        {
                            return RedirectToAction("Error", "Error");
                        }
                        else
                        {
                            MemoryStream stream = new MemoryStream(byteArr);

                            stream.Seek(0, SeekOrigin.Begin);

                            ICollection<string> arrFileName = zipFile.EntryFileNames;
                            var addzipFileName = Path.GetFileNameWithoutExtension((fileName));
                            var zipExtn = Path.GetExtension(fileName);

                            foreach (var item in arrFileName)
                            {

                                for (int j = 0; j < zipFile.Count; j++)
                                {

                                    if (addzipFileName + zipExtn == item)
                                    {
                                        if (addzipFileName.Contains("("))
                                        {
                                            string[] arraddzipFileName = addzipFileName.Split('(');
                                            string[] lastPart = arraddzipFileName[1].Split(')');
                                            int count = Convert.ToInt32(lastPart[0]);
                                            addzipFileName = addzipFileName + "(" + j + ")";

                                        }
                                        else
                                        {
                                            addzipFileName = addzipFileName + "(" + Convert.ToInt32(j + 1) + ")";
                                        }

                                    }
                                }
                            }
                            zipFile.AddEntry(addzipFileName + zipExtn, stream);
                        }
                    }
                    else
                    {
                        msg = "not get byte array for downloading selected file";
                        logger.Info(msg);
                    }


                }

            }
            UserWorkspace uwForZip = new UserWorkspace(UnitOfWork);
            var zipFileName = uwForZip.GetFileName(Convert.ToInt32(arrOfObjectId[0]), int.Parse(Session["UserId"].ToString()));
            var zipFileNameWithoutExtn = Path.GetFileNameWithoutExtension(zipFileName);
            Response.ClearContent();
            Response.ClearHeaders();
            Response.AppendHeader("content-disposition", "attachment; filename=" + zipFileNameWithoutExtn + ".zip");

            zipFile.Save(Response.OutputStream);
            zipFile.Dispose();


            return null;

        }


        public JsonResult SaveProject(DealData dt)
        {
            logger.Info("Inside getActivityData/SaveProject");
            string msg = String.Empty;
            UserWorkspace uw = new UserWorkspace(UnitOfWork);
            int result = 0;
            try
            {
                int tenantId = int.Parse(Session["CompanyId"].ToString());
                int userId = int.Parse(Session["UserId"].ToString());
                if (Session != null && (!string.IsNullOrEmpty(Session["UserId"].ToString())) && (!string.IsNullOrEmpty(Session["CompanyId"].ToString())))
                {
                    if ((dt.Value).ToString().Length > 16)
                    {
                        msg = "deal value is too long";
                        logger.Info(msg);
                    }
                    else
                    {


                        if (dt.OperationType == 0)
                        {
                            result = uw.ModifyProject(userId, dt);
                            if (result == 1)
                            {
                                logger.Info("Modify the project successfully");
                            }
                            else
                            {
                                msg = "unable to Modify project ";
                                logger.Info(msg);
                            }
                        }
                        else if (dt.OperationType == 1)
                        {
                            result = uw.CreateProject(userId, dt);
                            if (result == 1)
                            {
                                logger.Info("Create the project successfully");
                            }
                            else
                            {
                                msg = "unable to Create project";
                                logger.Info(msg);
                            }
                        }
                    }
            }
                else
                {
                msg = "Invalid session";
                logger.Info(msg);
            }
        }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/SaveProject: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveProject_old(string name,decimal deal,int currency,string performance,int status, int bdl, int dealchamp, int activity,int priority,int operationType,int projectId,string owner)
        {
            UserWorkspace uw = new UserWorkspace(UnitOfWork);
            int result=0;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            int userId= int.Parse(Session["UserId"].ToString());
            if (operationType==0)
            {
                result = uw.ModifyProject_old(userId,currency,name, deal, performance, status, bdl, dealchamp, activity, priority,projectId,owner);
            }
            else if (operationType == 1)
            {
                result = uw.CreateProject_old(userId,currency, name, deal, performance, status, bdl, dealchamp, activity, priority);
            }

            return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult fetchProjectData(int ObjectId)
        {
            logger.Info("Inside UserWorkSpace/fetchProjectData");
            string msg = String.Empty;
            UserWorkspace projectDetails = new UserWorkspace(UnitOfWork);
            DealData dt = new DealData();
            try
            {
            dt = projectDetails.projectDetails(int.Parse(Session["UserId"].ToString()), ObjectId);
                if (dt != null)
                {
                    logger.Info("Fetching Project Data  successfully");
                }
                else
                {
                    msg = "Fetching  Project Data fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/fetchProjectData: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, dealDetails = dt }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetActivityWiseProjList(int activityId,string projIds)
        {
            logger.Info("Inside UserWorkSpace/fetchProjectData");
            string msg = String.Empty;
            List<DealData> actProjList = new List<DealData>();
            int userId = int.Parse(Session["UserId"].ToString());

            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());
            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
            try
            {
            actProjList = userFolders.GetActivityWiseProjList(activityId, userId, projIds);
                if (actProjList != null)
                {
                    logger.Info("Got ActivityWise Project List successfully");
                }
                else
                {
                    msg = "Getting ActivityWise Project List fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                 logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, actProjList = actProjList }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetStageWiseProjList(string stageName)
        {
            logger.Info("Inside UserWorkSpace/getActivityData");
            string msg = String.Empty;
            List<DealData> actProjList = new List<DealData>();
            int userId = int.Parse(Session["UserId"].ToString());
            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());

            UserWorkspace userFolders = new UserWorkspace(UnitOfWork, RoleId, AllFetch);
            try
            {
            actProjList = userFolders.GetStageWiseProjList(stageName, userId);
                if (actProjList != null)
                {
                    logger.Info("Got stageWise Project List successfully");
                }
                else
                {
                    msg = "Getting ActivityWise Project List fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex) 
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/Index: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
          return Json(new { success = true, actProjList = actProjList }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult AdvSearch(AdvanceSearch ads)
        {
            logger.Info("Inside UserWorkSpace/AdvSearch");
            string msg = String.Empty;
            int AllFetch = int.Parse(Session["AccessTypeBDLforproject"].ToString());
            int RoleId = int.Parse(Session["RoleId"].ToString());

            List<UWObject> uwlist = new List<UWObject>();
            try
            {
            uwlist = new UserWorkspace(UnitOfWork, RoleId, AllFetch).AdvSearch(int.Parse(Session["CompanyId"].ToString()),int.Parse(Session["UserId"].ToString()), ads);
                if (uwlist != null)
                {
                    logger.Info("Got Advance search data successfully");
                }
                else
                {
                    msg = "Getting Advance search data fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/AdvSearch: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, ContentFolderList = uwlist }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
               
        public JsonResult ContentFilterSearch(string contentKeyWord, bool isFullTextSearch,string selectedFolder)
        {
            logger.Info("Inside UserWorkSpace/ContentFilterSearch");
            string msg = String.Empty;
            try
            {

            List<FullTextSearch> flts = new UserWorkspace(UnitOfWork).ContentFilterSearch(int.Parse(Session["CompanyId"].ToString()),  int.Parse(Session["UserId"].ToString()), contentKeyWord, isFullTextSearch,selectedFolder);
            return Json(new { success = true, FileIds = flts }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/ContentFilterSearch: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }
                
        public  JsonResult fetchPermission()
        {
            logger.Info("Inside UserWorkSpace/fetchPermission");
            string msg = String.Empty;
            try
            {
                var Permission = from ObjectPermission  e in Enum.GetValues(typeof(ObjectPermission))
                             where ( (int)e!=(byte)ObjectPermission.ContetFileShare && (int)e!=(byte)ObjectPermission.NoAccess)
                               select new
                               {

                                   ID = (int)e,
                                   Name = e.ToString()
                               };
                return Json(new { success = true, Permission = Permission }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/fetchPermission: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
           
        }
        public JsonResult fetchFilePermission()
        {
            logger.Info("Inside UserWorkSpace/fetchFilePermission");
            string msg = String.Empty;
            try
            {
            var Permission = from ObjectFilePermission e in Enum.GetValues(typeof(ObjectFilePermission))
                             where ((int)e != (byte)ObjectPermission.ContetFileShare && (int)e != (byte)ObjectPermission.NoAccess)

                             select new
                             {
                                 ID = (int)e,
                                 Name = e.ToString()
                             };
            return Json(new { success = true, Permission = Permission }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/fetchFilePermission: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

            }
        }
        public JsonResult fetchFolderPermission()
        {
            logger.Info("Inside UserWorkSpace/fetchFolderPermission");
            string msg = String.Empty;
            try
            {
            var Permission = from ObjectFolderPermission e in Enum.GetValues(typeof(ObjectFolderPermission))
                             where ((int)e != (byte)ObjectPermission.ContetFileShare && (int)e != (byte)ObjectPermission.NoAccess)
                             select new
                             {
                                 ID = (int)e,
                                 Name = e.ToString()
                             };
                if (Permission!=null)
                {
                    logger.Info("fetch Folder Permission Successful");
                }else
                    logger.Info("fetch Folder Permission fail");
                return Json(new { success = true, Permission = Permission }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/fetchFilePermission: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult SharePopup(int ObjectId, string folderForShare,string lineageForsharePopUp)
        {
            logger.Info("Inside UserWorkSpace/SharePopup");
            string msg = String.Empty;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            int Bdl;
            int Dealchamp;
            ShareModel shareInfo = new ShareModel();
            try
            {
            int Owner =new UserWorkspace(UnitOfWork).FetchProjectCreator(lineageForsharePopUp, ObjectId, out Bdl, out Dealchamp);

           
            shareInfo.Name = folderForShare;
            shareInfo.ObjectId = ObjectId;
            shareInfo.BdlId = Bdl;
            shareInfo.DealChampId = Dealchamp;
            shareInfo.OwnerId = Owner;

            shareInfo.ShareType = ShareType.UserWorkSpace;
            //  

            //int[] vals = Enum.GetValues(typeof(ObjectPermission))
            //             .Cast<int>().ToArray();
                       
           // shareInfo.Permission = vals;

            
            shareInfo.UserInfo = new UserManager(UnitOfWork).GetAllUsersByTenant(tenantId, ForecastModelType.BDL);
                if (shareInfo.UserInfo != null)
                {
                    logger.Info("Got share user info successfully");
                }
                else
                {
                    msg = "Getting share user info fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at UserWorkSpace/SharePopup: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            // shareInfo.UserInfo = shareInfo.UserInfo.Where(u => u.UserId != Owner && u.UserId != Bdl && u.UserId != Dealchamp).ToList();
            //  Array myArray = Enum.GetValues(typeof(ObjectPermission));
            return View(shareInfo);

           // return View();
        }

        public JsonResult ProjCreators(int objectId,string lineageForsharePopUp)
        {
            logger.Info("Inside UserWorkSpace/ProjCreators");
            string msg = String.Empty;
            List<int> projectCreator = new List<int>();
            try
            {
           projectCreator = new UserWorkspace(UnitOfWork).FetchProjectCreatorForShare(objectId, lineageForsharePopUp);
                if (projectCreator!=null)
                {
                    logger.Info("fetching project creator successfully");
                }
                else
                {
                    msg = "fetching project creator fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/ProjCreators: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
            {
                logger.Info("Fetch Project Creator For Share successful");
                return Json(new { success = true, value = projectCreator }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FecthAlreadyShared(int ObjectId,string lineageForAlreadyShare)
        {
            logger.Info("Inside UserWorkSpace/FecthAlreadyShared");
            string msg = String.Empty;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
           
            int UserId = int.Parse(Session["UserId"].ToString());
            List<ShareModel> userForShare=null;
            try
            {

            userForShare= new UserWorkspace(UnitOfWork).FecthAlreadyShared(ObjectId, UserId,lineageForAlreadyShare);
                if (userForShare!=null)
                {
                    logger.Info("Fetch Already Shared successfully");
                }
                else
                {
                    msg = "Fetch Already Shared fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/FecthAlreadyShared: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, userForShare = userForShare }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        //public JsonResult Share_old1(List<ShareModel> userForShare, string folderNameForNotification)
        //{
        //    logger.Info("Inside UserWorkSpace/Share");
        //    string msg = String.Empty;
        //    int tenantId = int.Parse(Session["CompanyId"].ToString());
        //    var a=10;
        //    int SharedById = int.Parse(Session["UserId"].ToString());
        //    try
        //    {
        //    string LoggedinUser = Session["FirstName"] + " " + Session["LastName"];
        //    a = new UserWorkspace(UnitOfWork).Share(userForShare, SharedById, tenantId, folderNameForNotification, LoggedinUser);
        //    }
        //    catch (Exception ex)
        //    {
        //        msg = ex.Message;
        //        logger.Error("Exception at UserWorkSpace/Share: {0} \r\n {1}", ex.Message, ex.StackTrace);

        //    }
        //    if (String.IsNullOrEmpty(msg))
        //    {
        //        logger.Info(" shared successfully");
        //        return Json(new { success = true, Permission = a }, JsonRequestBehavior.AllowGet);

        //    }
        //    else
        //        return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //}

        public JsonResult SendMail(SendMailUserInfo smi)
        {
            int result = 0;
            List<string> userNames = new List<string>();
            foreach (var item in smi.SendMailInfoValue)
            {
                string str = "";
                if (item.ReceiverEmail != null)
                {
                    int rs = GenUtil.CreateMailandSend(item, smi.CommonSendInfoValue);
                    if (rs == 1)
                    {
                        str = "succesfully sent to" + item.ReceiverName;
                        userNames.Add(str);
                        result = 1;
                    }
                    else
                        str = "successfully not sent" + item.ReceiverName;
                }
            }
            if (result==1)
            {
                logger.Info("Successfully sent mail");
                return Json(new { success = true,Users= userNames }, JsonRequestBehavior.AllowGet);

            }
            else
            {
                logger.Info("Mail not send ");
                return Json(new { success = false, errors = new[] { "not send mail" } }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult Share(List<ShareModel> userForShare, string folderNameForNotification)
        {
            logger.Info("Inside UserWorkSpace/Share");
            string msg = String.Empty;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            //var a = 10;
            SendMailUserInfo smi = new SendMailUserInfo();
            int SharedById = int.Parse(Session["UserId"].ToString());
            try
            {
                string LoggedinUser = Session["FirstName"] + " " + Session["LastName"];
                smi = new UserWorkspace(UnitOfWork).Share(userForShare, SharedById, tenantId, folderNameForNotification, LoggedinUser);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/Share: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
            {
                logger.Info(" shared successfully");
                return Json(new { success = true, Permission = smi.ResultUW, SendMailUsers=smi }, JsonRequestBehavior.AllowGet);

            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult UnshareItem(int objectId, int userId, string folderNameForNotification)
        {
            logger.Info("Inside UserWorkSpace/UnshareItem");
            string msg = String.Empty;
            int value=0;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            try
            {
            value = new UserWorkspace(UnitOfWork).UnShare(objectId, userId, folderNameForNotification);
                if(value==1)
                {
                    logger.Info("Unshared item successfully");
                }
                else
                {
                    msg = "Unshared item fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/UnshareItem: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, value = value }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult PrevUserChangePermission(int ProjectID,int BDLUserId = 0,int DealChampId = 0,int BDLUserPerm=0,int DealChampIdPerm =0)
        {
            logger.Info("Inside UserWorkSpace/PrevUserChangePermission");
            string msg = String.Empty;
            int result = 0;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            int UserId = int.Parse(Session["UserId"].ToString());
            try
            {
            result = new UserWorkspace(UnitOfWork).PrevUserChangePermission(UserId,ProjectID, BDLUserId, DealChampId, BDLUserPerm, DealChampIdPerm);
              if(result==1)
                {
                    logger.Info("Previous User Change Permission successful");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/PrevUserChangePermission: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult CheckSameProjNameExist(string ProjName)
        {
            logger.Info("Inside UserWorkSpace/CheckSameProjNameExist");
            string msg = String.Empty;
            int result = 0;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            //int UserId = int.Parse(Session["UserId"].ToString());
            try
            {
            result = new UserWorkspace(UnitOfWork).CheckSameProjNameExist(ProjName);
                if (result==0)
                {
                    logger.Info("Project name is already exist");
                }else 
                if (result == 1)
                { logger.Info("Project name is not exist"); }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at UserWorkSpace/CheckSameProjNameExist: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, result = result }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
    }
}
