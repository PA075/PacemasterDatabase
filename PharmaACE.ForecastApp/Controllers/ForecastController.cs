using Microsoft.SharePoint.Client;
using NLog;
using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace PharmaACE.ForecastApp.Controllers
{
    public class ForecastController : BaseController
    {
        public ActionResult Index()
        {
            if (Session != null && (!String.IsNullOrEmpty(Session["user"].SafeTrim())))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [AcceptVerbs(HttpVerbs.Get | HttpVerbs.Post)]
        public ActionResult ForecastModel(ForecastModelType type)
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View(GetForecastEntity(type));
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [AcceptVerbs(HttpVerbs.Get | HttpVerbs.Post)]
        public ActionResult Forecaster(ForecastModelType type)
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View(GetForecasterEntity(type));
            }
            else
                return RedirectToAction("Index", "Home");
        }
        private ForecastEntity GetForecasterEntity(ForecastModelType type, int userId = -1)
        {
            try
            {
                ForecastEntity forecastEntity = ForecastFactory.CreateForecastEntity(type);
                if (!forecastEntity.IsUtil)
                {
                    int roleID = Session["RoleId"].SafeToNum();
                    if (userId == -1)
                        userId = Session["UserId"].SafeToNum();

                    var forecastManager = ForecastFactory.CreateForecastManager(UnitOfWork, userId, (UserRole)roleID, type, GetModelBasedAccessType(type));
                    forecastManager.PopulateForecastDetails(forecastEntity);
                }
                return forecastEntity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //TO DO : design such that no switch case is required to get the access type
        private byte GetModelBasedAccessType(ForecastModelType type)
        {
            byte accessType = 0;
            switch (type)
            {
                case ForecastModelType.Generic:
                    accessType = byte.Parse(Session["AccessTypeGTforproject"].ToString());
                    break;
                case ForecastModelType.BDL:
                    accessType = byte.Parse(Session["AccessTypeBDLforproject"].ToString());
                    break;
                case ForecastModelType.Acthar:
                    accessType = byte.Parse(Session["AccessTypePFforproject"].ToString());
                    break;
            }

            return accessType;
        }

        public JsonResult ForecastEntity(ForecastModelType type, string email)
        {
            string msg = "";
            ForecastEntity entity = null;
            if (String.IsNullOrEmpty(email))
                email = Session["User"].ToString();
            try
            {
                if (Session != null && (!string.IsNullOrEmpty(Server.UrlDecode(email))))
                {
                    entity = GetForecastEntity(type, -1);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, entity = entity }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        private ForecastEntity GetForecastEntity(ForecastModelType type, int userId = -1)
        {
            ForecastEntity forecastEntity = null;
            try
            {
                forecastEntity = ForecastFactory.CreateForecastEntity(type);
                if(!forecastEntity.IsUtil)
                    GetForecastManager(type).PopulateForecastDetails(forecastEntity);
            }
            catch(Exception ex)
            {
                throw ex;
            }
            return forecastEntity;
        }

        private ForecastManager GetForecastManager(ForecastModelType type = ForecastModelType.Generic, bool defaultManager = false)
        {
            int roleID = Session["RoleId"].SafeToNum();
            int userId = Session["UserId"].SafeToNum();
            if (defaultManager)
                return ForecastFactory.GetDefaultForecastManager(UnitOfWork, userId);
            else
                return ForecastFactory.CreateForecastManager(UnitOfWork, userId, (UserRole)roleID, type, GetModelBasedAccessType(type));
        }

        public ActionResult Utilities()
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["AccessTypeUT"].SafeToNum() != 0))
            {
                TopRibbon T = new TopRibbon();
                T.LogoImagePath = "../../Content/img/utilities-icon-70.jpg";
                T.PageHeader = "Forecast Utilities";
                return View(T);
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public JsonResult CopyForecast(List<CopyForecast> UserVerisonArray)
        {
            int tenantId;
            tenantId = int.Parse(Session["CompanyId"].ToString());
            byte[] fs;
            string msg = "";
            string forecast = "";
            string copiedToForecast = "";
            string modelLocation ="";
            ForecastModelType type;
            int userId = Session["UserId"].SafeToNum();
            List<UserForecastMapping> userForecasts = new List<UserForecastMapping>();
            //UserForecastMapping userForecastMapping = new UserForecastMapping();
            List<ForecastVersion> Versions = new List<ForecastVersion>();
            //ForecastVersion Version = new ForecastVersion();
            List<string> ProjName = new List<string>();
            UserAccess VersionUserInfo = new UserAccess();
            string latestVersion;
            List<Stream> fileStreams = new List<Stream>();
            List<string> fileNames = new List<string>();
            List<string> comments = new List<string>();
            int intMinor = -1;
            bool enableMinor = false;
            string extension = "xlsb";
            var version = "";
            modelLocation = UserVerisonArray[0].modelLocation;
            copiedToForecast = UserVerisonArray[0].CopiedToForecastName;
            type = UserVerisonArray[0].type;
            forecast = UserVerisonArray[0].Forecast;
            try
            {
                //for (int i = 0; i < UserVerisonArray.Count; i++)
                foreach (var UserVersionDeatils in UserVerisonArray)
                {
                    //if (UserVersionDeatils.NoOfVersion >= 1)
                    //{
                        fileNames.Clear();
                        fileStreams.Clear();
                        userForecasts.Clear();
                        Versions.Clear();
                        ForecastVersion Version = new ForecastVersion();          
                        UserForecastMapping userForecastMapping = new UserForecastMapping();
                        version = UserVersionDeatils.VersionValue;
                      
                        if (string.IsNullOrEmpty(Path.GetExtension(copiedToForecast)))
                        {
                            copiedToForecast += ".xlsb";
                        }

                        if (copiedToForecast != null)
                        {
                            fileNames.Add(copiedToForecast);
                        }
                        else
                            throw new Exception("No name given to the file to be uploaded!");

                        string url = String.Empty;
                        url = String.Format("{0}{1}{2}{3}/{4}.{5}", GenUtil.SPHostUrl, GenUtil.ForecastModelServerRelativeUrl, Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.ForecastFolder, forecast, extension);
                        if (String.IsNullOrEmpty(url))
                            throw new Exception("Could not find the forecast version");
                        url = url.Trim(new char[] { ',' }).Replace(GenUtil.SPHostUrl, String.Empty);
                        if (!url.StartsWith("/"))
                            url = "/" + url;
                        //string ua = Request.UserAgent;
                       // SpComHelper.GetFileBytesFromSharePoint(LoadSPContext(), url, out fs, out msg);
                        string latest = SpComHelper.GetLatestDocumentVersion(LoadSPContext(), url, out msg);
                        if (String.Compare(latest, version, true) != 0)
                        {
                            int majorVersion, minorVersion;
                            GenUtil.GetMajorMinorFromLabel(version, out majorVersion, out minorVersion);
                            int historyBucket = majorVersion * 512 + minorVersion;
                            string strHistoryBucket = String.Format("/{0}/{1}/", "_vti_history", historyBucket.ToString());
                            url = String.Format("{0}{1}{2}/{3}.{4}", strHistoryBucket, Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.ForecastFolder, forecast, extension);
                            url = url.Trim(new char[] { ',' });
                            if (!url.StartsWith("/"))
                                url = "/" + url;
                            SpComHelper.GetOlderVersion(GenUtil.SPSiteUrl, Session["SPAccount"].SafeTrim(), Session["SPPassword"].SafeTrim(),
                                url, Request.UserAgent, out fs, out msg);
                        }
                        else
                        SpComHelper.GetFileBytesFromSharePoint(LoadSPContext(), url, out fs, out msg);

                        Stream streams = new MemoryStream(fs);
                        fileStreams.Add(streams);
                        var enableMinorVersion = UserVersionDeatils.IsEnableMinorVersionCheck.ToString();
                        if (enableMinorVersion != null)
                        {
                            Int32.TryParse(enableMinorVersion, out intMinor);
                            if (intMinor == 1)
                                enableMinor = true;
                            else
                                enableMinor = false;
                            SpComHelper.EnableMinorVersion(GenUtil.SPSiteUrl, Session["SPAccount"].ToString(), Session["SPPassword"].ToString(), "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ enableMinor, out msg);
                            if (!SpComHelper.UploadFilesToSharePoint(GenUtil.SPSiteUrl, Session["SPAccount"].ToString(), Session["SPPassword"].ToString(), "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ comments, fileStreams, fileNames, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/" + GenUtil.ForecastFolder + "/", out latestVersion, out msg))
                                throw new Exception("");

                            Version.Access = new UserAccess();
                            Version.Access.Creator = new UserInfo();
                            Version.Access.Creator.UserId = userId;
                            userForecastMapping.Forecast = copiedToForecast.Substring(0, copiedToForecast.LastIndexOf('.'));
                            Version.Label = latestVersion;
                            Version.Comment = "";
                            Versions.Add(Version);
                            userForecastMapping.Versions = Versions;
                            userForecasts.Add(userForecastMapping);
                            if (userForecasts != null)
                            {
                                var status = GetForecastManager(type).SetUserforecastMapping(userForecasts, true);
                                if (status.Count > 0)
                                    throw new Exception(status[0].Message);
                            }
                        }
                        else
                        {
                            if (!SpComHelper.UploadFilesToSharePoint(GenUtil.SPSiteUrl, Session["SPAccount"].ToString(), Session["SPPassword"].ToString(), "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ comments, fileStreams, fileNames, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/" + GenUtil.ForecastFolder + "/", out latestVersion, out msg))
                                throw new Exception("");
                        }
                        foreach (var stream in fileStreams)
                        {
                            stream.Close();
                        }
                    //}
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DownloadFile(string forecast, string version, string modelLocation, int type)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            byte[] fs; string msg; string contentUrl = "";
            // string extension = type == 0 ? "xlsx" : "xlsb";
            string extension = "xlsb";
            try
            {
                string url = String.Empty;
                url = String.Format("{0}{1}{2}/{3}.{4}", GenUtil.ForecastModelServerRelativeUrl, Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.ForecastFolder, forecast, extension);
                url = url.Trim(new char[] { ',' });
                if (String.IsNullOrEmpty(url))
                    throw new Exception("Could not find the forecast version");
                if (!url.StartsWith("/"))
                    url = "/" + url;
                string latest = SpComHelper.GetLatestDocumentVersion(LoadSPContext(), url, out msg);
                if (String.Compare(latest, version, true) != 0)
                {
                    int majorVersion, minorVersion;
                    GenUtil.GetMajorMinorFromLabel(version, out majorVersion, out minorVersion);
                    int historyBucket = majorVersion * 512 + minorVersion;
                    string strHistoryBucket = String.Format("/{0}/{1}/", "_vti_history", historyBucket.ToString());
                    url = String.Format("{0}{1}{2}/{3}.{4}", strHistoryBucket, Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.ForecastFolder, forecast, extension);
                    url = url.Trim(new char[] { ',' });
                    if (!url.StartsWith("/"))
                        url = "/" + url;
                    SpComHelper.GetOlderVersion(GenUtil.SPSiteUrl, Session["SPAccount"].SafeTrim(), Session["SPPassword"].SafeTrim(),
                        url, Request.UserAgent, out fs, out msg);
                }
                else
                    SpComHelper.GetFileBytesFromSharePoint(LoadSPContext(), url, out fs, out msg);
                var urlParts = url.Split('/');
                string guid = Guid.NewGuid().ToString();
                string fileNameWithExtension = urlParts[urlParts.Length - 1];
                string fileNameOnly = System.IO.Path.GetFileNameWithoutExtension(fileNameWithExtension);
                string fileExtension = System.IO.Path.GetExtension(fileNameWithExtension);
                string downloadedFileName = String.Format("{0}_{1}_{2}{3}", fileNameOnly, version, guid, fileExtension);
                string intermDirPath = Server.MapPath("~/Content/Intermediate");
                // If the folder does not exist yet, it will be created. If the folder exists already, the line will be ignored.
                // but because of this line portal log outs..
                //Directory.CreateDirectory(intermDirPath);
                System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(intermDirPath, downloadedFileName), fs);
                //var directory = Directory.CreateDirectory(GenUtil.CombineFileSysPaths(intermDirPath, guid));
                //System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(directory.FullName, downloadedFileName), fs);
                contentUrl = GetHostUrl() + Url.Content(String.Format(@"~\Content\Intermediate\{0}", downloadedFileName));
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, url = contentUrl }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        private ClientContext LoadSPContext()
        {
            var ctx = Session["sp_context"] as ClientContext;
            if (ctx == null)
            {
                var spEmail = Session["SPAccount"].SafeTrim();
                var spPassword = Session["SPPassword"].SafeTrim();
                ctx = SpComHelper.GetSPClientContext(GenUtil.SPSiteUrl, spEmail, spPassword);
                Session["sp_context"] = ctx;
            }

            return ctx;
        }

        //public FileResult DownloadAttachment(string source, string sink, string modelLocation)
        //{
        //    int CompanyId;
        //    CompanyId = int.Parse(Session["CompanyId"].ToString());
        //    //string Users = Session["User"].ToString();
        //    //BusinessLayer bal = new BusinessLayer();
        //    //List<string> User = new List<string>();
        //    //User.Add(Users);
        //    //var spUsers = GenUtil.GetSPUserByUserEmail(User, CompanyId);
        //    //var email = spUsers.Values.Select(u => new UserProfile { SP_Email = u[0] }).ToList()[0].SP_Email;
        //    //var password = spUsers.Values.Select(u => new UserProfile { SP_Password = u[1] }).ToList()[0].SP_Password;
        //    var email = Session["SPAccount"].SafeTrim(); //spUsers.Values.Select(u => new UserProfile { SP_Email = u[0] }).ToList()[0].SP_Email;
        //    var password = Session["SPPassword"].SafeTrim(); //spUsers.Values.Select(u => new UserProfile { SP_Password = u[1] }).ToList()[0].SP_Password;
        //    byte[] fs = null;
        //    string msg = String.Empty;
        //    try
        //    {
        //        var url = String.Format("{0}{1}/{2}", GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.AssumptionAttachmentsFolder, source);
        //        url = Server.UrlDecode(url);
        //        if (String.IsNullOrEmpty(url))
        //            throw new Exception("url null");
        //        //url = source.Trim(new char[] { ',' }).Replace(GenUtil.SPHostUrl, String.Empty);
        //        if (!url.StartsWith("/"))
        //            url = "/" + url;
        //        string ua = Request.UserAgent;
        //        SpComHelper.GetFileBytesFromSharePoint(LoadSPContext(), url, out fs, out msg);
        //        string contentType = string.Empty;
        //    }
        //    catch (Exception ex)
        //    {
        //        msg = ex.Message;
        //    }
        //    if (ModelState.IsValid && fs != null && String.IsNullOrEmpty(msg))
        //        return File(fs, "application/octet-stream", sink);
        //    return null;
        //}

        public ActionResult DownloadAttachmentFromDb(string streamId, string sink)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            byte[] fs = null;
            string msg = String.Empty;
            StorageTypeFactory factory = new ConcreteStorageFactory();
            StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
            var fileKey = streamId + "|" + CompanyId;
            try
            {
                fs = storagefactory.Download(UnitOfWork, fileKey, StorageContext.Forecast);
                string contentType = string.Empty;
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (fs != null && String.IsNullOrEmpty(msg))
                return File(fs, "application/octet-stream", sink);
            return null;
        }



        [HttpPost]
        public JsonResult SaveForecast()
        {
            ForecastModelType modelType;
            int flatFileId = 0;
            List<UserForecastMapping> userForecasts = new List<UserForecastMapping>();
            UserForecastMapping userForecastMapping = new UserForecastMapping();
            List<ForecastVersion> Versions = new List<ForecastVersion>();
            ForecastVersion Version = new ForecastVersion();
            List<string> ProjName = new List<string>();
            UserAccess VersionUserInfo = new UserAccess();
            List<ActionStatus> status = new List<ActionStatus>();
            string StorageId = "";
            bool IsSaveFlag = false;
            int IsSave = -1;
            int SaveAsFlag = -1;
            bool IsSaveAsForecast = false;
            var latestVersion = "";
            var returnVal = -1;
            int FlatFile = 1;
            bool isValidExt = true;
            string savedVersion = String.Empty;
            List<Assumption> assumptions = null;
            string tempSavePath = String.Empty;

            try
            {
                logger.Info("Inside SaveForecast");
                //if savetempfile has set a number against the session variable, it must be an error code
                int errorCode = Session["saved_forecast"].SafeToNum();
                if (errorCode >= 0)
                {
                    status.Add(new ActionStatus { Number = errorCode });
                    throw new Exception();
                }
                int userId = Session["UserId"].SafeToNum();
                modelType = (ForecastModelType)Request["type"].SafeToNum();
                string forecast = Request["Name"].SafeNoTrim();
                logger.Info("userId: {0}, model type: {1}, forecast file: {2}", userId, modelType, forecast);
                string projectName = Path.GetFileNameWithoutExtension(forecast);                
                StorageTypeFactory factory = new ConcreteStorageFactory();
                StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                //using Request.Unvalidated as assumptions can contain any kind of text including html; view has the responsibility to carefully disallow xss attacks
                string unvalidatedAssumptions = Request.Unvalidated["assumptions"];
                if (!String.IsNullOrEmpty(unvalidatedAssumptions))
                {
                    logger.Info("Assumption json: {0}", unvalidatedAssumptions);
                    var assumptionsDyn = new JavaScriptSerializer().Deserialize<dynamic>(unvalidatedAssumptions);
                    if (assumptionsDyn != null && assumptionsDyn.ContainsKey("assumptions"))
                        assumptions = new JavaScriptSerializer().Deserialize<List<Assumption>>(new JavaScriptSerializer().Serialize(assumptionsDyn["assumptions"]));
                    logger.Info("Deserialized assumption json to list of assumption objects");
                }
                string flatFileNameWithExtension = Session["saved_forecast"].SafeNoTrim();
                if (String.IsNullOrEmpty(flatFileNameWithExtension))
                {
                    status.Add(new ActionStatus { Number = 7 });
                    throw new Exception("Temporary file location is empty");
                }
                tempSavePath = GenUtil.CombineFileSysPaths(Server.MapPath("~/Content/Intermediate"), flatFileNameWithExtension);
                if (!System.IO.File.Exists(tempSavePath))
                {
                    status.Add(new ActionStatus { Number = 7 });
                    throw new Exception(String.Format("Could not find file {0}", tempSavePath));
                }
                isValidExt = GenUtil.fileFilterExtensions(tempSavePath);
                if (isValidExt)
                {
                    if (Request["IsSaveAsForecast"] != null)
                    {
                        logger.Info("Checking if it's a save as case");
                        Int32.TryParse(Request["IsSaveAsForecast"], out SaveAsFlag);
                        logger.Info("SaveAsFlag: {0}", SaveAsFlag);
                        if (SaveAsFlag == 1)
                            IsSaveAsForecast = true;
                        else
                            IsSaveAsForecast = false;
                    }
                    if (IsSaveAsForecast)                           // save as forecast template
                    {
                        logger.Info("Saving {0} as {1}", forecast, projectName);
                        returnVal = GetForecastManager(modelType).SetForecastTemplate(Request["TemplateNameForSaveAs"].ToString(), StorageId, projectName, userId);
                        if (returnVal != 1)
                            throw new Exception("Save as task failed while pointing to the existing template");
                    }

                    if (Request["isCreateFlag"] != null)
                    {
                        Int32.TryParse(Request["isCreateFlag"], out IsSave);
                        if (IsSave == 1)
                            IsSaveFlag = true;
                        if (IsSaveFlag)
                        {
                            FlatFile = 2;
                            StorageId = storagefactory.Upload(UnitOfWork, Session["CompanyId"].SafeTrim(), tempSavePath, StorageContext.Forecast, modelType, FlatFile);
                            if (String.IsNullOrEmpty(StorageId))
                            {
                                logger.Error("Sorage Id is null, uploading {0} might have faced some issue", tempSavePath);
                                throw new Exception();
                            }
                            logger.Info("Successfully stored the forecast file in file table. Storage Id: {0}.\r\nSetting the storage id in template table", StorageId);                            
                            returnVal = GetForecastManager(modelType).SetForecastTemplate(projectName, StorageId, "", userId);
                            if (returnVal != 1) //error
                            {
                                if (returnVal == 9)
                                {
                                    status.Add(new ActionStatus { Number = 9, Message = "Project name already exists" });
                                    throw new Exception("Project name already exists");
                                }
                                else
                                    throw new Exception("Could not set up storage id in template table");
                        }
                        }
                        else if (IsSaveFlag == false || IsSaveAsForecast == true)                  // for saving flat file and save as forecast
                        {
                            List<string> comments = new List<string>();
                            string desc = String.Empty;
                            if (Request["Description"] != null)
                            {
                                desc = Request["Description"].SafeNoTrim();
                                comments.Add(desc);
                            }

                            if (Request["MajorVersion"] != null)
                            {
                                var enableMinorbool = Request["MajorVersion"];
                                int majorVersion = Convert.ToInt32(enableMinorbool);
                                logger.Info("Storing forecast version file in file table with comment: {0}, as a {1} version", String.Join(",", comments), majorVersion.SafeToBool() ? "major": "minor");
                                StorageId = storagefactory.Upload(UnitOfWork, Session["CompanyId"].ToString(), tempSavePath, StorageContext.Forecast, modelType, FlatFile);
                                if (StorageId == "")
                                    throw new Exception("Could store forecast version file to file table");
                                latestVersion = GetForecastManager(modelType).SaveForecast(projectName, StorageId, majorVersion, desc, out flatFileId);                                
                                if (String.IsNullOrEmpty(latestVersion))
                                    throw new Exception("Could not save, problem determining the latest version, it came empty");
                                logger.Info("{0} latest version = {1}, flat file id = {2}", projectName, latestVersion, flatFileId);
                            }
                            var sectionsOrder = Request["SectionsOrder"].SafeTrim();
                            userForecastMapping.FlatFileId = flatFileId;
                            Version.Access = new UserAccess();
                            Version.Access.Creator = new UserInfo();
                            Version.Access.Creator.UserId = userId;
                            string FileNameOnly = Request["Name"].ToString();
                            userForecastMapping.Forecast = FileNameOnly.Substring(0, FileNameOnly.LastIndexOf('.'));
                            Version.Label = latestVersion;
                            if (comments.Count > 0)
                            {
                                string comment = string.Join(" ", comments);
                                Version.Comment = comment;
                            }
                            else
                            {
                                Version.Comment = "";
                            }
                            Versions.Add(Version);
                            userForecastMapping.Versions = Versions;
                            userForecasts.Add(userForecastMapping);

                            if (userForecasts != null)
                            {
                                logger.Info("Setting user forecast mapping for user id {0} and project {1} {2}", userId,
                                    userForecastMapping.Forecast, userForecastMapping.Versions == null ? null : String.Join(",", userForecastMapping.Versions));
                                status = GetForecastManager(modelType).SetUserforecastMapping(userForecasts, true);
                                if (status.Count > 0)
                                    throw new Exception("User forecast mapping failed");
                                logger.Info("User forecast mapping done successfully. Now setting up the section preferences to {0}", sectionsOrder);
                                status = GetForecastManager(modelType).SetSectionPreferences(projectName, latestVersion, sectionsOrder);
                                if (status.Count > 0)
                                    throw new Exception("Failed setting up section preferences");
                            }
                                                        
                            Dictionary<string, string> mapFileNames = null;
                            if (Request.Files.Count > 0)
                            {
                                logger.Info("Attachment count: {0}", Request.Files.Count);
                                List<HttpPostedFileBase> files = new List<HttpPostedFileBase>();
                                for (int i = 0; i < Request.Files.Count; i++)
                                {
                                    var file = Request.Files[i];
                                    logger.Info("Checking file type for attachmdent {0}", file.FileName);
                                    isValidExt = GenUtil.fileFilterExtensions(file.FileName);
                                    if (!isValidExt)
                                    {
                                        status.Add(new ActionStatus { Number = 12, Message = String.Format("Invalid attachment extension for {0}", file.FileName) });
                                        throw new Exception(String.Format("Invalid attachment extension for {0}", file.FileName));
                                    }
                                    files.Add(file);
                                }
                                logger.Info("Uploading attachments");
                                mapFileNames = UploadFilesInDb(modelType, files);
                                logger.Info("Successfully uploaded attachments as {0}", String.Join(",", mapFileNames != null ? mapFileNames.Values.ToArray() : new string[0]));
                            }

                            logger.Info("Setting {0} assumptions", assumptions.Count);
                            foreach (var assumption in assumptions)
                            {
                                assumption.Version = latestVersion;
                                if (mapFileNames != null && assumption.Attachments != null)
                                {
                                    foreach (var attachment in assumption.Attachments)
                                    {
                                        if (!String.IsNullOrEmpty(attachment.LocalPath))
                                        {
                                            if (mapFileNames.ContainsKey(attachment.LocalPath))
                                            {
                                                attachment.AttachmentPath = mapFileNames[attachment.LocalPath];
                                                logger.Info("{0}: {1} : {2}", attachment.AttachmentName, attachment.LocalPath, attachment.AttachmentPath);
                                            }
                                        }
                                    }
                                }
                            }
                            SetAssumptions(assumptions, modelType, projectName);
                            logger.Info("Successfully saved assumptions");
                        }
                        //}
                    }
                    if (status == null)
                        status = new List<ActionStatus>();
                    if(status.Count == 0)
                        status.Add(new ActionStatus { Number = 1, Message = "Saved successfully" });
                }
                else
                {
                    status.Add(new ActionStatus { Number = 10, Message = "Invalid file extension" });
                    throw new Exception("Invalid file extension");
                }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at Forecast/SaveForecast: {0} \r\n {1}", ex.Message, ex.StackTrace);
                if(status.Count == 0)
                    status.Add(new ActionStatus { Number = 0 }); //unknown error
                //rollback if transaction is open
            }

            if (!String.IsNullOrEmpty(tempSavePath))
                DeleteTempFileContainer(tempSavePath, true);

            if (status[0].Number != 1)
                return Json(new { success = false, error = status[0].Number });
            else
                return Json(new { success = true, Version = latestVersion });
        }

        /// <summary>
        /// Keep the forecast flat file in intermediate folder and go back
        /// </summary>
        /// <returns></returns>
        [Disconnected]
        [HttpPost]
        public ContentResult SaveTempFile()
        {            
            List<ActionStatus> status = new List<ActionStatus>();                        
            bool isValidExt = true;
            try
            {
                logger.Info("Inside SaveTempFile");
                int userId = Session["UserId"].SafeToNum();                
                Session["saved_forecast"] = String.Empty;
                if(Request.Files.Count == 0)
                {
                    Session["saved_forecast"] = 8;
                    throw new Exception("There was a problem receiving forecast data");
                }
                var file = Request.Files[0];
                logger.Info("userId: {0}, file: {1}", userId, file.FileName);
                isValidExt = GenUtil.fileFilterExtensions(file);
                logger.Info("File extension is valid");
                if (isValidExt)
                {
                    var uid = "_" + Session["UserId"] + "_" + Guid.NewGuid() + file.FileName;
                    //string tempSavePath = GenUtil.CombineFileSysPaths(Server.MapPath("~/Content/Intermediate"), uid);
                    string tempSavePath = GetUrlAndAddToContentFolder(true, uid, null);
                    logger.Info("Saving forecast file temporarily at {0}", tempSavePath);
                    file.SaveAs(tempSavePath);
                    logger.Info("Successfully cached forecast file");
                    Session["saved_forecast"] = Path.GetFileName(tempSavePath);
                }
                else {                    
                    Session["saved_forecast"] = 10;
                    throw new Exception("Invalid file extension");
                }

                //EDraw can't handle action result so don't bother about what's returned, is session["saved_forecast"] is empty that means this operation was unsuccessful
                return Content(Session["saved_forecast"].SafeNoTrim());
            }
            catch (Exception ex)
            {
                if (Session["saved_forecast"].SafeToNum() == -1)
                    Session["saved_forecast"] = 0;
                logger.Error("Exception at Forecast/SaveTempFile: {0} \r\n {1}", ex.Message, ex.StackTrace);
                status.Add(new ActionStatus { Number = 0, Message = ex.Message });
            }

            return Content(String.Empty);
        }

        public Dictionary<string, string> UploadFilesInDb(ForecastModelType type, List<HttpPostedFileBase> files)
            {
            logger.Info("Inside Home/UploadFilesInDb");

            var mapFileNames = new Dictionary<string, string>();
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
                for (int i = 0; i < files.Count; i++)
                {
                    file = files[i];
                    logger.Info("{0} is Uploading", file.FileName);
                    isValidExt = GenUtil.fileFilterExtensions(file);
                    extension = Path.GetExtension(file.FileName);
                    int index = file.FileName.LastIndexOf('.');
                    string fileExtension = file.FileName.Substring(index + 1);

                    int uploadTypeID = Convert.ToInt32(ConfigurationManager.AppSettings["uploadfiletype"].ToString());
                    //if (isValidExt)
                    //{
                    //    if (uploadTypeID == 0)
                    //    {
                    //        isValidStream = true;
                    //        msg = "";
                    //    }
                    //    else if (uploadTypeID == 1)
                    //    {
                    //        //isValidStream = true;
                    //        isValidStream = GenUtil.getActualTypeOfFile(file, extension);
                    //        if (isValidStream == false)
                    //        {
                    //            throw new Exception("This is not " + fileExtension + "extension!");
                    //        }
                    //    }
                    //}

                    if (isValidExt == false)
                    {
                        throw new Exception("One of selected file has invalid extension!");
                }

                }
                if (isValidExt == true /*&& isValidStream == true*/)
                {
                    logger.Info("Valid File Extensioin");
                    for (int j = 0; j < files.Count; j++)
                    {
                        newFile = files[j];
                        if (newFile != null && newFile.ContentLength > 0)
                {
                            StorageTypeFactory factory = new ConcreteStorageFactory();
                            StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                            storageID = storagefactory.Upload(UnitOfWork, key, newFile, StorageContext.Forecast, type, FlatFile);
                            logger.Info("Upoaded {0} as {1}", newFile.FileName, storageID);
                            string uniqueName = String.Format("{0}", storageID);
                            if(!mapFileNames.ContainsKey(newFile.FileName))
                                mapFileNames.Add(newFile.FileName, uniqueName);
                }
                        else if (newFile == null && newFile.ContentLength == 0)
                        {
                            logger.Info("File length is null");
                            if (!mapFileNames.ContainsKey(newFile.FileName))
                                mapFileNames.Add(newFile.FileName, String.Empty);
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
                if (!mapFileNames.ContainsKey(newFile.FileName))
                    mapFileNames.Add(newFile.FileName, String.Empty);

            }


            return mapFileNames;
        }

        byte[] FileStreamToByteArray(Stream stream)
        {
            MemoryStream memoryStream = stream as MemoryStream;
            if (memoryStream == null)
            {
                memoryStream = new MemoryStream();
                stream.CopyTo(memoryStream);
            }
            return memoryStream.ToArray();
        }

        public bool CheckForExistingProjectNameForSaveFile(string ProjectName, ForecastModelType type)
        {
            IEnumerable<string> projectNames = new List<string>();
            bool alreadyExist = true;
            string ProjectNameToLower;
            string projectnameToLower;
            try
            {
                projectNames = GetForecastManager(type).GetDistinctProjectNames();
                foreach (string projectname in projectNames)
                {
                    ProjectNameToLower = ProjectName.ToLower();
                    projectnameToLower = projectname.ToLower();

                    if (String.Compare(projectnameToLower, ProjectNameToLower) == 0)
                    {
                        alreadyExist = false;
                    }
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
            return alreadyExist;
        }

        public JsonResult FileUpload(HttpPostedFileBase uploadFile)
        {
            string msg = null;
            if (uploadFile.ContentLength > 0)
            {
                string filePath = Path.Combine(HttpContext.Server.MapPath("../Uploads"),
                                               Path.GetFileName(uploadFile.FileName));
                uploadFile.SaveAs(filePath);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult UploadExcelFile()
        {
            string msg = null;
            HttpPostedFileBase uploadFile = Request.Files[0];
            if (uploadFile.ContentLength > 0)
            {
                string filePath = Path.Combine(HttpContext.Server.MapPath("../Content/AppDocs"), Path.GetFileName(uploadFile.FileName));
                uploadFile.SaveAs(filePath);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        //public JsonResult GetAllUsers( ForecastModelType type)
        //{
        //    int tenantId = int.Parse(Session["CompanyId"].ToString());
        //    string msg = null;
        //    List<UserInfo> users = new UserManager().GetAllUsersByTenant(tenantId, type);
            
        //    users = users.Where(u => u.UserId != Session["UserId"].SafeToNum()).ToList();            
        //    if (String.IsNullOrEmpty(msg))
        //        return Json(new { success = true, users = users }, JsonRequestBehavior.AllowGet);
        //    else
        //        return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //}
        [HttpGet]
        public JsonResult GetAllUsers( ForecastModelType type)
        {
            logger.Info("Inside Forecast/GetAllUsers");
            string msg = string.Empty;
            List<UserInfo> users = new List<UserInfo>();
            try
            {
                if (Session == null)
                    logger.Error("Session is null");
                int tenantId = int.Parse(Session["CompanyId"].ToString());  
                int loggedUserID = int.Parse(Session["UserId"].ToString());
                logger.Info("Login User Id :{0}", loggedUserID);
                logger.Info("Getting users list");
                users = new UserManager(UnitOfWork).GetAllUsersByTenant(tenantId, type);
                users = users.Where(u => u.UserId != loggedUserID).ToList();
                logger.Info("UsersListCount :{0}", users.Count());
                logger.Info("Got AllUsers List");
            }
            catch (Exception ex)
            {
                msg = ex.Message;
               logger.Error("Exception at Forecast/GetAllUsers: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
                logger.Info("Successfully got all users list");
                return Json(new { success = true, users = users }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                logger.Info("Failed to get users list");
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetUserListForAutocomplete(ForecastModelType type)
        {
            logger.Info("Inside Forecast/GetUserListForAutocomplete");
            string msg = string.Empty;
            AutocompleteList data = new AutocompleteList();
            try
            {
                if (Session == null)
                    logger.Error("Session is null");
                int tenantId = int.Parse(Session["CompanyId"].ToString());
                logger.Info("Getting users list for autocomplete");
                data = new UserManager(UnitOfWork).GetAllUsersByTenantForShare(tenantId, type);
                logger.Info("AutocompleteUsersList :{0}", data.UsersList.Count());
                logger.Info("Got Autocomplete Users list");
            }
            catch(Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Forecast/GetUserListForAutocomplete: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            // return Json(data, JsonRequestBehavior.AllowGet);
            if (String.IsNullOrEmpty(msg))
            {
                logger.Info("Successfully got all users list for autocomplete");
                return Json(new { success = true, data = data }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                logger.Info("Failed to get all users list for autocomplete ");
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult UnShareDocument(List<UserForecastMappingForUnshare> UserForecastForUnshare, ForecastModelType type)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            string msg = "";
            try
            {
                if (UserForecastForUnshare != null)
                {
                    IEnumerable<UserInfo> UserInfoForEmail = new List<UserInfo>();
                    int res = GetForecastManager(type).UnshareForecast(UserForecastForUnshare);
                    if (res == 2)
                    {
                        // msg = "User did not have access to this forecast version";
                        msg = "NOT_FOUND";
                    }
                    else if (res == 0)
                        msg = "Could not share forecast";
                }
                else
                {
                    msg = "Could not share forecast";
                }
            }
            catch(Exception ex)
            {
                msg = ex.Message;
            }
            
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg }}, JsonRequestBehavior.AllowGet);
        }        

        [HttpPost]
        public JsonResult ShareDocument(List<UserForecastMapping> userForecasts, ForecastModelType type)
        {
            string msg = "";
            string StatusMsg = "";
            List<int> unsccessIds = new List<int>();
            ActionStatus statusForSendMail = new ActionStatus();
            if (userForecasts != null)
            {
                try
                {
                    IEnumerable<UserInfo> UserInfoForEmail = new List<UserInfo>();
                   var status = GetForecastManager(type).SetUserforecastMapping(userForecasts, false);
                    statusForSendMail.UserMailInfo = status[0].UserMailInfo;
                    // if (!status.Any(s => s.Number == 1))
                    /*if (status.Any(s => s.Number == 1))
                    {
                        if (status.Count == 0)
                            throw new Exception(status[0].Message);
                        else
                        {
                            if (status.Count == 1)
                                msg = status[0].Message;
                            else
                            {
                                var flag = false;
                                foreach (var item in status)
                                {
                                    if (item.Message == "User already has higher permission for the forecast version.")
                                        flag = true;
                                }
                                if (flag == true)
                                    msg = "Few of them are Not Shared Successfull..";
                            }
                        }
                    }*/

                    var flag = false;
                    var PermissionNotChangedCount = 0;
                    if (status.Count == 0)
                        throw new Exception(status[0].Message);
                    if (status.Count == 1)
                    {
                        if (status[0].Number == 4)
                        {
                            StatusMsg = status[0].Message;
                            unsccessIds.Add(status[0].UserID);
                        }
                    }

                    if (status.Count > 1)
                    {
                        foreach (var messages in status)
                        {
                            if (messages.Number==4)
                            {
                                unsccessIds.Add(messages.UserID);
                                PermissionNotChangedCount++;
                                flag = true;
                                //break;
                            }
                        }
                        if (flag == true)
                        {
                            if (PermissionNotChangedCount == 1)
                                StatusMsg = "User already has higher permission";
                            else
                                StatusMsg = "Few of them are not shared successfully";
                        }
                    }
                }
                catch (Exception ex)
                {
                    msg = ex.Message;
                }
            }
            else
            {
                msg = "Nothing to share";
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, SendMailInformation= statusForSendMail, StatusMsg= StatusMsg, unsccessIds = unsccessIds }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg }}, JsonRequestBehavior.AllowGet);
        }
        
        [HttpGet]
        public JsonResult GetAssumptions(string project, string version, string modelLocation, ForecastModelType type)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            IList<Assumption> assumptions = null;
            string msg = null;
            try
            {
                assumptions = GetForecastManager(type).GetAssumptions(project, version);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, notes = assumptions }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public List<Assumption> GetAssumptions(string project, string version, ForecastModelType type)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            List<Assumption> assumptions = null;
            try
            {
                assumptions = GetForecastManager(type).GetAssumptions(project, version);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return assumptions;
        }

        public void SetAssumptions(List<Assumption> assumptions, ForecastModelType type, string ProjectName)
        {
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            if (assumptions != null && assumptions.Count() > 0)
            {
                try
                {
                    GetForecastManager(type).SetAssumptions(assumptions);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        
        public JsonResult GetProductNewsParams(string product)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            NewsDetails newsParams = new NewsDetails();
            string msg = null;
            try
            {
                newsParams = new KnowledgeManager(UnitOfWork).GetNewsDetailsProductWise(product, CompanyId);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, data = newsParams }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        private bool ValidateSessionForBrowser(int userId, string expectedGUID)
        {
            //int CompanyId;
            //CompanyId = int.Parse(Session["CompanyId"].ToString());
            //string actualGUID = new ForecastManager().GetBrowserSpecificGUIDForUser(userId, CompanyId);
            //if (!String.IsNullOrEmpty(expectedGUID) && String.Compare(expectedGUID, actualGUID) == 0)
            //    return true;
            return false;
        }

        [HttpPost]
        public JsonResult GetGuidForSaveForecast()
        {
            int tenantId;
            tenantId = int.Parse(Session["CompanyId"].ToString());
            string msg = string.Empty;
            try
            {
                if (!string.IsNullOrEmpty(Session["NotificationKey"] as string))
                {
                    string uniqueId = Session["NotificationKey"].ToString();

                    IEnumerable<string> GuidsFormDataBase = new List<string>();
                    msg = GetForecastManager(defaultManager: true).GetGuidsFormDataBaseOfSavedProjects(uniqueId);
                }
            }
            catch(Exception ex)
            {
                msg = "";
            }
            if (!String.IsNullOrEmpty(msg))
                return Json(new { success = true, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult CheckForExistingProjectName(string projName, ForecastModelType type)
        {
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            IEnumerable<string> projectNames = new List<string>();
            string msg = string.Empty;
            bool alreadyExist = false;
            string projectnameToLower;
            string projNameToLower;
            try
            {
                projectNames = GetForecastManager(type).GetDistinctProjectNames();
                foreach (string projectname in projectNames)
                {
                    projectnameToLower = projectname.ToLower();
                    projNameToLower = projName.ToLower();
                    if (String.Compare(projectnameToLower, projNameToLower) == 0)
                    {
                        alreadyExist = true;
                    }
                }
            }
            catch(Exception ex)
            {
                msg = ex.Message;
            }
            if (alreadyExist && string.IsNullOrEmpty(msg))
                return Json(new { success = true  }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false , errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult UploadForecastFile(string modelLocation, string Description, string EnableMinorVersionSync, ForecastModelType typeOfTool)
        {
            string[] result;
            bool VersionBool;
            result = EnableMinorVersionSync.Split(',');
            string Version;
            string VersionCheck;
            int authorizationId = 1;
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            var email = Session["SPAccount"].SafeTrim(); //spUsers.Values.Select(u => new UserProfile { SP_Email = u[0] }).ToList()[0].SP_Email;
            var password = Session["SPPassword"].SafeTrim(); //spUsers.Values.Select(u => new UserProfile { SP_Password = u[1] }).ToList()[0].SP_Password;
            string[] arrFileNames = new string[Request.Files.Count];
            string msg = null;
            string latestVersion;
            List<string> fileNames = new List<string>();
            List<Stream> fileStreams = new List<Stream>();
            string contentString = String.Empty;
            bool enableMinorVer = false;
            bool enableMinor = false;
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFileBase file = Request.Files[i];
                if (file != null)
                {
                    fileNames.Clear();
                    fileStreams.Clear();
                    var FileNames = Path.GetFileName(file.FileName);
                    fileNames.Add(FileNames);
                    var FileNameWithoutExt = Path.GetFileNameWithoutExtension(FileNames);
                    arrFileNames[i] = String.Format("{0}{1}{2}/{3}", GenUtil.SPHostUrl, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/", GenUtil.AssumptionAttachmentsFolder, file.FileName);
                    fileStreams.Add(Request.Files[i].InputStream);
                    List<int> userIDs = new List<int>();
                    userIDs.Add(Session["UserId"].SafeToNum());
                    VersionCheck = result[i];
                    Boolean.TryParse(VersionCheck, out VersionBool);
                    if (VersionBool == false)
                    {
                        Version = "V1.0";
                    }
                    else
                    {
                        Version = "V0.1";
                    }
                    GetForecastManager(typeOfTool).GFSetUserforecastMappingForUpload(userIDs, FileNameWithoutExt, Version, userIDs, Description);
                }
                else if (file == null && file.ContentLength == 0)
                {
                    arrFileNames[i] = String.Empty;
                }

                if (Request.Params["EnableMinorVersionSync"] != null)
                {
                    var enableMinorbool = result[i];
                    Boolean.TryParse(enableMinorbool, out enableMinorVer);
                    if (enableMinorVer == true)
                        enableMinor = true;
                    SpComHelper.EnableMinorVersion(GenUtil.SPSiteUrl, email, password, "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ enableMinor, out msg);
                    if (!SpComHelper.UploadFilesToSharePoint(GenUtil.SPSiteUrl, email, password, "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ null, fileStreams, fileNames, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/" + GenUtil.ForecastFolder + "/", out latestVersion,out msg))
                        throw new Exception("");
                }
                else
                {
                    if (!SpComHelper.UploadFilesToSharePoint(GenUtil.SPSiteUrl, email, password, "", true, Session["Archive"].ToString(),/*GenUtil.DocLibName,*/ null, fileStreams, fileNames, GenUtil.ForecastModelServerRelativeUrl + Session["Archive"].ToString() + "/" + modelLocation + "/" + GenUtil.ForecastFolder + "/",out latestVersion, out msg))
                        throw new Exception("");
                }
            }

            //dispose the file streams
            foreach (var stream in fileStreams)
            {
                stream.Close();
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true });
            else
                return Json(new { success = false, errors = new[] { msg } });
        }

        public JsonResult DeleteTempFileContainer(string fullFilePath, bool local = false)
        {
            logger.Info("Inside Forecast/DeleteTempFileContainer");
            logger.Info("full file path is {0}", fullFilePath);
            var splitPaths = fullFilePath.Split('|');
            var finalPath = string.Empty;
            string msg = null;                        
            try
            {
                if (splitPaths.Count() >= 1)
                {
                    foreach (var path in splitPaths)
                    {
                        string filePath = string.Empty;
                        if (!string.IsNullOrEmpty(path))
                        {
                            finalPath = path;
                            string hostUrl = GetHostUrl();
                            if (!local)
                            {
                                filePath = Server.MapPath(path.Replace(hostUrl, String.Empty));
                                logger.Info("Resolved full file path is {0}", filePath);
                            }
                            System.IO.File.Delete(filePath);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Forecast/DeleteTempFileContainer: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
                logger.Info("Deleted {0}", finalPath);
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }

            else
            {
                logger.Info("Could not delete {0}", finalPath);
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetForecastData(string projectName, string versionLabel, ForecastModelType type)
        {
            object forecastData = null;
            string msg = null;
            try
            {
                forecastData = (GetForecastManager(type) as GenericForecastManager).GetGenericForecastData(projectName, versionLabel);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, forecastData = forecastData }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetForecastInputOutput(ForecastModelType type, ForecastVersionDetail forecastVersionDetails, int productId, int skuId, int scenarioId)
        {
            GenericForecastIO forecastIO = null;
            string msg = null;
            try
            {
                forecastIO = (GetForecastManager(type) as GenericForecastManager).GetForecastInputOutput(forecastVersionDetails, productId, skuId, scenarioId);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, fio = forecastIO });
            else
                return Json(new { success = false, errors = new[] { msg } });
        }

        public ActionResult ForecastReference(ForecastModelType type,string forecast,string version)
        {
            ViewData["type"] = (int)type;
            string IndicationValue = Request.QueryString["indicationValue"];
            ViewData["indicationValue"] = IndicationValue;
            ViewData["forecast"] = forecast;
            ViewData["version"] = version;
           
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                //return View(GetForecasterEntity(type));
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult ForecastIndicationInfo(string indication)
        {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                ForecastReference fr = new ForecastReference();
                int tenantId;
                tenantId = int.Parse(Session["CompanyId"].ToString());
                try
                {
                    fr = new KnowledgeManager(UnitOfWork).GetIndicationDetails(indication, tenantId);
                    if (fr != null)
                    {
                        return PartialView("ForecastIndicationInfo", fr);
                    }
                    else
                    {
                        return PartialView("ForecastReferenceNotFound");
                    }
                }
                catch(Exception ex)
                {
                    return PartialView("ForecastReferenceNotFound");
                }
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public JsonResult GFRemoveProjectDetails(string ProjectName, ForecastModelType type, string ModelLocation)
        {
            int CompanyId;
            CompanyId = int.Parse(Session["CompanyId"].ToString());
            var email = Session["SPAccount"].SafeTrim(); 
            var password = Session["SPPassword"].SafeTrim();
            string msg = "";
            string url = String.Empty;
            string extension = "xlsb";
            //ModelLocation = "Generics";
            if (ProjectName != null)
            {
                try
                {
                    if (!GetForecastManager(type).GFRemoveProjectDetails(ProjectName))
                        throw new Exception("failed to delete from database.");

                    url = String.Format("{0}{1}{2}{3}/{4}.{5}", GenUtil.SPHostUrl, GenUtil.ForecastModelServerRelativeUrl, Session["Archive"].ToString() + "/" + ModelLocation + "/", GenUtil.ForecastFolder, ProjectName, extension);
                    if (String.IsNullOrEmpty(url))
                    throw new Exception("Could not find the forecast version");
                    url = url.Trim(new char[] { ',' }).Replace(GenUtil.SPHostUrl, String.Empty);
                    if (!url.StartsWith("/"))
                    url = "/" + url;
                    if(!SpComHelper.DeleteFileFromSharePoint(GenUtil.SPSiteUrl, email, password, "", true, url,out msg))
                    throw new Exception("Failed to delete from sharepoint.");
                         
                }
                catch (Exception ex)
                {
                    msg = ex.Message;
                }

            }
            else
            {
                msg = "Could not share document!";
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

          [HttpPost]
        public JsonResult SetSectionPreferences(string forecast, ForecastModelType type, string version, string sectionPref)
        {
            string msg = "";
              try
                {
                     GetForecastManager(type).SetSectionPreferences(forecast, version, sectionPref);
                }
                catch (Exception ex)
                {
                    msg = ex.Message;
                }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


          public JsonResult GetSectionPreference(string Forecast, string Version, ForecastModelType type)
          {
              int CompanyId;
              CompanyId = int.Parse(Session["CompanyId"].ToString());
              List<ForecastSection> SectionsOrderByUserId = new List<ForecastSection>();
              string msg = null;
              try
              {
                  SectionsOrderByUserId = GetForecastManager(type).GetSectionPreference(Forecast, Version);
              }
              catch (Exception ex)
              {
                  msg = ex.Message;
              }
              if (String.IsNullOrEmpty(msg))
                  return Json(new { success = true, SectionsOrderByUserId = SectionsOrderByUserId }, JsonRequestBehavior.AllowGet);
              else
                  return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
          }

          public ActionResult VersionTracker()
          {
              return View();
          }

        //[HttpPost]
        //  public JsonResult SetForecastTemplate(string ProjectName, ForecastModelType Type, string filePathWithExtension)
        //  {
        //      int CompanyId;
        //      //string StorageId = "";    // this  is storage id which is given by shivam;
        //      int returnVal = -1;
        //      HttpPostedFileBase file = null;
        //      CompanyId = int.Parse(Session["CompanyId"].ToString());
        //      string msg = null;
        //      StorageTypeFactory factory = new ConcreteStorageFactory();
        //      StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
        //      string StorageId = storagefactory.Upload(Session["CompanyId"].ToString(), file, StorageContext.Forecast);
        //    //convert bool to int 
        //    //   bool t = true;
        //    // int i = t ? 1 : 0;        
        //      try
        //      {
        //        returnVal = GetForecastManager(Type).SetForecastTemplate(ProjectName, StorageId);
        //      }
        //      catch (Exception ex)
        //      {
        //          msg = ex.Message;
        //      }
        //      if (String.IsNullOrEmpty(msg))
        //          return Json(new { success = true, returnVal = returnVal }, JsonRequestBehavior.AllowGet);
        //      else
        //          return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //  }

        //[HttpPost]
        //public JsonResult SaveForecast(string ProjectName, ForecastModelType Type, bool MajorVersion, string Description)
        //{
        //    string CompanyId;
        //    //string StorageId = "";    // this storage id is given by shivam;
        //    HttpPostedFileBase file = null;
        //    int output = -1;
        //    CompanyId = Session["CompanyId"].ToString();
        //    string msg = null;
        //    int majorVersion = Convert.ToInt32(MajorVersion);
        //    StorageTypeFactory factory = new ConcreteStorageFactory();
        //    StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
        //    string StorageId = storagefactory.Upload(Session["CompanyId"].ToString(), file, StorageContext.Forecast);
        //    //convert bool to int 
        //    //   bool t = true;
        //    // int i = t ? 1 : 0;        
        //    try
        //    {
        //       output = GetForecastManager(Type).SaveForecast(ProjectName, StorageId, majorVersion, Description);
        //    }
        //    catch (Exception ex)
        //    {
        //        msg = ex.Message;
        //    }
        //    if (String.IsNullOrEmpty(msg))
        //        return Json(new { success = true, output = output }, JsonRequestBehavior.AllowGet);
        //    else
        //        return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //}
        public string GetUrlAndAddToContentFolder(bool isSave,string fileName, byte[] templeteOrFlatFs)
        {
            string pathUrl = "";
            string intermDirPath = Server.MapPath("~/Content/Intermediate");
            if (isSave)
            {
                pathUrl = GenUtil.CombineFileSysPaths(intermDirPath, fileName);               
            }
           else  //false indicates retrieve
            {
                System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(intermDirPath, fileName), templeteOrFlatFs);
                pathUrl = GetHostUrl() + Url.Content(String.Format(@"~\Content\Intermediate\{0}", fileName));
            }           
            return pathUrl;
        }
        public JsonResult DownloadFileFromdb(string forecast, string version, ForecastModelType type, bool isDownloadonlyflatFile)
        {
            byte[] fs; string contentUrl = "";
            string msg = "";
            string extension = ".xlsb";
            string CompanyId;
            //string StorageId = "";    // this storage id is given by shivam;
            //HttpPostedFileBase file = null;
            string storageId = "";
            int isFlatFile = 1;
            //int output = -1;
            CompanyId = Session["CompanyId"].ToString();
            var templatekey = "";
            var fileKey = "";
            byte[] tempaleteFs;
            StorageTypeFactory factory = new ConcreteStorageFactory();
            StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
            string templateStorgaeID = "";
            string templatecontentUrl = "";
            string finalUrl = "";
            //convert bool to int 
            //   bool t = true;
            // int i = t ? 1 : 0; 
            string downloadedFileName = "";
            string downloadedFileNameForTemplate = "";
         // string intermDirPath = Server.MapPath("~/Content/Intermediate");
            List<Assumption> assumptions = null;

            try
            {
                if (version == "V0.0")
                {
                    templateStorgaeID = GetForecastManager(type).retriveForecast(forecast, version, type, isFlatFile, true);
                    templatekey = templateStorgaeID + "|" + CompanyId;
                    tempaleteFs = storagefactory.Download(UnitOfWork, templatekey, StorageContext.Forecast);
                    string guid = Guid.NewGuid().ToString();
                    downloadedFileNameForTemplate = String.Format("_{0}_{1}_{2}{3}", Session["UserId"],forecast, guid, extension);    
                                   
                    //downloadedFileNameForTemplate = String.Format("{0}_{1}{2}", forecast, guid, extension);
                    // System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(intermDirPath, downloadedFileNameForTemplate), tempaleteFs);
                    //templatecontentUrl = GetHostUrl() + Url.Content(String.Format(@"~\Content\Intermediate\{0}", downloadedFileNameForTemplate));

                    templatecontentUrl = GetUrlAndAddToContentFolder(false, downloadedFileNameForTemplate, tempaleteFs);
                    finalUrl = templatecontentUrl + "|" + contentUrl;

                }
                else if (!isDownloadonlyflatFile)
                {
                    templateStorgaeID = GetForecastManager(type).retriveForecast(forecast, version, type, isFlatFile, true);
                    storageId = GetForecastManager(type).retriveForecast(forecast, version, type, isFlatFile, false);
                    templatekey = templateStorgaeID + "|" + CompanyId;
                    fileKey = storageId + "|" + CompanyId;
                    tempaleteFs = storagefactory.Download(UnitOfWork, templatekey, StorageContext.Forecast);
                    fs = storagefactory.Download(UnitOfWork,fileKey, StorageContext.Forecast);
                    string guid = Guid.NewGuid().ToString();
                    downloadedFileName = String.Format("_{0}_{1}_{2}_{3}{4}", Session["UserId"],forecast, version, guid, extension);
                    downloadedFileNameForTemplate = String.Format("_{0}_{1}_{2}{3}", Session["UserId"],forecast, guid, extension);

                    //downloadedFileName = String.Format("{0}_{1}_{2}{3}", forecast, version, guid, extension);
                    //downloadedFileNameForTemplate = String.Format("{0}_{1}{2}", forecast, guid, extension);
                    //System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(intermDirPath, downloadedFileNameForTemplate), tempaleteFs);
                    //System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(intermDirPath, downloadedFileName), fs);
                    //contentUrl = GetHostUrl() + Url.Content(String.Format(@"~\Content\Intermediate\{0}", downloadedFileName));
                    //templatecontentUrl = GetHostUrl() + Url.Content(String.Format(@"~\Content\Intermediate\{0}", downloadedFileNameForTemplate));

                    templatecontentUrl = GetUrlAndAddToContentFolder(false, downloadedFileNameForTemplate, tempaleteFs);
                    contentUrl = GetUrlAndAddToContentFolder(false, downloadedFileName, fs);
                    finalUrl = templatecontentUrl + "|" + contentUrl;
                    assumptions = GetAssumptions(forecast, version, type);
                }
                else
                {
                    storageId = GetForecastManager(type).retriveForecast(forecast, version, type, isFlatFile, false);
                    fileKey = storageId + "|" + CompanyId;
                    fs = storagefactory.Download(UnitOfWork, fileKey, StorageContext.Forecast);
                    string guid = Guid.NewGuid().ToString();
                    downloadedFileName = String.Format("_{0}_{1}_{2}_{3}{4}", Session["UserId"], forecast, version, guid, extension);

                    //downloadedFileName = String.Format("{0}_{1}_{2}{3}", forecast, version, guid, extension);
                    //System.IO.File.WriteAllBytes(GenUtil.CombineFileSysPaths(intermDirPath, downloadedFileName), fs);
                    //contentUrl = GetHostUrl() + Url.Content(String.Format(@"~\Content\Intermediate\{0}", downloadedFileName));

                    contentUrl = GetUrlAndAddToContentFolder(false, downloadedFileName, fs);
                    finalUrl = templatecontentUrl + "|" + contentUrl;
                    assumptions = GetAssumptions(forecast, version, type);
                }

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, url = finalUrl, notes = assumptions }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult OpenOfflineForTemplate(string projectName, ForecastModelType Type)
        {
            string msg = "";
            int returnVal = -1;
            try
            {
                returnVal = GetForecastManager(Type).CheckTemplatePresent(projectName);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, returnVal = returnVal }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
         public ActionResult SharePopup(ShareType shareType)
        {
            ShareModel shareInfo = new ShareModel();
            shareInfo.ShareType = shareType;
            return View(shareInfo);
        }

        [Disconnected]
        [HttpGet]
        public JsonResult DeleteIntermediateContainer()
        {
            string msg = string.Empty;
            string intermDirPath = Server.MapPath("~/Content/Intermediate");
            string[] filesToDelete = Directory.GetFiles(intermDirPath, "*.xlsb");
            foreach (string filePath in filesToDelete)
            {
                string fileName = (Path.GetFileName(filePath)).ToString();
                string userId =fileName.Split('_')[1];
                try
                {
                    if (userId== Session["UserId"].ToString())
                    {
                        System.IO.File.Delete(filePath);
                    }                    
                }
                catch(Exception ex)
                {
                   // msg = ex.Message;
                }
            }

            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        private string GetHostUrl()
        {
            return string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~")).TrimEnd(new char[] { '/' });
        }

    }
}
