using EntityFramework.Extensions;
using Newtonsoft.Json.Linq;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace PharmaACE.ForecastApp.Business
{
    public class ReportManager
    {
        private IUnitOfWork uow;

        public ReportManager(IUnitOfWork uow, int roleId = -1, int allFetch = -1)
        {
            this.uow = uow;
            
        }
        public ReportingModel GetReportingModel(ReportModelType type, int userId, int tenantId)
        {
            if (type == ReportModelType.Generic)
                return GetReportingModelForGenericsReport(tenantId, userId);
            else if (type == ReportModelType.BDL)
                return GetReportingModelForBDLReport(tenantId, userId);

            return null;
        }

        private ReportingModel GetReportingModelForGenericsReport(int tenantId, int userId)
        {            
            List<ReportForecast> forecasts = new List<ReportForecast>();
            List<string> reportingParameters = new List<string>();
            List<SaveReportSettings> reportList = new List<SaveReportSettings>();
            List<Dashboard> dashboardList = new List<Dashboard>();
            DateTime minStartDate = default(DateTime), maxEndDate = default(DateTime);

            String connectionString = GenUtil.GetTenantConnectionString(tenantId);
            using (var context = new TenantModel(connectionString))
            {
                try
                {
                    var reportParameters = context.GenericParameterMaster
                        .Where(param => param.Flag.HasValue && param.Flag.Value == true)
                        .Select(param => param.Name)
                        .Future();

                    var projectQueryable = context.GenericUserForecastMapping.AsQueryable();
                    if (userId >= 0)
                    {
                        projectQueryable = projectQueryable.Where(ufm => ufm.ShareWithID == userId);
                        var shareAllProjects = projectQueryable
                            .Where(ufm => String.IsNullOrEmpty(ufm.Version))
                            .SelectMany(ufm => context.GenericUserForecastMapping
                                          .Where(u => String.Compare(u.ProjectName, ufm.ProjectName) == 0 && u.Authorization == 1));
                        var shareVersionProjects = projectQueryable
                            .Where(ufm => !String.IsNullOrEmpty(ufm.Version))
                            .Select(ufm => context.GenericUserForecastMapping
                                          .FirstOrDefault(u => String.Compare(u.ProjectName, ufm.ProjectName) == 0 && String.Compare(u.Version, ufm.Version) == 0 && u.Authorization == 1));

                        projectQueryable = shareAllProjects.Union(shareVersionProjects);
                    }
                    else
                        projectQueryable = projectQueryable.Where(ufm => ufm.Authorization == 1);

                    var projectVersionDetails = projectQueryable
                        .GroupBy(ufm => ufm.ProjectName)
                        //.Select(g => g.GroupBy(gg => gg.Version).First())
                        .Select(g => new
                        {
                            Name = g.Key,
                            Versions = g.SelectMany(o => context.GenericProjectVersion
                                                .Where(pv => String.Compare(pv.ProjectMaster.Name, g.Key) == 0 && String.Compare(pv.VersionLabel, o.Version) == 0)
                                                .Select(pv => new { ProjectVersion = pv, CreationDate = o.CreationDate }))
                                        .OrderByDescending(o => o.CreationDate)
                                        .Select(o => new //ReportForecastVersion
                                        {
                                            Label = o.ProjectVersion.VersionLabel,
                                            Scenarios = o.ProjectVersion.ScenarioDetails.Select(sd => sd.ScenarioMaster.Name),
                                            Products = o.ProjectVersion.ProjectVersionProduct.Select(pvp => new //GenericReportProduct
                                            {
                                                Name = pvp.ProductMaster.Name,
                                                SKUs = pvp.SKU_Details.Select(sku => sku.SKU_Master.Name)
                                            }),
                                            //In the code below without the DateTime nullability check we get the following error: "The cast to value type 
                                            //'System.DateTime' failed because the materialized value is null. Either the result type's generic parameter 
                                            //or the query must use a nullable type"
                                            //Probably because we do a join and EF expects that some values can be null and it throws an error as a precaution. 
                                            //It only throws an error at the DateTime datatype because it knows what to do when the other properties are null 
                                            //(strings and nullable types).
                                            StartDate = (DateTime?)o.ProjectVersion.ProjectVersionDetails.DataAvailableFrom ?? default(DateTime),
                                            EndDate = (DateTime?)o.ProjectVersion.ProjectVersionDetails.ForecastTill ?? default(DateTime)
                                        })
                        })
                        .Future();

                    var reportListQueryable = GetReportInformation(context, userId, ReportModelType.Generic).Future();

                    var dashboardListQueryable = GetDashboardList(context, userId, ReportModelType.Generic).Future();

                    reportingParameters = reportParameters.ToList();

                    reportList = reportListQueryable.ToList()
                        .Select(r => new SaveReportSettings
                        {
                            ReportId = r.ReportId,
                            ReportName = r.ReportName,
                            ReportSettings = new JavaScriptSerializer().Deserialize<DistinctReportSettings>(r.ReportSettings)
                        })
                        .ToList();

                    dashboardList = dashboardListQueryable.ToList();

                    forecasts = projectVersionDetails.Select(pvd => new ReportForecast
                    {
                        Name = pvd.Name,
                        Versions = pvd.Versions
                        .Select(pvdv => new ReportForecastVersion
                        {
                            Label = pvdv.Label,
                            Scenarios = pvdv.Scenarios.ToList(),
                            Products = pvdv.Products.Select(pvdvp => new GenericReportProduct
                            {
                                Name = pvdvp.Name,
                                SKUs = pvdvp.SKUs.ToList()
                            } as ReportProduct).ToList()
                        }).ToList()
                    }).ToList();

                    minStartDate = projectVersionDetails.SelectMany(pvd => pvd.Versions.Where(v => v.StartDate > default(DateTime)).Select(v => v.StartDate)).Min();
                    maxEndDate = projectVersionDetails.SelectMany(pvd => pvd.Versions.Where(v => v.EndDate > default(DateTime)).Select(v => v.EndDate)).Max();
                 
                }
                catch (Exception ex)
                {

                }
            }

            return new ReportingModel
            {
                ReportType = ReportModelType.Generic,
                reportAxes = new ReportForecasts { Forecasts = forecasts, MinStartDate = minStartDate.ToString(), MaxEndDate = maxEndDate.ToString() },
                parameterList = reportingParameters,
                reportList = reportList,
                dashboardList = dashboardList
            };
        }

        private ReportingModel GetReportingModelForBDLReport(int tenantId, int userId)
        {
            string connectionString = GenUtil.GetTenantConnectionString(tenantId);
            List<ReportForecast> forecasts = new List<ReportForecast>();
            List<string> reportingParameters = new List<string>();
            List<SaveReportSettings> reportList = new List<SaveReportSettings>();
            List<Dashboard> dashboardList = new List<Dashboard>();
            DateTime minStartDate = default(DateTime), maxEndDate = default(DateTime);
            List<string> countrys = new List<string>();

            using (var context = new TenantModel(connectionString))
            {
                try
                {
                    var reportParameters = context.BDLParameterMaster
                        .Where(param => param.Flag.HasValue && param.Flag.Value == true)
                        .Select(param => param.Parameter)
                        .Future();

                    var projectQueryable = context.BDLUserForecastMapping.AsQueryable();
                    if (userId >= 0)
                    {
                        projectQueryable = projectQueryable.Where(ufm => ufm.ShareWithId == userId);
                        var shareAllProjects = projectQueryable
                            .Where(ufm => String.IsNullOrEmpty(ufm.Version))
                            .SelectMany(ufm => context.BDLUserForecastMapping
                                          .Where(u => String.Compare(u.ProjectName, ufm.ProjectName) == 0 && u.Authorization == 1));
                        var shareVersionProjects = projectQueryable
                            .Where(ufm => !String.IsNullOrEmpty(ufm.Version))
                            .Select(ufm => context.BDLUserForecastMapping
                                          .FirstOrDefault(u => String.Compare(u.ProjectName, ufm.ProjectName) == 0 && String.Compare(u.Version, ufm.Version) == 0 && u.Authorization == 1));

                        projectQueryable = shareAllProjects.Union(shareVersionProjects);
                    }
                    else
                        projectQueryable = projectQueryable.Where(ufm => ufm.Authorization == 1);

                    var projectVersionDetails = projectQueryable
                        .GroupBy(ufm => ufm.ProjectName)
                        //.Select(g => g.GroupBy(gg => gg.Version).First())
                        .Select(g => new
                        {
                            Name = g.Key,
                            Versions = g.SelectMany(o => context.BDLProjectVersion
                                                .Where(pv => String.Compare(pv.ProjectMaster.Name, g.Key) == 0 && String.Compare(pv.VersionLabel, o.Version) == 0)
                                                .Select(pv => new { ProjectVersion = pv, CreationDate = o.CreationDate }))
                                        .OrderByDescending(o => o.CreationDate)
                                        .Select(o => new //ReportForecastVersionz
                                        {
                                            Label = o.ProjectVersion.VersionLabel,
                                            Scenarios = o.ProjectVersion.ScenarioDetails.Select(sd => sd.ScenarioMaster.Scenario),
                                            //Scenarios = o.ProjectVersion.ParameterSelectionType.Select(sd => sd.ScenarioMaster.Scenario).Distinct(),
                                            Products = o.ProjectVersion.ProjectVersionProduct.Select(pvp => new //GenericReportProduct
                                            {
                                                Name = pvp.ProductDetail.ProductMaster.Name,
                                                Segments = pvp.ProjectVersion.SegmentVersion.Select(sv => sv.SegmentMaster.Name)
                                            }),
                                            Countrys = o.ProjectVersion.ParameterSelectionType.Select(pst => pst.CountryMaster.Country),
                                            //In the code below without the DateTime nullability check we get the following error: "The cast to value type 
                                            //'System.DateTime' failed because the materialized value is null. Either the result type's generic parameter 
                                            //or the query must use a nullable type"
                                            //Probably because we do a join and EF expects that some values can be null and it throws an error as a precaution. 
                                            //It only throws an error at the DateTime datatype because it knows what to do when the other properties are null 
                                            //(strings and nullable types).
                                            StartDate = (DateTime?)o.ProjectVersion.ProjectDetails.ForecastStart ?? default(DateTime),
                                            EndDate = (DateTime?)o.ProjectVersion.ProjectDetails.ForecastEnd ?? default(DateTime)
                                        })
                        })
                        .Future();

                    reportingParameters = reportParameters.ToList();

                    var reportListQueryable = GetReportInformation(context, userId, ReportModelType.BDL).Future();

                    var dashboardListQueryable = GetDashboardList(context, userId, ReportModelType.BDL).Future();


                    reportList = reportListQueryable.ToList()
                       .Select(r => new SaveReportSettings
                       {
                           ReportId = r.ReportId,
                           ReportName = r.ReportName,
                           ReportSettings = new JavaScriptSerializer().Deserialize<DistinctReportSettings>(r.ReportSettings),
                           Type=r.Type
                           
                       })
                       .ToList();

                    dashboardList = dashboardListQueryable.ToList();

                    forecasts = projectVersionDetails.Select(pvd => new ReportForecast
                    {
                        Name = pvd.Name,
                        Versions = pvd.Versions
                        .Select(pvdv => new ReportForecastVersion
                        {
                            Label = pvdv.Label,
                            Scenarios = pvdv.Scenarios.ToList(),
                            Products = pvdv.Products.Select(pvdvp => new BDLReportProduct
                            {
                                Name = pvdvp.Name,
                                Segments = pvdvp.Segments.ToList()
                            } as ReportProduct).ToList()
                        }).ToList()
                    }).ToList();
                    

                    

                    minStartDate = projectVersionDetails.SelectMany(pvd => pvd.Versions.Where(v => v.StartDate > default(DateTime)).Select(v => v.StartDate)).Min();
                    maxEndDate = projectVersionDetails.SelectMany(pvd => pvd.Versions.Where(v => v.EndDate > default(DateTime)).Select(v => v.EndDate)).Max();

                    countrys = projectVersionDetails.SelectMany(pvd => pvd.Versions.SelectMany(pvdv => pvdv.Countrys)).Distinct().ToList();
                   GenUtil.GetReportType();

                }
                catch (Exception ex)
                {

                }
            }

            return new ReportingModel
            {
                ReportType = ReportModelType.BDL,
                reportAxes = new ReportForecasts { Forecasts = forecasts, MinStartDate = minStartDate.ToString(), MaxEndDate = maxEndDate.ToString() },
                parameterList = reportingParameters,
                reportList = reportList,
                dashboardList = dashboardList,
                countrys = countrys
            };
        }

        public List<string> GetDistinctProjectNames()
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
        public int SaveReport(int tenantId, int userId, string configString, string reportName, string reportLink, ReportModelType type, bool overwrite = false)
        {
            int retval = 0;
            ReportMaster report = new ReportMaster();

            try
            {
                using (var masterContext = new MasterModel(GenUtil.MasterModelConnectionString))
                {
                    String connectionString = GenUtil.GetTenantConnectionString(tenantId, masterContext);
                    using (var context = new TenantModel(connectionString))
                    {
                        var existingReport = context.ReportMaster
                            .Where(rm => String.Compare(rm.Name, reportName, true) == 0 && rm.ModuleType == (byte)type)
                            .FirstOrDefault();
                        if (existingReport != null)
                        {
                            if (!overwrite)
                                retval = -1;
                            else {
                                existingReport.ModificationDate = DateTime.Now;
                                existingReport.ReportConfigurationMaster.ConfigurationString = configString;
                                context.SaveChanges();
                                retval = existingReport.Id;
                            }
                        }
                        
                           
                        else
                        {
                            report = new ReportMaster
                            {
                                CreationDate = DateTime.Now,
                                ModificationDate = DateTime.Now,
                                ModuleType = (byte)type,
                                Name = reportName,
                                ReportLink = reportLink,
                                ReportConfigurationMaster = new ReportConfigurationMaster
                                {
                                    ConfigurationString = configString
                                }
                            };
                            ReportUserMapping mapping = new ReportUserMapping
                            {
                                AuthenticationLevel = (byte)AuthenticationLevel.Create,
                                ShareByID = userId,
                                ShareWithId = userId
                            };

                            report.ReportUserMapping.Add(mapping);
                            context.ReportMaster.Add(report);
                            context.SaveChanges();
                            retval = report.Id;
                        }

                        
                        //retval = 1;
                    }
                }
            }
            catch (Exception ex)
            {
                retval = 0;
            }

            return retval;
        }

        public int SaveSharedReportDetails(int reportId, int shareBy, string shareWith, AuthenticationLevel authLevel, int tenantId, ReportModelType type)
        {
            int retval = 0;

            try
            {
                using (var masterContext = new MasterModel(GenUtil.MasterModelConnectionString))
                {
                    String connectionString = GenUtil.GetTenantConnectionStringWithoutDispose(tenantId, masterContext);
                    using (var context = new TenantModel(connectionString))
                    {
                        var reportQueryable = context.ReportMaster
                            .Where(rm => rm.Id == reportId && rm.ModuleType == (byte)type)
                            .Select(rm => rm.Name)
                            .Future();
                        var userQueryable = masterContext.UserMaster
                            .Where(um => um.Id == shareBy)
                            .Select(um => um.FirstName + " " + um.LastName)
                            .Future();
                        string reportName = reportQueryable.SingleOrDefault();
                        string userName = userQueryable.SingleOrDefault();
                        if (String.IsNullOrEmpty(reportName))
                            retval = 2; //report does not exist
                        else if (String.IsNullOrEmpty(userName))
                            retval = 3; //user does not exist
                        else
                        {
                            var sharedWiths = shareWith.Split(new char[',']);
                            foreach (var sharedWith in sharedWiths)
                            {
                                context.ReportUserMapping.Add(new ReportUserMapping
                                {
                                    AuthenticationLevel = (byte)authLevel,
                                    ReportId = reportId,
                                    ShareByID = shareBy,
                                    ShareWithId = sharedWith.SafeToNum()
                                });
                                //context.UserNotifications.Add(new TenantUserNotifications
                                //{
                                //    CreatedDate = DateTime.Now,
                                //    Descriptions = String.Format("{0} has shared report {1} with you", userQueryable.SingleOrDefault(), userName, reportName),
                                //    IsRead = false,
                                //    UserId = sharedWith.SafeToNum(),
                                //    UserKey = Guid.NewGuid().ToString()
                                //});
                            }
                        }

                        context.SaveChanges();
                        retval = 1;
                    }
                }
            }
            catch (Exception ex)
            {
                retval = 0;
            }

            return retval;
        }

        public List<SaveReportSettings> GetReportInformation(int userId, int tenantId, ReportModelType type)
        {
            List<SaveReportSettings> reportList = new List<SaveReportSettings>();
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {

                    var reportListQueryable = GetReportInformation(context, userId, ReportModelType.Generic).Future();
                    reportList = reportListQueryable.ToList()
                        .Select(r => new SaveReportSettings
                        {
                            ReportId = r.ReportId,
                            ReportName = r.ReportName,
                            ReportSettings = new JavaScriptSerializer().Deserialize<DistinctReportSettings>(r.ReportSettings)
                        })
                        .ToList();
                }
            }
            catch (Exception ex)
            {

            }

            return reportList;
        }

        public SaveReportSettings GetReportConfig(int reportId, int tenantId)
        {
            SaveReportSettings reportSetting = null;
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    var reportSettingQueryable = context.ReportMaster
                        .Where(rm => rm.Id == reportId)
                        .Select(rm => new
                        {
                            ReportName = rm.Name,
                            Config = rm.ReportConfigurationMaster.ConfigurationString
                        })
                        .SingleOrDefault();
                    if (reportSettingQueryable != null)
                        reportSetting = new SaveReportSettings
                        {
                            ReportName = reportSettingQueryable.ReportName,
                            ReportSettings = new JavaScriptSerializer().Deserialize<DistinctReportSettings>(reportSettingQueryable.Config.SafeTrim())
                        };
                }
            }
            catch (Exception ex)
            {

            }

            return reportSetting;
        }        

        public int CreateDashboard(int userId, List<int> reportIDs, string dashboardName, int tenantId, ReportModelType type,bool overWriteDash=false)
        {
            int retVal = 0;   
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    var dashId = GetDashboardId(context, dashboardName);
                    if (dashId == 0)
                    {
                        DashboardUserMapping dashboardUserMapping = new DashboardUserMapping
                        {
                            AuthenticationLevel = (int)AuthenticationLevel.Create,
                            ShareById = userId,
                            ShareWithId = userId
                        };
                        dashboardUserMapping.DashboardMaster = new DashboardMaster
                        {
                            Dashboard = dashboardName,
                            ModuleType = (byte)type
                        };
                        context.DashboardUserMapping.Add(dashboardUserMapping);
                        context.SaveChanges();
                        retVal = 3;  //Empty DashBoard created successfully.
                    }
                    else
                    {
                        if (!overWriteDash)
                            retVal = -1;  //DashBoard name already exist.
                        else
                        {
                            ReportDashboardMapping mapping = null;
                            var reportIds = context.ReportDashboardMapping.Where(rdm => rdm.DashboardId == dashId).ToList();

                            foreach (var row in reportIds)
                            {
                                context.ReportDashboardMapping.Remove(row);
                            }
                            context.SaveChanges();
                            foreach (var id in reportIDs)
                            {
                                mapping = new ReportDashboardMapping
                                {
                                    DashboardId=dashId,
                                    ReportId = id,
                                };
                                context.ReportDashboardMapping.Add(mapping);
                            }


                            context.SaveChanges();
                            retVal = 4; //DashBoard overWritten with current data.
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                retVal = 0;
            }

            return retVal;
        }

        public int CreateDashboardWithPinReport(int userId, List<int> reportIDs, string dashboardName, int tenantId, ReportModelType type)
        {
            int retVal = 0;
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    bool ifExists = GetDashboardId(context, dashboardName) > 0;
                    if (!ifExists)
                    {
                        DashboardUserMapping dashboardUserMapping = new DashboardUserMapping
                        {
                            AuthenticationLevel = (int)AuthenticationLevel.Create,
                            ShareById = userId,
                            ShareWithId = userId
                        };
                        dashboardUserMapping.DashboardMaster = new DashboardMaster
                        {
                            Dashboard = dashboardName,
                            ModuleType = (byte)type
                        };
                        context.DashboardUserMapping.Add(dashboardUserMapping);

                        int dashboardId = 0;
                        List<int> existingReportIDs = new List<int>();
                       //GetDashboardReportIDs(context, dashboardName, ref dashboardId, ref existingReportIDs);
                        ReportDashboardMapping mapping = null;
                        reportIDs = reportIDs.Except(existingReportIDs).ToList();
                        foreach (var reportId in reportIDs)
                        {
                            if (dashboardId > 0)
                            {
                                mapping = new ReportDashboardMapping
                                {
                                    DashboardId = dashboardId,
                                    ReportId = reportId
                                };
                            }
                            else
                            {
                                mapping = new ReportDashboardMapping
                                {
                                    //DashboardMaster = new DashboardMaster { Dashboard = dashboardName, ModuleType = (byte)type },
                                    ReportId = reportId
                                };
                            }
                            context.ReportDashboardMapping.Add(mapping);
                        }

                        context.SaveChanges();
                        retVal = 1;  //DashBoard created and report pinned successfully.
                    }
                    else
                        retVal = -1;  //DashBoard name already exist.
                }
            }
            catch (Exception ex)
            {
                retVal = 0;
            }

            return retVal;
        }

        private int GetDashboardId(TenantModel context, string dashboardName)
        {
            return context.DashboardMaster.Where(dm => String.Compare(dm.Dashboard, dashboardName, true) == 0).Select(dm => dm.Id).FirstOrDefault();
        }

        private void GetDashboardReportIDs(TenantModel context, string dashboardName, ref int dashboardId, ref List<int> reportIDs)
        {
            var dashboardAndReportIDs = context.DashboardMaster
                .Where(dm => String.Compare(dm.Dashboard, dashboardName, true) == 0)
                .Select(dm => new { DashboardId = dm.Id, ReportIDs = dm.ReportDashboardMapping.Select(rdm => rdm.ReportId) })
                .FirstOrDefault();
            dashboardId = dashboardAndReportIDs.DashboardId;
            if (dashboardId > 0 && dashboardAndReportIDs.ReportIDs != null)
                reportIDs = dashboardAndReportIDs.ReportIDs.ToList();
        }

        public List<Dashboard> GetDashboardList(int userId, int tenantId, ReportModelType type)
        {
            List<Dashboard> dashboardList = new List<Dashboard>();
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    dashboardList = context.DashboardUserMapping
                        .Where(dum => dum.ShareWithId == userId && dum.DashboardMaster.ModuleType == (byte)type)
                        .Select(dum => new Dashboard
                        {
                            Id = dum.DashboardMaster.Id,
                            Name = dum.DashboardMaster.Dashboard
                        })
                        .ToList();                    
                }
            }
            catch(Exception ex)
            {

            }

            return dashboardList;
        }

        public int PinReportToDashboard(string dashboardName, List<int> reportIDs, int tenantId, ReportModelType type)
        {
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    int dashboardId = 0;
                    List<int> existingReportIDs = new List<int>();
                    GetDashboardReportIDs(context, dashboardName, ref dashboardId, ref existingReportIDs);
                    ReportDashboardMapping mapping = null;
                    reportIDs = reportIDs.Except(existingReportIDs).ToList();
                    foreach (var reportId in reportIDs)
                    {
                        if (dashboardId > 0)
                        {
                            mapping = new ReportDashboardMapping
                            {
                                DashboardId = dashboardId,
                                ReportId = reportId
                            };
                        }
                        else
                        {
                            mapping = new ReportDashboardMapping
                            {
                                DashboardMaster = new DashboardMaster { Dashboard = dashboardName, ModuleType = (byte)type },
                                ReportId = reportId
                            };
                        }
                        context.ReportDashboardMapping.Add(mapping);
                    }

                    context.SaveChanges();
                    return 1;  //Report pinned to DashBoard successfully.
                }
            }
            catch(Exception ex)
            {
                return 0; //Error.
            }
        }

        public List<SaveReportSettings> GetReportsDetailsByDashboardId(int dashboardId, int tenantId)
        {
            List<SaveReportSettings> reportSettingsList = new List<SaveReportSettings>();
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    var reportSettings = context.DashboardMaster
                        .Where(dm => dm.Id == dashboardId)
                        .SelectMany(dm => dm.ReportDashboardMapping
                                        .Select(rdm => new
                                        {
                                            ReportId = rdm.ReportMaster.Id,
                                            ReportName = rdm.ReportMaster.Name,
                                            DashboardName = rdm.DashboardMaster.Dashboard,
                                            Config = rdm.ReportMaster.ReportConfigurationMaster.ConfigurationString
                                        }))
                                        .ToList();

                    reportSettingsList = reportSettings.Select(rsq => new SaveReportSettings
                    {
                        ReportId = rsq.ReportId,
                        ReportName = rsq.ReportName,
                        DashboardName = rsq.DashboardName,
                        ReportSettings = new JavaScriptSerializer().Deserialize<DistinctReportSettings>(rsq.Config)
                    }).ToList();

                }
            }
            catch (Exception ex)
            {

            }
            return reportSettingsList;
        }

        public int RemoveReport(int userId, int reportId, int tenantId)
        {
            int retVal = 0;
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {   
                        //TO DO: check if user has permission to delete report

                        var reportDashboardMappingQueryable = context.ReportDashboardMapping.Where(rdm => rdm.ReportId == reportId).Future();
                        var reportUserMappingQueryable = context.ReportUserMapping.Where(rum => rum.ReportId == reportId).Future();
                        var reportQueryable = context.ReportMaster.Where(rm => rm.Id == reportId).Future();
                        var reportConfigurationQueryable = context.ReportMaster.Where(rm => rm.Id == reportId).Select(rm => rm.ReportConfigurationMaster).Future();

                        var reportDashboardMappingList = reportDashboardMappingQueryable.ToList();
                    using (var dbContextTransaction = context.Database.BeginTransaction())
                    {
                        try
                        {
                            if (reportDashboardMappingList != null && reportDashboardMappingList.Count == 0)
                                context.ReportDashboardMapping.RemoveRange(reportDashboardMappingList);
                            //else report is not part of any dashboard yet
                            var reportUserMappingList = reportUserMappingQueryable.ToList();
                            if (reportUserMappingList != null && reportUserMappingList.Count == 0)
                                context.ReportUserMapping.RemoveRange(reportUserMappingList);
                            //else report is not accessible to any user, not possible. must be some wrong, non-transactional behavior that will raise this scenario
                            var report = reportQueryable.SingleOrDefault();
                            if (report != null)
                                context.ReportMaster.Remove(report);
                            else
                            {
                                retVal = 2; //report does not exist
                                throw new Exception("Report does not exist");
                            }
                            var reportConfiguration = reportConfigurationQueryable.SingleOrDefault();
                            if(reportConfiguration != null)
                                context.ReportConfigurationMaster.Remove(reportConfiguration);
                            else
                            {
                                retVal = 3; //report has not been configured!
                                throw new Exception("Report has not been configured");
                            }

                            context.SaveChanges();
                            dbContextTransaction.Commit();
                            retVal = 1; //success
                        }
                        catch(Exception ex)
                        {
                            dbContextTransaction.Rollback();
                        }                       
                    }                    
                }
            }
            catch(Exception ex)
            {
                retVal = 0;
            }

            return retVal;
        }

        public int RemoveDashboard(int userId, int dashboardId, int tenantId)
        {
            int retVal = 0;
            try
            {
                string connectionString = GenUtil.GetTenantConnectionString(tenantId);
                using (var context = new TenantModel(connectionString))
                {
                    //TO DO: check if user has permission to delete report

                    var reportDashboardMappingQueryable = context.ReportDashboardMapping.Where(rdm => rdm.DashboardId == dashboardId).Future();
                    var dashboardUserMappingQueryable = context.DashboardUserMapping.Where(dum => dum.DashboardId == dashboardId).Future();
                    var dashboardQueryable = context.DashboardMaster.Where(dm => dm.Id == dashboardId).Future();
                    
                    var reportDashboardMappingList = reportDashboardMappingQueryable.ToList();
                    using (var dbContextTransaction = context.Database.BeginTransaction())
                    {
                        try
                        {
                            if (reportDashboardMappingList != null && reportDashboardMappingList.Count == 0)
                                context.ReportDashboardMapping.RemoveRange(reportDashboardMappingList);
                            //else dashboard does not have any report
                            var dashboardUserMappingList = dashboardUserMappingQueryable.ToList();
                            if (dashboardUserMappingList != null && dashboardUserMappingList.Count == 0)
                                context.DashboardUserMapping.RemoveRange(dashboardUserMappingList);
                            //else report is not accessible to any user, not possible. must be some wrong, non-transactional behavior that will raise this scenario
                            var dashboard = dashboardQueryable.SingleOrDefault();
                            if (dashboard != null)
                                context.DashboardMaster.Remove(dashboard);
                            else
                            {
                                retVal = 2; //dashboard does not exist
                                throw new Exception("Dashboard does not exist");
                            }
                            
                            context.SaveChanges();
                            dbContextTransaction.Commit();
                            retVal = 1; //success
                        }
                        catch (Exception ex)
                        {
                            dbContextTransaction.Rollback();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                retVal = 0;
            }

            return retVal;
        }

        public int SaveSharedDashboard(int dashboardId, string shareWith, int shareBy, byte authLevel, int tenantId)
        {
            int retval = -1;
            
                try
                {
                    using (var masterContext = new MasterModel(GenUtil.MasterModelConnectionString))
                    {
                        String connectionString = GenUtil.GetTenantConnectionStringWithoutDispose(tenantId, masterContext);
                        using (var context = new TenantModel(connectionString))
                        {
                            var dashboardQueryable = context.DashboardMaster
                            .Where(dm => dm.Id == dashboardId)
                            .Select(dm => dm.Dashboard)
                            .Future();
                            var userQueryable = masterContext.UserMaster
                            .Where(um => um.Id == shareBy)
                            .Select(um => um.FirstName + " " + um.LastName)
                            .Future();
                            var dashboard = dashboardQueryable.SingleOrDefault();
                        var userName = userQueryable.SingleOrDefault();
                        if (String.IsNullOrEmpty(dashboard))
                            retval = 2; //dashboard does not exist
                        else if (String.IsNullOrEmpty(userName))
                            retval = 3; //user does not exist
                        else
                        {
                            var mappings = shareWith.Split(new char[',']).Select(sw => new DashboardUserMapping
                            {
                                AuthenticationLevel = authLevel,
                                DashboardId = dashboardId,
                                ShareById = shareBy,
                                ShareWithId = sw.SafeToNum()
                            });

                            foreach (var mapping in mappings)
                            {
                                //var userNotification = new TenantUserNotifications
                                //{
                                //    CreatedDate = DateTime.Now,
                                //    Descriptions = String.Format("{0} has shared dashboard {1} with you", userName, dashboard),
                                //    IsRead = false,
                                //    UserId = mapping.ShareWithId,
                                //    UserKey = Guid.NewGuid().ToString()
                                //};
                                context.DashboardUserMapping.Add(mapping);
                                //context.UserNotifications.Add(userNotification);
                            }

                            context.SaveChanges();
                            retval = 1;
                        }
                        }
                    }
                }
                catch (Exception ex)
                {
                    retval = 0;
                }
            
            return retval;
        }

        internal class UnmappedSaveReportSettings
        {
            public string DashboardName { get; set; }
            public string ReportName { get; set; }
            public int ReportId { get; set; }
            public string ReportSettings { get; set; }
            public ReportModelType Type { get; set; }
        }

        private IQueryable<UnmappedSaveReportSettings> GetReportInformation(TenantModel context, int userId, ReportModelType type)
        {
            return context.ReportUserMapping
                .Where(rum => (userId == -1 && rum.AuthenticationLevel == 1 || rum.ShareWithId == userId) && rum.ReportMaster.ModuleType.Value == (byte)type)
                .Select(rum => new UnmappedSaveReportSettings
                {                    
                    ReportId = rum.ReportId,
                    ReportName = rum.ReportMaster.Name,
                    ReportSettings = rum.ReportMaster.ReportConfigurationMaster.ConfigurationString,
                    Type = type
                });
        }

        private IQueryable<Dashboard> GetDashboardList(TenantModel context, int userId, ReportModelType type)
        {
            return context.DashboardUserMapping
                .Where(dum => (userId == -1 && dum.AuthenticationLevel==1|| dum.ShareWithId == userId) && dum.DashboardMaster.ModuleType == (byte)type)
                .Select(dum => new Dashboard
                {
                    Id = dum.DashboardId,
                    Name = dum.DashboardMaster.Dashboard
                });
        }

        public void SendMailForShareReportOrDashboard(string useremail, string Fname, string Lname, string UserFname, string UserLname, string ReportOrDashBoardName, bool shareDashbord)
        {
            StringBuilder sbEmailBody = new StringBuilder();
            sbEmailBody.Append("Hello " + Fname + " " + Lname + "," + "<br/><br/>");
            if (shareDashbord == true)
            {
                sbEmailBody.Append(UserFname + " " + UserLname + " has shared the Dashboard " + "<b>" + ReportOrDashBoardName + "</b>" + " with You.");
            }
            else
            {
                sbEmailBody.Append(UserFname + " " + UserLname + " has shared the Report " + "<b>" + ReportOrDashBoardName + "</b>" + " with You.");
            }
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>Regards,</b>");
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append("<b>"+ GenUtil.GetClientNameForSendingMail()+"</b>");
            GenUtil.SendEmail(ReportOrDashBoardName + " has been shared with you.", sbEmailBody.ToString(), useremail);

        }

        public string GetQlikTicket()
        {
            string data = null;
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://192.168.1.15:8080/Home/TicketRequest");
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    Stream receiveStream = response.GetResponseStream();
                    StreamReader readStream = null;
                    if (response.CharacterSet == null)
                        readStream = new StreamReader(receiveStream);
                    else
                        readStream = new StreamReader(receiveStream, Encoding.GetEncoding(response.CharacterSet));
                    data = readStream.ReadToEnd();
                    response.Close();
                    readStream.Close();
                    dynamic dynData = JObject.Parse(data);
                    return dynData.Ticket;
                }
            }
            catch (Exception ex)
            {

            }

            return String.Empty;
        }
    }
}
