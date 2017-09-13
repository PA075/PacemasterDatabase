using EntityFramework.Extensions;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Business
{
    public class ForecastManager
    {
        protected IUnitOfWork uow;
        protected int userId;
        private UserRole userRole;
        private byte forecastAccessType;
        protected bool IsAllAccessible { get { return forecastAccessType == 1 || userRole == UserRole.SuperAdmin; } }
        protected virtual string Namespace { get { return ""; } }

        public ForecastManager(IUnitOfWork uow, int userId)
        {
            this.uow = uow;
            this.userId = userId;
        }

        public ForecastManager(IUnitOfWork uow, int userId, UserRole userRole, byte accessType)
        {
            this.uow = uow;
            this.userId = userId;
            this.userRole = userRole;
            this.forecastAccessType = accessType;
        }

        protected virtual List<UserForecastMapping> GetUserForecastMapping() { return null; }

        public virtual int UnshareForecast(List<UserForecastMappingForUnshare> userForecastsForUnshare) { return 0; }

        public void PopulateForecastDetails(ForecastEntity forecastEntity)
        {
            string msg = String.Empty;
            List<UserForecastMapping> userForecastMapping = new List<UserForecastMapping>();
            //var lstObjs = new List<ForecastFlatFile>();
            if (!String.IsNullOrWhiteSpace(forecastEntity.ModelLocation))
            {
                userForecastMapping = GetUserForecastMapping();
                forecastEntity.ForecastDetails.ItemList = userForecastMapping;
            }
            forecastEntity.Sections = GetSectionPreference(null, null);
            forecastEntity.ForecastAuxiliary.NewsDetails = new UserManager(uow).GetNewsFeedParams(userId);
            forecastEntity.ForecastAuxiliary.Assumptions = new ForecastAssumptions();
            forecastEntity.ForecastAuxiliary.Assumptions.Visible = !forecastEntity.DisplayInitialModel;
        }

        protected bool SetVersionAccess(Models.UserAccess versionAccess, int sharedWithId, int sharedById, int authorization, DateTime accessDate,
            List<int> userIDs, ForecastVersion latest, int projectCreatorId = 0)
        {
            bool isLatest = false;
            if (authorization == 1 && sharedWithId > 0)
            {
                versionAccess.Creator = new UserInfo
                {
                    UserId = sharedWithId,
                };
                versionAccess.CreatedOn = accessDate;
                userIDs.Add(sharedWithId);
                //set latest
                if (latest != null && latest.Access != null && latest.Access.CreatedOn < versionAccess.CreatedOn)
                    isLatest = true;

                //add project creator to the shared access list
                if (projectCreatorId > 0)
                {
                    if (!versionAccess.SharedAccess.Any(sa => sa.SharedWith.UserId == projectCreatorId))
                    {
                        //introducing implicit access through code, no separate entry in database for this
                        SharedAccessInfo sharedAccess = new SharedAccessInfo
                        {
                            AuthorizationLevel = 2, //Edit
                            SharedWith = new UserInfo
                            {
                                UserId = projectCreatorId
                            },
                            SharedBy = new UserInfo
                            {
                                UserId = sharedById
                            },
                            SharedOn = accessDate
                        };
                        versionAccess.SharedAccess.Add(sharedAccess);
                        userIDs.Add(projectCreatorId);
                        userIDs.Add(sharedById);
                    }
                }
            }
            else if (sharedWithId > 0 && sharedById > 0)
            {
                SharedAccessInfo sharedAccess = new SharedAccessInfo
                {
                    AuthorizationLevel = authorization,
                    SharedWith = new UserInfo
                    {
                        UserId = sharedWithId
                    },
                    SharedBy = new UserInfo
                    {
                        UserId = sharedById
                    },
                    SharedOn = accessDate
                };
                versionAccess.SharedAccess.Add(sharedAccess);
                userIDs.Add(sharedWithId);
                userIDs.Add(sharedById);
            }

            return isLatest;
        }

        protected void IncludeAllVersionsAccess(Dictionary<string, UserForecastMapping> filteredForecastSet, Dictionary<string, List<SharedAccessInfo>> allVersionsShared, List<int> userIDs)
        {
            foreach (var kvp in filteredForecastSet)
            {
                var forecast = kvp.Key;
                if (allVersionsShared.ContainsKey(forecast))
                {
                    var lstSharedAccess = allVersionsShared[forecast];
                    foreach (var accessItem in lstSharedAccess)
                    {
                        SharedAccessInfo sharedAccess = new SharedAccessInfo
                        {
                            AuthorizationLevel = accessItem.AuthorizationLevel,
                            SharedWith = new UserInfo
                            {
                                UserId = accessItem.SharedWith.UserId
                            },
                            SharedBy = new UserInfo
                            {
                                UserId = accessItem.SharedBy.UserId
                            },
                            SharedOn = accessItem.SharedOn
                        };
                        var versions = kvp.Value.Versions;
                        foreach (var versionItem in versions)
                        {
                            var versionAccess = versionItem.Access;
                            HashSet<int> sharedWithSet = null;
                            if (versionAccess == null)
                            {
                                versionAccess = new Models.UserAccess
                                {
                                    SharedAccess = new List<SharedAccessInfo>()
                                };
                            }
                            else if(versionAccess.SharedAccess == null)
                            {
                                versionAccess.SharedAccess = new List<SharedAccessInfo>();
                            }
                            else
                                sharedWithSet = new HashSet<int>(versionAccess.SharedAccess.Select(sa => sa.SharedWith.UserId).Distinct());

                            //a major version should not be processed if it is a mock version (i.e. it does not exist, but is there just because of its minors)
                            //its minors should still be processed as they really exist!
                            if (!versionItem.IsMock)
                            {
                                if (sharedWithSet != null && !sharedWithSet.Contains(sharedAccess.SharedWith.UserId))
                                    if (!sharedWithSet.Contains(userId))
                                        if(sharedAccess != null && sharedAccess.AuthorizationLevel != 1)
                                           versionAccess.SharedAccess.Add(sharedAccess);
                            }

                            if (versionItem.PreDrafts != null)
                            {
                                foreach (var preDraft in versionItem.PreDrafts)
                                {
                                    var preDraftAccess = preDraft.Access;
                                    if (preDraftAccess == null)
                                    {
                                        preDraftAccess = new Models.UserAccess
                                        {
                                            SharedAccess = new List<SharedAccessInfo>()
                                        };
                                    }
                                    else
                                        sharedWithSet = new HashSet<int>(preDraftAccess.SharedAccess.Select(sa => sa.SharedWith.UserId).Distinct());

                                    if (sharedWithSet != null && !sharedWithSet.Contains(sharedAccess.SharedWith.UserId))
                                        if (!sharedWithSet.Contains(userId))
                                            if (sharedAccess != null && sharedAccess.AuthorizationLevel != 1)
                                                preDraftAccess.SharedAccess.Add(sharedAccess);
                                }
                            }
                        }
                    }

                    userIDs.AddRange(lstSharedAccess.Select(a => a.SharedWith.UserId));
                    userIDs.AddRange(lstSharedAccess.Select(a => a.SharedBy.UserId));
                }
            }
        }

        protected List<ForecastVersion> SortForecastVersions(List<ForecastVersion> versions, bool descending = true)
        {
            if (versions == null || versions.Count == 0)
                return null;
            if (descending)
                return versions.OrderByDescending(v => GenUtil.GetVersionDateTime(v, userId)).ToList();
            else
                return versions.OrderBy(v => GenUtil.GetVersionDateTime(v, userId)).ToList();
        }

        private bool UpdateUserInfoForManagerialAccess(ForecastVersion version, Dictionary<int, UserInfo> accessors)
        {
            var userManager = new UserManager(uow);
            if (version.Access.Creator != null && version.Access.Creator.UserId > 0)
            {
                userManager.PopulateUserInfoFromUserId(version.Access.Creator, accessors);
            }
            if (version.Access.SharedAccess != null && version.Access.SharedAccess.Count > 0)
            {
                foreach (var sharedAccess in version.Access.SharedAccess)
                {
                    if (sharedAccess == null)
                        continue;
                    if (sharedAccess.SharedWith.UserId != userId)
                        userManager.PopulateUserInfoFromUserId(sharedAccess.SharedWith, accessors);
                }
            }
            return true;
        }

        protected bool UpdateUserInforForVersionAccess(ForecastVersion version, Dictionary<int, UserInfo> accessors)
        {
            if (IsAllAccessible)
            {
                UpdateUserInfoForManagerialAccess(version, accessors);
                return true;
            }
            else
            {
                bool hasAccess = false;
                if (version == null || version.Access == null || accessors == null || accessors.Count == 0)
                    return false;
                var userManager = new UserManager(uow);
                if (version.Access.Creator != null && version.Access.Creator.UserId > 0)
                {
                    userManager.PopulateUserInfoFromUserId(version.Access.Creator, accessors);
                    if (version.Access.Creator.UserId == userId)
                        hasAccess = true;
                }
                if (version.Access.SharedAccess != null && version.Access.SharedAccess.Count > 0)
                {
                    foreach (var sharedAccess in version.Access.SharedAccess)
                    {
                        if (sharedAccess == null)
                            continue;
                        userManager.PopulateUserInfoFromUserId(sharedAccess.SharedWith, accessors);
                        userManager.PopulateUserInfoFromUserId(sharedAccess.SharedBy, accessors);
                        if (sharedAccess.SharedWith.UserId == userId)
                            hasAccess = true;
                    }
                }

                return hasAccess;
            }
        }

        protected HashSet<string> GetFlattenedUserForecasts(List<UserForecastMapping> userForecasts , bool isAuthorization)
        {
            HashSet<string> flattenedUserForecasts = new HashSet<string>();
            string flattenedUserForecast = null;
            foreach (var userForecast in userForecasts)
            {
                foreach (var version in userForecast.Versions)
                {
                    if (version == null)
                        continue;
                    if (version.Access != null && version.Access.Creator != null)
                    {
                        flattenedUserForecast = userForecast.Forecast + "|" + version.Label + "|" + version.Access.Creator.UserId + "|" + "1";
                        if (!flattenedUserForecasts.Contains(flattenedUserForecast))
                            flattenedUserForecasts.Add(flattenedUserForecast);
                    }
                    if (version.Access != null && version.Access.SharedAccess != null)
                    {
                        foreach (var access in version.Access.SharedAccess)
                        {
                            if (isAuthorization)
                            flattenedUserForecast = userForecast.Forecast + "|" + version.Label + "|" + access.SharedWith.UserId + "|" + access.AuthorizationLevel;
                            else
                            flattenedUserForecast = userForecast.Forecast + "|" + version.Label + "|" + access.SharedWith.UserId;

                            if (!flattenedUserForecasts.Contains(flattenedUserForecast))
                                flattenedUserForecasts.Add(flattenedUserForecast);
                        }
                    }
                }
            }

            return flattenedUserForecasts;
        }

        protected virtual List<ActionStatus> SetUserforecastMapping(TenantModel context ,List<UserForecastMapping> userForecasts, bool isSave) { return null; }

        public List<ActionStatus> SetUserforecastMapping(List<UserForecastMapping> userForecasts, bool isSave)
        {
            List<ActionStatus> statusMessages = new List<ActionStatus>();
            try
            {
                if (userForecasts != null)
                {
                    //exclude any case where loggedinuser shared with himself
                    var sharedWithOwn = userForecasts.Where(uf => uf.Versions
                                                                    .Any(v => v.Access != null && v.Access.SharedAccess != null && v.Access.SharedAccess
                                                                               .Any(sa => sa.AuthorizationLevel != 1 && sa.SharedBy == sa.SharedWith)))
                                                     .ToList();
                    if (sharedWithOwn != null)
                    {
                        foreach (var selfShared in sharedWithOwn)
                        {
                            userForecasts.Remove(selfShared);
                        }
                    }

                    if (userForecasts.Count > 0)
                    {
                        //if Version is NULL, Authorization cannot be 1 and vice versa
                        var sharingAllWhileSaving = userForecasts
                            .Any(uf => uf.Versions.Any(v => String.IsNullOrEmpty(v.Label) && v.Access.SharedAccess.Any(sa => sa.AuthorizationLevel == 1)));
                        if (sharingAllWhileSaving)
                            statusMessages.Add(new ActionStatus { Number = 2, Message = "Share all and save cannot go together" });
                        else
                        {
                                    //build users map
                            statusMessages = SetUserforecastMapping(uow.TenantContext, userForecasts, isSave);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                statusMessages.Add(new ActionStatus { Number = 0, Message = String.Format("Could not {0} version", isSave ? "save" : "share") });
            }

            return statusMessages;
        }

        public virtual List<string> GetDistinctProjectNames() { return null; }

        public bool GFRemoveProjectDetails(string project)
        {
            bool isDeleteProjectName = false;

                SqlParameter param = new SqlParameter();
            param = new SqlParameter("@ProjectName", SqlDbType.VarChar, 500);
                param.Direction = ParameterDirection.Input;
                param.Value = project;
            isDeleteProjectName = uow.TenantContext.Database.SqlQuery<bool>(String.Format("exec {0}.uspRemoveProjectDetails @ProjectName", Namespace), param).SingleOrDefault().SafeToBool();

            return isDeleteProjectName;
        }

        public virtual string GetLatestVersionByProjectName(string project) { return null; }
        public virtual string retriveForecast(string project, string version, ForecastModelType type, int isFlatFile, bool isTemplate) { return null; }
        public virtual List<ActionStatus> SetSectionPreferences(string forecast, string version, string sectionPref) { return null; }
        public virtual int SetForecastTemplate(string projectName, string StorageId,string saveAsForecastName,int loggedinUserId) { return 0; }
        public virtual string SaveForecast(string projectName, string StorageId, int MajorVersion, string Description, out int flatFileId) { flatFileId = 0; return ""; }
        public virtual int CheckTemplatePresent(string projectName) { return -1; }




        public virtual List<ForecastSection> GetSectionPreference(string forecast, string version) { return null; }

        protected List<ForecastSection> GetFilteredSections(Dictionary<int, ForecastSection> forecastSectionsMap, string strSectionSetting)
        {
            List<ForecastSection> forecastSections = new List<ForecastSection>();
            var strSectionIDs = strSectionSetting.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var strSectionId in strSectionIDs)
            {
                int sectionId = strSectionId.SafeToNum();
                if (sectionId > 0)
                    forecastSections.Add(forecastSectionsMap[sectionId]);
            }
            return forecastSections;
        }

        public virtual void SetAssumptions(List<Assumption> assumptions) { }

        public virtual List<Assumption> GetAssumptions(string project, string version) { return null; }
        
        protected void SendMailForShareForecast(string useremail, string Fname, string Lname, string UserFname, string UserLname, string projectName)
        {
            // StringBuilder class is present in System.Text namespace

            StringBuilder sbEmailBody = new StringBuilder();
            sbEmailBody.Append("Hello " + Fname + Lname + "," + "<br/><br/>");
            sbEmailBody.Append(UserFname + UserLname + " has shared the forecast " + "<b>" + projectName + "</b>" + " with You.You can access and make changes to this forecast from now on. ");
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>Regards,</b>");
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append("<b>"+ GenUtil.GetClientNameForSendingMail() +"</b>");
            GenUtil.SendEmail(projectName + " has been shared with you.", sbEmailBody.ToString(), useremail);

        }

        public string GetGuidsFormDataBaseOfSavedProjects(string guid)
        {
            string desc = null;
            try
            {
                desc = uow.TenantContext.UserNotifications
                        .Where(un => un.UserId == userId && !String.IsNullOrEmpty(guid) && String.Compare(guid, un.UserKey, true) == 0)
                        .Select(un => un.Descriptions)
                        .FirstOrDefault();
                }
            catch (Exception ex)
            {

            }

            return desc;
        }

        public List<ActionStatus> GFSetUserforecastMappingForUpload(List<int> users, string project, string version, List<int> sharedbyUsers, string description)
        {
            List<ActionStatus> statusMessages = new List<ActionStatus>();
            List<UserForecastMapping> userForecasts = new List<UserForecastMapping>();
            try
            {
                foreach (int userId in sharedbyUsers)
                {
                    var ufm = new UserForecastMapping
                    {
                        Forecast = project,
                        Versions = new List<ForecastVersion>()
                    };
                    userForecasts.Add(ufm);
                    var fv = new ForecastVersion
                    {
                        Label = version,
                        Comment = description,
                        Access = new Models.UserAccess
                        {
                            //CreatedOn = DateTime.Now,
                            CreatedOn =DateTime.UtcNow,
                            Creator = new UserInfo
                            {
                                UserId = userId
                            }
                        }
                    };
                    ufm.Versions.Add(fv);
                }
                statusMessages = SetUserforecastMapping(userForecasts, true);
            }
            catch (Exception ex)
            {

            }

            return statusMessages;
        }
    }

    public class BDLForecastManager : ForecastManager
    {
        protected override string Namespace
        {
            get
            {
                return "BDL";
            }
        }

        public BDLForecastManager(IUnitOfWork uow, int userId, UserRole userRole, byte accessType):base(uow, userId, userRole, accessType)
        {
        }

        protected override List<UserForecastMapping> GetUserForecastMapping()
        {
            var filteredForecastSet = new Dictionary<string, UserForecastMapping>();
            var allVersionsShared = new Dictionary<string, List<SharedAccessInfo>>();
            var forecastMappingList = new List<UserForecastMapping>();
          
            try
            {
                    var projectTemplates = new HashSet<string>(uow.TenantContext.BDLForecastTemplateMaster
                       .Where(ftm => ftm.UserId == userId)
                        .Select(ftm => ftm.ProjectName)
                        .Distinct().AsEnumerable());

                    var projectTemplatesWithTime = uow.TenantContext.BDLForecastTemplateMaster
                        .Select(ptw => new
                        {
                            projectName = ptw.ProjectName,
                            DateTime = ptw.DateTime,
                            Creator = ptw.UserId
                        }).Distinct();


                    //var allVersionAccessProjects =
                    //    tenantContext.BDLUserForecastMapping.Where(ufm => ufm.ShareWithId == userId && String.IsNullOrEmpty(ufm.Version))
                    //    .Select(ufm => ufm.ProjectName)
                    //    .Distinct();

                    var allVersionAccessProjects =
                       uow.TenantContext.BDLUserForecastMapping.Where(ufm => ufm.ShareWithId == userId && String.IsNullOrEmpty(ufm.Version))
                       .Select(ufm => ufm.ProjectName)
                       .Union(projectTemplatesWithTime.Where(ptw => ptw.Creator == userId).Select(ptw => ptw.projectName))
                       .Distinct();

                    var accessibleProjectVersions =
                        uow.TenantContext.BDLUserForecastMapping.Where(ufm => !allVersionAccessProjects.Contains(ufm.ProjectName) && ufm.ShareWithId == userId && !String.IsNullOrEmpty(ufm.Version))
                        .Select(ufm => ufm.ProjectName + "|" + ufm.Version)
                        .Distinct();

                    var forecastQueryable =
                    uow.TenantContext.BDLUserForecastMapping
                        //important: don't change the order of the following || OR clause, you know why
                        .Where(ufm => IsAllAccessible ||
                                      allVersionAccessProjects.Contains(ufm.ProjectName) ||
                                      accessibleProjectVersions.Contains(ufm.ProjectName + "|" + ufm.Version))
                        .GroupBy(ufm => new { ufm.ProjectName, ufm.Version, ufm.ShareWithId })
                        //.Select(g => g.OrderBy(v => v.Authorization).FirstOrDefault()) //minimum authorization value === maximum permission
                        .SelectMany(g => g.Select(ufm => new
                        {
                            Forecast = ufm.ProjectName,
                            Version = ufm.Version,
                            ShareWithID = ufm.ShareWithId,
                            ShareByID = ufm.ShareById,
                            Authorization = ufm.Authorization,
                            AccessDate = ufm.CreationDate,
                            Description = ufm.Description
                        }));

                    var forecastMappingsFromDB = forecastQueryable.OrderBy(f => f.Forecast).ThenBy(f => f.Version).ToList();
                    if (forecastMappingsFromDB != null && forecastMappingsFromDB.Count > 0)
                    {
                        UserForecastMapping accessibleForecast = null;
                        List<int> userIDs = new List<int>();
                        Dictionary<string, ForecastVersion> majorVersions = new Dictionary<string, ForecastVersion>();
                        Dictionary<string, List<ForecastVersion>> minorVersions = new Dictionary<string, List<ForecastVersion>>();
                        foreach (var forecastMappingFromDB in forecastMappingsFromDB)
                        {
                            string forecast = forecastMappingFromDB.Forecast;
                            int projectCreatorId = projectTemplatesWithTime.Where(ptw => String.Compare(ptw.projectName, forecast) == 0).Select(ptw => ptw.Creator).FirstOrDefault();
                            string label = forecastMappingFromDB.Version.SafeTrim();
                            int sharedWithId = forecastMappingFromDB.ShareWithID;
                            int sharedById = forecastMappingFromDB.ShareByID;
                            int authorization = forecastMappingFromDB.Authorization;
                            DateTime accessDate = forecastMappingFromDB.AccessDate;
                            string comment = forecastMappingFromDB.Description;

                            //for all versions shared
                            if (String.IsNullOrEmpty(label) || IsAllAccessible)
                            {
                                if (!allVersionsShared.ContainsKey(forecast))
                                    allVersionsShared.Add(forecast, new List<SharedAccessInfo>());
                                var allVersionsSharedWith = allVersionsShared[forecast].Where(a => a.SharedWith != null && a.SharedWith.UserId == sharedWithId).SingleOrDefault();
                                if (allVersionsSharedWith == null)
                                {
                                    allVersionsSharedWith = new SharedAccessInfo
                                    {
                                        SharedWith = new UserInfo
                                        {
                                            UserId = sharedWithId
                                        },
                                        SharedBy = new UserInfo
                                        {
                                            UserId = sharedById
                                        },
                                        AuthorizationLevel = authorization,
                                        SharedOn = accessDate
                                    };
                                    allVersionsShared[forecast].Add(allVersionsSharedWith);
                                }
                            }
                            //all versions shared end

                            if (String.IsNullOrEmpty(forecast) || String.IsNullOrEmpty(label) || sharedWithId < 1 || authorization < 1)
                                continue;

                            if (!filteredForecastSet.ContainsKey(forecast))
                            {
                                accessibleForecast = new UserForecastMapping
                                {
                                    Forecast = forecast,
                                    Versions = new List<ForecastVersion>(),
                                    LatestVersion = new ForecastVersion { Access = new Models.UserAccess() }
                                };
                                filteredForecastSet.Add(forecast, accessibleForecast);
                            }
                            else
                                accessibleForecast = filteredForecastSet[forecast];
                            ForecastVersion version = new ForecastVersion
                            {
                                Label = label,
                                Comment = comment,
                                Access = new Models.UserAccess { SharedAccess = new List<SharedAccessInfo>() }
                            };

                            //SetVersionAccess(version.Access, sharedWithId, sharedById, authorization, accessDate, userIDs);                    

                            int majorVersionNumber;
                            bool isMajor = GenUtil.IsMajor(label, out majorVersionNumber);
                            string majorVersionKey = forecast + "V" + majorVersionNumber;
                            //should be no case where there is no creater or no sharer
                            //if (version.Access.Creator != null || version.Access.SharedAccess != null)
                            //{
                            if (isMajor)
                            {
                                if (!majorVersions.ContainsKey(majorVersionKey))
                                {
                                    majorVersions.Add(majorVersionKey, version);
                                    accessibleForecast.Versions.Add(version);
                                }
                                else
                                {
                                    version = majorVersions[majorVersionKey];
                                }

                            }
                            else
                            {
                                if (!minorVersions.ContainsKey(majorVersionKey))
                                    minorVersions.Add(majorVersionKey, new List<ForecastVersion>());
                                var minorVersion = minorVersions[majorVersionKey].Where(v => String.Compare(v.Label, label, true) == 0).SingleOrDefault();
                                if (minorVersion != null)
                                    version = minorVersion;
                                else
                                    minorVersions[majorVersionKey].Add(version); //will be processed after this loop
                            }
                            //}

                            if (SetVersionAccess(version.Access, sharedWithId, sharedById, authorization, accessDate, userIDs, accessibleForecast.LatestVersion, projectCreatorId))
                                accessibleForecast.LatestVersion = version;
                            //if(String.Compare(forecast, "Project_Ocean_V2") == 0)
                            //{
                            //    var s = "";
                            //    var a = "";
                            //    s = a;
                            //}
                        }

                        if (IsAllAccessible)
                        {
                            //include all versions access
                            IncludeAllVersionsAccess(filteredForecastSet, allVersionsShared, userIDs);
                        }

                        //keep user id vs user details ready
                        var accessors = new UserManager(uow).GetUserInfoByUserId(userIDs);
                        //relate minorVersions with majors

                        foreach (var kvp in minorVersions)
                        {
                            string postMajorKey = GenUtil.GetPostMajorKey(kvp.Key);
                            if (majorVersions.ContainsKey(postMajorKey))
                                majorVersions[postMajorKey].PreDrafts = kvp.Value;
                            else
                            {
                                var mockVersion = new ForecastVersion
                                {
                                    Label = GenUtil.GetVersionLabelFromVersionKey(postMajorKey),
                                    IsMock = true,
                                    PreDrafts = kvp.Value,
                                    Access = new Models.UserAccess
                                    {
                                        CreatedOn = kvp.Value[0].Access.CreatedOn
                                    }
                                };
                                majorVersions.Add(postMajorKey, mockVersion);
                                var forecastName = GenUtil.GetForecastNameFromVersionKey(postMajorKey);
                                filteredForecastSet[forecastName].Versions.Add(mockVersion);
                            }
                        }


                        if (!IsAllAccessible)
                        {
                            //include all versions access
                            IncludeAllVersionsAccess(filteredForecastSet, allVersionsShared, userIDs);
                        }

                        //finally sort the versions and put the user deatils in
                        foreach (var filteredForecast in filteredForecastSet)
                        {
                            filteredForecast.Value.Versions = SortForecastVersions(filteredForecast.Value.Versions);
                            for (int majorVersionIterator = 0; filteredForecast.Value != null && filteredForecast.Value.Versions != null && majorVersionIterator < filteredForecast.Value.Versions.Count; majorVersionIterator++)
                            {
                                var filteredVersion = filteredForecast.Value.Versions[majorVersionIterator];
                                bool hasMajorAccess = false, hasPreDraftAccess = false;
                                filteredVersion.PreDrafts = SortForecastVersions(filteredVersion.PreDrafts);
                                hasMajorAccess = UpdateUserInforForVersionAccess(filteredVersion, accessors);
                                bool isMock = false;
                                if (filteredVersion.PreDrafts != null)
                                {
                                    for (int preDraftIterator = 0; preDraftIterator < filteredVersion.PreDrafts.Count; preDraftIterator++)
                                    {
                                        var preDraft = filteredVersion.PreDrafts[preDraftIterator];
                                        hasPreDraftAccess = UpdateUserInforForVersionAccess(preDraft, accessors);
                                        if (!hasPreDraftAccess)
                                        {
                                            //filter
                                            filteredVersion.PreDrafts.RemoveAt(preDraftIterator);
                                            preDraftIterator--;
                                            continue;
                                        }
                                        else
                                            isMock = true;
                                    }
                                }

                                if (!hasMajorAccess)
                                {
                                    //filter
                                    if (!isMock)
                                    {
                                        filteredForecast.Value.Versions.RemoveAt(majorVersionIterator);
                                        majorVersionIterator--;
                                    }
                                    else
                                        filteredForecast.Value.Versions[majorVersionIterator].IsMock = true;
                                    continue;
                                }
                            }
                        }
                    }

                    Dictionary<string, UserForecastMapping> ProjectList = null;
                    if (filteredForecastSet != null && filteredForecastSet.Count > 0)
                    {
                        ProjectList = filteredForecastSet
                            .Where(ff => projectTemplates.Contains(ff.Key))
                            .ToDictionary(f => f.Key, f => f.Value);
                    }

                    var Templates = projectTemplates.Where(x => ProjectList == null || !ProjectList.ContainsKey(x)).Distinct();


                    UserForecastMapping forecastDetails = null;


                    foreach (var item in Templates)
                    {
                        string forecast = item;
                        DateTime dateTime = projectTemplatesWithTime.Where(pt => pt.projectName == forecast).Select(pt => pt.DateTime).FirstOrDefault();
                        forecastDetails = new UserForecastMapping
                        {
                            Forecast = forecast,
                            Versions = new List<ForecastVersion>(),
                            LatestVersion = new ForecastVersion { Access = new Models.UserAccess() }
                        };

                        var mockVersion = new ForecastVersion
                        {
                            Label = "V0.0",
                            IsMock = false,
                            PreDrafts = null,
                            Access = new Models.UserAccess
                            {
                                CreatedOn = dateTime
                            }
                        };
                        List<int> userIds = new List<int>();
                        var userId = projectTemplatesWithTime.Where(pt => pt.projectName == forecast).Select(pt => pt.Creator).FirstOrDefault();
                        userIds.Add(userId);
                        var accessors_template = new UserManager(uow).GetUserInfoByUserId(userIds);
                        var userManager = new UserManager(uow);
                        mockVersion.Access.Creator = new UserInfo
                        {
                            UserId = userId,
                        };
                        userManager.PopulateUserInfoFromUserId(mockVersion.Access.Creator, accessors_template);
                        filteredForecastSet.Add(forecast, forecastDetails);

                        filteredForecastSet[forecast].Versions.Add(mockVersion);
                        forecastDetails.LatestVersion = new ForecastVersion
                        {
                            Label = "V0.0",
                            IsMock = false,
                            PreDrafts = null,
                            Access = new Models.UserAccess
                            {
                                CreatedOn = dateTime
                            }
                        };

                    }
                    forecastMappingList = filteredForecastSet
                        // .Where(ff => projectTemplates.Contains(ff.Key))
                        .ToDictionary(f => f.Key, f => f.Value)
                        .Values.OrderByDescending(f => f.Versions != null && f.Versions.Count > 0 ?
                        f.Versions[0].Access.CreatedOn
                        : projectTemplatesWithTime.Where(ptw => String.Compare(ptw.projectName, f.Forecast) == 0).Select(ptw => ptw.DateTime).FirstOrDefault())
                        .ToList();
                }
            catch (Exception ex)
            {

            }


            return forecastMappingList;
        }

        public override int UnshareForecast(List<UserForecastMappingForUnshare> userForecastsForUnshare)
        {
            var res = 0;
            try
            {
                    foreach (var item in userForecastsForUnshare)
                    {
                        var projectName = item.projectName;
                        var version = item.Version;
                        var unShareUserId = item.UnShareUserID;
                        var loggedinUserId = item.loggedInUserId;
                        var ufmList = uow.TenantContext.BDLUserForecastMapping
                        .Where(ufm =>  String.Compare(projectName, ufm.ProjectName) == 0
                                                 && (ufm.Version==null || (String.Compare(version, ufm.Version) == 0))
                                                 && unShareUserId == ufm.ShareWithId
                                                 && loggedinUserId == ufm.ShareById).ToList();

                    uow.TenantContext.BDLUserForecastMapping.RemoveRange(ufmList);
                        if (ufmList.Count == 0)
                            res = 2; //user did not have access to this forecast version

                    if (ufmList.Count != 0)
                    {
                        if (uow.TenantContext.SaveChanges() == ufmList.Count)
                            res = 1;
                    }
                }
            }
            catch (Exception ex)
            {
                res = 0;
            }

            return res;
        }
        public SendMailInfo DefineSendMailObj(string receiverEmail, string currentAuth, string prevAuth, bool FlagForUpdation)
        {
            SendMailInfo sendMailInfoObj = new SendMailInfo();
            sendMailInfoObj.ReceiverEmail = receiverEmail;
            sendMailInfoObj.CurrentAuth = currentAuth;
            sendMailInfoObj.PrevAuth = prevAuth;
            sendMailInfoObj.FlagForUpdation = FlagForUpdation;
            return sendMailInfoObj;
        }
        public SendMailUserInfo CheckEachEmailAndSendMail(string loggedinUser, string forecast, string version, string moduleType, List<SendMailInfo> sendMailInfoObj)
        {
            SendMailUserInfo userinfo = new SendMailUserInfo();
            CommonSendInfo csi = new CommonSendInfo();
            csi.IsShare = true; //true=Share and false=unshare
            csi.SenderName = loggedinUser;
            csi.ProjectName = forecast;
            csi.ForecastVersion = version;
            csi.ClientName = GenUtil.GetClientNameForSendingMail();
            csi.ModuleType = moduleType;
            //foreach (var item in sendMailInfoObj)
            //{
            //    if (item.FlagForSendMail)
            //    {
            //        string str = "";
            //        int rs = GenUtil.CreateMailandSend(item, csi);
            //        if (rs == 1)
            //            str = "succesfully sent";
            //        else
            //            str = "successfully not sent";
            //    }
            //}


            userinfo.SendMailInfoValue = sendMailInfoObj;
            userinfo.CommonSendInfoValue = csi;
            return userinfo;
        }


        protected override List<ActionStatus> SetUserforecastMapping(TenantModel context , List<UserForecastMapping> userForecasts, bool isSave)
        {
            List<ActionStatus> statusMessages = new List<ActionStatus>();
             List<int> sharedWithIdsForNotifications = new List<int>();
            List<SendMailInfo> sendMailInfoObj = new List<SendMailInfo>();
            SendMailUserInfo userInfor = new SendMailUserInfo();
            // ForecastPermission forecastPermission = new ForecastPermission();
            // List<string> sharedWithIdsForNotifications = new List<string>();
            HashSet<string> flattenedUserForecasts = GetFlattenedUserForecasts(userForecasts,isSave);
            //HashSet<string> flattenedUserForecasts = GetFlattenedUserForecasts(userForecasts, true);
            // var criterion = userForecastsForUnshare.Select(unsh => String.Format("{0}|{1}|{2}", unsh.projectName, unsh.Version ?? String.Empty, unsh.UnShareUserID));
            //List<int> sharedWithIdsForNotifications = new List<int>();
            //ProjectName, Version, SharedWithId, Authorization combination should be unique            
            var alreadyExistingItems = context.BDLUserForecastMapping
                                                      .Where(ufm => flattenedUserForecasts.Contains(ufm.ProjectName + "|" + ufm.Version + "|" + ufm.ShareWithId + "|" + ufm.Authorization))
                                                      .ToList();
            /*var alreadyExistingItemsForShare1 = context.BDLUserForecastMapping
                                                      .Select(ufm => ufm.ProjectName + "|" + ufm.Version ?? "" + "|" + ufm.ShareWithId).ToString()
                                                      .ToList();*/
            var alreadyExistingItemsForShare= context.BDLUserForecastMapping
                                                      .Where(ufm => flattenedUserForecasts.Contains(ufm.ProjectName + "|" + ufm.Version + "|" + ufm.ShareWithId ))
                                                      .ToList();
            
                try
                {
                    foreach (var userForecast in userForecasts)
                    {
                    SendMailInfo sendMailInfoObj1 = new SendMailInfo();
                    foreach (var forecastVersion in userForecast.Versions)
                        {
                            List<int> sharedWiths = new List<int>();
                            List<int> sharedBys = new List<int>();
                            List<int> authorizations = new List<int>();
                            if (isSave && forecastVersion.Access != null && forecastVersion.Access.Creator != null)
                            {
                                sharedWiths.Add(forecastVersion.Access.Creator.UserId);
                                sharedBys.Add(forecastVersion.Access.Creator.UserId);
                                authorizations.Add(1); //creator = 1
                            }
                            else if (forecastVersion.Access != null && forecastVersion.Access.SharedAccess != null)
                            {
                                foreach (var item in forecastVersion.Access.SharedAccess)
                                {
                                    sharedWiths.Add(item.SharedWith.UserId);
                                    sharedBys.Add(item.SharedBy.UserId);
                                    authorizations.Add(item.AuthorizationLevel);
                                   // sharedWithIdsForNotifications.Add(item.SharedWith.UserId);
                                }
                            }
                            for (int i = 0; i < sharedWiths.Count; i++)
                            {
                                int sharedWith = sharedWiths[i];
                                int sharedBy = sharedBys[i];
                                int authLevel = authorizations[i];

                                var existingItem = alreadyExistingItems.FirstOrDefault(item => String.Compare(item.ProjectName, userForecast.Forecast) == 0
                                                              && String.Compare(item.Version, forecastVersion.Label) == 0
                                                              && item.ShareWithId == sharedWith
                                                              && item.Authorization == authLevel);
                                if (existingItem != null)
                                {
                                    statusMessages.Add(new ActionStatus
                                    {
                                        Number = 3,
                                        Message = isSave ? String.Format("{0} {1} had been already created by you", userForecast.Forecast, forecastVersion.Label)
                                                         : "Can't share forecast with its creator"
                                    });
                                }
                                else
                                {
                                    if (forecastVersion.Access != null && forecastVersion.Access.Creator != null)
                                    {
                                        var newItem = new BDLUserForecastMapping
                                        {
                                            Authorization = 1,
                                            //CreationDate = DateTime.Now,
                                            CreationDate =DateTime.UtcNow,
                                            Description = forecastVersion.Comment,
                                            ProjectName = userForecast.Forecast,
                                            ShareById = sharedBy,
                                            ShareWithId = sharedWith,
                                            Version = forecastVersion.Label,
                                            FlatFileId = userForecast.FlatFileId
                                        };
                                        context.BDLUserForecastMapping.Add(newItem);
                                        //statusMessages.Add(new ActionStatus { Number = 1, Message = "Saved successfully" });
                                    }
                                #region ShareLogic
                                else if (forecastVersion.Access != null && forecastVersion.Access.SharedAccess != null)
                                    {
                                        foreach (var sa in forecastVersion.Access.SharedAccess)
                                        {
                                            existingItem = alreadyExistingItemsForShare.FirstOrDefault(item => String.Compare(item.ProjectName, userForecast.Forecast) == 0
                                                                      && String.Compare(item.Version, forecastVersion.Label) == 0
                                                                      && item.ShareWithId == sharedWith);
                                            if (existingItem != null)
                                            {
                                                if (existingItem.Authorization < sa.AuthorizationLevel)
                                                {
                                                    statusMessages.Add(new ActionStatus { UserID=sa.SharedWith.UserId, Number = 4, Message = "User already has higher permission" });                                                
                                                }
                                                else
                                                {
                                                    if (existingItem.Authorization != sa.AuthorizationLevel)
                                                    {
                                                    sendMailInfoObj1 = DefineSendMailObj(userForecast.UserEmail, ((ForecastPermission)sa.AuthorizationLevel).ToString(), ((ForecastPermission)existingItem.Authorization).ToString(), true);
                                                    sendMailInfoObj.Add(sendMailInfoObj1);

                                                        existingItem.Authorization = sa.AuthorizationLevel;
                                                        statusMessages.Add(new ActionStatus { UserID = sa.SharedWith.UserId, Number = 3, Message = "Updated successfully..." });
                                                        sharedWithIdsForNotifications.Add(sa.SharedWith.UserId);
                                                    }
                                                    else
                                                    {
                                                        statusMessages.Add(new ActionStatus { UserID = sa.SharedWith.UserId, Number = 2, Message = "Already shared successfully..." });                                                    
                                                    }
                                                }
                                                if (String.Compare(existingItem.Description, forecastVersion.Comment) != 0)
                                                    existingItem.Description = forecastVersion.Comment;
                                            }
                                            else
                                            {
                                                var newItem = new BDLUserForecastMapping
                                                {
                                                    Authorization = sa.AuthorizationLevel,
                                                    //CreationDate = DateTime.Now,
                                                    CreationDate =DateTime.UtcNow,
                                                    Description = forecastVersion.Comment,
                                                    ProjectName = userForecast.Forecast,
                                                    ShareById = sa.SharedBy.UserId,
                                                    ShareWithId = sa.SharedWith.UserId,
                                                    Version = forecastVersion.Label
                                                };
                                                context.BDLUserForecastMapping.Add(newItem);
                                                statusMessages.Add(new ActionStatus { UserID = sa.SharedWith.UserId, Number = 1, Message = "Shared successfully" });
                                                sharedWithIdsForNotifications.Add(sa.SharedWith.UserId);

                                            sendMailInfoObj1 = DefineSendMailObj(userForecast.UserEmail, ((ForecastPermission)sa.AuthorizationLevel).ToString(), null, false);
                                            sendMailInfoObj.Add(sendMailInfoObj1);
                                        }
                                       }
                                    }
#endregion                             
                            }
                           }
                        }

                    }

                context.SaveChanges();
                if (!isSave)
                {
                    if (sendMailInfoObj.Count > 0)
                    {
                        userInfor = CheckEachEmailAndSendMail(userForecasts[0].LoggedInUserName, userForecasts[0].Forecast, userForecasts[0].Versions[0].Label, "Forecast", sendMailInfoObj);
                        statusMessages[0].UserMailInfo = userInfor;
                    }
                }

                List<int> userIDS = new List<int>();
                    userIDS.Add(userId);
                    UserInfo userInfo = new UserInfo();
                    var accessors = new UserManager(uow).GetUserInfoByUserId(userIDS);
                    userInfo = accessors[userId];
                    var forecastName = userForecasts[0].Forecast;
                    if (sharedWithIdsForNotifications.Count >= 1)
                    {
                        for (int j = 0; j < sharedWithIdsForNotifications.Count; j++)
                        {
                            var ShareWithID = sharedWithIdsForNotifications[j];
                            TenantUserNotifications notification = new TenantUserNotifications
                            {
                                UserId = ShareWithID,
                                Descriptions = String.Format("{0} has Shared forecast " + forecastName + " with you", userInfo.FirstName + " " + userInfo.LastName),
                                UserKey = Guid.NewGuid().ToString(),
                                // CreatedDate = DateTime.Now,
                                CreatedDate =DateTime.UtcNow,
                                IsRead = false

                            };
                            context.UserNotifications.Add(notification);
                        }
                    }
                    context.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

            return statusMessages;
        }

        public override List<string> GetDistinctProjectNames()
        {
            List<string> projectnames = new List<string>();

            try
            {
                projectnames = uow.TenantContext.BDLUserForecastMapping
                                        .Select(ufm => ufm.ProjectName)
                                        .Distinct()
                                        .ToList();
                }
            catch (Exception ex)
            {

            }

            return projectnames;
        }

        public override string GetLatestVersionByProjectName(string project)
        {
            string msg = string.Empty;
            string res = "";
            try
            {
                            res = uow.TenantContext.BDLUserForecastMapping
                                .Where(ufm => String.Compare(ufm.ProjectName, project) == 0)
                                .OrderByDescending(ufm => ufm.CreationDate)
                                .Select(ufm => ufm.Version)
                                .FirstOrDefault();                    
                
                if (String.IsNullOrEmpty(res))
                    throw new Exception("No version exists for the requested project");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return res;
        }

        public override List<ForecastSection> GetSectionPreference(string forecast, string version)
        {
            try
            {
                    // get all versions as default versions from sectionMaster
                    var defaultSectionsQueryable = uow.TenantContext.BDLSectionDetails.Include(sd => sd.SectionMaster)
                                                 .Select(sd => new
                                                 {
                                                     Id = sd.SectionMaster.Id,
                                                     End = sd.EndRow,
                                                     HasAssumption = sd.SectionMaster.HasAssumptions ?? false,
                                                     Name = sd.SectionMaster.SectionName,
                                                     Scope = sd.Scope,
                                                     Start = sd.StartRow,
                                                     Parent = sd.SectionMaster.Parent
                                                 })
                                                 .Future();
                    string sectionSettings = null;
                    //if forecast/version is empty that means we are asked for default section setting
                    if (!String.IsNullOrEmpty(forecast) && !String.IsNullOrEmpty(version))
                    {
                        //sort all versions of the project from latest to oldest by their creation date time
                        var forecastVersionsQueryable = uow.TenantContext.BDLUserForecastMapping
                            .Where(ufm => String.Compare(ufm.ProjectName, forecast, true) == 0 
                                && ufm.Authorization == 1)
                            .Select(ufm => new UserSectionSetting
                            {
                                Version = ufm.Version,
                                When = ufm.CreationDate
                            })
                            .OrderByDescending(u => u.When)
                            .Future();
                        // get those versions which have section setting for this particular user
                        var sectionSettingsByVersionsQueryable = uow.TenantContext.BDLUserForecastSectionMapping
                            .Where(ufsm => ufsm.UserId == userId && 
                                String.Compare(ufsm.UserForecastMapping.ProjectName, forecast, true) == 0)
                        .Select(ufsm => new
                        {
                                Version = ufsm.UserForecastMapping.Version,
                                sectionSetting = ufsm.SectionIdCombination
                        })
                        .Future();
                        var forecastVersions = forecastVersionsQueryable.ToList();
                        var removeTill = -1;
                        for (int i = 0; i < forecastVersions.Count; i++)
                        {
                            if (String.Compare(forecastVersions[i].Version, version) == 0)
                            {
                                removeTill = i - 1;
                                break;
                            }
                        }
                        if(removeTill >= 0)
                            forecastVersions.RemoveRange(0, removeTill + 1);

                        var sectionSettingsByVersions = sectionSettingsByVersionsQueryable.ToList();
                        if (sectionSettingsByVersions != null && sectionSettingsByVersions.Count > 0)
                        {
                            var sectionSettingsByVersionsSet = sectionSettingsByVersions.ToDictionary(usv => usv.Version, usv => usv.sectionSetting);
                            foreach (var item in forecastVersions)
                            {
                                if (sectionSettingsByVersionsSet.ContainsKey(item.Version))
                                {
                                    sectionSettings = sectionSettingsByVersionsSet[item.Version];
                                    if (!String.IsNullOrEmpty(sectionSettings))
                                        break;
                                }
                            }
                        }
                    }
                    var defaultAnonymousSections = defaultSectionsQueryable.ToList();
                    var defaultSections = new List<ForecastSection>();
                    //build subsections based on parent info
                    Dictionary<int, ForecastSection> sectionMap = new Dictionary<int, ForecastSection>();
                    Dictionary<int, int?> parentMap = new Dictionary<int, int?>();
                    foreach (var section in defaultAnonymousSections)
                    {
                        //if (section.parent == null)
                        //{ 
                        sectionMap.Add(section.Id, new ForecastSection
                        {
                            Id = section.Id,
                            End = section.End,
                            HasAssumption = section.HasAssumption,
                            Name = section.Name,
                            Scope = (ForecastParameterScope)section.Scope,
                            Start = section.Start,
                            Parent = section.Parent,
                            SubSections = new List<ForecastSection>()
                        });
                           // }
                        parentMap.Add(section.Id, section.Parent);
                    }
                    foreach (var item in parentMap)
                    {
                        if (item.Value.HasValue)
                        {
                            sectionMap[item.Value.Value].SubSections.Add(sectionMap[item.Key]);
                            sectionMap.Remove(item.Key);
                        }
                    }

                    if (!String.IsNullOrEmpty(forecast) && !String.IsNullOrEmpty(version))
                    {
                        //if user has not set any section preference for any of the versions of the project till now
                        if (String.IsNullOrEmpty(sectionSettings))
                            return sectionMap.Values.ToList();
                        else
                            return GetFilteredSections(sectionMap, sectionSettings); //user has some section preference set for the current version or a version before it
                    }
                    return sectionMap.Values.ToList();
                }
            catch (Exception ex)
            {

            }

            return null;
        }

        public override string retriveForecast(string projectName, string version, ForecastModelType type, int isFlatFile, bool isTemplate)
        {
            var storageId = "";
            string ProjectName_Template = projectName + "_Template";
            try
            {
                    if (isTemplate)
                    {
                        storageId = uow.TenantContext.BDLForecastTemplateMaster
                                              .Where(ftm => String.Compare(ftm.ProjectName, projectName, true) == 0)
                                              .Select(ftm => ftm.TemplateStorageID)
                                              .FirstOrDefault();
                    }
                    else
                    {
                        var versionwithoutV = version.Substring(1);
                        var spiltVersion = versionwithoutV.Split('.');
                        int newVersion = 0;
                        var MajorVersionPos = Convert.ToInt32(spiltVersion[0]);
                        if (spiltVersion[1] == "0")
                        {
                            var projectVersionNullCount = uow.TenantContext.BDLForecastFlatFileMaster
                                                .Where(ftm => String.Compare(ftm.BDLForecastTemplateMaster.ProjectName, projectName, true) == 0 && ftm.MajorVersion == null)
                                                .ToList();
                           
                            var item2 = projectVersionNullCount.ElementAt(Convert.ToInt32(MajorVersionPos - 1));
                            storageId = item2.StorageID;
                        }
                        else
                        {
                            newVersion = Convert.ToInt32(spiltVersion[0]) + 1;
                            var minorVersionPos = Convert.ToInt32(spiltVersion[1]);
                            var projectVersion = uow.TenantContext.BDLForecastFlatFileMaster
                                                    .Where(ftm => String.Compare(ftm.BDLForecastTemplateMaster.ProjectName, projectName, true) == 0 && ftm.MajorVersion == newVersion)
                                                    .ToList();
                            var item1 = projectVersion.ElementAt(Convert.ToInt32(minorVersionPos - 1));
                            storageId = item1.StorageID;
                        }
                        
                    }
            }
            catch (Exception ex)
            {

            }
            return storageId;
        }
        public override int SetForecastTemplate(string projectName, string StorageId,string saveAsForecastName, int loggedinUserId)
        {
            int returnValue = -1;
            try
            {
                //if ((!String.IsNullOrEmpty(projectName)) && (!String.IsNullOrEmpty(StorageId)))
                if ((!String.IsNullOrEmpty(projectName)))
                {
                    BDLForecastTemplateMaster Ftemplate = null;
                    
                        var existingTemplates = uow.TenantContext.BDLForecastTemplateMaster
                            .Where(ftm => String.Compare(ftm.ProjectName, projectName, true) == 0
                             ).ToList();

                        if(existingTemplates.Count >= 1)                  // for save as get the stream id of existing forecast and then insert template
                        {
                            if (String.Compare(projectName, saveAsForecastName) != 0) 
                            {
                                var templateStorageId = uow.TenantContext.BDLForecastTemplateMaster
                                                          .Where(f => String.Compare(f.ProjectName, projectName) == 0)
                                                          .Select(f => f.TemplateStorageID)
                                                          .FirstOrDefault();

                                Ftemplate = new BDLForecastTemplateMaster()
                                {
                                    ProjectName = saveAsForecastName,
                                    TemplateStorageID = templateStorageId,
                                    //DateTime = DateTime.Now,
                                    DateTime =DateTime.UtcNow,
                                    UserId = loggedinUserId

                                };
                            uow.TenantContext.BDLForecastTemplateMaster.Add(Ftemplate);
                            }
                            else
                                returnValue = 9; //project name already exists
                        }
                        else if (existingTemplates.Count == 0)
                        {
                            if ((!String.IsNullOrEmpty(StorageId)))                    // create fresh forecast
                            {

                                Ftemplate = new BDLForecastTemplateMaster()
                                {
                                    ProjectName = projectName,
                                    TemplateStorageID = StorageId,
                                    //DateTime = DateTime.Now,
                                    DateTime =DateTime.UtcNow,
                                    UserId = loggedinUserId

                                };
                            uow.TenantContext.BDLForecastTemplateMaster.Add(Ftemplate);
                            }
                        }
                        if (returnValue == -1)
                        {
                        uow.TenantContext.SaveChanges();
                        returnValue = 1;
                        }
                    
                }
            }
            catch (Exception ex)
            {
                returnValue = 0;
            }
            return returnValue;
        }

        public override int CheckTemplatePresent(string projectName)
        {
            int output = -1;
            try
            {
                if ((!String.IsNullOrEmpty(projectName)))
                {
                        var existingTemplates = uow.TenantContext.BDLForecastTemplateMaster
                            .Where(ftm => String.Compare(ftm.ProjectName, projectName, true) == 0
                             ).ToList();
                        if (existingTemplates.Count >= 1)
                            output = 1;
                        else
                            output = 0;
                    }
                }
            catch(Exception ex)
            {
                output = -1;
            }
            return output;
        }

        public override string SaveForecast(string projectName, string StorageId, int MajorVersion, string Description, out int flatFileId)
        {
            string latestVersion = string.Empty;
            flatFileId = 0;
            //string ProjectName_Template = projectName + "_Template";
            try
            {
                int MajorVersionindb = 0;
                if ((!String.IsNullOrEmpty(projectName)) && (!String.IsNullOrEmpty(StorageId)))
                {
                    BDLForecastFlatFileMaster Fflatfile = null;
                        var existingTemplates = uow.TenantContext.BDLForecastTemplateMaster
                            .Where(ftm => String.Compare(ftm.ProjectName, projectName, true) == 0
                             ).ToList();

                        if (existingTemplates.Count >=1 )
                        {
                            var templateId = uow.TenantContext.BDLForecastTemplateMaster
                                                      .Where(f => String.Compare(f.ProjectName, projectName) == 0)
                                                      .Select(f => f.ID)
                                                      .FirstOrDefault();                                   // get the template id of project
                            var Nullcount = uow.TenantContext.BDLForecastFlatFileMaster
                                            .Where(f => String.Compare(f.BDLForecastTemplateMaster.ProjectName, projectName) == 0 && f.MajorVersion == null)         // get the count of null i.e major versions
                                            .ToList()
                                            .Count();

                            var minorVersion = Nullcount + 1;                          // minor version means next major of that minor
                            var minorVersionCount = uow.TenantContext.BDLForecastFlatFileMaster
                                            .Where(f => String.Compare(f.BDLForecastTemplateMaster.ProjectName, projectName) == 0 && f.MajorVersion == minorVersion)
                                            .ToList()
                                            .Count();                                   // get the minor version count
                                            

                            //var maxID = context.BDLForecastFlatFileMaster
                            //              .Where(f => String.Compare(f.BDLForecastTemplateMaster.ProjectName, ProjectName_Template) == 0)
                            //              .OrderByDescending(f => f.ID)
                            //              .Select(f => f.MajorVersion != null)
                            //              .Count();

                            if (MajorVersion == 1)                              // insert major version into db
                            {
                                Fflatfile = new BDLForecastFlatFileMaster()
                                {
                                    StorageID = StorageId,
                                    //DateTime = DateTime.Now,
                                    DateTime =DateTime.UtcNow,
                                    MajorVersion = null,
                                    TemplateID = templateId

                                };
                                latestVersion = "V" + (Nullcount + 1) + ".0";
                            }
                            else if (MajorVersion == 0)
                            {
                                var newMinorVersion = 0 ;
                                MajorVersionindb = Nullcount + 1;                     // check if major version is present or not || if not then insert minor version
                                if(minorVersionCount >= 1)
                                {
                                    newMinorVersion = minorVersionCount + 1;
                                }
                                else
                                {
                                    newMinorVersion = 1;
                                }

                                Fflatfile = new BDLForecastFlatFileMaster()
                                {
                                    StorageID = StorageId,
                                    //DateTime = DateTime.Now,
                                    DateTime =DateTime.UtcNow,
                                    MajorVersion = MajorVersionindb,
                                    TemplateID = templateId

                                };
                               
                                    latestVersion = ("V" + (Nullcount) + "." + (newMinorVersion));
                            }
                        uow.TenantContext.BDLForecastFlatFileMaster.Add(Fflatfile);
                            //flatFileId = context.BDLForecastFlatFileMaster
                            //            .Where(ffm => ffm.StorageID == StorageId)
                            //            .Select(ffm => ffm.ID)

                        }
                    uow.TenantContext.SaveChanges();
                        flatFileId = Fflatfile.ID;
                }
            }
            catch (Exception ex)
            {

            }

            return latestVersion;
        }

        public override List<ActionStatus> SetSectionPreferences(string forecast, string version, string sectionPref)
        {
            List<ActionStatus> status = new List<ActionStatus>();
            try
            {
                sectionPref = sectionPref.SafeTrim();
                if (!String.IsNullOrEmpty(sectionPref))
                {
                        var existingUFSMs = uow.TenantContext.BDLUserForecastMapping
                            .Where(ufm => String.Compare(ufm.ProjectName, forecast, true) == 0
                                && String.Compare(ufm.Version, version) == 0)
                            .Select(ufm => new
                        {
                                UserForecastMappingId = ufm.Id,
                                UserForecastSectionMapping = ufm.BDLUserForecastSectionMapping.Where(ufsm => ufsm.UserId == userId).FirstOrDefault()
                            })
                            .ToList();

                        var existingUFSM = existingUFSMs.Where(ufsma => ufsma.UserForecastSectionMapping != null).FirstOrDefault();    

                            //context.BDLUserForecastSectionMapping
                            //.Where(ufsm => ufsm.UserId == userId && String.Compare(ufsm.UserForecastMapping.ProjectName, forecast, true) == 0 && String.Compare(ufsm.UserForecastMapping.Version, version) == 0)
                            //.Select(ufsm => new
                            //{
                            //    UserForecastMappingId = ufsm.UserForecastMappingID,
                            //    UserForecastSectionMapping = ufsm
                            //})
                            //.FirstOrDefault();

                        if (existingUFSM == null)
                            {
                        uow.TenantContext.BDLUserForecastSectionMapping.Add(new BDLUserForecastSectionMapping
                                {
                                UserForecastMappingID = existingUFSMs[0].UserForecastMappingId,
                                UserId = userId,
                                    SectionIdCombination = sectionPref
                                });
                        uow.TenantContext.SaveChanges();
                            }
                        else if (String.Compare(existingUFSM.UserForecastSectionMapping.SectionIdCombination, sectionPref, true) != 0)
                            {
                                existingUFSM.UserForecastSectionMapping.SectionIdCombination = sectionPref;
                        uow.TenantContext.SaveChanges();
                    }
                }
                //status.Add(new ActionStatus { Number = 1, Message = "Section preferences set successfully" });//
            }
            catch (Exception ex)
            {                
                status.Add(new ActionStatus { Number = 11, Message = "Failed setting up section preferences" });
            }

            return status;
        }

        public override void SetAssumptions(List<Assumption> assumptions)
        {
            try
            {
                    if (assumptions == null)
                        return;
                    assumptions = assumptions.Where(a => a != null && (!String.IsNullOrEmpty(a.Description) || (a.Attachments != null && a.Attachments.Count > 0))).ToList();
                    HashSet<string> assumptionSet = new HashSet<string>();
                    HashSet<string> attachmentSet = new HashSet<string>();
                    foreach (var assumption in assumptions)
                    {
                        string flattenedAssumption = String.Format("{0}|{1}|{2}|{3}|{4}", assumption.Project, assumption.Version, assumption.Scenario, assumption.Product, assumption.Section);
                        if (!assumptionSet.Contains(flattenedAssumption))
                            assumptionSet.Add(flattenedAssumption);
                        if (assumption.Attachments != null)
                        {
                            foreach (var attachment in assumption.Attachments)
                            {
                                string flattenedAttachment = String.Format("{0}|{1}", attachment.AttachmentName, attachment.AttachmentPath);
                                if (!attachmentSet.Contains(flattenedAttachment))
                                    attachmentSet.Add(flattenedAttachment);
                            }
                        }
                    }
                    var existingAssumptionsQueryable = uow.TenantContext.BDLAssumptions
                        .Include(ga => ga.AssumptionAttachmentMapping)
                        .Include(ga => ga.AssumptionAttachmentMapping.Select(aam => aam.AttachamentMaster))
                        .Where(ga => assumptionSet.Contains(ga.PROJECT + "|" + ga.VERSION + "|" + ga.SCENARIO + "|" + ga.COUNTRY + "|" + ga.SECTION))
                        .Future();
                    var existingAttachmentsQueryable = uow.TenantContext.AttachamentMaster
                        .Where(am => attachmentSet.Contains(am.Name + "|" + am.Path))
                        .Future();

                    var existingAssumptions = existingAssumptionsQueryable.ToList();
                    var existingAttachments = existingAttachmentsQueryable.ToList();
                    if (existingAssumptions != null && existingAssumptions.Count() > 0)
                    {
                        //update existing assumptions, if needed
                        foreach (var item in existingAssumptions)
                        {
                            var MatchedAssumption = assumptions.FirstOrDefault(a => String.Compare(a.Project, item.PROJECT, true) == 0
                                                         && String.Compare(a.Version, item.VERSION, true) == 0
                                                         && a.Scenario == item.SCENARIO
                                                         && a.Product == item.COUNTRY
                                                         && a.Section == item.SECTION);
                            if (MatchedAssumption != null)
                            {
                                if (String.Compare(MatchedAssumption.Description, item.DESCRIPTION) != 0)
                                    item.DESCRIPTION = MatchedAssumption.Description;
                                var existingAttachmentsToBeRemoved = item.AssumptionAttachmentMapping
                                    .SelectMany(aam => MatchedAssumption.Attachments
                                                                         .Where(a => String.Compare(a.AttachmentPath, aam.AttachamentMaster.Path) == 0));
                                foreach (var att in existingAttachmentsToBeRemoved)
                                {
                                    MatchedAssumption.Attachments.Remove(att);
                                }
                                foreach (var att in MatchedAssumption.Attachments)
                                {
                                    AttachamentMaster newAttachment = new AttachamentMaster
                                    {
                                        Name = att.AttachmentName,
                                        Path = att.AttachmentPath
                                    };
                                    BDLAssumptionAttachmentMapping newMapping = new BDLAssumptionAttachmentMapping
                                    {
                                        Assumptions = item,
                                        AttachamentMaster = newAttachment
                                    };

                                uow.TenantContext.BDLAssumptionAttachmentMapping.Add(newMapping);
                                }

                                assumptions.Remove(MatchedAssumption);
                            }
                        }
                    }

                    //insert the rest
                    BDLAssumptions newOrExistingAssumption = null;
                    foreach (var assumption in assumptions)
                    {
                        newOrExistingAssumption = new BDLAssumptions
                        {
                            PROJECT = assumption.Project,
                            VERSION = assumption.Version,
                            SCENARIO = assumption.Scenario,
                            COUNTRY = assumption.Product,
                            SECTION = assumption.Section,
                            DESCRIPTION = assumption.Description
                        };
                        if (assumption.Attachments != null && assumption.Attachments.Count > 0)
                        {
                            foreach (var att in assumption.Attachments)
                            {
                                AttachamentMaster newOrExistingAttachment = existingAttachments
                                    .Where(ea => String.Compare(ea.Name, att.AttachmentName) == 0
                                              && String.Compare(ea.Path, att.AttachmentPath) == 0)
                                    .FirstOrDefault();

                                if (newOrExistingAttachment == null)
                                {
                                    newOrExistingAttachment = new AttachamentMaster
                                    {
                                        Name = att.AttachmentName,
                                        Path = att.AttachmentPath
                                    };
                                }
                                BDLAssumptionAttachmentMapping newMapping = new BDLAssumptionAttachmentMapping
                                {
                                    Assumptions = newOrExistingAssumption,
                                    AttachamentMaster = newOrExistingAttachment
                                };

                            uow.TenantContext.BDLAssumptionAttachmentMapping.Add(newMapping);
                            }
                        }
                        else
                        uow.TenantContext.BDLAssumptions.Add(newOrExistingAssumption);
                    }

                uow.TenantContext.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new Exception("Could not save assumptions");
            }

        }

        public override List<Assumption> GetAssumptions(string project, string version)
        {
            List<Assumption> assumptions = new List<Assumption>();

            try
            {
                    return uow.TenantContext.BDLAssumptions
                                .Where(ga => String.Compare(ga.PROJECT, project) == 0 && String.Compare(ga.VERSION, version) == 0)
                                .Select(ga => new
                                {
                                    Description = ga.DESCRIPTION,
                                    Country = ga.COUNTRY,
                                    Project = ga.PROJECT,
                                    Scenario = ga.SCENARIO,
                                    Section = ga.SECTION,
                                    Version = ga.VERSION,
                                    Attachments = ga.AssumptionAttachmentMapping
                                                    .Where(aam => aam.AttachamentMaster != null && !String.IsNullOrEmpty(aam.AttachamentMaster.Name) && !String.IsNullOrEmpty(aam.AttachamentMaster.Path))
                                                    .Select(aam => new
                                                    {
                                                        Name = aam.AttachamentMaster.Name,//.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries),
                                                Path = aam.AttachamentMaster.Path//.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries)
                                            })
                                })
                                .ToList()
                                .Select(a => new Assumption
                                {
                                    Description = a.Description,
                                    Product = a.Country,
                                    Project = a.Project,
                                    Scenario = a.Scenario,
                                    Section = a.Section,
                                    Version = a.Version,
                                    Attachments = a.Attachments
                                                    .Select(aam => new
                                                    {
                                                        Names = aam.Name.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries),
                                                        Paths = aam.Path.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries)
                                                    })
                                                    .SelectMany(att => Enumerable.Range(0, att.Names.Length).ToArray()
                                                                           .Select(index => new Attachment
                                                                           {
                                                                               AttachmentName = att.Names[index],
                                                                               AttachmentPath = att.Paths[index]
                                                                           })
                                                                ).ToList()
                                }).ToList();
                }
            catch (Exception ex)
            {

            }

            return assumptions;
        }
    }

    public class ActharForecastManager : ForecastManager
    {
        protected override string Namespace
        {
            get
            {
                return "Acthar";
            }
        }

        public ActharForecastManager(IUnitOfWork uow, int userId, UserRole userRole, byte accessType):base(uow, userId, userRole, accessType)
        {
        }

        protected override List<UserForecastMapping> GetUserForecastMapping()
        {
            var filteredForecastSet = new Dictionary<string, UserForecastMapping>();
            var allVersionsShared = new Dictionary<string, List<SharedAccessInfo>>();
            var forecastMappingList = new List<UserForecastMapping>();

            try
            {
                    var allVersionAccessProjects =
                        uow.TenantContext.ActharUserForecastMapping.Where(ufm => ufm.ShareWithID == userId && String.IsNullOrEmpty(ufm.Version))
                        .Select(ufm => ufm.ProjectName)
                        .Distinct();

                    var accessibleProjectVersions =
                        uow.TenantContext.ActharUserForecastMapping.Where(ufm => ufm.ShareWithID == userId && !String.IsNullOrEmpty(ufm.Version))
                        .Select(ufm => ufm.ProjectName + "|" + ufm.Version)
                        .Distinct();

                    var forecastQueryable =
                        uow.TenantContext.ActharUserForecastMapping
                        //important: don't change the order of the following || OR clause, you know why
                        .Where(ufm => IsAllAccessible ||
                                      allVersionAccessProjects.Contains(ufm.ProjectName) ||
                                      accessibleProjectVersions.Contains(ufm.ProjectName + "|" + ufm.Version))
                        .GroupBy(ufm => new { ufm.ProjectName, ufm.Version, ufm.ShareWithID })
                        //.Select(g => g.OrderBy(v => v.Authorization).FirstOrDefault()) //minimum authorization value === maximum permission
                        .SelectMany(g => g.Select(ufm => new
                        {
                            Forecast = ufm.ProjectName,
                            Version = ufm.Version,
                            ShareWithID = ufm.ShareWithID,
                            ShareByID = ufm.ShareByID,
                            Authorization = ufm.Authorization,
                            AccessDate = ufm.CreationDate,
                            Description = ufm.Description
                        }));

                    var forecastMappingsFromDB = forecastQueryable.OrderBy(f => f.Forecast).ThenBy(f => f.Version).ToList();
                    if (forecastMappingsFromDB != null && forecastMappingsFromDB.Count > 0)
                    {
                        UserForecastMapping accessibleForecast = null;
                        List<int> userIDs = new List<int>();
                        Dictionary<string, ForecastVersion> majorVersions = new Dictionary<string, ForecastVersion>();
                        Dictionary<string, List<ForecastVersion>> minorVersions = new Dictionary<string, List<ForecastVersion>>();
                        foreach (var forecastMappingFromDB in forecastMappingsFromDB)
                        {
                            string forecast = forecastMappingFromDB.Forecast;
                            //if (String.Compare(forecast, "version_Testing", true) != 0)
                            //    continue;
                            string label = forecastMappingFromDB.Version.SafeTrim();
                            int sharedWithId = forecastMappingFromDB.ShareWithID;
                            int sharedById = forecastMappingFromDB.ShareByID;
                            int authorization = forecastMappingFromDB.Authorization;
                            DateTime accessDate = forecastMappingFromDB.AccessDate;
                            string comment = forecastMappingFromDB.Description;

                            //for all versions shared
                            if (String.IsNullOrEmpty(label) || IsAllAccessible)
                            {
                                if (!allVersionsShared.ContainsKey(forecast))
                                    allVersionsShared.Add(forecast, new List<SharedAccessInfo>());
                                var allVersionsSharedWith = allVersionsShared[forecast].Where(a => a.SharedWith != null && a.SharedWith.UserId == sharedWithId).SingleOrDefault();
                                if (allVersionsSharedWith == null)
                                {
                                    allVersionsSharedWith = new SharedAccessInfo
                                    {
                                        SharedWith = new UserInfo
                                        {
                                            UserId = sharedWithId
                                        },
                                        SharedBy = new UserInfo
                                        {
                                            UserId = sharedById
                                        },
                                        AuthorizationLevel = authorization,
                                        SharedOn = accessDate
                                    };
                                    allVersionsShared[forecast].Add(allVersionsSharedWith);
                                }
                            }
                            //all versions shared end

                            if (String.IsNullOrEmpty(forecast) || String.IsNullOrEmpty(label) || sharedWithId < 1 || authorization < 1)
                                continue;

                            if (!filteredForecastSet.ContainsKey(forecast))
                            {
                                accessibleForecast = new UserForecastMapping
                                {
                                    Forecast = forecast,
                                    Versions = new List<ForecastVersion>(),
                                    LatestVersion = new ForecastVersion { Access = new Models.UserAccess() }
                                };
                                filteredForecastSet.Add(forecast, accessibleForecast);
                            }
                            else
                                accessibleForecast = filteredForecastSet[forecast];
                            ForecastVersion version = new ForecastVersion
                            {
                                Label = label,
                                Comment = comment,
                                Access = new Models.UserAccess { SharedAccess = new List<SharedAccessInfo>() }
                            };

                            //SetVersionAccess(version.Access, sharedWithId, sharedById, authorization, accessDate, userIDs);                    

                            int majorVersionNumber;
                            bool isMajor = GenUtil.IsMajor(label, out majorVersionNumber);
                            string majorVersionKey = forecast + "V" + majorVersionNumber;
                            //should be no case where there is no creater or no sharer
                            //if (version.Access.Creator != null || version.Access.SharedAccess != null)
                            //{
                            if (isMajor)
                            {
                                if (!majorVersions.ContainsKey(majorVersionKey))
                                {
                                    majorVersions.Add(majorVersionKey, version);
                                    accessibleForecast.Versions.Add(version);
                                }
                                else
                                {
                                    version = majorVersions[majorVersionKey];
                                }

                            }
                            else
                            {
                                if (!minorVersions.ContainsKey(majorVersionKey))
                                    minorVersions.Add(majorVersionKey, new List<ForecastVersion>());
                                var minorVersion = minorVersions[majorVersionKey].Where(v => String.Compare(v.Label, label, true) == 0).SingleOrDefault();
                                if (minorVersion != null)
                                    version = minorVersion;
                                else
                                    minorVersions[majorVersionKey].Add(version); //will be processed after this loop
                            }
                            //}

                            if (SetVersionAccess(version.Access, sharedWithId, sharedById, authorization, accessDate, userIDs, accessibleForecast.LatestVersion))
                                accessibleForecast.LatestVersion = version;
                        }

                        if (IsAllAccessible)
                        {
                            //include all versions access
                            IncludeAllVersionsAccess(filteredForecastSet, allVersionsShared, userIDs);
                        }

                        //keep user id vs user details ready
                        var accessors = new UserManager(uow).GetUserInfoByUserId(userIDs);
                        //relate minorVersions with majors
                        foreach (var kvp in minorVersions)
                        {
                            string postMajorKey = GenUtil.GetPostMajorKey(kvp.Key);
                            if (majorVersions.ContainsKey(postMajorKey))
                                majorVersions[postMajorKey].PreDrafts = kvp.Value;
                            else
                            {
                                var mockVersion = new ForecastVersion
                                {
                                    Label = GenUtil.GetVersionLabelFromVersionKey(postMajorKey),
                                    IsMock = true,
                                    PreDrafts = kvp.Value,
                                    Access = new Models.UserAccess
                                    {
                                        CreatedOn = kvp.Value[0].Access.CreatedOn
                                    }
                                };
                                majorVersions.Add(postMajorKey, mockVersion);
                                var forecastName = GenUtil.GetForecastNameFromVersionKey(postMajorKey);
                                filteredForecastSet[forecastName].Versions.Add(mockVersion);
                            }
                        }

                       if(!IsAllAccessible)
                        { 
                            //include all versions access
                            IncludeAllVersionsAccess(filteredForecastSet, allVersionsShared, userIDs);
                        }

                        //finally sort the versions and put the user deatils in
                        foreach (var filteredForecast in filteredForecastSet)
                        {
                            filteredForecast.Value.Versions = SortForecastVersions(filteredForecast.Value.Versions);
                            for (int majorVersionIterator = 0; filteredForecast.Value != null && filteredForecast.Value.Versions != null && majorVersionIterator < filteredForecast.Value.Versions.Count; majorVersionIterator++)
                            {
                                var filteredVersion = filteredForecast.Value.Versions[majorVersionIterator];
                                bool hasMajorAccess = false, hasPreDraftAccess = false;
                                filteredVersion.PreDrafts = SortForecastVersions(filteredVersion.PreDrafts);
                                hasMajorAccess = UpdateUserInforForVersionAccess(filteredVersion, accessors);
                                bool isMock = false;
                                if (filteredVersion.PreDrafts != null)
                                {
                                    for (int preDraftIterator = 0; preDraftIterator < filteredVersion.PreDrafts.Count; preDraftIterator++)
                                    {
                                        var preDraft = filteredVersion.PreDrafts[preDraftIterator];
                                        hasPreDraftAccess = UpdateUserInforForVersionAccess(preDraft, accessors);
                                        if (!hasPreDraftAccess)
                                        {
                                            //filter
                                            filteredVersion.PreDrafts.RemoveAt(preDraftIterator);
                                            preDraftIterator--;
                                            continue;
                                        }
                                        else
                                            isMock = true;
                                    }
                                }

                                if (!hasMajorAccess)
                                {
                                    //filter
                                    if (!isMock)
                                    {
                                        filteredForecast.Value.Versions.RemoveAt(majorVersionIterator);
                                        majorVersionIterator--;
                                    }
                                    else
                                        filteredForecast.Value.Versions[majorVersionIterator].IsMock = true;
                                    continue;
                                }
                            }
                        }


                        //filteredForecastSet.OrderByDescending(f => f.Value.Versions[0].Access.CreatedOn).Select(f => f.Value.Versions[0].Access.CreatedOn).ToList();
                        // return filteredForecastSet.Values.OrderByDescending(f => f.Versions[0].Access.CreatedOn).ThenByDescending(f=>f.LatestVersion.Access.CreatedOn).ToList();
                        // return filteredForecastSet.Values.OrderByDescending(f => f.LatestVersion.Access.CreatedOn).ThenByDescending(f => f.Versions[0].Access.CreatedOn).ToList();
                        forecastMappingList = filteredForecastSet.Values.OrderByDescending(f => f.Versions[0].Access.CreatedOn).ToList();
                        // return filteredForecastSet.Values.ToList();
                    }
                }
            catch (Exception ex)
            {

            }

            return forecastMappingList;
        }

        public override int UnshareForecast(List<UserForecastMappingForUnshare> userForecastsForUnshare)
        {
            var res = 0;
            try
            {
                    var ufmList = uow.TenantContext.ActharUserForecastMapping
                        .Where(ufm => userForecastsForUnshare
                                        .Any(unsh => String.Compare(unsh.projectName, ufm.ProjectName) == 0
                                                 && (String.IsNullOrEmpty(unsh.Version) || String.Compare(unsh.Version, ufm.Version) == 0)
                                                 && unsh.UnShareUserID == ufm.ShareWithID))
                        .ToList();
                uow.TenantContext.ActharUserForecastMapping.RemoveRange(ufmList);
                    if (ufmList.Count == 0)
                        return 2; //user did not have access to this forecast version

                    if (uow.TenantContext.SaveChanges() == ufmList.Count)
                        return 1;
            }
            catch (Exception ex)
            {
                res = 0;
            }

            return res;
        }

        protected override List<ActionStatus> SetUserforecastMapping(TenantModel context, List<UserForecastMapping> userForecasts, bool isSave)
        {
            List<ActionStatus> statusMessages = new List<ActionStatus>();
            HashSet<string> flattenedUserForecasts = GetFlattenedUserForecasts(userForecasts,true);
            //ProjectName, Version, SharedWithId, Authorization combination should be unique 
            List<int> sharedWithIdsForNotifications = new List<int>();
         
            var alreadyExistingItems = context.ActharUserForecastMapping
                                                      .Where(ufm => flattenedUserForecasts.Contains(ufm.ProjectName + "|" + ufm.Version + "|" + ufm.ShareWithID + "|" + ufm.Authorization))
                                                      .ToList();
            
                foreach (var userForecast in userForecasts)
                {
                    foreach (var forecastVersion in userForecast.Versions)
                    {
                        List<int> sharedWiths = new List<int>();
                        List<int> sharedBys = new List<int>();
                        if (isSave && forecastVersion.Access != null && forecastVersion.Access.Creator != null)
                        {
                            sharedWiths.Add(forecastVersion.Access.Creator.UserId);
                            sharedBys.Add(forecastVersion.Access.Creator.UserId);
                        }
                        else if (forecastVersion.Access != null && forecastVersion.Access.SharedAccess != null)
                        {
                            foreach (var item in forecastVersion.Access.SharedAccess)
                            {
                                sharedWiths.Add(item.SharedWith.UserId);
                                sharedBys.Add(item.SharedBy.UserId);
                                sharedWithIdsForNotifications.Add(item.SharedWith.UserId);
                            }
                        }
                        for (int i = 0; i < sharedWiths.Count; i++)
                        {
                            int sharedWith = sharedWiths[i];
                            int sharedBy = sharedBys[i];

                            var existingItem = alreadyExistingItems.FirstOrDefault(item => String.Compare(item.ProjectName, userForecast.Forecast) == 0
                                                          && String.Compare(item.Version, forecastVersion.Label) == 0
                                                          && item.ShareWithID == sharedWith
                                                          && item.Authorization == 1);
                            if (existingItem != null)
                            {
                                statusMessages.Add(new ActionStatus
                                {
                                    Number = 3,
                                    Message = isSave ? String.Format("{0} {1} had been already created by you", userForecast.Forecast, forecastVersion.Label)
                                                     : "Can't share forecast with its creator"
                                });
                            }
                            else
                            {
                                if (forecastVersion.Access != null && forecastVersion.Access.Creator != null)
                                {
                                    var newItem = new ActharUserForecastMapping
                                    {
                                        Authorization = 1,
                                        // CreationDate = DateTime.Now,
                                        CreationDate = DateTime.UtcNow,
                                        Description = forecastVersion.Comment,
                                        ProjectName = userForecast.Forecast,
                                        ShareByID = sharedBy,
                                        ShareWithID = sharedWith,
                                        Version = forecastVersion.Label
                                    };
                                    context.ActharUserForecastMapping.Add(newItem);
                                    statusMessages.Add(new ActionStatus { Number = 1, Message = "Saved successfully" });
                                }
                                else if (forecastVersion.Access != null && forecastVersion.Access.SharedAccess != null)
                                {
                                    foreach (var sa in forecastVersion.Access.SharedAccess)
                                    {
                                        existingItem = alreadyExistingItems.FirstOrDefault(item => String.Compare(item.ProjectName, userForecast.Forecast) == 0
                                                                  && String.Compare(item.Version, forecastVersion.Label) == 0
                                                                  && item.ShareWithID == sharedWith);
                                        if (existingItem != null)
                                        {
                                            if (existingItem.Authorization <= sa.AuthorizationLevel)
                                                statusMessages.Add(new ActionStatus { Number = 4, Message = "User already has higher permission for the forecast version." });
                                            else
                                                existingItem.Authorization = sa.AuthorizationLevel;
                                            if (String.Compare(existingItem.Description, forecastVersion.Comment) != 0)
                                                existingItem.Description = forecastVersion.Comment;
                                        }
                                        else
                                        {
                                            var newItem = new ActharUserForecastMapping
                                            {
                                                Authorization = sa.AuthorizationLevel,
                                                // CreationDate = DateTime.Now,
                                                CreationDate = DateTime.UtcNow,
                                                Description = forecastVersion.Comment,
                                                ProjectName = userForecast.Forecast,
                                                ShareByID = sa.SharedBy.UserId,
                                                ShareWithID = sa.SharedWith.UserId,
                                                Version = forecastVersion.Label
                                            };
                                            context.ActharUserForecastMapping.Add(newItem);
                                            statusMessages.Add(new ActionStatus { Number = 1, Message = "Shared successfully" });
                                        }
                                    }
                                }
                            }
                        }
                    }

                }

                context.SaveChanges();
                List<int> userIDS = new List<int>();
                userIDS.Add(userId);
                UserInfo userInfo = new UserInfo();
                var accessors = new UserManager(uow).GetUserInfoByUserId(userIDS);
                userInfo = accessors[userId];
                var forecastName = userForecasts[0].Forecast;
                if (sharedWithIdsForNotifications.Count >= 1)
                {
                    for (int j = 0; j < sharedWithIdsForNotifications.Count; j++)
                    {
                        var ShareWithID = sharedWithIdsForNotifications[j];
                        TenantUserNotifications notification = new TenantUserNotifications
                        {
                            UserId = ShareWithID,
                            Descriptions = String.Format("{0} has Shared Forecast " + forecastName + " with You", userInfo.FirstName + " " + userInfo.LastName),
                            UserKey = Guid.NewGuid().ToString(),
                            //CreatedDate = DateTime.Now,
                            CreatedDate = DateTime.UtcNow,
                            IsRead = false

                        };
                        context.UserNotifications.Add(notification);
                    }
                }
                context.SaveChanges();

            return statusMessages;
        }

        public override List<string> GetDistinctProjectNames()
        {
            List<string> projectnames = new List<string>();

            try
            {
                            projectnames = uow.TenantContext.ActharUserForecastMapping
                        .Select(ufm => ufm.ProjectName)
                        .Distinct()
                        .ToList();
                }
            catch (Exception ex)
            {

            }

            return projectnames;
        }

        public override string GetLatestVersionByProjectName(string project)
        {
            string msg = string.Empty;
            string res = "";
            try
            {
                            res = uow.TenantContext.ActharUserForecastMapping
                                .Where(ufm => String.Compare(ufm.ProjectName, project) == 0)
                                .OrderByDescending(ufm => ufm.CreationDate)
                                .Select(ufm => ufm.Version)
                                .FirstOrDefault();                    
                
                if (String.IsNullOrEmpty(res))
                    throw new Exception("No version exists for the requested project");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return res;
        }

        public override List<ActionStatus> SetSectionPreferences(string forecast, string version, string sectionPref)
        {
            throw new NotImplementedException();
        }

        public override List<ForecastSection> GetSectionPreference(string forecast, string version)
        {
           // throw new NotImplementedException();
            List<ForecastSection> sections = new List<ForecastSection>();

            sections.Add(
                new ForecastSection
                {
                    Name = "Received Referals",
                    HasAssumption = true,
                    Start = 12,
                    End = 88
                }
                );
            sections.Add(
                new ForecastSection
                {
                    Name = "Closed Rate",
                    HasAssumption = false,
                    Start = 89,
                    End = 110
                }
                );
            sections.Add(
                new ForecastSection
                {
                    Name = "Closed Referals",
                    HasAssumption = true,
                    Start = 111,
                    End = 116
                }
                );
            sections.Add(
                new ForecastSection
                {
                    Name = "Shipped Rate",
                    HasAssumption = false,
                    Start = 117,
                    End = 145
                }
                );
            sections.Add(
                new ForecastSection
                {
                    Name = "Paid Referals",
                    HasAssumption = true,
                    Start = 146,
                    End = 157
                }
                );
            sections.Add(
                new ForecastSection
                {
                    Name = "Vials/Rx",
                    HasAssumption = false,
                    Start = 158,
                    End = 167
                }
                );
            sections.Add(
                new ForecastSection
                {
                    Name = "Vials",
                    HasAssumption = true,
                    Start = 168,
                    End = 169
                }
                );


            return sections;
        }

        public override void SetAssumptions(List<Assumption> assumptions)
        {
            try
            {
                    if (assumptions == null)
                        return;
                    assumptions = assumptions.Where(a => a != null && (!String.IsNullOrEmpty(a.Description) || (a.Attachments != null && a.Attachments.Count > 0))).ToList();
                    HashSet<string> assumptionSet = new HashSet<string>();
                    HashSet<string> attachmentSet = new HashSet<string>();
                    foreach (var assumption in assumptions)
                    {
                        string flattenedAssumption = String.Format("{0}|{1}|{2}|{3}|{4}|{5}", assumption.Project, assumption.Version, assumption.Scenario, assumption.Product, assumption.SKU, assumption.Section);
                        if (!assumptionSet.Contains(flattenedAssumption))
                            assumptionSet.Add(flattenedAssumption);
                        if (assumption.Attachments != null)
                        {
                            foreach (var attachment in assumption.Attachments)
                            {
                                string flattenedAttachment = String.Format("{0}|{1}", attachment.AttachmentName, attachment.AttachmentPath);
                                if (!attachmentSet.Contains(flattenedAttachment))
                                    attachmentSet.Add(flattenedAttachment);
                            }
                        }
                    }
                    var existingAssumptionsQueryable = uow.TenantContext.ActharAssumptions
                        .Include(ga => ga.AssumptionAttachmentMapping)
                        .Include(ga => ga.AssumptionAttachmentMapping.Select(aam => aam.AttachamentMaster))
                        .Where(ga => assumptionSet.Contains(ga.PROJECT + "|" + ga.VERSION + "|" + ga.SECTION))
                        .Future();
                    var existingAttachmentsQueryable = uow.TenantContext.AttachamentMaster
                        .Where(am => attachmentSet.Contains(am.Name + "|" + am.Path))
                        .Future();

                    var existingAssumptions = existingAssumptionsQueryable.ToList();
                    var existingAttachments = existingAttachmentsQueryable.ToList();
                    if (existingAssumptions != null && existingAssumptions.Count() > 0)
                    {
                        //update existing assumptions, if needed
                        foreach (var item in existingAssumptions)
                        {
                            var MatchedAssumption = assumptions.FirstOrDefault(a => String.Compare(a.Project, item.PROJECT, true) == 0
                                                         && String.Compare(a.Version, item.VERSION, true) == 0
                                                         && a.Section == item.SECTION);
                            if (MatchedAssumption != null)
                            {
                                if (String.Compare(MatchedAssumption.Description, item.DESCRIPTION) != 0)
                                    item.DESCRIPTION = MatchedAssumption.Description;
                                var existingAttachmentsToBeRemoved = item.AssumptionAttachmentMapping
                                    .SelectMany(aam => MatchedAssumption.Attachments
                                                                         .Where(a => String.Compare(a.AttachmentPath, aam.AttachamentMaster.Path) == 0));
                                foreach (var att in existingAttachmentsToBeRemoved)
                                {
                                    MatchedAssumption.Attachments.Remove(att);
                                }
                                foreach (var att in MatchedAssumption.Attachments)
                                {
                                    AttachamentMaster newAttachment = new AttachamentMaster
                                    {
                                        Name = att.AttachmentName,
                                        Path = att.AttachmentPath
                                    };
                                    ActharAssumptionAttachmentMapping newMapping = new ActharAssumptionAttachmentMapping
                                    {
                                        Assumptions = item,
                                        AttachamentMaster = newAttachment
                                    };

                                uow.TenantContext.ActharAssumptionAttachmentMapping.Add(newMapping);
                                }

                                assumptions.Remove(MatchedAssumption);
                            }
                        }
                    }

                    //insert the rest
                    ActharAssumptions newOrExistingAssumption = null;
                    foreach (var assumption in assumptions)
                    {
                        newOrExistingAssumption = new ActharAssumptions
                        {
                            PROJECT = assumption.Project,
                            VERSION = assumption.Version,
                            SECTION = assumption.Section,
                            DESCRIPTION = assumption.Description,
                            INDICATION = assumption.Indication
                        };
                        if (assumption.Attachments != null && assumption.Attachments.Count > 0)
                        {
                            foreach (var att in assumption.Attachments)
                            {
                                AttachamentMaster newOrExistingAttachment = existingAttachments
                                    .Where(ea => String.Compare(ea.Name, att.AttachmentName) == 0
                                              && String.Compare(ea.Path, att.AttachmentPath) == 0)
                                    .FirstOrDefault();

                                if (newOrExistingAttachment == null)
                                {
                                    newOrExistingAttachment = new AttachamentMaster
                                    {
                                        Name = att.AttachmentName,
                                        Path = att.AttachmentPath
                                    };
                                }
                                ActharAssumptionAttachmentMapping newMapping = new ActharAssumptionAttachmentMapping
                                {
                                    Assumptions = newOrExistingAssumption,
                                    AttachamentMaster = newOrExistingAttachment
                                };

                            uow.TenantContext.ActharAssumptionAttachmentMapping.Add(newMapping);
                            }
                        }
                        else
                        uow.TenantContext.ActharAssumptions.Add(newOrExistingAssumption);
                    }

                uow.TenantContext.SaveChanges();
                
            }

            catch (Exception ex)
            {
                throw new Exception("Could not save assumptions");
            }

        }

        public override List<Assumption> GetAssumptions(string project, string version)
        {
            List<Assumption> assumptions = new List<Assumption>();

            try
            {
                    return uow.TenantContext.ActharAssumptions
                                .Where(ga => String.Compare(ga.PROJECT, project) == 0 && String.Compare(ga.VERSION, version) == 0)
                                .Select(ga => new
                                {
                                    Description = ga.DESCRIPTION,
                                    Indication = ga.INDICATION,
                                    Project = ga.PROJECT,
                                    Section = ga.SECTION,
                                    Version = ga.VERSION,
                                    Attachments = ga.AssumptionAttachmentMapping
                                                    .Where(aam => aam.AttachamentMaster != null && !String.IsNullOrEmpty(aam.AttachamentMaster.Name) && !String.IsNullOrEmpty(aam.AttachamentMaster.Path))
                                                    .Select(aam => new
                                                    {
                                                        Name = aam.AttachamentMaster.Name,//.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries),
                                                Path = aam.AttachamentMaster.Path//.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries)
                                            })
                                })
                                .ToList()
                                .Select(a => new Assumption
                                {
                                    Indication = a.Indication,
                                    Description = a.Description,
                                    Project = a.Project,
                                    Section = a.Section,
                                    Version = a.Version,
                                    Attachments = a.Attachments
                                                    .Select(aam => new
                                                    {
                                                        Names = aam.Name.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries),
                                                        Paths = aam.Path.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries)
                                                    })
                                                    .SelectMany(att => Enumerable.Range(0, att.Names.Length).ToArray()
                                                                           .Select(index => new Attachment
                                                                           {
                                                                               AttachmentName = att.Names[index],
                                                                               AttachmentPath = att.Paths[index]
                                                                           })
                                                                ).ToList()
                                }).ToList();
                
            }
            catch (Exception ex)
            {

            }

            return assumptions;
        }
    }

    public class GenericForecastManager : ForecastManager
    {
        protected override string Namespace
        {
            get
            {
                return "Generic";
            }
        }

        public GenericForecastManager(IUnitOfWork uow, int userId, UserRole userRole, byte accessType):base(uow, userId, userRole, accessType)
        {
        }

        protected override List<UserForecastMapping> GetUserForecastMapping()
        {
            var filteredForecastSet = new Dictionary<string, UserForecastMapping>();
            var allVersionsShared = new Dictionary<string, List<SharedAccessInfo>>();
            var forecastMappingList = new List<UserForecastMapping>();            

            try
            {
                    var allVersionAccessProjects =
                        uow.TenantContext.GenericUserForecastMapping.Where(ufm => ufm.ShareWithID == userId && String.IsNullOrEmpty(ufm.Version))
                        .Select(ufm => ufm.ProjectName)
                        .Distinct();

                    var accessibleProjectVersions =
                        uow.TenantContext.GenericUserForecastMapping.Where(ufm => ufm.ShareWithID == userId && !String.IsNullOrEmpty(ufm.Version))
                        .Select(ufm => ufm.ProjectName + "|" + ufm.Version)
                        .Distinct();

                    var forecastQueryable =
                uow.TenantContext.GenericUserForecastMapping
                        //important: don't change the order of the following || OR clause, you know why
                        .Where(ufm => IsAllAccessible ||
                                      allVersionAccessProjects.Contains(ufm.ProjectName) || 
                                      accessibleProjectVersions.Contains(ufm.ProjectName + "|" + ufm.Version))
                        .GroupBy(ufm => new { ufm.ProjectName, ufm.Version, ufm.ShareWithID })
                        //.Select(g => g.OrderBy(v => v.Authorization).FirstOrDefault()) //minimum authorization value === maximum permission
                        .SelectMany(g => g.Select(ufm => new
                        {
                            Forecast = ufm.ProjectName,
                            Version = ufm.Version,
                            ShareWithID = ufm.ShareWithID,
                            ShareByID = ufm.ShareByID,
                            Authorization = ufm.Authorization,
                            AccessDate = ufm.CreationDate,
                            Description = ufm.Description
                        }));

                    var forecastMappingsFromDB = forecastQueryable.OrderBy(f => f.Forecast).ThenBy(f => f.Version).ToList();
                    if (forecastMappingsFromDB != null && forecastMappingsFromDB.Count > 0)
                    {
                        UserForecastMapping accessibleForecast = null;
                        List<int> userIDs = new List<int>();
                        Dictionary<string, ForecastVersion> majorVersions = new Dictionary<string, ForecastVersion>();
                        Dictionary<string, List<ForecastVersion>> minorVersions = new Dictionary<string, List<ForecastVersion>>();
                        foreach (var forecastMappingFromDB in forecastMappingsFromDB)
                        {
                            string forecast = forecastMappingFromDB.Forecast;
                            string label = forecastMappingFromDB.Version.SafeTrim();
                            int sharedWithId = forecastMappingFromDB.ShareWithID;
                            int sharedById = forecastMappingFromDB.ShareByID;
                            int authorization = forecastMappingFromDB.Authorization;
                            DateTime accessDate = forecastMappingFromDB.AccessDate;
                            string comment = forecastMappingFromDB.Description;

                            //for all versions shared
                            if (String.IsNullOrEmpty(label) || IsAllAccessible)
                            {
                                if (!allVersionsShared.ContainsKey(forecast))
                                    allVersionsShared.Add(forecast, new List<SharedAccessInfo>());
                                var allVersionsSharedWith = allVersionsShared[forecast].Where(a => a.SharedWith != null && a.SharedWith.UserId == sharedWithId).SingleOrDefault();
                                if (allVersionsSharedWith == null)
                                {
                                    allVersionsSharedWith = new SharedAccessInfo
                                    {
                                        SharedWith = new UserInfo
                                        {
                                            UserId = sharedWithId
                                        },
                                        SharedBy = new UserInfo
                                        {
                                            UserId = sharedById
                                        },
                                        AuthorizationLevel = authorization,
                                        SharedOn = accessDate
                                    };
                                    allVersionsShared[forecast].Add(allVersionsSharedWith);
                                }
                            }
                            //all versions shared end

                            if (String.IsNullOrEmpty(forecast) || String.IsNullOrEmpty(label) || sharedWithId < 1 || authorization < 1)
                                continue;

                            if (!filteredForecastSet.ContainsKey(forecast))
                            {
                                accessibleForecast = new UserForecastMapping
                                {
                                    Forecast = forecast,
                                    Versions = new List<ForecastVersion>(),
                                    LatestVersion = new ForecastVersion { Access = new Models.UserAccess() }
                                };
                                filteredForecastSet.Add(forecast, accessibleForecast);
                            }
                            else
                                accessibleForecast = filteredForecastSet[forecast];
                            ForecastVersion version = new ForecastVersion
                            {
                                Label = label,
                                Comment = comment,
                                Access = new Models.UserAccess { SharedAccess = new List<SharedAccessInfo>() }
                            };

                            //SetVersionAccess(version.Access, sharedWithId, sharedById, authorization, accessDate, userIDs);                    

                            int majorVersionNumber;
                            bool isMajor = GenUtil.IsMajor(label, out majorVersionNumber);
                            string majorVersionKey = forecast + "V" + majorVersionNumber;
                            //should be no case where there is no creater or no sharer
                            //if (version.Access.Creator != null || version.Access.SharedAccess != null)
                            //{
                            if (isMajor)
                            {
                                if (!majorVersions.ContainsKey(majorVersionKey))
                                {
                                    majorVersions.Add(majorVersionKey, version);
                                    accessibleForecast.Versions.Add(version);
                                }
                                else
                                {
                                    version = majorVersions[majorVersionKey];
                                }

                            }
                            else
                            {
                                if (!minorVersions.ContainsKey(majorVersionKey))
                                    minorVersions.Add(majorVersionKey, new List<ForecastVersion>());
                                var minorVersion = minorVersions[majorVersionKey].Where(v => String.Compare(v.Label, label, true) == 0).SingleOrDefault();
                                if (minorVersion != null)
                                    version = minorVersion;
                                else
                                    minorVersions[majorVersionKey].Add(version); //will be processed after this loop
                            }
                            //}

                            if (SetVersionAccess(version.Access, sharedWithId, sharedById, authorization, accessDate, userIDs, accessibleForecast.LatestVersion))
                                accessibleForecast.LatestVersion = version;
                        }

                        if (IsAllAccessible)
                        {
                            //include all versions access
                            IncludeAllVersionsAccess(filteredForecastSet, allVersionsShared, userIDs);
                        }

                        //keep user id vs user details ready
                        var accessors = new UserManager(uow).GetUserInfoByUserId(userIDs);
                        //relate minorVersions with majors
                        foreach (var kvp in minorVersions)
                        {
                            string postMajorKey = GenUtil.GetPostMajorKey(kvp.Key);
                            if (majorVersions.ContainsKey(postMajorKey))
                                majorVersions[postMajorKey].PreDrafts = kvp.Value;
                            else
                            {
                                var mockVersion = new ForecastVersion
                                {
                                    Label = GenUtil.GetVersionLabelFromVersionKey(postMajorKey),
                                    IsMock = true,
                                    PreDrafts = kvp.Value,
                                    Access = new Models.UserAccess
                                    {
                                        CreatedOn = kvp.Value[0].Access.CreatedOn
                                    }
                                };
                                majorVersions.Add(postMajorKey, mockVersion);
                                var forecastName = GenUtil.GetForecastNameFromVersionKey(postMajorKey);
                                filteredForecastSet[forecastName].Versions.Add(mockVersion);
                            }
                        }


                        if (!IsAllAccessible)
                        {
                            //include all versions access
                            IncludeAllVersionsAccess(filteredForecastSet, allVersionsShared, userIDs);
                        }

                        //finally sort the versions and put the user deatils in
                        foreach (var filteredForecast in filteredForecastSet)
                        {
                            filteredForecast.Value.Versions = SortForecastVersions(filteredForecast.Value.Versions);
                            for (int majorVersionIterator = 0; filteredForecast.Value != null && filteredForecast.Value.Versions != null && majorVersionIterator < filteredForecast.Value.Versions.Count; majorVersionIterator++)
                            {
                                var filteredVersion = filteredForecast.Value.Versions[majorVersionIterator];
                                bool hasMajorAccess = false, hasPreDraftAccess = false;
                                filteredVersion.PreDrafts = SortForecastVersions(filteredVersion.PreDrafts);
                                hasMajorAccess = UpdateUserInforForVersionAccess(filteredVersion, accessors);
                                bool isMock = false;
                                if (filteredVersion.PreDrafts != null)
                                {
                                    for (int preDraftIterator = 0; preDraftIterator < filteredVersion.PreDrafts.Count; preDraftIterator++)
                                    {
                                        var preDraft = filteredVersion.PreDrafts[preDraftIterator];
                                        hasPreDraftAccess = UpdateUserInforForVersionAccess(preDraft, accessors);
                                        if (!hasPreDraftAccess)
                                        {
                                            //filter
                                            filteredVersion.PreDrafts.RemoveAt(preDraftIterator);
                                            preDraftIterator--;
                                            continue;
                                        }
                                        else
                                            isMock = true;
                                    }
                                }

                                if (!hasMajorAccess)
                                {
                                    //filter
                                    if (!isMock)
                                    {
                                        filteredForecast.Value.Versions.RemoveAt(majorVersionIterator);
                                        majorVersionIterator--;
                                    }
                                    else
                                        filteredForecast.Value.Versions[majorVersionIterator].IsMock = true;
                                    continue;
                                }
                            }
                        }


                        //filteredForecastSet.OrderByDescending(f => f.Value.Versions[0].Access.CreatedOn).Select(f => f.Value.Versions[0].Access.CreatedOn).ToList();
                        // return filteredForecastSet.Values.OrderByDescending(f => f.Versions[0].Access.CreatedOn).ThenByDescending(f=>f.LatestVersion.Access.CreatedOn).ToList();
                        // return filteredForecastSet.Values.OrderByDescending(f => f.LatestVersion.Access.CreatedOn).ThenByDescending(f => f.Versions[0].Access.CreatedOn).ToList();
                        forecastMappingList = filteredForecastSet.Values.OrderByDescending(f => f.Versions[0].Access.CreatedOn).ToList();
                        // return filteredForecastSet.Values.ToList();
                    }
                
            }
            catch (Exception ex)
            {

            }

            return forecastMappingList;
        }
        
        public override int UnshareForecast(List<UserForecastMappingForUnshare> userForecastsForUnshare)
        {
            var res = 0;
            try
            {
                var criterion = userForecastsForUnshare.Select(unsh => String.Format("{0}|{1}|{2}", unsh.projectName, unsh.Version ?? String.Empty, unsh.UnShareUserID));
                
                    //var ufmList = context.GenericUserForecastMapping
                    //        .Where(ufm => userForecastsForUnshare
                    //                        .Any(unsh => String.Compare(unsh.projectName, ufm.ProjectName) == 0
                    //                                 && (String.IsNullOrEmpty(unsh.Version) || String.Compare(unsh.Version, ufm.Version) == 0)
                    //                                 && unsh.UnShareUserID == ufm.ShareWithID))
                
                    var ufmList = uow.TenantContext.GenericUserForecastMapping
                        .Where( ufm =>  criterion.Contains (ufm.ProjectName + "|" + ufm.Version + "|" + ufm.ShareWithID)).ToList();

                uow.TenantContext.GenericUserForecastMapping.RemoveRange(ufmList);
                    if (ufmList.Count == 0)
                        return 2; //user did not have access to this forecast version

                    if (uow.TenantContext.SaveChanges() == ufmList.Count)
                        return 1;

                
            }
            catch (Exception ex)
            {
                res = 0;
            }

            return res;
        }

        protected override List<ActionStatus> SetUserforecastMapping(TenantModel context, List<UserForecastMapping> userForecasts, bool isSave)
        {
            List<ActionStatus> statusMessages = new List<ActionStatus>();
            HashSet<string> flattenedUserForecasts = GetFlattenedUserForecasts(userForecasts, true);
            HashSet<string> flattenedUserForecastswithoutAuth = GetFlattenedUserForecasts(userForecasts, false);
            List<int> sharedWithIdsForNotifications = new List<int>();
            //ProjectName, Version, SharedWithId, Authorization combination should be unique            
            var alreadyExistingItems = context.GenericUserForecastMapping
                                                      .Where(ufm => flattenedUserForecasts.Contains(ufm.ProjectName + "|" + ufm.Version + "|" + ufm.ShareWithID + "|" + ufm.Authorization))
                                                      .ToList();

            var alreadyExistingItemswithoutAuthorization = context.GenericUserForecastMapping
                                                     .Where(ufm => flattenedUserForecastswithoutAuth.Contains(ufm.ProjectName + "|" + ufm.Version + "|" + ufm.ShareWithID))
                                                     .ToList();


            foreach (var userForecast in userForecasts)
            {
                foreach (var forecastVersion in userForecast.Versions)
                {
                    List<int> sharedWiths = new List<int>();
                    List<int> sharedBys = new List<int>();
                    if (isSave && forecastVersion.Access != null && forecastVersion.Access.Creator != null)
                    {
                        sharedWiths.Add(forecastVersion.Access.Creator.UserId);
                        sharedBys.Add(forecastVersion.Access.Creator.UserId);
                    }
                    else if (forecastVersion.Access != null && forecastVersion.Access.SharedAccess != null)
                    {
                        foreach (var item in forecastVersion.Access.SharedAccess)
                        {
                            sharedWiths.Add(item.SharedWith.UserId);
                            sharedBys.Add(item.SharedBy.UserId);
                            sharedWithIdsForNotifications.Add(item.SharedWith.UserId);
                        }
                    }
                    for (int i = 0; i < sharedWiths.Count; i++)
                    {
                        int sharedWith = sharedWiths[i];
                        int sharedBy = sharedBys[i];

                        var existingItem = alreadyExistingItems.FirstOrDefault(item => String.Compare(item.ProjectName, userForecast.Forecast) == 0
                                                      && String.Compare(item.Version, forecastVersion.Label) == 0
                                                      && item.ShareWithID == sharedWith
                                                      && item.Authorization == 1);
                        if (existingItem != null)
                        {
                            statusMessages.Add(new ActionStatus
                            {
                                Number = 3,
                                Message = isSave ? String.Format("{0} {1} had been already created by you", userForecast.Forecast, forecastVersion.Label)
                                                 : "Can't share forecast with its creator"
                            });
                        }
                        else
                        {
                            if (forecastVersion.Access != null && forecastVersion.Access.Creator != null)
                            {
                                var newItem = new GenericUserForecastMapping
                                {
                                    Authorization = 1,
                                    //CreationDate = DateTime.Now,
                                    CreationDate = DateTime.UtcNow,
                                    Description = forecastVersion.Comment,
                                    ProjectName = userForecast.Forecast,
                                    ShareByID = sharedBy,
                                    ShareWithID = sharedWith,
                                    Version = forecastVersion.Label
                                };
                                context.GenericUserForecastMapping.Add(newItem);
                                statusMessages.Add(new ActionStatus { Number = 1, Message = "Saved successfully" });
                            }
                            else if (forecastVersion.Access != null && forecastVersion.Access.SharedAccess != null)
                            {
                                foreach (var sa in forecastVersion.Access.SharedAccess)
                                {
                                    existingItem = alreadyExistingItems.FirstOrDefault(item => String.Compare(item.ProjectName, userForecast.Forecast) == 0
                                                              && String.Compare(item.Version, forecastVersion.Label) == 0
                                                              && item.ShareWithID == sharedWith);
                                    if (existingItem != null)
                                    {
                                        if (existingItem.Authorization <= sa.AuthorizationLevel)
                                            statusMessages.Add(new ActionStatus { Number = 4, Message = "User already has higher permission for the forecast version." });
                                        else
                                            existingItem.Authorization = sa.AuthorizationLevel;
                                        if (String.Compare(existingItem.Description, forecastVersion.Comment) != 0)
                                            existingItem.Description = forecastVersion.Comment;
                                    }
                                    else
                                    {
                                        var ExistingItemswithoutAuthorization = alreadyExistingItemswithoutAuthorization.FirstOrDefault(itemWithoutAuth => String.Compare(itemWithoutAuth.ProjectName, userForecast.Forecast) == 0
                                             && String.Compare(itemWithoutAuth.Version, forecastVersion.Label) == 0
                                             && itemWithoutAuth.ShareWithID == sharedWith);
                                        if (ExistingItemswithoutAuthorization == null)
                                        {
                                            var newItem = new GenericUserForecastMapping
                                            {
                                                Authorization = sa.AuthorizationLevel,
                                                // CreationDate = DateTime.Now,
                                                CreationDate = DateTime.UtcNow,
                                                Description = forecastVersion.Comment,
                                                ProjectName = userForecast.Forecast,
                                                ShareByID = sa.SharedBy.UserId,
                                                ShareWithID = sa.SharedWith.UserId,
                                                Version = forecastVersion.Label
                                            };
                                            context.GenericUserForecastMapping.Add(newItem);
                                        }
                                        else if (ExistingItemswithoutAuthorization.Authorization != sa.AuthorizationLevel)
                                        {
                                            ExistingItemswithoutAuthorization.Authorization = sa.AuthorizationLevel;
                                        }
                                        statusMessages.Add(new ActionStatus { Number = 1, Message = "Shared successfully" });
                                    }
                                }
                            }
                        }
                    }
                }

            }
            context.SaveChanges();

            List<int> userIDS = new List<int>();
            userIDS.Add(userId);
            UserInfo userInfo = new UserInfo();
            var accessors = new UserManager(uow).GetUserInfoByUserId(userIDS);
            userInfo = accessors[userId];
            var forecastName = userForecasts[0].Forecast;
            if (sharedWithIdsForNotifications.Count >= 1)
            {
                for (int j = 0; j < sharedWithIdsForNotifications.Count; j++)
                {
                    var ShareWithID = sharedWithIdsForNotifications[j];
                    TenantUserNotifications notification = new TenantUserNotifications
                    {
                        UserId = ShareWithID,
                        Descriptions = String.Format("{0} has Shared Forecast " + forecastName + " with You", userInfo.FirstName + " " + userInfo.LastName),
                        UserKey = Guid.NewGuid().ToString(),
                        // CreatedDate = DateTime.Now,
                        CreatedDate = DateTime.UtcNow,
                        IsRead = false

                    };
                    context.UserNotifications.Add(notification);
                }
            }
            context.SaveChanges();
        
            return statusMessages;
        }
        
        public override List<string> GetDistinctProjectNames()
        {
            List<string> projectnames = new List<string>();

            try
            {
                    
                            projectnames = uow.TenantContext.GenericUserForecastMapping
                        .Select(ufm => ufm.ProjectName)
                        .Distinct()
                        .ToList();
                
            }
            catch (Exception ex)
            {

            }

            return projectnames;
        }

        public override string GetLatestVersionByProjectName(string project)
        {
            string msg = string.Empty;
            string res = "";
            try
            {
                            res = uow.TenantContext.GenericUserForecastMapping
                                .Where(ufm => String.Compare(ufm.ProjectName, project) == 0)
                                .OrderByDescending(ufm => ufm.CreationDate)
                                .Select(ufm => ufm.Version)
                                .FirstOrDefault();                 
                
                if (String.IsNullOrEmpty(res))
                    throw new Exception("No version exists for the requested project");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return res;
        }        

        public override void SetAssumptions(List<Assumption> assumptions)
        {
            try
            {
                    if (assumptions == null)
                        return;
                    assumptions = assumptions.Where(a => a != null && (!String.IsNullOrEmpty(a.Description) || (a.Attachments != null && a.Attachments.Count > 0))).ToList();
                    HashSet<string> assumptionSet = new HashSet<string>();
                    HashSet<string> attachmentSet = new HashSet<string>();
                    foreach (var assumption in assumptions)
                    {
                        string flattenedAssumption = String.Format("{0}|{1}|{2}|{3}|{4}|{5}", assumption.Project, assumption.Version, assumption.Scenario, assumption.Product, assumption.SKU, assumption.Section);
                        if (!assumptionSet.Contains(flattenedAssumption))
                            assumptionSet.Add(flattenedAssumption);
                        if (assumption.Attachments != null)
                        {
                            foreach (var attachment in assumption.Attachments)
                            {
                                string flattenedAttachment = String.Format("{0}|{1}", attachment.AttachmentName, attachment.AttachmentPath);
                                if (!attachmentSet.Contains(flattenedAttachment))
                                    attachmentSet.Add(flattenedAttachment);
                            }
                        }
                    }
                    var existingAssumptionsQueryable = uow.TenantContext.GenericAssumptions
                        .Include(ga => ga.AssumptionAttachmentMapping)
                        .Include(ga => ga.AssumptionAttachmentMapping.Select(aam => aam.AttachamentMaster))
                        .Where(ga => assumptionSet.Contains(ga.PROJECT + "|" + ga.VERSION + "|" + ga.SCENARIO + "|" + ga.PRODUCT + "|" + ga.SKU + "|" + ga.SECTION))
                        .Future();
                    var existingAttachmentsQueryable = uow.TenantContext.AttachamentMaster
                        .Where(am => attachmentSet.Contains(am.Name + "|" + am.Path))
                        .Future();

                    var existingAssumptions = existingAssumptionsQueryable.ToList();
                    var existingAttachments = existingAttachmentsQueryable.ToList();
                    if (existingAssumptions != null && existingAssumptions.Count() > 0)
                    {
                        //update existing assumptions, if needed
                        foreach (var item in existingAssumptions)
                        {
                            var MatchedAssumption = assumptions.FirstOrDefault(a => String.Compare(a.Project, item.PROJECT, true) == 0
                                                         && String.Compare(a.Version, item.VERSION, true) == 0
                                                         && a.Scenario == item.SCENARIO
                                                         && a.Product == item.PRODUCT
                                                         && a.SKU == item.SKU
                                                         && a.Section == item.SECTION);
                            if (MatchedAssumption != null)
                            {
                                if (String.Compare(MatchedAssumption.Description, item.DESCRIPTION) != 0)
                                    item.DESCRIPTION = MatchedAssumption.Description;
                                var existingAttachmentsToBeRemoved = item.AssumptionAttachmentMapping
                                    .SelectMany(aam => MatchedAssumption.Attachments
                                                                         .Where(a => String.Compare(a.AttachmentPath, aam.AttachamentMaster.Path) == 0));
                                foreach (var att in existingAttachmentsToBeRemoved)
                                {
                                    MatchedAssumption.Attachments.Remove(att);
                                }
                                foreach (var att in MatchedAssumption.Attachments)
                                {
                                    AttachamentMaster newAttachment = new AttachamentMaster
                                    {
                                        Name = att.AttachmentName,
                                        Path = att.AttachmentPath
                                    };
                                    GenericAssumptionAttachmentMapping newMapping = new GenericAssumptionAttachmentMapping
                                    {
                                        Assumptions = item,
                                        AttachamentMaster = newAttachment
                                    };

                                uow.TenantContext.GenericAssumptionAttachmentMapping.Add(newMapping);
                                }

                                assumptions.Remove(MatchedAssumption);
                            }
                        }
                    }

                    //insert the rest
                    GenericAssumptions newOrExistingAssumption = null;
                    foreach (var assumption in assumptions)
                    {
                        newOrExistingAssumption = new GenericAssumptions
                        {
                            PROJECT = assumption.Project,
                            VERSION = assumption.Version,
                            SCENARIO = assumption.Scenario,
                            PRODUCT = assumption.Product,
                            SKU = assumption.SKU,
                            SECTION = assumption.Section,
                            DESCRIPTION = assumption.Description
                        };
                        if (assumption.Attachments != null && assumption.Attachments.Count > 0)
                        {
                            foreach (var att in assumption.Attachments)
                            {
                                AttachamentMaster newOrExistingAttachment = existingAttachments
                                    .Where(ea => String.Compare(ea.Name, att.AttachmentName) == 0
                                              && String.Compare(ea.Path, att.AttachmentPath) == 0)
                                    .FirstOrDefault();

                                if (newOrExistingAttachment == null)
                                {
                                    newOrExistingAttachment = new AttachamentMaster
                                    {
                                        Name = att.AttachmentName,
                                        Path = att.AttachmentPath
                                    };
                                }
                                GenericAssumptionAttachmentMapping newMapping = new GenericAssumptionAttachmentMapping
                                {
                                    Assumptions = newOrExistingAssumption,
                                    AttachamentMaster = newOrExistingAttachment
                                };

                            uow.TenantContext.GenericAssumptionAttachmentMapping.Add(newMapping);
                            }
                        }
                        else
                        uow.TenantContext.GenericAssumptions.Add(newOrExistingAssumption);
                    }

                uow.TenantContext.SaveChanges();
                
            }
            catch(Exception ex)
            {
                throw new Exception("Could not save assumptions");
            }
                    
        }        

        public override List<Assumption> GetAssumptions(string project, string version)
        {
            List<Assumption> assumptions = new List<Assumption>();

            try
            {
                    return uow.TenantContext.GenericAssumptions
                                .Where(ga => String.Compare(ga.PROJECT, project) == 0 && String.Compare(ga.VERSION, version) == 0)
                                .Select(ga => new
                                {
                                    Description = ga.DESCRIPTION,
                                    Product = ga.PRODUCT,
                                    Project = ga.PROJECT,
                                    Scenario = ga.SCENARIO,
                                    Section = ga.SECTION,
                                    SKU = ga.SKU,
                                    Version = ga.VERSION,
                                    Attachments = ga.AssumptionAttachmentMapping
                                                    .Where(aam => aam.AttachamentMaster != null && !String.IsNullOrEmpty(aam.AttachamentMaster.Name) && !String.IsNullOrEmpty(aam.AttachamentMaster.Path))
                                                    .Select(aam => new
                                                    {
                                                        Name = aam.AttachamentMaster.Name,//.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries),
                                                Path = aam.AttachamentMaster.Path//.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries)
                                            })
                                })
                                .ToList()
                                .Select(a => new Assumption
                                {
                                    Description = a.Description,
                                    Product = a.Product,
                                    Project = a.Project,
                                    Scenario = a.Scenario,
                                    Section = a.Section,
                                    SKU = a.Section,
                                    Version = a.Version,
                                    Attachments = a.Attachments
                                                    .Select(aam => new
                                                    {
                                                        Names = aam.Name.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries),
                                                        Paths = aam.Path.Split(new string[] { "||^||" }, StringSplitOptions.RemoveEmptyEntries)
                                                    })
                                                    .SelectMany(att => Enumerable.Range(0, att.Names.Length).ToArray()
                                                                           .Select(index => new Attachment
                                                                           {
                                                                               AttachmentName = att.Names[index],
                                                                               AttachmentPath = att.Paths[index]
                                                                           })
                                                                ).ToList()
                                }).ToList();
                
            }
            catch (Exception ex)
            {

            }

            return assumptions;
        }

        public void AddGenericForecast(TenantModel context, ForecastVersionInputOutput fvio)
        {
            
                        var fv = fvio.fv as GenericForecastVersionDetail;
                        var fio = fvio.fio;
                        var projectName = context.GenericProjectMaster.Where(pm => String.Compare(pm.Name, fv.Name) == 0).SingleOrDefault();
                        if (projectName != null)
                        {
                            throw new Exception("Project name already exists");
                        }

                        //project master
                        GenericProjectMaster project = new GenericProjectMaster
                        {
                            Name = fv.Name
                        };
                        context.GenericProjectMaster.Add(project);
                        context.SaveChanges();
                        //project version details
                        var hdFrom = DateTime.Parse(fv.DataAvailableFrom);
                        var hdTill = DateTime.Parse(fv.DataAvailableTill);
                        var period = (byte)fv.Period;
                        var fdTill = new DateTime(fv.ForecastYearTill, 1, 1);
                        var cat = (byte)fv.Category;
                        var type = (byte)fv.DataType;
                        var projectVersionDetail = context.GenericProjectVersionDetails.
                            Where(pvd => pvd.Category == cat && pvd.DataAvailableFrom == hdFrom && pvd.DataAvailableTill == hdTill && pvd.ForecastPeriod == period
                            && pvd.ForecastTill == fdTill && pvd.Type == type).SingleOrDefault();
                        if (projectVersionDetail == null)
                        {
                            projectVersionDetail = new GenericProjectVersionDetails
                            {
                                DataAvailableFrom = hdFrom,
                                DataAvailableTill = hdTill,
                                ForecastPeriod = period,
                                ForecastTill = fdTill,
                                Category = cat,
                                Type = type
                            };
                            context.GenericProjectVersionDetails.Add(projectVersionDetail);
                            context.SaveChanges();
                        }
                        //project version
                        GenericProjectVersion version = context.GenericProjectVersion.Where(pv => pv.ProjectID == project.ID && String.Compare(pv.VersionLabel, fv.Version) == 0).SingleOrDefault();
                        if (version == null)
                        {
                            version = new GenericProjectVersion
                            {
                                ProjectID = project.ID,
                                ProjectVersionDetailsID = projectVersionDetail.ID,
                                VersionLabel = fv.Version
                            };
                            context.GenericProjectVersion.Add(version);
                            context.SaveChanges();
                        }
                        //scenario master                        
                        var incomingScenarios = fv.Scenarios.ToDictionary(sc => sc.Name, sc => new GenericScenarioMaster { Name = sc.Name });
                        var existingScenarios = context.GenericScenarioMaster.ToDictionary(sm => sm.Name, sm => sm);
                        var newScenarioKeys = incomingScenarios.Keys.Except(existingScenarios.Keys);
                        List<GenericScenarioMaster> newScenarios = new List<GenericScenarioMaster>();
                        foreach (var item in newScenarioKeys)
                        {
                            var sm = incomingScenarios[item];
                            newScenarios.Add(sm);
                            context.GenericScenarioMaster.Add(sm);
                        }
                        context.SaveChanges();
                        //scenario details
                        foreach (var item in newScenarios)
                        {
                            context.GenericScenarioDetails.Add(new GenericScenarioDetails
                            {
                                ProjectVersionID = version.id,
                                ScenarioID = item.ID,
                                ScenarioOrder = fv.Scenarios.Single(sc => String.Compare(sc.Name, item.Name) == 0).Order
                            });
                        }

                        //product master
                        var incomingProducts = fv.ForecastProducts.ToDictionary(p => p.Name, p => new GenericProductMaster { Name = p.Name });
                        var existingProducts = context.GenericProductMaster.ToDictionary(pm => pm.Name, pm => pm);
                        var newProductKeys = incomingProducts.Keys.Except(existingProducts.Keys);
                        List<GenericProductMaster> newProducts = new List<GenericProductMaster>();
                        foreach (var item in newProductKeys)
                        {
                            var pm = incomingProducts[item];
                            newProducts.Add(pm);
                            context.GenericProductMaster.Add(pm);
                        }
                        context.SaveChanges();
                        //product details          
                        List<GenericProductDetails> newProductDetails = new List<GenericProductDetails>();
                        foreach (var item in newProducts)
                        {
                            var prod = fv.ForecastProducts.Single(fp => String.Compare(fp.Name, item.Name) == 0) as GenericProduct;
                            var prodDetail = new GenericProductDetails
                            {
                                Brand = (byte)prod.Brand,
                                Projection = (byte)prod.Projection,
                                TrendingType = (byte)prod.TrendingType,
                                Type = prod.Type == ProductType.Pipeline ? true : false
                            };
                            context.GenericProductDetails.Add(prodDetail);
                            newProductDetails.Add(prodDetail);
                        }
                        context.SaveChanges();
                        //projectversionproduct
                        List<GenericProjectVersionProduct> pvpList = new List<GenericProjectVersionProduct>();
                        for (int i = 0; i < newProductDetails.Count; i++)
                        {
                            pvpList.Add(new GenericProjectVersionProduct
                            {
                                ProductDetailsID = newProductDetails[i].ID,
                                ProductID = newProducts[i].ID,
                                ProjectVersionID = version.id,
                                ProductOrder = fv.ForecastProducts.Where(fp => String.Compare(fp.Name, newProducts[i].Name) == 0).Single().Order
                            });
                        }
                        context.GenericProjectVersionProduct.AddRange(pvpList);
                        context.SaveChanges();

                        //sku master
                        List<GenericSKU_Master> skuList = new List<GenericSKU_Master>();
                        foreach (var fp in fv.ForecastProducts)
                        {
                            var product = fp as GenericProduct;
                            foreach (var item in product.SKUs)
                            {
                                GenericSKU_Master sku = new GenericSKU_Master { Name = item.Name };
                                skuList.Add(sku);
                            }
                        }
                        context.GenericSKU_Master.AddRange(skuList);
                        context.SaveChanges();

                        //sku details
                        List<GenericSKU_Details> skuDetailsList = new List<GenericSKU_Details>();
                        for (int i = 0; i < fv.ForecastProducts.Count; i++)
                        {
                            var fp = fv.ForecastProducts[i] as GenericProduct;
                            for (int j = 0; j < fp.SKUs.Count; j++)
                            {
                                GenericSKU_Details sd = new GenericSKU_Details();
                                sd.SKU_ID = skuList.Where(sku => String.Compare(sku.Name, fp.SKUs[j].Name) == 0).Select(sku => sku.ID).SingleOrDefault();
                                var productId = newProducts.Where(p => String.Compare(fv.ForecastProducts[i].Name, p.Name) == 0).Select(p => p.ID).Single();
                                sd.ProjectVersionProductID = pvpList[i].ID;
                                skuDetailsList.Add(sd);
                            }
                        }
                        context.GenericSKU_Details.AddRange(skuDetailsList);
                        context.SaveChanges();

                        //historical data

                        
                
            
        }

        public GenericForecastVersionInputOutput GetGenericForecastData(string projectName, string versionLabel)
        {
            ForecastVersionDetail forecastVersionDetails = null;
            GenericForecastIO forecastIO = new GenericForecastIO();
            int firstProductId = 0, firstSKUId = 0, firstScenarioId = 0;
                try
                {
                    forecastVersionDetails = GetGenericsForecastVersionDetail(uow.TenantContext, projectName, versionLabel, ref firstProductId, ref firstSKUId, ref firstScenarioId);
                    forecastIO = GetForecastInputOutput(uow.TenantContext, forecastVersionDetails, firstProductId, firstSKUId, firstScenarioId);
                }
                catch (Exception ex)
                {

                }
            

            return new GenericForecastVersionInputOutput
            {
                fv = forecastVersionDetails,
                fio = forecastIO
            };
        }

        public ForecastVersionDetail GetGenericsForecastVersionDetail(TenantModel context, string projectName, string versionLabel,
            ref int firstProductId, ref int firstSKUId, ref int firstScenarioId)
        {
            ForecastVersionDetail forecastVersionDetails = null;
            GenericForecastIO forecastIO = new GenericForecastIO();
            string firstProduct = null, firstSKU = null, firstScenario = null;

            var projectVersionDetails = context.GenericProjectVersion
                        .Where(v => String.Compare(v.ProjectMaster.Name, projectName) == 0 && String.Compare(v.VersionLabel, versionLabel) == 0)
                        .Include(v => v.ProjectVersionDetails)
                        .Include(v => v.ScenarioDetails)
                        .Include(v => v.ScenarioDetails.Select(s => s.ScenarioMaster))
                        .Include(v => v.ProjectVersionProduct)
                        .Include(v => v.ProjectVersionProduct.Select(pvp => pvp.ProductDetails))
                        .Include(v => v.ProjectVersionProduct.Select(pvp => pvp.ProductMaster))
                        .SingleOrDefault();
            forecastVersionDetails = new GenericForecastVersionDetail
            {
                Category = (ForecastCategory)projectVersionDetails.ProjectVersionDetails.Category,
                DataAvailableFrom = projectVersionDetails.ProjectVersionDetails.DataAvailableFrom.ToString(@"MM\/dd\/yyyy"),
                DataAvailableTill = projectVersionDetails.ProjectVersionDetails.DataAvailableTill.ToString(@"MM\/dd\/yyyy"),
                DataType = (ForecastDataType)projectVersionDetails.ProjectVersionDetails.Type,
                ForecastYearTill = projectVersionDetails.ProjectVersionDetails.ForecastTill.Year,
                Name = projectName,
                Period = (ForecastPeriod)projectVersionDetails.ProjectVersionDetails.ForecastPeriod,
                Version = versionLabel,
                ForecastProducts = new List<ForecastProduct>(),
                Scenarios = new List<ForecastScenario>()
            };
            forecastVersionDetails.HistoricalTimeStep = GetTimeStep(projectVersionDetails.ProjectVersionDetails.DataAvailableTill, forecastVersionDetails);
            forecastVersionDetails.TotalTimeStep = GetTimeStep(projectVersionDetails.ProjectVersionDetails.ForecastTill, forecastVersionDetails);

            var orderedScenarios = projectVersionDetails.ScenarioDetails.OrderBy(sc => sc.ScenarioOrder);
            foreach (var item in orderedScenarios)
            {
                var scenario = new ForecastScenario
                {
                    Id = item.ScenarioMaster.ID,
                    Name = item.ScenarioMaster.Name,
                    Order = item.ScenarioOrder
                };
                if (firstScenarioId == 0)
                {
                    firstScenarioId = item.ScenarioMaster.ID;
                    firstScenario = scenario.Name;
                }
                forecastVersionDetails.Scenarios.Add(scenario);
            }
            var orderedProducts = projectVersionDetails.ProjectVersionProduct.OrderBy(pvp => pvp.ProductOrder);
            foreach (var pvp in orderedProducts)
            {
                var prod = new GenericProduct
                {
                    UniqueId = pvp.ID,
                    Brand = (ProductBrand)pvp.ProductDetails.Brand,
                    IsSKULevel = pvp.ProductDetails.EnableSKU.HasValue ? pvp.ProductDetails.EnableSKU.Value : false,
                    Name = pvp.ProductMaster.Name,
                    Order = pvp.ProductOrder,
                    Projection = (ForecastProjectionType)pvp.ProductDetails.Projection,
                    TrendingType = pvp.ProductDetails.TrendingType.HasValue ? (ForecastTrendingType)pvp.ProductDetails.TrendingType.Value : ForecastTrendingType.None,
                    Type = pvp.ProductDetails.Type ? ProductType.Pipeline : ProductType.Inline,
                    SKUs = new List<ForecastSKU>()
                };

                if (firstProductId == 0)
                {
                    firstProductId = pvp.ID;
                    firstProduct = prod.Name;
                }

                var orderedSKUs = pvp.SKU_Details.OrderBy(sku => sku.SKU_Order);
                foreach (var skuDetail in orderedSKUs)
                {
                    var sku = new ForecastSKU
                    {
                        Id = skuDetail.SKU_Master.ID,
                        Name = skuDetail.SKU_Master.Name,
                        Order = skuDetail.SKU_Order
                    };

                    if (firstSKUId == 0)
                    {
                        firstSKUId = skuDetail.SKU_Master.ID;
                        firstSKU = sku.Name;
                    }

                    prod.SKUs.Add(sku);
                }

                forecastVersionDetails.ForecastProducts.Add(prod);
            }

            return forecastVersionDetails;
        }

        public GenericForecastIO GetForecastInputOutput(ForecastVersionDetail forecastVersionDetails, int productId, int skuId, int scenarioId)
        {
            GenericForecastIO fioResult = null;
            
                try
                {
                    fioResult = GetForecastInputOutput(uow.TenantContext, forecastVersionDetails, productId, skuId, scenarioId);
                }
                catch (Exception ex)
                {

                }
            

            return fioResult;
        }

        private GenericForecastIO GetForecastInputOutput(TenantModel context, ForecastVersionDetail forecastVersionDetails,
            int productId, int skuId, int scenarioId)
        {
            List<ForecastCompetitor> competitorList = new List<ForecastCompetitor>();
            List<ForecastPack> packList = new List<ForecastPack>();
            List<GenericHistoricalTransaction> htList = new List<GenericHistoricalTransaction>();
            List<GenericForecastTransaction> ftList = new List<GenericForecastTransaction>();
            List<ForecastEventSection> edList = new List<ForecastEventSection>();
            List<GenericPackTransaction> ptList = new List<GenericPackTransaction>();
            ProductPenetration productPenetration = new ProductPenetration();
            string projectName = forecastVersionDetails.Name;
            string versionLabel = forecastVersionDetails.Version;

            var hdData = context.GenericProjectVersion
                        .Where(v => String.Compare(v.ProjectMaster.Name, projectName) == 0 && String.Compare(v.VersionLabel, versionLabel) == 0)
                        .SelectMany(pv => pv.HistoricalData)
                        .Where(hd => hd.ProjectVersionProductID == productId && hd.SKU_ID == skuId && hd.ScenarioID == scenarioId)
                        .Select(hd => new
                        {
                            Parameter = new ForecastParameter
                            {
                                Name = hd.ParameterMaster.Name,
                                StartRow = hd.ParameterMaster.StartRow,
                                StartColumn = hd.ParameterMaster.StartColumn,
                                Scope = (ForecastParameterScope)(hd.ParameterMaster.Scope ?? 0)
                            },
                            Competitor = hd.CompetitorMaster.Name,
                            CompetitorOrder = hd.CompetitorMaster.CompetitorDetails.Where(cd => cd.ProjectVersionProductID == productId && cd.SKU_ID == skuId && cd.ScenarioID == scenarioId).Select(cd => cd.CompetitorOrder).FirstOrDefault(),
                            Date = hd.HistoricalDate,
                            Data = hd.HistoricalValue.HasValue ? hd.HistoricalValue.ToString() : null
                        })
                        .OrderBy(hd => hd.Parameter.StartRow)
                        .OrderBy(hd => hd.Date)
                        .OrderBy(hd => hd.CompetitorOrder)
                        .Future();
            var fdData = context.GenericProjectVersion
                .Where(v => String.Compare(v.ProjectMaster.Name, projectName) == 0 && String.Compare(v.VersionLabel, versionLabel) == 0)
                .SelectMany(pv => pv.ForecastData)
                .Where(fd => fd.ProjectVersionProductID == productId && fd.SKU_ID == skuId && fd.ScenarioID == scenarioId)
                .Select(fd => new
                {
                    Parameter = new ForecastParameter
                    {
                        Name = fd.ParameterMaster.Name,
                        StartRow = fd.ParameterMaster.StartRow,
                        StartColumn = fd.ParameterMaster.StartColumn
                    },
                    Date = fd.ForecastDate,
                    Data = fd.ForecastValue.HasValue ? fd.ForecastValue.ToString() : null
                })
                .OrderBy(fd => fd.Parameter.StartRow)
                .OrderBy(fd => fd.Date)
                .Future();
            var eventData = context.GenericEvent
                .Where(e => e.ProjectVersionProductID == productId && e.SKU_ID == skuId && e.ScenarioID == scenarioId)
                .Select(e => new
                {
                    Section = e.Section,
                    Name = e.Name,
                    Order = e.EventOrder,
                    LaunchDate = e.LaunchDate == null ? null : e.LaunchDate.Value.ToString(),
                    MonthsToPeak = e.MonthsToPeak,
                    PeakShare = e.PeakShare,
                    StartShare = e.StartShare,
                    Status = e.Status,
                    UptakeCurve = e.UptakeCurve,
                    ImpactType = e.ImpactType.HasValue ? (e.ImpactType.Value ? ForecastEventImpactType.Positive : ForecastEventImpactType.Negative) : ForecastEventImpactType.None
                })
                .OrderBy(e => e.Section)
                .OrderBy(e => e.Order)
                .Future();
            var penetrationData = context.GenericProjectVersion
                .Where(v => String.Compare(v.ProjectMaster.Name, projectName) == 0 && String.Compare(v.VersionLabel, versionLabel) == 0)
                .SelectMany(pv => pv.PenetrationTypeData)
                .Where(pd => pd.ProjectVersionProductID == productId && pd.SKU_ID == skuId && pd.ScenarioId == scenarioId)
                .Select(pd => new
                {
                    Type = pd.PenetrationType,
                    LaunchPriceSelection = pd.LaunchPriceSelection,
                    PriceBasedOn = pd.PriceBasedOn,
                    SelectedTrend = pd.SelectedTrend,
                    StartMonth1 = pd.StartMonth1,
                    StartMonth2 = pd.StartMonth2,
                    TrendType = pd.TrendType,
                    Date = pd.PenetrationDate,
                    Data = pd.PenetrationValue.HasValue ? pd.PenetrationValue.ToString() : null
                })
                .OrderBy(pd => pd.Date)
                .Future();
            //var packData = context.GenericProjectVersion
            //    .Where(v => String.Compare(v.ProjectMaster.Name, projectName) == 0 && String.Compare(v.VersionLabel, versionLabel) == 0)
            //    .SelectMany(pv => pv.PackInfo)
            //    .Where(pd => pd.ProjectVersionProductID == productId && pd.SKU_ID == skuId && pd.ScenarioID == scenarioId)
            //    .Select(pd => new
            //    {
            //        Parameter = new ForecastParameter
            //        {
            //            Name = pd.ParameterMaster.Name,
            //            StartRow = pd.ParameterMaster.StartRow,
            //            StartColumn = pd.ParameterMaster.StartColumn
            //        },
            //        Competitor = pd.PackMaster.Name,
            //        Date = pd.PackDate,
            //        Data = pd.PackValue.HasValue ? pd.PackValue.ToString() : null
            //    })
            //    .OrderBy(pd => pd.Parameter.StartRow)
            //    .OrderBy(pd => pd.Date)
            //    .Future();
            var hdDataList = hdData == null ? null : hdData.ToList();
            var fdDataList = fdData == null ? null : fdData.ToList();
            var eventDataList = eventData == null ? null : eventData.ToList();
            //var packDataList = packData == null ? null : packData.ToList();
            var penetrationDataList = penetrationData == null ? null : penetrationData.ToList();
            Dictionary<string, GenericHistoricalTransaction> dict1 = new Dictionary<string, GenericHistoricalTransaction>();
            Dictionary<string, Dictionary<string, CompetitorTransaction>> dict2 = new Dictionary<string, Dictionary<string, CompetitorTransaction>>();
            foreach (var item in hdDataList)
            {
                GenericHistoricalTransaction hdt = null;
                Dictionary<string, CompetitorTransaction> tempDict = null;
                if (!dict1.ContainsKey(item.Parameter.Name))
                {
                    hdt = new GenericHistoricalTransaction { Parameter = item.Parameter };
                    dict1.Add(item.Parameter.Name, hdt);
                    tempDict = new Dictionary<string, CompetitorTransaction>();
                    dict2.Add(item.Parameter.Name, tempDict);
                    htList.Add(hdt);
                }
                else
                {
                    hdt = dict1[item.Parameter.Name];
                    tempDict = dict2[item.Parameter.Name];
                }
                CompetitorTransaction rbt = null;
                if (!tempDict.ContainsKey(item.Competitor))
                {
                    rbt = new CompetitorTransaction { Competitor = item.Competitor };
                    tempDict.Add(item.Competitor, rbt);
                    hdt.Transactions.Add(rbt);
                    competitorList.Add(new ForecastCompetitor { Name = item.Competitor, Order = item.CompetitorOrder });
                }
                else
                    rbt = tempDict[item.Competitor];
                if (rbt.DataStartFrom == -1)
                    rbt.DataStartFrom = GetTimeStep(item.Date, forecastVersionDetails);
                rbt.Transactions.Add(item.Data);
            }

            FilterGenericHistoricalDataBasedOnCompetitorsExistence(htList);  
                      

            Dictionary<string, GenericForecastTransaction> dict3 = new Dictionary<string, GenericForecastTransaction>();
            foreach (var item in fdDataList)
            {
                GenericForecastTransaction fdt = null;
                if (!dict3.ContainsKey(item.Parameter.Name))
                {
                    fdt = new GenericForecastTransaction { Parameter = item.Parameter };
                    dict3.Add(item.Parameter.Name, fdt);
                    ftList.Add(fdt);
                }
                else
                    fdt = dict3[item.Parameter.Name];
                if (fdt.DataStartFrom == -1)
                    fdt.DataStartFrom = GetTimeStep(item.Date, forecastVersionDetails);
                fdt.Transactions.Add(item.Data);
            }

            Dictionary<int, ForecastEventSection> dict6 = new Dictionary<int, ForecastEventSection>();
            foreach (var item in eventDataList)
            {
                if (!dict6.ContainsKey(item.Section))
                    dict6.Add(item.Section, new ForecastEventSection { Section = item.Section });
                var forecastEventSection = dict6[item.Section];
                ForecastEvent forecastEvent = new ForecastEvent
                {
                    ImpactType = item.ImpactType,
                    MonthsToPeak = item.MonthsToPeak,
                    LaunchDate = item.LaunchDate,
                    Name = item.Name,
                    Order = item.Order,
                    PeakShare = item.PeakShare,
                    StartShare = item.StartShare,
                    Status = item.Status,
                    UptakeCurve = item.UptakeCurve
                };
                forecastEventSection.Events.Add(forecastEvent);
            }
            edList = dict6.Values.ToList();

            //Dictionary<string, PackTransaction> dict4 = new Dictionary<string, PackTransaction>();
            //Dictionary<string, Dictionary<string, CompetitorTransaction>> dict5 = new Dictionary<string, Dictionary<string, CompetitorTransaction>>();
            //foreach (var item in packDataList)
            //{
            //    PackTransaction pt = null;
            //    Dictionary<string, CompetitorTransaction> tempDict = null;
            //    if (!dict4.ContainsKey(item.Parameter.Name))
            //    {
            //        pt = new PackTransaction { Parameter = item.Parameter };
            //        dict4.Add(item.Parameter.Name, pt);
            //        tempDict = new Dictionary<string, CompetitorTransaction>();
            //        dict5.Add(item.Parameter.Name, tempDict);
            //        ptList.Add(pt);
            //    }
            //    else
            //    {
            //        pt = dict4[item.Parameter.Name];
            //        tempDict = dict5[item.Parameter.Name];
            //    }
            //    CompetitorTransaction rbt = null;
            //    if (!tempDict.ContainsKey(item.Competitor))
            //    {
            //        rbt = new CompetitorTransaction { Competitor = item.Competitor };
            //        tempDict.Add(item.Competitor, rbt);
            //        pt.Transactions.Add(rbt);
            //        packList.Add(new ForecastPack { Name = item.Competitor });
            //    }
            //    else
            //        rbt = tempDict[item.Competitor];
            //    if (rbt.DataStartFrom == -1)
            //        rbt.DataStartFrom = GetTimeStep(item.Date, forecastVersionDetails);
            //    rbt.Transactions.Add(item.Data);
            //}

            if (penetrationDataList != null && penetrationDataList.Count > 0)
                {
            productPenetration = new ProductPenetration
            {
                LaunchPriceSelection = penetrationDataList[0].LaunchPriceSelection,
                PriceBasedOn = penetrationDataList[0].PriceBasedOn,
                StartMonth1 = penetrationDataList[0].StartMonth1,
                StartMonth2 = penetrationDataList[0].StartMonth2,
                TrendType = penetrationDataList[0].TrendType,
                Type = penetrationDataList[0].Type.HasValue ? (PenetrationType)penetrationDataList[0].Type.Value : PenetrationType.Calculated,
                DataStartFrom = GetTimeStep(penetrationDataList[0].Date, forecastVersionDetails)
            };
            foreach (var item in penetrationDataList)
            {
                productPenetration.Transactions.Add(item.Data);
            }
            }

            return new GenericForecastIO
            {
                Competitors = competitorList.Distinct(new CompetitorComparer()).OrderBy(c => c.Order).ToList(),
                Packs = packList.Distinct(new PackComparer()).ToList(),
                EventSections = edList,
                ForecastData = ftList,
                HistoricalData = htList,
                PackData = ptList,
                Penetration = productPenetration
            };
        }

        private void FilterGenericHistoricalDataBasedOnCompetitorsExistence(List<GenericHistoricalTransaction> htList)
        {
            bool hasCompetitors1 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Market TRx", true) == 0)
                .Any(ht => ht.Transactions.Any(hd => !IsGenericTotal(hd.Competitor)));
            var htList1 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Market TRx", true) == 0)
                                .SelectMany(ht => ht.Transactions
                                .Where(hd => !hasCompetitors1 || (hasCompetitors1 && !IsGenericTotal(hd.Competitor))))
                                .ToList();

            bool hasCompetitors2 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Conversion Factor", true) == 0)
                .Any(ht => ht.Transactions.Any(hd => !IsGenericTotal(hd.Competitor)));
            var htList2 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Conversion Factor", true) == 0)
                                .SelectMany(ht => ht.Transactions)
                                .Where(hd => !hasCompetitors2 || (hasCompetitors2 && !IsGenericTotal(hd.Competitor)))
                                .ToList();

            bool hasCompetitors3 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Market Units", true) == 0)
                .Any(ht => ht.Transactions.Any(hd => !IsGenericTotal(hd.Competitor)));
            var htList3 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Market Units", true) == 0)
                                .SelectMany(ht => ht.Transactions)
                                .Where(hd => !hasCompetitors3 || (hasCompetitors3 && !IsGenericTotal(hd.Competitor)))
                                .ToList();

            bool hasCompetitors4 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Market Dollars", true) == 0)
                .Any(ht => ht.Transactions.Any(hd => !IsGenericTotal(hd.Competitor)));
            var htList4 = htList.Where(ht => String.Compare(ht.Parameter.Name, "Market Dollars", true) == 0)
                                .SelectMany(ht => ht.Transactions)
                                .Where(hd => !hasCompetitors4 || (hasCompetitors4 && !IsGenericTotal(hd.Competitor)))
                                .ToList();


            foreach (var ht in htList)
            {
                if (String.Compare(ht.Parameter.Name, "Market TRx", true) == 0)
                    ht.Transactions = htList1;
                if (String.Compare(ht.Parameter.Name, "Conversion Factor", true) == 0)
                    ht.Transactions = htList2;
                if (String.Compare(ht.Parameter.Name, "Market Units", true) == 0)
                    ht.Transactions = htList3;
                if (String.Compare(ht.Parameter.Name, "Market Dollars", true) == 0)
                    ht.Transactions = htList4;
            }
        }

        private bool IsGenericTotal(string competitor)
        {
            return String.Compare("Total Market TRx", competitor, true) == 0
                || String.Compare("Total Market", competitor, true) == 0
                || String.Compare("Total Market Units", competitor, true) == 0
                || String.Compare("Total Market Revenue", competitor, true) == 0;
        }

        private int GetTimeStep(DateTime historicalDate, ForecastVersionDetail forecastVersionDetails)
        {
            int timeStep = 0;
            switch ((ForecastPeriod)forecastVersionDetails.Period)
            {
                case ForecastPeriod.Monthly:
                    timeStep = (historicalDate.Year - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Year) * 12 + (historicalDate.Month - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Month + 1);
                    break;
                case ForecastPeriod.Yearly:
                    timeStep = historicalDate.Year - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Year + 1;
                    break;
                case ForecastPeriod.Quarterly:
                    timeStep = (historicalDate.Year - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Year + 1) * 4 + (historicalDate.Month - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Month + 1) / 3;
                    break;
                default:
                    //default to monthly
                    timeStep = (historicalDate.Year - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Year) * 12 + (historicalDate.Month - Convert.ToDateTime(forecastVersionDetails.DataAvailableFrom).Month + 1);
                    break;
            }

            return timeStep;
        }
        public override string retriveForecast(string projectName, string version, ForecastModelType type, int isFlatFile, bool isTemplate)
        {
            var storageId = "";
            try
            {
                    var spiltVersion = version.Split('.');
                    var projectVersionNullCount = uow.TenantContext.GenericForecastFlatFileMaster
                                        .Where(ftm => String.Compare(ftm.GenericForecastTemplateMaster.ProjectName, projectName, true) == 0 && ftm.MajorVersion == null)
                                        .ToList();

                    projectVersionNullCount.ElementAt(projectVersionNullCount.Count - 1);
                    var item = projectVersionNullCount.ElementAt(projectVersionNullCount.Count - 1);
                    int id = item.ID;
                    int newVersion = Convert.ToInt32(spiltVersion[1]) + 1;

                    var projectVersion = uow.TenantContext.GenericForecastFlatFileMaster
                                        .Where(ftm => String.Compare(ftm.GenericForecastTemplateMaster.ProjectName, projectName, true) == 0 && ftm.MajorVersion == newVersion)
                                        .ToList();
                    var item1 = projectVersion.ElementAt(Convert.ToInt32(spiltVersion[1]));
                    storageId = item1.StorageID;
            }
            catch (Exception ex)
            {

            }
            return storageId;
        }

        public override int SetForecastTemplate(string projectName, string StorageId, string saveAsForecastName, int loggedinUserId)
        {
            int returnValue = -1;
            try
            {
                if ((!String.IsNullOrEmpty(projectName)) && (!String.IsNullOrEmpty(StorageId)))
                {
                    GenericForecastTemplateMaster Ftemplate = null;
                        var existingTemplates = uow.TenantContext.GenericForecastTemplateMaster
                            .Where(ftm => String.Compare(ftm.ProjectName, projectName, true) == 0
                             ).ToList();

                        if (existingTemplates.Count == 0)
                        {

                            Ftemplate = new GenericForecastTemplateMaster()
                            {
                                ProjectName = projectName,
                                TemplateStorageID = StorageId,
                                //DateTime = DateTime.Now
                                DateTime = DateTime.UtcNow
                            };

                        uow.TenantContext.GenericForecastTemplateMaster.Add(Ftemplate);
                        }
                        else
                        {
                            returnValue = 2; 
                        }
                    uow.TenantContext.SaveChanges();
                        returnValue = 1;
                    
                }
            }
            catch (Exception ex)
            {
                returnValue = 0;
            }
            return returnValue;
        }


        public override string SaveForecast(string projectName, string StorageId, int MajorVersion, string Description, out int flatFileId)
        {
            string latestVersion = "";
            flatFileId = 0;
            try
            {
                int MajorVersionindb = 0;
                if ((!String.IsNullOrEmpty(projectName)) && (!String.IsNullOrEmpty(StorageId)))
                {
                    GenericForecastFlatFileMaster Fflatfile = null;
                                        
                        var existingTemplates = uow.TenantContext.GenericForecastTemplateMaster
                            .Where(ftm => String.Compare(ftm.ProjectName, projectName, true) == 0
                             ).ToList();

                        if (existingTemplates.Count >= 1)
                        {
                          var templateId = uow.TenantContext.GenericForecastTemplateMaster
                                                    .Where(f => String.Compare(f.ProjectName, projectName) == 0)
                                                    .Select(f => f.ID)
                                                    .FirstOrDefault();
                          var count = uow.TenantContext.GenericForecastFlatFileMaster
                                          .Where(f => String.Compare(f.GenericForecastTemplateMaster.ProjectName, projectName) == 0)
                                          .Select(f => f.MajorVersion == null)
                                          .Count();
                          var wholeNo = uow.TenantContext.GenericForecastFlatFileMaster
                                        .Where(f => String.Compare(f.GenericForecastTemplateMaster.ProjectName, projectName) == 0)
                                        .Select(f => f.MajorVersion != null)
                                        .Count();
                            if (MajorVersion == 1)
                            {
                                Fflatfile = new GenericForecastFlatFileMaster()
                                {
                                    StorageID = StorageId,
                                    //DateTime = DateTime.Now,
                                    DateTime = DateTime.UtcNow,
                                    MajorVersion = null,
                                    TemplateID = templateId

                                };
                                latestVersion = "V" + (count + 1) + ".0";
                            }
                            else if (MajorVersion == 0)
                            {
                                MajorVersionindb = count + 1;
                                Fflatfile = new GenericForecastFlatFileMaster()
                               {
                                   StorageID = StorageId,
                                    // DateTime = DateTime.Now,
                                    DateTime = DateTime.UtcNow,
                                   MajorVersion = MajorVersionindb,
                                   TemplateID = templateId

                               };

                                latestVersion = ("V" + (count) + "." + wholeNo);
                            }
                        uow.TenantContext.GenericForecastFlatFileMaster.Add(Fflatfile);    
                        }
                    uow.TenantContext.SaveChanges();
                       
                       
                }
            }
            catch (Exception ex)
            {
                
            }
            return latestVersion;
        }

        
        public override List<ActionStatus> SetSectionPreferences(string forecast, string version, string sectionPref)
        {
            throw new NotImplementedException();
        }

        public override List<ForecastSection> GetSectionPreference(string forecast, string version)
        {
            //throw new NotImplementedException();
            {
                List<ForecastSection> sections = new List<ForecastSection>();

                sections.Add(
                    new ForecastSection
                    {
                        Name = "Historical Data",
                        HasAssumption = true,
                        Start = 12,
                        End = 88
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Projections",
                        HasAssumption = true,
                        Start = 89,
                        End = 110
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Penetration",
                        HasAssumption = true,
                        Start = 111,
                        End = 116
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Events",
                        HasAssumption = true,
                        Start = 117,
                        End = 145
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Conversion Parameters",
                        HasAssumption = true,
                        Start = 146,
                        End = 157
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Output",
                        HasAssumption = false,
                        Start = 158,
                        End = 167
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Pack Split",
                        HasAssumption = false,
                        Start = 168,
                        End = 169
                    }
                    );


                return sections;
            }

        }
    }
}
