using Ionic.Zip;
using iTextSharp.text;
using iTextSharp.text.pdf;
using MvcReportViewer;
using Newtonsoft.Json;
using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace PharmaACE.ForecastApp.Controllers
{
    public class ReportingController : BaseController
    {

        public ActionResult Index()
        {
            logger.Info("Inside Reporting/Index");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult SampleReportModel()
        {
            logger.Info("Inside Reporting/SampleReportModel");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return RedirectToAction("NewVersionReportModel","Reporting",new { type = 0 });
            }
            else
                return RedirectToAction("Index", "Home");
        }
   
        [AcceptVerbs(HttpVerbs.Get | HttpVerbs.Post)]
        public ActionResult NewVersionReportModel(ReportModelType type)
        {
            logger.Info("Inside Reporting/NewVersionReportModel");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                var CompanyId = int.Parse(Session["CompanyId"].ToString());
                var userId = int.Parse(Session["UserId"].ToString());
                //pass userId as -1 for all-report-access
                GetPermissionBasedUserId(type, ref userId);
                ReportingModel SampleReportingModel = new ReportManager(UnitOfWork).GetReportingModel(type, userId, CompanyId);
                //if (type == ReportModelType.BDL)
                //{                    
                //    reportingModel.parameterList = ReportValueParameters(type);
                //    reportingModel.reportAxes = ReportAxes(type);
                //    if (reportingModel.ReportType == ReportModelType.BDL)
                //        reportingModel.countrys = BL.GetAllCountrysForReport(CompanyId);
                //}
                //reportingModel.reportList = BL.GetReportInformation(userId, CompanyId, type);
                //reportingModel.dashboardList = BL.GetDashboardList(userId, CompanyId, type);
                return View(SampleReportingModel);

            }
            else
                return RedirectToAction("Index", "Home");
        }

        [AcceptVerbs(HttpVerbs.Get | HttpVerbs.Post)]
        public ActionResult ReportModel(ReportModelType type)
        {
            logger.Info("Inside Reporting/ReportModel");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                var CompanyId = int.Parse(Session["CompanyId"].ToString());
                var userId = int.Parse(Session["UserId"].ToString());
                //pass userId as -1 for all-report-access
                GetPermissionBasedUserId(type, ref userId);
                ReportingModel SampleReportingModel = new ReportManager(UnitOfWork).GetReportingModel(type, userId, CompanyId);
                //if (type == ReportModelType.BDL)
                //{                    
                //    reportingModel.parameterList = ReportValueParameters(type);
                //    reportingModel.reportAxes = ReportAxes(type);
                //    if (reportingModel.ReportType == ReportModelType.BDL)
                //        reportingModel.countrys = BL.GetAllCountrysForReport(CompanyId);
                //}
                //reportingModel.reportList = BL.GetReportInformation(userId, CompanyId, type);
                //reportingModel.dashboardList = BL.GetDashboardList(userId, CompanyId, type);


                //var qlikTkt = new ReportManager(UnitOfWork).GetQlikTicket();
                //string url = String.Format("http://{0}/{1}/sense/app/{2}/sheet/aPkWKB/state/analysis?qlikTicket={3}", "192.168.1.15:81", "webticket",
                //    "98a1d9c4-b033-476e-8bf5-63d43e04d6f1", qlikTkt);

                var filter = "&select=Frequency,Yearly";
                var qlikTkt = new ReportManager(UnitOfWork).GetQlikTicket();
                //string url = String.Format("http://{0}/{1}/single?qlikTicket={2}&appid={3}&sheet=jhmrcR&select=clearall{4}", "192.168.1.15:81", "webticket",
                //    qlikTkt, "463fea13-32f5-4e9b-84e7-311c674ae539", filter);
                //http://192.168.1.15:81/webticket/single?qlikTicket=8fU-LzvOnknUJQLf&appid=463fea13-32f5-4e9b-84e7-311c674ae539&sheet=jhmrcR&opt=nointeraction&select=clearall&select=Frequency,Yearly
                //string url = String.Format("http://{0}/{1}/sense/app/{2}/sheet/aPkWKB/state/analysis?qlikTicket={3}", "192.168.1.15:81", "webticket",
                //    "98a1d9c4-b033-476e-8bf5-63d43e04d6f1", qlikTkt);
                string url = String.Format("https://{0}/{1}/sense/app/17f3e61f-7e77-4d51-9de4-8da803d72b81/sheet/DtnzPjG/state/analysis?qlikTicket={2}", "192.168.1.15", "webticket", qlikTkt);
                //"https://192.168.1.15/sense/app/3039ffbe-4415-42c6-8f7c-4002eac8fc16/sheet/jhmrcR/state/analysis";
                SampleReportingModel.Url = url;  //"http://192.168.1.15:81/single/?appid=c16adb91-0461-43fd-a4e5-fd24b5a88c8e&sheet=aPkWKB&select=clearall&select=ProjectName,Ice";
                

                return View(SampleReportingModel);

            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult AsIsAnalysis(ReportModelType type)
        {
            logger.Info("Inside Reporting/AsIsAnalysis");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                var CompanyId = int.Parse(Session["CompanyId"].ToString());
                var userId = int.Parse(Session["UserId"].ToString());
                //pass userId as -1 for all-report-access
                GetPermissionBasedUserId(type, ref userId);
                ReportingModel SampleReportingModel = new ReportManager(UnitOfWork).GetReportingModel(type, userId, CompanyId);
                //if (type == ReportModelType.BDL)
                //{                    
                //    reportingModel.parameterList = ReportValueParameters(type);
                //    reportingModel.reportAxes = ReportAxes(type);
                //    if (reportingModel.ReportType == ReportModelType.BDL)
                //        reportingModel.countrys = BL.GetAllCountrysForReport(CompanyId);
                //}
                //reportingModel.reportList = BL.GetReportInformation(userId, CompanyId, type);
                //reportingModel.dashboardList = BL.GetDashboardList(userId, CompanyId, type);


                //var qlikTkt = new ReportManager(UnitOfWork).GetQlikTicket();
                //string url = String.Format("http://{0}/{1}/sense/app/{2}/sheet/aPkWKB/state/analysis?qlikTicket={3}", "192.168.1.15:81", "webticket",
                //    "98a1d9c4-b033-476e-8bf5-63d43e04d6f1", qlikTkt);

                var filter = "&select=Frequency,Yearly";
                var qlikTkt = new ReportManager(UnitOfWork).GetQlikTicket();
                //string url = String.Format("http://{0}/{1}/single?qlikTicket={2}&appid={3}&sheet=jhmrcR&select=clearall{4}", "192.168.1.15:81", "webticket",
                //    qlikTkt, "463fea13-32f5-4e9b-84e7-311c674ae539", filter);
                //http://192.168.1.15:81/webticket/single?qlikTicket=8fU-LzvOnknUJQLf&appid=463fea13-32f5-4e9b-84e7-311c674ae539&sheet=jhmrcR&opt=nointeraction&select=clearall&select=Frequency,Yearly
                //string url = String.Format("http://{0}/{1}/sense/app/{2}/sheet/aPkWKB/state/analysis?qlikTicket={3}", "192.168.1.15:81", "webticket",
                //    "98a1d9c4-b033-476e-8bf5-63d43e04d6f1", qlikTkt);
                string url = String.Format("https://{0}/{1}/sense/app/feb33d9f-246e-4e64-83f3-71a1aa803328/sheet/CXuzuuC/state/analysis?qlikTicket={2}", "192.168.1.15", "webticket", qlikTkt);
                //"https://192.168.1.15/sense/app/3039ffbe-4415-42c6-8f7c-4002eac8fc16/sheet/jhmrcR/state/analysis";
                SampleReportingModel.Url = url;  //"http://192.168.1.15:81/single/?appid=c16adb91-0461-43fd-a4e5-fd24b5a88c8e&sheet=aPkWKB&select=clearall&select=ProjectName,Ice";


                return View("ReportModel", SampleReportingModel);

            }
            else
                return RedirectToAction("Index", "Home");
        }

        private void GetPermissionBasedUserId(ReportModelType type, ref int userId)
        {
            if (type == ReportModelType.Generic && byte.Parse(Session["AccessTypeGTforproject"].ToString()) == 1)
                userId = -1;
            if (type == ReportModelType.BDL && (byte.Parse(Session["AccessTypeBDLforproject"].ToString()) == 1))
                userId = -1;
        }

        [HttpPost]
        [OutputCache(Duration = 7200, Location = OutputCacheLocation.Client, VaryByParam = "none", NoStore = true)]
        public ActionResult GenericsRenderer(DistinctReportSettings settings)
        {
            logger.Info("Inside Reporting/GenericsRenderer");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                settings.ReportType = ReportModelType.Generic;
                return PartialView("ReportRenderer", settings);
            }
            else
                return RedirectToAction("Index", "Home");
        }
        [HttpPost]
        [OutputCache(Duration = 7200, Location = OutputCacheLocation.Client, VaryByParam = "none", NoStore = true)]
        public ActionResult BDLRenderer(DistinctReportSettings settings)
        {
            logger.Info("Inside Reporting/BDLRenderer");
            if (Session != null && (!string.IsNullOrEmpty(Session["User"] as string)))
            {
                settings.ReportType = ReportModelType.BDL;
                return PartialView("ReportRenderer", settings);
            }
            else
                return RedirectToAction("Index", "Home");
        }
        public ActionResult DownloadReport(int reportId, ReportFormat format, ReportModelType modelType)
        {
            logger.Info("Inside Reporting/DownloadReport");
            if (Session != null && (!string.IsNullOrEmpty(Session["User"] as string)))
            {
                try
                {
                    int companyId = int.Parse(Session["CompanyId"].ToString());
                    var reportSettings = new ReportManager(UnitOfWork).GetReportConfig(reportId, companyId);
                   
                    if (reportSettings.ReportSettings.Parameters.Count==1)
                    {
                return this.Report(
                    format,
                    String.Format("/{0}/{1}", Session["SubscriberName"], modelType == ReportModelType.Generic ? "GenericsReport" : "BDL_Report"),
                    GenUtil.GetReportSettings(reportSettings.ReportSettings),
                    filename: reportSettings.ReportName);
                    }
                    else
                    {

                        List<FileStreamResult> streamList = new List<FileStreamResult>();
                        string[] parameterArray;
                        int totalSize = 0;
                        parameterArray = reportSettings.ReportSettings.Parameters.ToArray();
                        for (int i = 0; i < parameterArray.Length; i++)
                        {
                            string parameter = parameterArray[i].ToString();
                            reportSettings.ReportSettings.Parameters.Clear();
                            reportSettings.ReportSettings.Parameters.Add(parameter);
                            FileStreamResult fs = this.Report(
                              format,
                              String.Format("/{0}/{1}", Session["SubscriberName"], modelType == ReportModelType.Generic ? "GenericsReport" : "BDL_Report"),
                             GenUtil.GetReportSettings(reportSettings.ReportSettings), filename: reportSettings.ReportName);
                            streamList.Add(fs);
                            totalSize += (int)fs.FileStream.Length;

                        }

                        FileStreamResult result = null;
                        if (format.ToString() == "Word")
                        {
                            var stream = new MemoryStream(totalSize);
                            result = new FileStreamResult(stream, "application/word");
                        }
                        if (format.ToString()=="Pdf")
                            result = AppendStreamsInSinglePdf(streamList,format);
                        if (format.ToString() == "Image" || format.ToString() == "Jpeg")
                            result = AppendStreamsInSingleImage(streamList, format);  

                          
                        return result;
                    }
                }
                catch (Exception ex)
                {
                    //return could not download view on a new tab
                    throw new Exception();
                }
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult DownloadDashboard(int DashboardId, ReportFormat format, ReportModelType modelType)
        {
            logger.Info("Inside Reporting/DownloadDashboard");

            if (Session != null && (!string.IsNullOrEmpty(Session["User"] as string)))
            {
                List<SaveReportSettings> reportSettingsList = null;
                int CompanyId = -1;
                if (Session != null)
                {
                    CompanyId = int.Parse(Session["CompanyId"].ToString());
                }
                try
                {
                    reportSettingsList = new ReportManager(UnitOfWork).GetReportsDetailsByDashboardId(DashboardId, CompanyId);
                    int companyId = int.Parse(Session["CompanyId"].ToString());
                    List<FileStreamResult> streamList = new List<FileStreamResult>();
                    Dictionary<string, FileStreamResult> reportDictionary = new Dictionary<string, FileStreamResult>();

                    string[] parameterArray = null;
                    List<string> parameterList = new List<string>();
                    int totalSize = 0;
                    string DashBoardName = reportSettingsList[0].DashboardName;
                    for (int i = 0; i < reportSettingsList.Count; i++)
                    {
                        parameterArray = null;
                        parameterArray = reportSettingsList[i].ReportSettings.Parameters.ToArray();
                        for (int j = 0; j < parameterArray.Length; j++)
                            parameterList.Add(parameterArray[j].ToString());

                        for (int k = 0; k < parameterList.Count; k++)
                        {
                            string parameter = parameterList[k].ToString();
                            DistinctReportSettings reportSettings = reportSettingsList[i].ReportSettings;
                            reportSettings.Parameters.Clear();
                            reportSettings.Parameters.Add(parameter);
                            string fileName = reportSettingsList[i].ReportName+" "+parameter;
                            FileStreamResult fs = this.Report(
                              format,
                              String.Format("/{0}/{1}", Session["SubscriberName"], modelType == ReportModelType.Generic ? "GenericsReport" : "BDL_Report"),
                            GenUtil.GetReportSettings(reportSettings), filename: fileName);
                            streamList.Add(fs);
                            reportDictionary.Add(fileName, fs);
                            totalSize += (int)fs.FileStream.Length;

                        }
                    }
                    var stream = new MemoryStream(totalSize);
                    FileStreamResult result = new FileStreamResult(stream, "application/word");

                    if (format.ToString() == "Pdf")
                        result = AppendStreamsInSinglePdf(streamList, format);
                    if (format.ToString() == "Image" || format.ToString() == "Jpeg")
                        result = AppendFileStreamResultInSingleZip(reportDictionary, DashBoardName);

                    return result;
                }
                catch (Exception ex)
                {
                    //return could not download view on a new tab
                    throw ex;
                }

            }
            else
                return RedirectToAction("Index", "Home");
        }

        private FileStreamResult AppendFileStreamResultInSingleZip(Dictionary<string, FileStreamResult> reportDictionary, string DashBoardName)
        {
            MemoryStream workStream = new MemoryStream();
            FileStreamResult fileResult = new FileStreamResult(workStream, System.Net.Mime.MediaTypeNames.Application.Zip);
            try
            {
                using (var zip = new ZipFile())
                {
                    foreach (var pair in reportDictionary)
                    {
                        var key = pair.Key;
                        var value = pair.Value;
                        zip.AddEntry(key, value.FileStream);
                    }
                    Response.ClearHeaders();
                    // Response.AppendHeader("content-disposition", "attachment; filename=Report.zip");
                    zip.Save(workStream);
                }
                workStream.Position = 0;
                fileResult.FileDownloadName = DashBoardName + ".zip";
            }
            catch (Exception ex)
            {
                //return could not download view on a new tab
                throw ex;
            }
            return fileResult;
        }
        private FileStreamResult AppendStreamsInSingleImage(List<FileStreamResult> streamList, ReportFormat format)
        {
            List<System.Drawing.Bitmap> images = new List<System.Drawing.Bitmap>();
            System.Drawing.Bitmap finalImage = null;

            try
            {
                int width = 1;
                int height = 1;

                for (int i = 0; i < streamList.Count; i++)
                {
                    //create a Bitmap from the file and add it to the list
                    System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap(streamList[i].FileStream);

                    //update the size of the final bitmap
                    width = bitmap.Width;
                    height += bitmap.Height > height ? bitmap.Height : height;

                    images.Add(bitmap);
                }

                //create a bitmap to hold the combined image
                finalImage = new System.Drawing.Bitmap(width, height);
                // finalImage = new Bitmap(width, height);

                //get a graphics object from the image so we can draw on it
                using (System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(finalImage))
                {
                    //set background color
                    g.Clear(System.Drawing.Color.White);

                    //go through each image and draw it on the final image
                    int offset = 0;
                    foreach (System.Drawing.Bitmap image in images)
                    {
                        g.DrawImage(image,
                          new System.Drawing.Rectangle(0, offset, image.Width, image.Height));
                        offset += image.Height;
                    }

                }
            }
            catch (Exception ex)
            {
                if (finalImage != null)
                    finalImage.Dispose();
                throw ex;
            }

            Stream stream = new MemoryStream();
            finalImage.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
            stream.Position = 0;
            return new FileStreamResult(stream, "image/Jpeg");

        }

        private FileStreamResult AppendStreamsInSinglePdf(List<FileStreamResult> streamList, ReportFormat format)
        {
            byte[] mergedPdf = null;
            using (MemoryStream ms = new MemoryStream())
            {
                using (Document document = new Document())
                {
                    using (PdfCopy copy = new PdfCopy(document, ms))
                    {
                        document.Open();

                        for (int i = 0; i < streamList.Count; ++i)
                        {
                            PdfReader reader = new PdfReader(streamList[i].FileStream);
                            // loop over the pages in that document
                            int n = reader.NumberOfPages;
                            for (int page = 0; page < n;)
                            {
                                copy.AddPage(copy.GetImportedPage(reader, ++page));
                            }
                        }
                    }
                }
                mergedPdf = ms.ToArray();
            }
            Stream stream = new MemoryStream(mergedPdf);
            return new FileStreamResult(stream, "application/pdf");
        }
        [HttpGet]
        public JsonResult GetProjectNameForForcastReport()
        {
            logger.Info("Inside Reporting/GetProjectNameForForcastReport");
            string msg = string.Empty;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            IEnumerable<string> projectNames = new List<string>();
            try
            {
                projectNames = new ReportManager(UnitOfWork).GetDistinctProjectNames();
                if(projectNames!=null)
                {
                    logger.Info("Project Name for forcast reporting got succeessfully");

                }
                else
                {
                    msg = "Unable to get project Name for forcast reporting";
                    logger.Info(msg);

                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/GetProjectNameForForcastReport: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, projectNames = projectNames }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetTableauToken()
        {
            logger.Info("Inside Reporting/GetTableauToken");
            string msg = null;
            string token = null;
            try
            {
                HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create("http://13.89.232.215:8080");
                //request.Method = "GET";
                //request.AllowAutoRedirect = false;
                //request.Accept = "*/*";
                request.ContentType = "application/x-www-form-urlencoded";
                var httpResponse = (HttpWebResponse)request.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    token = streamReader.ReadToEnd();

                    //Now you have your response.
                    //or false depending on information in the response     
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/GetTableauToken: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }

            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, token = token }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        //{
        //    string msg = null;
        //    string token = null;
        //    try
        //    {
        //        HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create("http://13.89.232.215:8000/trusted");
        //        request.Method = "POST";
        //        //request.AllowAutoRedirect = false;
        //        //request.Accept = "*/*";
        //        request.ContentType = "application/x-www-form-urlencoded";

        //        StringBuilder postData = new StringBuilder();
        //        postData.Append("username=" + HttpUtility.UrlEncode("ddas"));
        //        var data = Encoding.ASCII.GetBytes(postData.ToString());

        //        using (var stream = request.GetRequestStream())
        //        {
        //            stream.Write(data, 0, data.Length);
        //        }
        //        var httpResponse = (HttpWebResponse)request.GetResponse();
        //        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        //        {
        //            token = streamReader.ReadToEnd();

        //            //Now you have your response.
        //            //or false depending on information in the response     
        //        }
        //    }
        //    catch(Exception ex)
        //    {
        //        msg = ex.Message;
        //    }

        //    if (String.IsNullOrEmpty(msg))
        //        return Json(new { success = true, token = token }, JsonRequestBehavior.AllowGet);
        //    else
        //        return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //}

        [HttpPost]
        public JsonResult SaveReport(SaveReportSettings reportSetting)
        {
            logger.Info("Inside Reporting/SaveReport");
            int saveResult = 0;
            string msg = "";
            int companyId = -1;
            int userId = -1;
            if (Session != null)
            {
                companyId = Session["CompanyId"].SafeToNum();
                userId = Session["UserId"].SafeToNum();
            }
            try
            {
                string configString = new JavaScriptSerializer().Serialize(reportSetting.ReportSettings);                
                string reportLink = string.Empty;
                saveResult = new ReportManager(UnitOfWork).SaveReport(companyId, userId, configString, reportSetting.ReportName, reportLink, reportSetting.Type, reportSetting.overWrite);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/SaveReport: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, reportId = saveResult }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveSharedReportDetails(string ReportName, int ReportId, string SharedWithIDs, ReportModelType type)
        {
            logger.Info("Inside Reporting/SaveSharedReportDetails");
            bool shareDashbord = false;
            int saveSharedResult = 0;
            string msg = "";
            int tenantId = -1;
            int userId = -1;
            string UserFname = "";
            string UserLname = "";
            if (Session != null)
            {
                tenantId = int.Parse(Session["CompanyId"].ToString());
                userId = int.Parse(Session["UserId"].ToString());
                UserFname = Session["FirstName"].ToString();
                UserLname = Session["LastName"].ToString();
            }
            try
            {
                saveSharedResult = new ReportManager(UnitOfWork).SaveSharedReportDetails(ReportId, userId, SharedWithIDs, AuthenticationLevel.Edit, tenantId, type);
                if (saveSharedResult == 1)
                {
                    logger.Info("successfully saved shared report");
                    SendMailForReportAndDashboardShare(SharedWithIDs, ReportName, shareDashbord);
                }
                else if (saveSharedResult == 2)
                {
                    logger.Info("report does not exist");
                }
                else if (saveSharedResult == 3)
                {
                    logger.Info("user does not exist");
                }
                else
                {
                    msg = "fail to save shard report ";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/SaveSharedReportDetails: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, reportId = saveSharedResult }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public void SendMailForReportAndDashboardShare(string SharedWithIDs, string ReportOrDashBoardName, bool shareDashbord)
        {
            Dictionary<int, PharmaACE.ForecastApp.Models.UserInfo> usersInfoSet = new Dictionary<int, PharmaACE.ForecastApp.Models.UserInfo>();
            PharmaACE.ForecastApp.Models.UserInfo user = new PharmaACE.ForecastApp.Models.UserInfo();
            List<int> shareIDs = new List<int>(SharedWithIDs.Split(',').Select(int.Parse));
            int UserId = -1;
            string UserFname = "";
            string UserLname = "";
            if (Session != null)
            {
                UserId = int.Parse(Session["UserId"].ToString());
                UserFname = Session["FirstName"].ToString();
                UserLname = Session["LastName"].ToString();
            }
            usersInfoSet = new UserManager(UnitOfWork).GetUserInfoByUserId(shareIDs);
            foreach (var item in usersInfoSet)
            {
                new ReportManager(UnitOfWork).SendMailForShareReportOrDashboard(item.Value.Email, item.Value.FirstName, item.Value.LastName, UserFname, 
                    UserLname, ReportOrDashBoardName, shareDashbord);
            }
        }
        [HttpPost]
        public JsonResult GetReportInformation(ReportModelType type)
        {
            logger.Info("Inside Reporting/GetReportInformation");
            List<SaveReportSettings> ReportInfoList = new List<SaveReportSettings>();
            string msg = "";
            int CompanyId = -1;
            int UserId = -1;
            if (Session != null)
            {
                CompanyId = int.Parse(Session["CompanyId"].ToString());
                UserId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                ReportInfoList = new ReportManager(UnitOfWork).GetReportInformation(UserId, CompanyId, type);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/GetReportInformation: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, ReportInfoList = ReportInfoList }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        //public JsonResult CreateDashboard(string DashboardName, ReportModelType type)
        //{
        //    int saveResult = 0;
        //    string msg = "";
        //    int CompanyId = -1;
        //    int UserId = -1;
        //    if (Session != null)
        //    {
        //        CompanyId = int.Parse(Session["CompanyId"].ToString());
        //        UserId = int.Parse(Session["UserId"].ToString());
        //    }
        //    try
        //    {
        //        saveResult = new ReportManager(UnitOfWork).CreateDashboard(UserId, DashboardName, CompanyId, type);
        //    }
        //    catch (Exception ex)
        //    {
        //        msg = ex.Message;
        //    }
        //    if (String.IsNullOrEmpty(msg))
        //        return Json(new { success = true, dashbordId = saveResult }, JsonRequestBehavior.AllowGet);
        //    else
        //        return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        //}

        [HttpPost]
        public JsonResult GetDashboardList(ReportModelType type)
        {
            logger.Info("Inside Reporting/GetDashboardList");
            IEnumerable<Dashboard> dashboardList = new List<Dashboard>();
            string msg = "";
            int CompanyId = -1;
            int UserId = -1;
            if (Session != null)
            {
                CompanyId = int.Parse(Session["CompanyId"].ToString());
                UserId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                dashboardList = new ReportManager(UnitOfWork).GetDashboardList(UserId, CompanyId, type);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/GetDashboardList: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, DashboardList = dashboardList }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CreateDashboard(string DashboardName, string ReportIds, ReportModelType type,bool newDashboard,bool overWriteDash)
        {
            logger.Info("Inside Reporting/CreateDashboard");
            int saveResult = 0;
            string msg = "";
            int CompanyId = -1;
            int UserId = -1;
            if (Session != null)
            {
                CompanyId = int.Parse(Session["CompanyId"].ToString());
                UserId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                if (overWriteDash==true)
                {
                    saveResult = new ReportManager(UnitOfWork).CreateDashboard(UserId,ReportIds.Split(new char[',']).Select(repId => repId.SafeToNum()).ToList(), DashboardName, CompanyId, type, overWriteDash);
                }
                if (ReportIds=="-1")
                {
                    saveResult = new ReportManager(UnitOfWork).CreateDashboard(UserId, ReportIds.Split(new char[',']).Select(repId => repId.SafeToNum()).ToList(), DashboardName, CompanyId, type,overWriteDash);
                }

                else if (newDashboard==true && overWriteDash==false)
                {
                    saveResult = new ReportManager(UnitOfWork).CreateDashboardWithPinReport(UserId, ReportIds.Split(new char[',']).Select(repId => repId.SafeToNum()).ToList(),
                        DashboardName,CompanyId, type);
                }
                else if (newDashboard == false && overWriteDash == false)
                {
                    if (new ReportManager(UnitOfWork).PinReportToDashboard(DashboardName, ReportIds.Split(new char[',']).Select(repId => repId.SafeToNum()).ToList(), CompanyId, type) == 0)
                        msg = "There was a problem storing the report against the database.";
                    else
                        saveResult = 2;
                }
                
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/CreateDashboard: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true , dashbordId = saveResult }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        //vinod-7/12/16 start
        public JsonResult GetReportsDetailsByDashboardId(int dashboardId)
        {
            logger.Info("Inside Reporting/GetReportsDetailsByDashboardId");
            List<SaveReportSettings> reportSettingsList = null;
            string msg = "";
            int CompanyId = -1;
            int UserId = -1;
            if (Session != null)
            {
                CompanyId = int.Parse(Session["CompanyId"].ToString());
                UserId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                reportSettingsList = new ReportManager(UnitOfWork).GetReportsDetailsByDashboardId(dashboardId, CompanyId);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/GetReportsDetailsByDashboardId: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, reportSettingsList = reportSettingsList }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult RemoveReport(int reportId)
        {
            logger.Info("Inside Reporting/RemoveReport");
            int removeResult = 0;
            string msg = "";
            int tenantId = -1;
            int userId = -1;
            if (Session != null)
            {
                tenantId = int.Parse(Session["CompanyId"].ToString());
                userId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                removeResult = new ReportManager(UnitOfWork).RemoveReport(userId, reportId, tenantId);
                if (removeResult==1)
                {
                    logger.Info("successfully Remove Report");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/RemoveReport: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, removeResult = removeResult }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult RemoveDashboard(int DashboardId)
        {
            logger.Info("Inside Reporting/RemoveDashboard");
            int removeResult = 0;
            string msg = "";
            int CompanyId = -1;
            int UserId = -1;
            if (Session != null)
            {
                CompanyId = int.Parse(Session["CompanyId"].ToString());
                UserId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                removeResult = new ReportManager(UnitOfWork).RemoveDashboard(UserId, DashboardId, CompanyId);
                if (removeResult==1)
                {
                    logger.Info("successfully remove dashboard");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/RemoveDashboard: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, removeResult = removeResult }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SaveSharedDashboard(int DashboardId, string SharedWithIDs, string DashboardName)
        {
            logger.Info("Inside Reporting/SaveSharedDashboard");
            bool shareDashbord = true;
            int saveSharedResult = 0;
            string msg = "";
            int CompanyId = -1;
            int UserId = -1;
            if (Session != null)
            {
                CompanyId = int.Parse(Session["CompanyId"].ToString());
                UserId = int.Parse(Session["UserId"].ToString());
            }
            try
            {
                saveSharedResult = new ReportManager(UnitOfWork).SaveSharedDashboard(DashboardId, SharedWithIDs, UserId, 2, CompanyId);
                if (saveSharedResult == 1)
                {
                    logger.Info("successfully saved shared dashboard");
                    SendMailForReportAndDashboardShare(SharedWithIDs, DashboardName, shareDashbord);
                }
                else if (saveSharedResult==2)
                {
                    logger.Info("dashboard does not exist");
                }
                else if (saveSharedResult == 3)
                {
                    logger.Info("user does not exist");
                }
                else
                {
                    msg = "fail to save shard dashboard ";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Reporting/SaveSharedDashboard: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, reportId = saveSharedResult }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }        
    }
}


