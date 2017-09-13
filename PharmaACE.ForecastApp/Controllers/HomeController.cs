using FileTypeDetective;
using NLog;
using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class HomeController : BaseController
    {
        //[OutputCache(NoStore = true, Duration = 0)]
        [Disconnected]
        public ActionResult Index()
        {
            logger.Info("Inside Home/Index");
            return View();
        }

        [Disconnected]
        public ActionResult GetModule(string partialName)
        {
            logger.Info("Inside Home/GetModule");
            return PartialView("~/Views/Shared/HeaderViews/" + partialName);
        }

        [HttpGet]
        public JsonResult ShowUserInformation()
        {
            logger.Info("Inside Home/ShowUserInformation");
            UserInfo userInfo = new UserInfo();
            string msg = null;
            if (Session != null && (!String.IsNullOrEmpty(Session["user"].SafeTrim())))
            {
                string email;
                email = Session["User"].ToString();
                var loginDate = Session["LoginDate"];
                userInfo = new UserManager(UnitOfWork).GetUserInformationByEmail(email);
                return Json(new { success = true, userInfo = userInfo }, JsonRequestBehavior.AllowGet);
            }
            if (userInfo != null)
            {
                logger.Info("UserInformation Show Successfully");
                return Json(new { success = true, userInfo = userInfo }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public JsonResult UpdateUserProfile(string firstname, string lastname, string email)
        {
            logger.Info("Inside Home/UpdateUserProfile");
            string msg = null;
            var model = new UpdateUserProfile();
            model.FirstName = firstname;
            model.LastName = lastname;
            //model.SubscriptionStartDate = subscriptionstartdate;
            //model.SubscriptionEndDate = subscriptionstartdate;
            model.Email = email;
            Session["FirstName"] = model.FirstName;
            Session["LastName"] = model.LastName;
            int outparam = 0;
            outparam = int.Parse(new UserManager(UnitOfWork).UpdateUserProfile(firstname, lastname, email).ToString());
            if(outparam == 0)
            {
                msg = "No change in first name and last name";
                logger.Info(msg);
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else if (outparam == 1)
            {
                msg = "Updated successfully";
                logger.Info(msg);
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                msg = "Fail............ ";
                logger.Info(msg);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
            
        }

        [HttpGet]
        public JsonResult IsSignedIn()
        {
            logger.Info("Inside Home/IsSignedIn");
            try
            {
                if (Session != null && (!String.IsNullOrEmpty(Session["User"].SafeTrim())))
                {
                    logger.Info("User is " + Session["User"]);
                    return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    logger.Info("Session issue");
                    return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.Message);
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult SignInTest(string email, string password)
        {
            logger.Info("Inside Home/SignInTest");

            string msg = "";
            bool returnStatus = false;
           
            UserLoginDetails userLoginDetails = new UserLoginDetails();
            //var mac = new UserManager().GetMACAddress();
            //userLoginDetails = new UserManager().CheckUsersCredentials(email, password, out spUser, out spPassword);
            try
            {
               
                logger.Info("Checking {0} credentials", email);
                userLoginDetails = new UserManager(UnitOfWork).CheckUsersCredentials(email, password);
                if (String.IsNullOrEmpty(msg) && userLoginDetails.userInfo.LoginResult == 1)
                {
                    logger.Info("User credentials valid, setting up session variables");
                    
                    Session["User"] = email;
                    Session["CompanyId"] = userLoginDetails.userInfo.CompanyId;
                    Session["RoleId"] = userLoginDetails.userInfo.RoleId;
                    Session["FirstName"] = userLoginDetails.userInfo.FirstName;
                    Session["LastName"] = userLoginDetails.userInfo.LastName;
                    Session["User_Group"] = userLoginDetails.userInfo.UserGroup;
                    Session["Archive"] = userLoginDetails.userInfo.Archive;
                    Session["SubscriberName"] = userLoginDetails.userInfo.SubscriberName;
                    Session["ServerUrl"] = GenUtil.SPHostUrl;
                    Session["UserId"] = userLoginDetails.userInfo.UserId;
                    Session["FeedKeyword"] = userLoginDetails.userInfo.FeedKeyword;
                    //Session["RegulatoryFeedKeyword"] = userLoginDetails.userInfo.RegulatoryFeedKeyword;

                    //Get Users Permitions
                    Session["KnowledgeManagement"] = userLoginDetails.userPermission.KnowledgeManagement;
                    Session["AccessTypeKM"] = userLoginDetails.userPermission.AccessTypeKM;
                    Session["BusinessIntelligence"] = userLoginDetails.userPermission.BusinessIntelligence;
                    Session["AccessTypeBI"] = userLoginDetails.userPermission.AccessTypeBI;
                    Session["Utilities"] = userLoginDetails.userPermission.Utilities;
                    Session["AccessTypeUT"] = userLoginDetails.userPermission.AccessTypeUT;
                    Session["CustomFeed"] = userLoginDetails.userPermission.CustomFeed;
                    Session["AccessTypeCF"] = userLoginDetails.userPermission.AccessTypeCF;
                    Session["CommunityOfPractice"] = userLoginDetails.userPermission.CommunityOfPractice;
                    Session["AccessTypeCP"] = userLoginDetails.userPermission.AccessTypeCP;
                    Session["UserWorkspace"] = userLoginDetails.userPermission.UserWorkspace;
                    Session["AccessTypeUW"] = userLoginDetails.userPermission.AccessTypeUW;
                    Session["HelpDesk"] = userLoginDetails.userPermission.HelpDesk;
                    Session["AccessTypeHD"] = userLoginDetails.userPermission.AccessTypeHD;
                    Session["ForecastPlatform"] = userLoginDetails.userPermission.ForecastPlatform;
                    Session["AccessTypeFP"] = userLoginDetails.userPermission.AccessTypeFP;
                    Session["GenericTool"] = userLoginDetails.userPermission.GenericTool;
                    Session["AccessTypeGT"] = userLoginDetails.userPermission.AccessTypeGT;
                    Session["BDLTool"] = userLoginDetails.userPermission.BDLTool;
                    Session["AccessTypeBDL"] = userLoginDetails.userPermission.AccessTypeBDL;
                    Session["PatientFlow"] = userLoginDetails.userPermission.PatientFlow;
                    Session["AccessTypePF"] = userLoginDetails.userPermission.AccessTypePF;
                    Session["AccessTypePFforproject"] = userLoginDetails.userPermission.AccessTypePFforproject;
                    Session["AccessTypeBDLforproject"] = userLoginDetails.userPermission.AccessTypeBDLforproject;
                    Session["AccessTypeGTforproject"] = userLoginDetails.userPermission.AccessTypeGTforproject;

                    logger.Info("Session populated, returning with success");
                    returnStatus = true;                    
                }
                else
                {
                    logger.Info("User credentials invalid, returning with failure");
                }                
            }
            catch(Exception ex)
            {
                logger.Error("Exception at Home/SignInTest: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }

            return Json(new { success = returnStatus, userLoginDetails = userLoginDetails }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetUserNotification()
        {
            logger.Info("Inside Home/GetUserNotification");
            //IEnumerable<Notification> notifications = null;
            NotificationCount notifications = null;
            if (Session != null && (!string.IsNullOrEmpty(Session["User"] as string)))
            {
                notifications = new UserManager(UnitOfWork).GetNotifications(Session["CompanyId"].SafeToNum(), Session["UserId"].SafeToNum());
                if (notifications.Notifications.Count() >= 1)
                {
                    Session["RecentNotificationId"] = notifications.Notifications.ElementAt(0).NotificationId.ToString();
                }
                return Json(new { success = true, notifications = notifications }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                logger.Info("Invalid session");
                return Json(new { success = false, notifications = notifications }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpPost]
        public JsonResult UpdateNotificationStatus(List<int> NotificationIdArr)
        {
            logger.Info("Inside Home/UpdateNotificationStatus");
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            var UpdateStatus = new UserManager(UnitOfWork).UpdateNotificationStatus(Session["UserId"].SafeToNum(), NotificationIdArr, tenantId);
            return Json(new { success = true, UpdateStatus = UpdateStatus }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult About()
        {
            logger.Info("Inside Home/About");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                ViewBag.Message = "Your app description page.";
                return View();
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
        }
        public ActionResult Contact()
        {
            logger.Info("Inside Home/Contact");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                ViewBag.Message = "Your contact page.";
                return View();
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
         }
        public ActionResult logout()
        {
            logger.Info("Inside Home/logout");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                Session["user"] = null;
                Session["CompanyId"] = null;
                Session["RoleId"] = null;
                Session["FirstName"] = null;
                Session["LastName"] = null;
                Session["User_Group"] = null;
                Session["Archive"] = null;
                Session["SubscriberName"] = null;
                Session["ServerUrl"] = null;
                Session["UserId"] = null;
                Session["FeedKeyword"] = null;
                //Session["RegulatoryFeedKeyword"] = userLoginDetails.userInfo.RegulatoryFeedKeyword;

                //Get Users Permitions
                Session["KnowledgeManagement"] = null;
                Session["AccessTypeKM"] = null;
                Session["BusinessIntelligence"] = null;
                Session["AccessTypeBI"] = null;
                Session["Utilities"] = null;
                Session["AccessTypeUT"] = null;
                Session["CustomFeed"] = null;
                Session["AccessTypeCF"] = null;
                Session["CommunityOfPractice"] = null;
                Session["AccessTypeCP"] = null;
                Session["UserWorkspace"] = null;
                Session["AccessTypeUW"] = null;
                Session["HelpDesk"] = null;
                Session["AccessTypeHD"] = null;
                Session["ForecastPlatform"] = null;
                Session["AccessTypeFP"] = null;
                Session["GenericTool"] = null;
                Session["AccessTypeGT"] = null;
                Session["BDLTool"] = null;
                Session["AccessTypeBDL"] = null;
                Session["PatientFlow"] = null;
                Session["AccessTypePF"] = null;
                Session["AccessTypePFforproject"] = null;
                Session["AccessTypeBDLforproject"] = null;
                Session["AccessTypeGTforproject"] = null;


                return RedirectToAction("Index", "Home");
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
        }
        
		[HttpGet]
        public JsonResult UpdatePassword(string email, string currentPassword, string newPassword)
        {
            logger.Info("Inside Home/UpdatePassword");
            string msg = null;
            var model = new UpdatePassword();
            model.Email = email;
            model.CurrentPassword = currentPassword;
            model.NewPassword = newPassword;
            int outparam = 0;
            try
            {
                outparam = new UserManager(UnitOfWork).UpdatePassword(email, currentPassword, newPassword);
                if (outparam == 1)
                    msg = "Password updated successfully";
                else if (outparam == 2)
                    msg = "User does not exist";
                else if (outparam == 3)
                    msg = "Old password does not match";
                else if (outparam == 4)
                    msg = "New password cannot be same as current";
            logger.Info(msg);
        }
            catch(Exception ex)
            {
                logger.Error("Exception at Home/UpdatePassword: {0} \r\n {1}", ex.Message, ex.StackTrace);
                
            }
           
            return Json(new { success = false, status = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult UploadFile(string modelLocation)
        {
            logger.Info("Inside Home/UploadFile");
            //string modelLocation;
            //if (Request.Params["modelLocation"] != null)
            //{
            //    modelLocation = Request.Params["modelLocation"].ToString();
            //}
            //else
            //    throw new Exception("Model Location not found!");
            //string modelLocation = Request["modelLocation"];
            //int CompanyId;
            //CompanyId = int.Parse(Session["CompanyId"].ToString());
            //string Users = Session["User"].ToString();
            //BusinessLayer bal = new BusinessLayer();
            //List<string> User = new List<string>();
            //User.Add(Users);
            //var spUsers = GenUtil.GetSPUserByUserEmail(User, CompanyId);
            //var email = spUsers.Values.Select(u => new UserProfile { SP_Email = u[0] }).ToList()[0].SP_Email;
            //var password = spUsers.Values.Select(u => new UserProfile { SP_Password = u[1] }).ToList()[0].SP_Password;
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                var email = Session["SPAccount"].ToString(); //spUsers.Values.Select(u => new UserProfile { SP_Email = u[0] }).ToList()[0].SP_Email;
                var password = Session["SPPassword"].ToString(); //spUsers.Values.Select(u => new UserProfile { SP_Password = u[1] }).ToList()[0].SP_Password;
                string[] arrFileNames = new string[Request.Files.Count];
                string msg = null;
                string latestVersion;
                List<string> fileNames = new List<string>();
                List<Stream> fileStreams = new List<Stream>();
                string contentString = String.Empty;
                for (int i = 0; i < Request.Files.Count; i++)
                {
                    HttpPostedFileBase file = Request.Files[i];
                    if (file != null)
                    {
                        logger.Info("File is not Empty");
                        //use guid as the saved name to make a unique instance in any use case                    
                        string uniqueName = String.Format("{0}{1}", Guid.NewGuid().ToString(), Path.GetExtension(file.FileName));
                        fileNames.Add(uniqueName);
                        //arrFileNames[i] = String.Format("{0}{1}{2}/{3}", GenUtil.SPHostUrl, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.AssumptionAttachmentsFolder, uniqueName);
                        arrFileNames[i] = uniqueName;
                        fileStreams.Add(Request.Files[i].InputStream);
                    }
                    else if (file == null && file.ContentLength == 0)
                    {
                        logger.Info("Empty file");
                        arrFileNames[i] = String.Empty;
                    }
                }
                //SpComHelper.UploadFilesToSharePoint(GenUtil.SPSiteUrl, email, password, "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ null, fileStreams, fileNames, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/" + GenUtil.AssumptionAttachmentsFolder, out msg);
                SpComHelper.UploadFilesToSharePoint(GenUtil.SPSiteUrl, email, password, "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ null, fileStreams, fileNames, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/" + GenUtil.AssumptionAttachmentsFolder, out latestVersion, out msg);
                //dispose te file streams
                foreach (var stream in fileStreams)
                {
                    stream.Close();
                }
                contentString = String.Join("||^||", arrFileNames);
                return Content(contentString, "text/plain");
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public ActionResult UploadFileInDb(ForecastModelType type)
        {
            logger.Info("Inside Home/UploadFileInDb");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                string[] arrFileNames = new string[Request.Files.Count];
                string storageID = "";
                List<string> fileNames = new List<string>();
                List<Stream> fileStreams = new List<Stream>();
                string contentString = String.Empty;
                string key = Session["CompanyId"].ToString();
                int FlatFile = 0;
                bool isValidExt = false;
                string msg = string.Empty;
                string extension = string.Empty;
                bool isValidStream = false;
                HttpPostedFileBase file = null;
                HttpPostedFileBase newFile = null;
                try
                {
                    for (int i = 0; i < Request.Files.Count; i++)
                    {
                        file = Request.Files[i];
                        logger.Info("{0} is Uploading", file.FileName);
                        isValidExt = GenUtil.fileFilterExtensions(file);
                        extension = Path.GetExtension(file.FileName);
                        int index = file.FileName.LastIndexOf('.');
                        string fileExtension = file.FileName.Substring(index + 1);

                        int uploadTypeID = Convert.ToInt32(ConfigurationManager.AppSettings["uploadfiletype"].ToString());
                        if (isValidExt)
                        {
                            if (uploadTypeID == 0)
                            {
                                isValidStream = true;
                                msg = "";
                            }
                            else if (uploadTypeID == 1)
                            {
                                isValidStream = true;
                                //isValidStream = GenUtil.getActualTypeOfFile(file, extension);
                                if (isValidStream == false)
                                {
                                   throw new Exception("This is not " + fileExtension + "extension!");
                                }
                            }
                        }

                        if (isValidExt == false)
                        {
                           throw new Exception( "One of selected file has invalid extension!");
                        }

                    }
                    if (isValidExt == true && isValidStream == true)
                    {
                        logger.Info("Valid File Extensioin");
                        for (int j = 0; j < Request.Files.Count; j++)
                        {
                            newFile = Request.Files[j];
                            if (newFile != null && newFile.ContentLength > 0)
                            {
                                var fileName = Path.GetFileName(newFile.FileName);
                                StorageTypeFactory factory = new ConcreteStorageFactory();
                                StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                                storageID = storagefactory.Upload(UnitOfWork, key, newFile, StorageContext.Forecast, type, FlatFile);
                                //string uniqueName = String.Format("{0}{1}|{3}", Guid.NewGuid().ToString(), Path.GetExtension(file.FileName), storageID);
                                string uniqueName = String.Format("{0}", storageID);
                                arrFileNames[j] = uniqueName;
                            }
                            else if (newFile == null && newFile.ContentLength == 0)
                            {
                                logger.Info("File length is null");
                                arrFileNames[j] = String.Empty;
                            }
                        }

                    }
                    else
                    {
                        logger.Info("Invalid File Extension");
                    }
                }

                catch (Exception ex)
                {
                    logger.Error("Exception at Home/UploadFileInDb: {0} \r\n {1}", ex.Message, ex.StackTrace);
                    arrFileNames[0] = String.Empty;
                    
                }
                
               
                contentString = String.Join("||^||", arrFileNames);
                return Content(contentString, "text/plain");
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");

            }
        }


        byte[] FileStreamToByteArray(Stream stream)
        {
            logger.Info("Inside Home/FileStreamToByteArray");
            MemoryStream memoryStream = stream as MemoryStream;
            if (memoryStream == null)
            {
                memoryStream = new MemoryStream();
                stream.CopyTo(memoryStream);
            }
            return memoryStream.ToArray();
        }
        public JsonResult SendMail(string email)
        {
            logger.Info("Inside Home/SendMail");
            string msg = null;
            int outparam = 0;
            //email = Session["User"].ToString();
            var model = new ForgotPassword();
            model.email = email;
            int result = new UserManager(UnitOfWork).CheckValidUser(email);
            int sendValue = 0;

            string hostUrl = String.Format("{0}{1}{2}:{3}", Request.Url.Scheme, Uri.SchemeDelimiter, Request.Url.Host, Request.Url.Port); // TODO : write better logic for dynamic host url implementation

            if (result == 2)
            {
                logger.Info("Valid User");
                outparam = new UserManager(UnitOfWork).SendPasswordResetEmail(email, hostUrl);
            }
            else if (result == 1)
            {
                logger.Info("User doesn't exist");
                sendValue = 1;
            }
            else if (result ==3)
            {
                logger.Info("Subscription expired");
                sendValue = 2;
            }


            if (result==2 && outparam == 1)
            {
                logger.Info("Password is Send to Email");
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = false,validStatus=sendValue, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }
        public ActionResult HelpDesk()
        {
            logger.Info("Inside Home/HelpDesk");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["HelpDesk"].ToString() == "True") && (Session["AccessTypeHD"].SafeToNum() != 0))
            {
                //TopRibbon T = new TopRibbon();
                //T.LogoImagePath = "../../Content/img/call.jpg";
                //T.PageHeader = "Help Desk";
                //return View(T);

                return View();
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
        }
        [HttpPost]
        public JsonResult SendMailHelpDesk(HttpPostedFileBase file, string issue, string issuedesc, string loginEmail, string toEmail)
        {
            logger.Info("Inside Home/SendMailHelpDesk");
            string msg = string.Empty;
            List<byte[]> fileBytes = new List<byte[]>();
            List<string> fileNames = new List<string>();
            string fileNameWithoutPath;
            bool isValidExt = false;
            bool isValidStream = false;
            var fileclass = "";
            var allfield = 0; 
            string extension = string.Empty;
            bool result = false;
            try
            {
                if (issuedesc.Trim()!="" && issue.Trim()!="")
                {
                if (Request.Files.Count > 0)
                {
                    for (int i = 0; i < Request.Files.Count; i++)
                    {
                        file = Request.Files[i];
                        isValidExt = GenUtil.fileFilterExtensions(file);
                        extension = Path.GetExtension(file.FileName);
                        logger.Info("{0} is Uploading", file.FileName);
                        int index = file.FileName.LastIndexOf('.');
                        string fileExtension = file.FileName.Substring(index + 1);

                        int uploadTypeID = Convert.ToInt32(ConfigurationManager.AppSettings["uploadfiletype"].ToString());
                        if (isValidExt)
                        {
                            if (uploadTypeID == 0)
                            {
                                isValidStream = true;
                                result = true;
                                msg = "";
                            }
                            else if (uploadTypeID == 1)
                            {
                                isValidStream = true;
                                //isValidStream = GenUtil.getActualTypeOfFile(file, extension);
                                //result = true;
                                //msg = "";
                                if (isValidStream == false)
                                {
                                    msg = "This is not " + fileExtension + "extension!";
                                    result = false;
                                    break;
                                }
                            }
                        }

                        if (isValidExt == false)
                        {
                            msg = "One of selected file has invalid extension!";
                            result = false;
                            break;
                        }

                    }
                    logger.Info(msg);

                    if (isValidExt == true && isValidStream == true)
                    {
                        logger.Info("File Extension is valid!");
                        for (int i = 0; i < Request.Files.Count; i++)
                        {
                            HttpPostedFileBase newfile = null;
                            newfile = Request.Files[i];
                            int fileSize = newfile.ContentLength;
                            string fileName = newfile.FileName;
                            fileNameWithoutPath = Path.GetFileName(fileName);
                            string mimeType = newfile.ContentType;
                            System.IO.Stream fileContent = newfile.InputStream;
                            fileBytes.Add(FileStreamToByteArray(newfile.InputStream));
                            fileNames.Add(fileNameWithoutPath);
                                logger.Info("sending mail with attachment: {0}", fileNames);
                                result = new HelpDeskManager().SendMailHelpDesk(fileNames, fileBytes, issue, issuedesc, loginEmail, toEmail);
                           
                        }
                    }
                    else
                        logger.Info("File Extension is not valid!");
                }
                else
                {
                        logger.Info("sending mail without attachment");
                    result = new HelpDeskManager().SendMailHelpDesk(fileNames, fileBytes, issue, issuedesc, loginEmail, toEmail);
                }
                }
                else
                {
                    msg = "User Not enter enter issue or issue description";
                    allfield = 1;
                }

            }
            catch (Exception ex)
            {
                logger.Error("Exception at Home/SendMailHelpDesks: {0} \r\n {1}", ex.Message, ex.StackTrace);
                msg = ex.Message;
                result = false;
            }

            if (result == true && string.IsNullOrEmpty(msg))
            {
                logger.Info("Send mail Successfully");
                return Json(new { success = true , fileclass = fileclass }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                logger.Info("fail in Send mail");
                return Json(new { success = false,allfield=allfield, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// This action method will be hit only when an unhandled exception falls back to Application_Error method in global.asax.cs
        /// </summary>
        /// <returns></returns>
        public JsonResult Error()
        {
            logger.Info("Inside Home/Error");
            return Json(new { success = false, error = 100 }, JsonRequestBehavior.AllowGet);
        }
    }
}