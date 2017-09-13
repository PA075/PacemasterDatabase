using Microsoft.SharePoint.Client;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace PharmaACE.ForecastApp.Business
{
    public class SpComHelper
    {

        /// <summary>
        /// </summary>
        static void ctx_ExecutingWebRequest_FixForMixedMode(object sender, WebRequestEventArgs e)
        {
            // to support mixed mode auth
            e.WebRequestExecutor.RequestHeaders.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f");
        }

        /// <summary>
        /// </summary>
        public static bool GetListFoldersFilesFolderLevel(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string folderUrl,
            int sortCol,
            HashSet<string> userForecastMapping,
            out List<ForecastFlatFile> lstObjs,
            out string msg)
        {
            msg = "";
            lstObjs = new List<ForecastFlatFile>();
            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var folder = ctx.Web.GetFolderByServerRelativeUrl(folderUrl);

                var folders = folder.Folders;
                ctx.Load(folders, x => x.Include(z => z.Name, z => z.ServerRelativeUrl, z => z.Files.Include(y => y.Name, y => y.MajorVersion, y => y.MinorVersion, y => y.CheckInComment, y => y.Author, y => y.ModifiedBy, y => y.TimeCreated, y => y.TimeLastModified, y => y.Versions, y => y.ServerRelativeUrl, y => y.ListItemAllFields)));

                var files = folder.Files;
                ctx.Load(files, x => x.Include(y => y.Name, y => y.MajorVersion, y => y.MinorVersion, y => y.CheckInComment, y => y.Author, y => y.ModifiedBy, y => y.TimeCreated, y => y.TimeLastModified, y => y.Versions, y => y.ServerRelativeUrl, y => y.ListItemAllFields));

                ctx.ExecuteQuery();

                foreach (Folder curFolder in folders)
                {
                    lstObjs.Add(new ForecastFlatFile()
                    {
                        treeNodeType = Enums.TreeNodeTypes.FOLDER,
                        name = curFolder.Name,
                        url = curFolder.ServerRelativeUrl
                    });


                    foreach (File curFile in curFolder.Files)
                    {
                        if (!userForecastMapping.Contains(curFile.Name.ReplaceLastOccurrence(".xlsx", String.Empty)))
                            continue;
                        lstObjs.Add(new ForecastFlatFile()
                        {
                            treeNodeType = Enums.TreeNodeTypes.FILE,
                            name = curFile.Name,
                            url = curFile.ServerRelativeUrl,
                            Author = curFile.Author.Email,
                            LastModifiedBy = curFile.ModifiedBy.Email,
                            dtCreated = curFile.TimeCreated.ToString("MMMM dd, yyyy H:mm tt"),
                            dtModified = curFile.TimeLastModified.ToString("MMMM dd, yyyy H:mm tt"),
                            MajorVersion = curFile.MajorVersion,
                            MinorVersion = curFile.MinorVersion,
                            Comment = curFile.CheckInComment,
                            ItemId = curFile.ListItemAllFields.FieldValues.ContainsKey("ID") ? (int)GenUtil.SafeToNum(curFile.ListItemAllFields.FieldValues["ID"]) : -1,
                            //dtModified = curFile.ListItemAllFields.FieldValues.ContainsKey("Modified") ? (DateTime?)GenUtil.SafeToDateTime(curFile.ListItemAllFields.FieldValues["Modified"]) : null,
                            size = curFile.ListItemAllFields.FieldValues.ContainsKey("File_x0020_Size") ? GenUtil.GetSizeLabelFromBytes((long?)GenUtil.SafeToNum(curFile.ListItemAllFields.FieldValues["File_x0020_Size"]), 2) : null,
                            versions = new List<PharmaACE.ForecastApp.Models.ForecastVersion>()
                        });
                        foreach (var v in curFile.Versions)
                        {
                            var fileVersion = new PharmaACE.ForecastApp.Models.ForecastVersion();
                            fileVersion.Url = v.Url;
                            fileVersion.MajorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[0]);
                            fileVersion.MinorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[1]);
                            fileVersion.Comment = v.CheckInComment;
                            lstObjs.Last().versions.Add(fileVersion);
                        }
                        if (curFile.Versions.Count > 0)
                        {
                            lstObjs.Last().versions = curFile.Versions.Select(v => new PharmaACE.ForecastApp.Models.ForecastVersion
                            {
                                Url = v.Url,
                                MajorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[0]),
                                MinorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[1]),
                                Comment = v.CheckInComment
                            }).AsEnumerable().ToList();
                        }
                    }
                }

                foreach (File curFile in files)
                {
                    if (!userForecastMapping.Contains(curFile.Name.ReplaceLastOccurrence(".xlsx", String.Empty)))
                        continue;
                    lstObjs.Add(new ForecastFlatFile()
                    {
                        treeNodeType = Enums.TreeNodeTypes.FILE,
                        name = curFile.Name,
                        url = curFile.ServerRelativeUrl,
                        Author = curFile.Author.Email,
                        LastModifiedBy = curFile.ModifiedBy.Email,
                        dtCreated = curFile.TimeCreated.ToLocalTime().ToString("MMMM dd, yyyy H:mm tt"),
                        dtModified = curFile.TimeLastModified.ToLocalTime().ToString("MMMM dd, yyyy H:mm tt"),
                        MajorVersion = curFile.MajorVersion,
                        MinorVersion = curFile.MinorVersion,
                        Comment = curFile.CheckInComment,
                        ItemId = curFile.ListItemAllFields.FieldValues.ContainsKey("ID") ? (int)GenUtil.SafeToNum(curFile.ListItemAllFields.FieldValues["ID"]) : -1,
                        //dtModified = curFile.ListItemAllFields.FieldValues.ContainsKey("Modified") ? (DateTime?)GenUtil.SafeToDateTime(curFile.ListItemAllFields.FieldValues["Modified"]) : null,
                        size = curFile.ListItemAllFields.FieldValues.ContainsKey("File_x0020_Size") ? GenUtil.GetSizeLabelFromBytes((long?)GenUtil.SafeToNum(curFile.ListItemAllFields.FieldValues["File_x0020_Size"]), 2) : null,
                        versions = new List<PharmaACE.ForecastApp.Models.ForecastVersion>()
                    });
                    foreach (var v in curFile.Versions)
                    {
                        var fileVersion = new PharmaACE.ForecastApp.Models.ForecastVersion();
                        fileVersion.Url = v.Url;
                        fileVersion.MajorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[0]);
                        fileVersion.MinorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[1]);
                        fileVersion.Comment = v.CheckInComment;
                        lstObjs.Last().versions.Add(fileVersion);
                    }
                    if (curFile.Versions.Count > 0)
                    {
                        lstObjs.Last().versions = curFile.Versions.Select(v => new PharmaACE.ForecastApp.Models.ForecastVersion
                        {
                            Url = v.Url,
                            MajorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[0]),
                            MinorVersion = Int32.Parse(v.VersionLabel.Split(new char[] { '.' })[1]),
                            Comment = v.CheckInComment
                        }).AsEnumerable().ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        public static bool UploadFilesToSharePoint(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string docLibTitle,
            List<string> checkInComments,
            List<byte[]> sourceFiles,
            List<string> destFileNames,
            string spFolderUrl,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var folder = ctx.Web.GetFolderByServerRelativeUrl(spFolderUrl);
                List<File> newSpFiles = new List<File>();
                for (int i = 0; i < sourceFiles.Count; i++)
                {
                    var fci = new FileCreationInformation();
                    fci.Content = sourceFiles[i];
                    fci.Url = destFileNames[i];
                    fci.Overwrite = true;
                    newSpFiles.Add(folder.Files.Add(fci));
                }
                ctx.ExecuteQuery(); //unlock
                if (checkInComments != null && checkInComments.Count() > 0)
                {
                    bool executeQueryForComments = false;
                    for (int i = 0; i < newSpFiles.Count; i++)
                    {
                        var newSpFile = newSpFiles[i];
                        if (!String.IsNullOrWhiteSpace(checkInComments[i]))
                        {
                            List list = ctx.Web.Lists.GetByTitle(docLibTitle);
                            list.ForceCheckout = true;
                            list.Update();
                            newSpFile.CheckOut();
                            newSpFile.CheckIn(checkInComments[i], CheckinType.OverwriteCheckIn);
                            list.ForceCheckout = false;
                            list.Update();
                            executeQueryForComments = true;
                        }
                    }
                    if (executeQueryForComments)
                        ctx.ExecuteQuery();
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool GetAllUsersWithAccessToTenantArchive(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string groupName,
            out List<PharmaACE.ForecastApp.Models.UserProfile> users,
            out string msg)
        {
            msg = "";
            users = new List<UserProfile>();

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var groups = ctx.Web.SiteGroups;
                var group = groups.GetByName(groupName);
                var grpUsers = group.Users;
                ctx.Load(grpUsers);
                ctx.ExecuteQuery();
                foreach (var user in grpUsers)
                {
                    users.Add(new UserProfile { UserId = user.Id, Email = user.Email });
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool CreateFolderInSharePoint(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string folderName,
            string spFolderUrl,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var folder = ctx.Web.GetFolderByServerRelativeUrl(spFolderUrl);
                var newFolder = folder.Folders.Add(folderName);

                ctx.ExecuteQuery();

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool GetFileBytesFromSharePoint(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string fileServerRelUrl,
            string userAgent,
            bool isLatestVersion,
            out byte[] fileData,
            out string msg)
        {
            msg = "";
            fileData = null;

            try
            {
                var ctx = new ClientContext(spSiteUrl);
                MsOnlineClaimsHelper claimsHelper = null;
                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                if (isLatestVersion)
                {
                    var fi = File.OpenBinaryDirect(ctx, fileServerRelUrl);
                    fileData = GenUtil.ReadFully(fi.Stream);
                }
                else
                {
                    //string myVersionFullUrl = "https://pharmaacedev.sharepoint.com/sites/PharmaDocs/_vti_history/512/Shared Documents/PharmaACE Forecast Tool_Draft Version V1.13/Pipeline Volume/zzz_EU.xlsx";
                    //string userName = "debajyoti.das@pharmaacedev.onmicrosoft.com";//WebConfigurationManager.AppSettings.Get("VersionAccessUser");
                    //string strPassword = "__Imagination12";//WebConfigurationManager.AppSettings.Get("VersionAccessPassword");                    
                    MsOnlineClaimsHelper claimsHelper1 = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    var client = new WebClient();
                    client.Headers["Accept"] = "/";
                    client.Headers.Add(HttpRequestHeader.UserAgent, userAgent);
                    if (claimsHelper1 != null)
                        client.Headers.Add(HttpRequestHeader.Cookie, claimsHelper1.CookieContainer.GetCookieHeader(new Uri(GenUtil.SPHostUrl)));
                    string fullUrl = GenUtil.SPSiteUrl + fileServerRelUrl;
                    fileData = client.DownloadData(fullUrl);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message + ": " + ex.StackTrace;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool DeleteFileFromSharePoint(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string fileServerRelUrl,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var file = ctx.Web.GetFileByServerRelativeUrl(fileServerRelUrl);
                file.DeleteObject();

                ctx.ExecuteQuery();

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool DeleteFolderFromSharePoint(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string folderServerRelUrl,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var folder = ctx.Web.GetFolderByServerRelativeUrl(folderServerRelUrl);
                folder.DeleteObject();

                ctx.ExecuteQuery();

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool RenameSharePointFile(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string fileServerRelUrl,
            string newFileName,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var file = ctx.Web.GetFileByServerRelativeUrl(fileServerRelUrl);
                ctx.Load(file,
                    f => f.ListItemAllFields);
                ctx.ExecuteQuery();

                file.ListItemAllFields["FileLeafRef"] = newFileName;
                file.ListItemAllFields.Update();
                ctx.ExecuteQuery();

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool RenameSharePointFolder(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            Guid listId,
            string folderServerRelUrl,
            string newFolderName,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }

                var oldFolderParentUrl = folderServerRelUrl.Substring(0, folderServerRelUrl.LastIndexOf('/'));
                var oldFolderName = folderServerRelUrl.Substring(folderServerRelUrl.LastIndexOf('/') + 1);

                var list = ctx.Web.Lists.GetById(listId);

                var query = new CamlQuery();
                query.FolderServerRelativeUrl = oldFolderParentUrl;
                query.ViewXml = "<View Scope=\"RecursiveAll\"> " +
                                    "<Query>" +
                                        "<Where>" +
                                            "<And>" +
                                                "<Eq>" +
                                                    "<FieldRef Name=\"FSObjType\" />" +
                                                    "<Value Type=\"Integer\">1</Value>" +
                                                 "</Eq>" +
                                                  "<Eq>" +
                                                    "<FieldRef Name=\"FileLeafRef\"/>" +
                                                    "<Value Type=\"Text\">" + oldFolderName + "</Value>" +
                                                  "</Eq>" +
                                            "</And>" +
                                         "</Where>" +
                                    "</Query>" +
                                "</View>";

                var items = list.GetItems(query);

                ctx.Load(items,
                    x => x.Include(
                        y => y["Title"],
                        y => y["FileLeafRef"]));

                ctx.ExecuteQuery();

                if (items.Count != 1)
                    throw new Exception("Folder not found: " + folderServerRelUrl);

                items[0]["Title"] = newFolderName;
                items[0]["FileLeafRef"] = newFolderName;
                items[0].Update();
                ctx.ExecuteQuery();

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

        /// <summary>
        /// </summary>
        public static bool EnableMinorVersion(
            string spSiteUrl,
            string spSiteUsername,
            string spSitePwd,
            string spSiteDomain,
            bool isSpOnline,
            string listTitle,
            bool enableMinorVersion,
            out string msg)
        {
            msg = "";

            try
            {
                var ctx = new ClientContext(spSiteUrl);

                if (!isSpOnline)
                {
                    ctx.Credentials = new NetworkCredential(spSiteUsername, spSitePwd, spSiteDomain);
                    ctx.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(ctx_ExecutingWebRequest_FixForMixedMode);
                }
                else
                {
                    var claimsHelper = new MsOnlineClaimsHelper(spSiteUrl, spSiteUsername, spSitePwd);
                    ctx.ExecutingWebRequest += claimsHelper.clientContext_ExecutingWebRequest;
                }


                var list = ctx.Web.Lists.GetByTitle(listTitle);
                list.EnableMinorVersions = enableMinorVersion;
                list.Update();
                ctx.ExecuteQuery();

            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg == "";
        }

    }
}
