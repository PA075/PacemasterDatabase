using System;
using System.Collections.Generic;
using System.Linq;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using System.Data;
using System.IO;
using System.Web;
using PAFE = PharmaACE.ForecastApp.EntityProvider;
using PharmaACE.ForecastApp.Models;
using System.Data.SqlClient;
using System.Collections;
using System.Text.RegularExpressions;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using System.Text;
using System.Xml;

namespace PharmaACE.ForecastApp.Business
{
    public class UserWorkspace
    {
        private IUnitOfWork uow;
        private int roleId;
        private int allFetch;
        public UserWorkspace(IUnitOfWork uow,int roleId=-1,int allFetch=-1)
        {
            this.uow = uow;
            this.roleId = roleId;
            this.allFetch = allFetch;
        }

        public List<ObjectUserMapping> GetFolderList(int userId)
        {
            List<PAFE.TenantModel.ObjectUserMapping> userFolders = new List<PAFE.TenantModel.ObjectUserMapping>();
            
                try
                {

                    var folderList = uow.TenantContext.ObjectUserMapping.Include("ObjectMaster").Include("ObjUserPermission").Where(s => (s.ShareById == userId || s.ShareWithId == userId)
                                     && s.ObjUserPermission.LastOrDefault().Permission != (byte)ObjectPermission.NoAccess
                    ).ToList();
                    //var list = folderList.Where(u => u.ObjectMaster.Lineage == "3");
                    userFolders = folderList;
                }

                catch (Exception ex)
                {

                }

            

            return userFolders;
        }

        public List<UWObject> GetContentfFolder(int userId, int objectId, string lineage,  bool isProject, string parentIndex = "")
        {
            List<UWObject> UWFileFolder = new List<UWObject>();
            try

            {

                string LineageForFileCount = string.Empty;
                string parentLineage = string.Empty;//=lineage
                if (lineage == "0")
                {
                    parentLineage = Convert.ToString(objectId);
                }
                else
                {
                    parentLineage = lineage;
                }

                if (isProject)
                {

                    var ProjectCreatorList = uow.TenantContext.DealDetails
                                                  .Where(d => d.ObjectMaster.Id == objectId)
                                                  .OrderByDescending(d => d.CreatedDate).FirstOrDefault();

                    if (ProjectCreatorList.BDL_Lead == userId || ProjectCreatorList.Owner == userId || ProjectCreatorList.DealChampion == userId || roleId == 3 || allFetch == 1)
                    {
                        UWFileFolder = fetchFoldersForCreators(objectId, parentLineage, userId, parentIndex);
                    }
                    else
                    {
                        UWFileFolder = fetchFoldersForNormalUsers(objectId, userId, parentLineage, parentIndex);
                    }

                }
                else
                {
                    string[] split = lineage.Split(GenUtil.LINEAGE_SPLITTER);
                    int resultantId = Convert.ToInt32(split[0]);
                    var ProjectCreatorList = uow.TenantContext.DealDetails
                                         .Where(d => d.ObjectMaster.Id == resultantId)
                                         .OrderByDescending(d => d.CreatedDate).FirstOrDefault();


                    if (ProjectCreatorList.BDL_Lead == userId || ProjectCreatorList.Owner == userId || ProjectCreatorList.DealChampion == userId || roleId == 3 || allFetch == 1)
                    {
                        UWFileFolder = fetchFoldersForCreators(objectId, parentLineage, userId, parentIndex);
                    }
                    if (ProjectCreatorList.BDL_Lead != userId && ProjectCreatorList.Owner != userId && ProjectCreatorList.DealChampion != userId && roleId != 3 && allFetch != 1)
                    {
                        UWFileFolder = fetchFoldersForNormalUsers(objectId,  userId, parentLineage, parentIndex);
                    }

                }

            }

            catch (Exception ex)
            {
            }

            return UWFileFolder;


        }

        public List<UWObject> fetchFoldersForCreators(int objectId, string lineage, int userId, string parentIndex = "")
        {
            List<UWObject> UWFolder = new List<UWObject>();
            try
            {
                int IndexCount = 1;

                var DefaultFoldersQueryable = uow.TenantContext.ProjectFolderList.Where(d=>d.Lineage!="0");

                DateTime creationDate = uow.TenantContext.DealDetails.Where(d => d.ObjectMaster.Id == objectId)
                                      .OrderByDescending(d => d.CreatedDate).Select(dd => dd.CreatedDate).FirstOrDefault();
                #region Query
                string suffixedLineage = lineage + GenUtil.LINEAGE_SPLITTER;

                var allFilesQueryable = uow.TenantContext.ObjectMaster.Where(om => om.Type == (int)ObjectType.File
                                        && (om.Lineage.StartsWith(suffixedLineage) || String.Compare(om.Lineage, lineage) == 0));

                var allFoldersQueryable = uow.TenantContext.ObjectMaster.Where(om => om.Type == (int)ObjectType.SubFolder
                                        && (om.Lineage.StartsWith(suffixedLineage) || String.Compare(om.Lineage, lineage) == 0));


                var anonymousObjectList = uow.TenantContext.ObjectMaster
                 .Where(om => om.ParentId == objectId && om.Type == (int)ObjectType.SubFolder)
               .Select(om => new
               {
                   Id = om.Id,
                   Type = om.Type,
                   Size = om.Size,
                   Lineage = om.Lineage,
                   Name = om.Name,
                   Path = om.Path,
                   Details = om.ObjectUserMapping
                   .Select(oum => new
                   {
                       CreationDate = creationDate,
                       Permission =
                        new
                        {
                            Perm = (int)ObjectPermission.FullControl,
                            ModDate = creationDate

                        }
                   }).FirstOrDefault(),
                   FileCount = allFilesQueryable.Count(f => f.Lineage.StartsWith(om.Lineage + "|" + om.Id + "|") || String.Compare(f.Lineage, om.Lineage + "|" + om.Id) == 0),
                   FolderCount = allFoldersQueryable.Count(c => c.ParentId == om.Id),
                   IsDefault = DefaultFoldersQueryable.Any(c => c.Name == om.Name && !om.Lineage.Contains("|"))
               }).ToList();
                #endregion
               
                foreach (var item in anonymousObjectList)
                {

                    ObjectPermission contextMenuDisplayStatus = (ObjectPermission)item.Details.Permission.Perm;
                    string Perm = contextMenuDisplayStatus.ToString();


                    UWObject folders = new UWFolder
                    {
                        ObjectId = item.Id,
                        Name = item.Name,
                        creationDate = item.Details.CreationDate,
                        Desc = string.Empty,
                        Lineage = item.Lineage,
                        Moddate = item.Details.Permission.ModDate,
                        permission = (ObjectPermission)item.Details.Permission.Perm,
                        permString = Perm,
                        Size = (decimal)item.Size,
                        Type = ObjectType.SubFolder,
                        FileCounts = item.FileCount, //contentFileCount(userId, true, item.Id, item.Lineage),
                        FolderCounts = item.FolderCount,  //contentFolderCount(true, item.Id, userId),
                        Index = parentIndex + "." + IndexCount,
                        isDefaultFolder = item.IsDefault

                    };
                    UWFolder.Add(folders);
                    IndexCount = IndexCount + 1;
                }
            }

            catch (Exception)
            { }
            return UWFolder;
        }

        public int contentFileCount(int userId,Boolean isCreator=true,int objectid=1,string lineage="")
        {
            int count = 0;

            if (lineage.Trim()=="0")
            {
                lineage = Convert.ToString( objectid);
            }
            else
            {
                lineage = lineage + GenUtil.LINEAGE_SPLITTER + objectid;
            }
                    
           
            string resultantLineage = lineage + GenUtil.LINEAGE_SPLITTER;

            if (isCreator)
            {
                count = uow.TenantContext.ObjectMaster
              .Where(om => (om.Lineage.StartsWith(resultantLineage) || om.Lineage == lineage)
                                       && om.Type == (int)ObjectType.File)
                                       .Count();
            }
            else if (isCreator==false)
            {

                #region Query
                var anonymousObjectList = uow.TenantContext.ObjectMaster.Where(om => (om.Lineage.StartsWith(resultantLineage)
                                             || om.Lineage == lineage)
                                             && om.Type == (int)ObjectType.File)

                        .Select(om => new
                        {
                            Id = om.Id,
                          
                            Details = om.ObjectUserMapping.Where(p => p.ShareWithId == userId)
                      .Select(oum => new
                      {
                         
                          Permission = oum.ObjUserPermission
                          .OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault()
                      }).FirstOrDefault()
                        }).ToList();
                foreach (var item in anonymousObjectList)
                {
                    if (item.Details !=null && item.Details.Permission!=null)
                    {
                        if (item.Details.Permission.Permission != (int)ObjectPermission.NoAccess)
                        {
                            count = count + 1;
                        }
                    }                    
                }     



                #endregion
            }

            return count;
        }
        public int contentFolderCount(Boolean isCreator=true,int objectId=1,int userId=1)

        {
            int count = 0;

            if (isCreator)
            {
                count = uow.TenantContext.ObjectMaster
                             .Where(om => om.ParentId == objectId && om.Type == (int)ObjectType.SubFolder).Count();
                         
            }

            if (isCreator==false)
            {
               count= uow.TenantContext.ObjectMaster
                 .Where(om => om.ParentId == objectId && om.Type == (int)ObjectType.SubFolder)

               .Select(om => new
               {
                   Details = om.ObjectUserMapping.Where(oum => oum.ShareWithId == userId &&
                   oum.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault()
                                                        .Permission != (byte)ObjectPermission.NoAccess)
                   .Select(oum => new
                   {
                     
                       Permission = oum.ObjUserPermission//.Where(op => op.Permission != (byte)ObjectPermission.NoAccess)
                       .OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault()
                   }).FirstOrDefault()
               }).Count();

            }

            return count;
        }
        public List<UWObject> fetchFoldersForNormalUsers(int objectId, int userId,string lineage, string parentIndex="")
        {
            List<UWObject> UWFolder = new List<UWObject>();
            try
            {
                int IndexCount = 1;

                string suffixedLineage = lineage + GenUtil.LINEAGE_SPLITTER;

                var DefaultFoldersQueryable = uow.TenantContext.ProjectFolderList.Where(d => d.Lineage != "0");

                var allFilesQueryable = uow.TenantContext.ObjectMaster.Where(om => om.Type == (int)ObjectType.File
                                     && (om.Lineage.StartsWith(suffixedLineage) || String.Compare(om.Lineage, lineage) == 0));

                var allFoldersQueryable = uow.TenantContext.ObjectMaster.Where(om => om.Type == (int)ObjectType.SubFolder
                                     && (om.Lineage.StartsWith(suffixedLineage) || String.Compare(om.Lineage, lineage) == 0));



                #region Query
                var anonymousObjectList = uow.TenantContext.ObjectMaster
                  .Where(om => om.ParentId == objectId && om.Type == (int)ObjectType.SubFolder)

                .Select(om => new
                {
                    Id = om.Id,
                    Type = om.Type,
                    Size = om.Size,
                    Lineage = om.Lineage,
                    Name = om.Name,
                    Path = om.Path,
                    Details = om.ObjectUserMapping.Where(oum => oum.ShareWithId == userId &&
                              oum.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault()
                             .Permission != (byte)ObjectPermission.NoAccess)
                    .Select(oum => new
                    {
                        CreationDate = oum.CreationDate,
                        Desc = oum.Description,
                        Permission = oum.ObjUserPermission//.Where(op => op.Permission != (byte)ObjectPermission.NoAccess)
                        .OrderByDescending(oup => oup.ModifiedDate)
                        .Select(oup => new
                        {
                            Perm = oup.Permission,
                            ModDate = oup.ModifiedDate
                        }).FirstOrDefault()
                    }).FirstOrDefault(),
                    FileCount = allFilesQueryable
                                .Where(f => f.ObjectUserMapping.Any(m => m.ObjectId == f.Id && m.ShareWithId == userId &&
                                m.ObjUserPermission.OrderByDescending(
                                oup => oup.ModifiedDate).FirstOrDefault().Permission != (int)ObjectPermission.NoAccess)
                                )
                                .Count(f => (f.Lineage.StartsWith(om.Lineage + "|" + om.Id + "|")
                                || String.Compare(f.Lineage, om.Lineage + "|" + om.Id) == 0)),

                    FolderCount = allFoldersQueryable
                                .Where(f => f.ObjectUserMapping.Any(m => m.ObjectId == f.Id && m.ShareWithId == userId
                                && m.ObjUserPermission.OrderByDescending(
                                oup => oup.ModifiedDate).FirstOrDefault().Permission != (int)ObjectPermission.NoAccess))
                                .Count(f => (f.ParentId == om.Id)),
                    IsDefault = DefaultFoldersQueryable.Any(c => c.Name == om.Name && !om.Lineage.Contains("|"))
                }).ToList();


                #endregion

                foreach (var item in anonymousObjectList)
                {
                   
                    if (item.Details!=null && item.Details.Permission !=null)
                    {

                        ObjectPermission contextMenuDisplayStatus = (ObjectPermission)item.Details.Permission.Perm;
                        string Perm = contextMenuDisplayStatus.ToString();

                        UWObject folders = new UWFolder
                        {

                            ObjectId = item.Id,
                            Name = item.Name,
                            creationDate = item.Details.CreationDate,
                            Desc = string.Empty,
                            Lineage = item.Lineage,
                            Moddate = item.Details.Permission.ModDate,
                            permission = (ObjectPermission)item.Details.Permission.Perm,
                            permString=Perm,
                            Size = (decimal)item.Size,
                            Type = ObjectType.SubFolder,
                            FileCounts =item.FileCount,//contentFileCount(userId, false, item.Id, item.Lineage),
                            FolderCounts = item.FolderCount, //contentFolderCount(false, item.Id, userId),
                            Index = parentIndex + "." + IndexCount,
                            isDefaultFolder=item.IsDefault

                        };
                        UWFolder.Add(folders);
                        IndexCount = IndexCount + 1;

                    }
                }

            }
            catch (Exception e)
            {               
            }


            return UWFolder;
        }


        public List<UWActivityReporting> GetContentFileForReporting(int userId, int objectId, string lineage)
        {

            UWFolder folder = new UWFolder();
            List<UWActivityReporting> UWReporting = new List<UWActivityReporting>();
            List<UWFile> uwfile = new List<UWFile>();
            
                try
                {
                    int type = (int)ObjectType.File;
                    Extension fileExtn;
                    string resultantLineage = lineage + GenUtil.LINEAGE_SPLITTER;
                    var anonymousObjectList = uow.TenantContext.ActivityDetailsMaster.Where(o => o.ObjectMaster.Lineage.StartsWith(resultantLineage) || o.ObjectMaster.Lineage == lineage || o.ObjectMaster.Id == objectId)
                        .Select(
                        k => new
                        {
                            objectId = k.ObjectId,
                            ActivityDate = k.ActDate,
                            Activity = k.Activity,
                            UserId = k.UserId,
                            Name = k.ObjectMaster.Name,
                            Type = k.ObjectMaster.Type,
                            Lineage = k.ObjectMaster.Lineage,
                            Size = k.ObjectMaster.Size,
                            Extn = k.ObjectMaster.Extn,
                            CustomMessage = k.CustomMessage


                        }).ToList();






                    #region testing

                    foreach (var item in anonymousObjectList)
                    {
                        List<int> userIds = new List<int>();
                        userIds.Add(item.UserId);
                        UserInfo userInfo = new UserInfo();
                        var accessors = new UserManager(uow).GetUserInfoByUserId(userIds);
                        userInfo = accessors[item.UserId];
                        string fExtn = string.Empty;

                        if (item.Extn != null)
                        {
                            fExtn ="."+((Extension)item.Extn).ToString().ToLower();
                        }
                        else
                        {
                            fExtn = "";
                        }
                        string mylineage = item.Lineage;
                        int idForName = Convert.ToInt32(mylineage.Split(GenUtil.LINEAGE_SPLITTER).Last());
                        string name = uow.TenantContext.ObjectMaster.Where(u => u.Id == idForName)
                                             .Select(u => u.Name).FirstOrDefault();
                        UWActivityReporting file = new UWActivityReporting
                        {

                            Extn = fExtn,
                            Name = item.Name,
                            Lineage = item.Lineage,
                            Size = (decimal)item.Size / 1024,
                            Type = (ObjectType)item.Type,

                            ActivityDate = item.ActivityDate,

                            UserId = item.UserId,
                            ActivityName = ((Activity)item.Activity).ToString(),
                            FullName = userInfo.FirstName + " " + userInfo.LastName,
                            MainFolderName = name,
                            CustomMessage = item.CustomMessage



                        };

                        UWReporting.Add(file);

                        // }
                    }

                    #endregion



                }

                catch (Exception ex)
                {

                }
            
            return UWReporting;
        }
        
        public List<UWObject> fetchFilesForCreators(int objectId, int userId, string lineage)
        {
            List<UWObject> UWFile = new List<UWObject>();
            try
            {
                int IndexCount = 0;

                string[] split = lineage.Split(GenUtil.LINEAGE_SPLITTER);
                int projId = Convert.ToInt32(split.FirstOrDefault());               


                DateTime creationDate = uow.TenantContext.DealDetails.Where(d => d.ObjectMaster.Id == projId)
                                      .OrderByDescending(d => d.CreatedDate).Select(dd => dd.CreatedDate).FirstOrDefault();
                Extension fileExtn;
                string resultantLineage = lineage + GenUtil.LINEAGE_SPLITTER;

                #region Query
                var anonymousObjectList = uow.TenantContext.ObjectMaster
                    .Where(om => (om.Lineage.StartsWith(resultantLineage) || om.Lineage == lineage)
                                             && om.Type == (int)ObjectType.File)                
               .Select(om => new
               {
                   Id = om.Id,
                   Extn = (Extension)om.Extn,
                   Type = om.Type,
                   Size = om.Size,
                   Lineage = om.Lineage,
                   Name = om.Name,
                   Path = om.Path,
                   Details = om.ObjectUserMapping
                   .Select(oum => new
                   {
                       CreationDate = creationDate,
                       Permission =
                        new
                        {
                            Perm = (int)ObjectFilePermission.Share,
                            ModDate = creationDate

                        }
                   }).FirstOrDefault()
               }).ToList();
                #endregion

                #region objFileAssign
                foreach (var item in anonymousObjectList)
                {
                    fileExtn = (Extension)item.Extn;
                    ObjectFilePermission enumDisplayStatus = (ObjectFilePermission)item.Details.Permission.Perm;
                    string Perm = enumDisplayStatus.ToString();
                    decimal resultedSize = Math.Round((decimal)item.Size / 1024);
                    if (resultedSize==0)
                    {
                        resultedSize = 1;
                    }
                    UWObject file = new UWFile
                    {
                        ObjectId = item.Id,
                        Extn = fileExtn.ToString(),
                        Name = item.Name,
                        creationDate = item.Details.CreationDate,
                        Desc = string.Empty,
                        Lineage = item.Lineage,
                        Moddate = item.Details.Permission.ModDate,
                        permission = (ObjectPermission)item.Details.Permission.Perm,
                        Type = ObjectType.File,
                        permString = Perm,
                        Size = resultedSize,
                        IndexPath = FindIndexPath(item.Lineage),
                        Path = item.Path,
                        SharedWithUsers = FindShareWithNames(item.Id, userId)

                    };
                    UWFile.Add(file);
                    IndexCount = IndexCount + 1;
                }
                #endregion

            }

            catch (Exception ex)
            { }
            return UWFile;
        }

        public List<UWObject> fetchFilesForNormalUsers(int objectId, int userId, string lineage)
        {
            List<UWObject> UWFile = new List<UWObject>();
            try
            {
               
                Extension fileExtn;
               
                string resultantLineage = lineage + GenUtil.LINEAGE_SPLITTER;

                #region Query
              var  anonymousObjectList = uow.TenantContext.ObjectMaster.Where(om => (om.Lineage.StartsWith(resultantLineage) 
                                            || om.Lineage == lineage)
                                            && om.Type == (int)ObjectType.File)

                      .Select(om => new
                      {
                          Id = om.Id,
                          Extn = (Extension)om.Extn,
                          Type = om.Type,
                          Size = om.Size,
                          Lineage = om.Lineage,
                          Name = om.Name,
                          Path = om.Path,
                          Details = om.ObjectUserMapping.Where(p => p.ShareWithId == userId )
                    .Select(oum => new
                    {
                        CreationDate = oum.CreationDate,
                        Desc = oum.Description,
                        Permission = oum.ObjUserPermission
                        .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                        {
                            Perm = oup.Permission,
                            ModDate = oup.ModifiedDate
                        }).FirstOrDefault()
                    }).FirstOrDefault()
                      }).OrderByDescending(u => u.Id).ToList();
                #endregion

                #region objFileAssign
                foreach (var item in anonymousObjectList)
                {
                    
                    if (item.Details != null && item.Details.Permission != null && item.Details.Permission.Perm != (byte)ObjectPermission.NoAccess)
                    {
                        fileExtn = (Extension)item.Extn;
                        ObjectFilePermission enumDisplayStatus = (ObjectFilePermission)item.Details.Permission.Perm;
                        string Perm = enumDisplayStatus.ToString();

                        decimal resultedSize = Math.Round((decimal)item.Size / 1024);
                        if (resultedSize == 0)
                        {
                            resultedSize = 1;
                        }
                        UWObject file = new UWFile
                        {
                            ObjectId = item.Id,
                            Extn = fileExtn.ToString(),
                            Name = item.Name,
                            creationDate = item.Details.CreationDate,
                            Desc = item.Details.Desc,
                            Lineage = item.Lineage,
                            Moddate = item.Details.Permission.ModDate,
                            permission = (ObjectPermission)item.Details.Permission.Perm,
                            permString = Perm,
                            Size = resultedSize,
                            IndexPath = FindIndexPath(item.Lineage),
                            Type = ObjectType.File,
                            Path = item.Path,
                            SharedWithUsers = FindShareWithNames(item.Id,userId)
                        };

                        UWFile.Add(file);
                        
                    }

                }
                #endregion

            }
            
            catch (Exception e)
            {
            }


        
            return UWFile;
        }

        public List<UWObject> GetContentfFile(int userId, int objectId, string lineage)
        {

            UWFolder folder = new UWFolder();
            List<UWObject> UWFile = new List<UWObject>();
            List<UWFile> uwfile = new List<UWFile>();
            UserLoginDetails UserInfo = new UserLoginDetails();
            UserManager um = new UserManager(uow);
            
                try
                {                                   

                    var ProjectCreatorList = uow.TenantContext.DealDetails
                                             .Where(d => d.ObjectMaster.Id == objectId)
                                             .OrderByDescending(d => d.CreatedDate).FirstOrDefault();

                    if (ProjectCreatorList == null)
                    {
                        string[] split = lineage.Split(GenUtil.LINEAGE_SPLITTER);
                        int resultantId = Convert.ToInt32(split[0]);
                        ProjectCreatorList = uow.TenantContext.DealDetails
                                              .Where(d => d.ObjectMaster.Id == resultantId)
                                              .OrderByDescending(d => d.CreatedDate).FirstOrDefault();
                    }
                    

                    if (ProjectCreatorList.BDL_Lead == userId || ProjectCreatorList.Owner == userId || ProjectCreatorList.DealChampion == userId || roleId==3 || allFetch==1)
                    {
                        UWFile = fetchFilesForCreators(objectId, userId, lineage);
                    }

                    else
                    {
                        UWFile = fetchFilesForNormalUsers(objectId, userId, lineage);
                    }                    

                }

                catch (Exception ex)
                {
                   
                }

                return UWFile;
            

        }

        public List<UWObject> GetRootFolder(int userId)
        {

            UWFolder folder = new UWFolder();
            List<UWObject> UWFileFolder = new List<UWObject>();

            List<UWFolder> uwfolder = new List<UWFolder>();
            int CountOfFile = 0;
            int CountOfFOlder = 0;
            
                try
                {
                    int type = (int)ObjectType.RootFolder;
                    string LineageForFileCount = string.Empty;

                var anonymousObjectList = uow.TenantContext.ObjectMaster.Where(om => om.Type == type
                   )
                     .Select(om => new
                     {
                         Id = om.Id,

                         Type = om.Type,
                         Size = om.Size,
                         Lineage = om.Lineage,
                         Name = om.Name,
                         Path = om.Path,
                         Details = om.ObjectUserMapping.Where(p => p.ShareWithId == userId)

                         .Select(oum => new
                         {
                             CreationDate = oum.CreationDate,
                             Desc = oum.Description,
                             Permission = oum.ObjUserPermission
                             .OrderByDescending(oup => oup.ModifiedDate)
                             //.Where(op => op.Permission != (int)ObjectPermission.NoAccess)
                             .Select(oup => new
                             {
                                 Perm = oup.Permission,
                                 ModDate = oup.ModifiedDate
                             }).FirstOrDefault()
                         }).FirstOrDefault()
                     }).OrderByDescending(o => o.Details.CreationDate).ToList();

                if (roleId==3||allFetch==1)
                {
                    #region ifHaveAllAccess
                     anonymousObjectList = uow.TenantContext.ObjectMaster.Where(om => om.Type == type
                       )
                         .Select(om => new
                         {
                             Id = om.Id,

                             Type = om.Type,
                             Size = om.Size,
                             Lineage = om.Lineage,
                             Name = om.Name,
                             Path = om.Path,
                             Details = om.ObjectUserMapping

                             .Select(oum => new
                             {
                                 CreationDate = oum.CreationDate,
                                 Desc = oum.Description,
                                 Permission = oum.ObjUserPermission
                                 .OrderByDescending(oup => oup.ModifiedDate)
                                 
                                 .Select(oup => new
                                 {
                                     Perm = (byte)(ObjectPermission.FullControl),
                                     ModDate = oup.ModifiedDate
                                 }).FirstOrDefault()
                             }).FirstOrDefault()
                         }).OrderByDescending(o => o.Details.CreationDate).ToList();

                    #endregion
                }
              

               

                    foreach (var item in anonymousObjectList)
                    {
                        if (item.Details !=null && item.Details.Permission!=null && item.Details.Permission.Perm!= (int)ObjectPermission.NoAccess)
                        {
                            if (item.Lineage == "0")

                            {
                                LineageForFileCount = Convert.ToString(item.Id);

                            }
                            else
                            {
                                LineageForFileCount = item.Lineage + GenUtil.LINEAGE_SPLITTER + item.Id;
                            }
                            var ResLineageForFileCount = LineageForFileCount + GenUtil.LINEAGE_SPLITTER;
                           

                            var prjCreatorList = uow.TenantContext.DealDetails.Where(o => o.ObjectID == item.Id)
                                                .OrderByDescending(d => d.CreatedDate).FirstOrDefault();


                            if (prjCreatorList.BDL_Lead==userId || prjCreatorList.DealChampion==userId || prjCreatorList.Owner==userId || roleId==3 || allFetch==1)
                            {
                                CountOfFile = contentFileCount(userId, true, item.Id, item.Lineage);
                            }

                            else
                            {
                                CountOfFile = contentFileCount(userId, false, item.Id, item.Lineage);
                            }

                        ObjectPermission contextMenuDisplayStatus = (ObjectPermission)item.Details.Permission.Perm;
                        string Perm = contextMenuDisplayStatus.ToString();

                        UWObject folders = new UWFolder
                            {
                                ObjectId = item.Id,
                                Name = item.Name,
                                creationDate = item.Details.CreationDate,
                                Desc = item.Details.Desc,
                                Lineage = item.Lineage,
                                Moddate = item.Details.Permission.ModDate,
                                permission = (ObjectPermission)item.Details.Permission.Perm,
                                permString=Perm,
                                Size = (decimal)item.Size,
                                Type = ObjectType.SubFolder,
                                FileCounts = CountOfFile,
                                FolderCounts = CountOfFOlder,
                            };

                            UWFileFolder.Add(folders);
                            CountOfFile = 0;
                        }
                                        
                    }//



                }
                catch (Exception e)
                {


                }

                return UWFileFolder;
                //UWFileFolder = ;


            
        }

        public int UploadDocsInDb(int userId,ObjectMaster item,string resultedLineage,int newParentId)
        {
            int result = 0;
            try
            {
                #region objectAssign
                var objMaster = new ObjectMaster
                {
                    Extn = item.Extn,
                    Lineage = resultedLineage,
                    Name = item.Name,
                    ParentId = newParentId,
                    Size = item.Size,
                    Type = item.Type,
                    Path = item.Path
                };

                var objUserMapping = new ObjectUserMapping
                {
                    //CreationDate = DateTime.Now,
                    CreationDate = DateTime.UtcNow,
                    isGroup = false,
                    ShareById = userId,
                    ShareWithId = userId
                };

                var objPermission = new ObjUserPermission
                {
                    //ModifiedDate = DateTime.Now,
                    ModifiedDate = DateTime.UtcNow,
                    Permission = (byte)ObjectFilePermission.Share
                };
               
                objUserMapping.ObjUserPermission.Add(objPermission);
                objMaster.ObjectUserMapping.Add(objUserMapping);

                uow.TenantContext.ObjectMaster.Add(objMaster);

                #endregion


                result = ContextUtil.addActivityDetails((int)Activity.UploadFile, objMaster.Id, DateTime.UtcNow, uow.TenantContext, userId, item.Name + " file uploaded successfully");
                if (result == 1)
                {
                    uow.TenantContext.SaveChanges();
                  
                    #region forPrevUserFullControl
                    string resultantLineage = resultedLineage + GenUtil.LINEAGE_SPLITTER + objMaster.Id;
                    string[] splitLineage = resultedLineage.Split(GenUtil.LINEAGE_SPLITTER);

                    int projId = Convert.ToInt32(splitLineage.FirstOrDefault());
                    var BDLLeadDealChamp = uow.TenantContext.DealDetails.OrderByDescending(o => o.CreatedDate).
                                          Select(o => new
                                          {
                                              BDLId = o.BDL_Lead,
                                              DealChampId = o.DealChampion,
                                              Owner = o.Owner
                                          })
                                         .FirstOrDefault();


                    
                    int parentObjId = Convert.ToInt32(splitLineage.LastOrDefault());

                    #region MyRegion
                    var ProjCreator = uow.TenantContext.ObjectUserMapping.Where(o => o.ObjectId == parentObjId)
                                      .Select(oum => new
                                      {
                                          sharedWith = oum.ShareWithId,
                                          Permission = oum.ObjUserPermission

                                                      .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                                                      {
                                                          perm = oup.Permission
                                                      }).FirstOrDefault()

                                      }).ToList();

                    #endregion

                    foreach (var creator in ProjCreator)
                    {
                        byte perm = creator.Permission.perm;
                        if (creator.Permission.perm != (int)ObjectPermission.NoAccess && creator.Permission.perm !=(int)ObjectPermission.ContetFileShare)
                        {
                            if (creator.sharedWith != BDLLeadDealChamp.BDLId && creator.sharedWith != BDLLeadDealChamp.DealChampId && creator.sharedWith != BDLLeadDealChamp.Owner)
                            {
                                ObjectUserMapping alreadyShare = new ObjectUserMapping
                                {
                                    ObjectId = objMaster.Id,
                                    isGroup = false,
                                    ShareById = userId,
                                    ShareWithId = creator.sharedWith,
                                    CreationDate = DateTime.UtcNow
                                };

                                ObjUserPermission AddPerms = new ObjUserPermission
                                {
                                    ModifiedDate = DateTime.UtcNow,
                                    Permission = (byte)ObjectFilePermission.Share
                                };

                                alreadyShare.ObjUserPermission.Add(AddPerms);
                                uow.TenantContext.ObjectUserMapping.Add(alreadyShare);
                                uow.TenantContext.SaveChanges();
                            }
                        }
                    }
                    //success
                    #endregion

                }

                return result;
            }

            catch (Exception ex)
            {
                return 0;
            }
        }

        public int pastefile(string objectIdsForCopy, string lineagesForCopy, int objectIdForPaste, string lineageForPaste, int userId, string arrayOfNamesForCopy)
        {
            var status = 0;
            try
            {
                if (lineageForPaste == "0")
                {
                    lineageForPaste = Convert.ToString(objectIdForPaste);
                }
                else
                {
                    lineageForPaste = lineageForPaste + GenUtil.LINEAGE_SPLITTER + objectIdForPaste;
                }

                var arrobjectIdForCopy = objectIdsForCopy.Split('|');
                var arrlineageForCopy = lineagesForCopy.Split(',');
                var arrFileNameForCopy = arrayOfNamesForCopy.Split('|');


                for (int i = 0; i < arrobjectIdForCopy.Length; i++)
                {
                    int isfilepresent = checkNameForPasteWithSameName(objectIdForPaste, lineageForPaste, userId, arrFileNameForCopy[i]);
                    int count = 1;
                    if (isfilepresent == 0)
                    {
                        int present = 0;
                        while (present == 0)
                        {
                            string name = arrFileNameForCopy[i];
                            if (arrFileNameForCopy[i].Length >= 248)
                            {
                                name = arrFileNameForCopy[i].Remove(arrFileNameForCopy[i].Length - (arrFileNameForCopy[i].Length - 238));
                            }

                            arrFileNameForCopy[i] = string.Format("{0}({1})", name, count++);
                            present = checkNameForPasteWithSameName(objectIdForPaste, lineageForPaste, userId, arrFileNameForCopy[i]);

                        }

                    }

                    string lineageForCopy = arrlineageForCopy[i];
                    int objectIdForCopy = Convert.ToInt32(arrobjectIdForCopy[i]);
                    lineageForCopy = lineageForCopy + GenUtil.LINEAGE_SPLITTER + objectIdForCopy;
                    string resultantLineage = lineageForCopy + GenUtil.LINEAGE_SPLITTER;
                    var fileToCopyObj = uow.TenantContext.ObjectMaster.Find(objectIdForCopy);

                    if (fileToCopyObj != null)
                    {
                        var filecopy = new ObjectMaster();

                        filecopy = new ObjectMaster()
                        {
                            Extn = fileToCopyObj.Extn,
                            Lineage = lineageForPaste,
                            Name = arrFileNameForCopy[i],
                            Type = fileToCopyObj.Type,
                            ParentId = objectIdForPaste,
                            Size = fileToCopyObj.Size,
                            Path = fileToCopyObj.Path
                        };
                        int result = UploadDocsInDb(userId, filecopy, lineageForPaste, objectIdForPaste);

                        status = result;
                    }
                    else
                    {
                        status = 2;
                        break;
                    }
                }
               
                return status;
            }
            catch (Exception e)
            {
                return 0;
            }

        }
        
        public int pasteFolder(string objectIdsForCopy, string lineagesForCopy, int objectIdForPaste, string lineageForPaste, int userId, string arrayOfNamesForCopy)
        {
            int status = 0;
            try
            {
                if (lineageForPaste == "0")
                {
                    lineageForPaste = Convert.ToString(objectIdForPaste);
                }
                else
                {
                    lineageForPaste = lineageForPaste + GenUtil.LINEAGE_SPLITTER + objectIdForPaste;
                }

                var arrobjectIdForCopy = objectIdsForCopy.Split('|');
                var arrlineageForCopy = lineagesForCopy.Split(',');
                var arrfolderNameForCopy = arrayOfNamesForCopy.Split('|');
                for (int i = 0; i < arrobjectIdForCopy.Length; i++)
                {
                    int isFolderPresent = checkNameForPasteWithSameName(objectIdForPaste, lineageForPaste, userId, arrfolderNameForCopy[i]);
                    int count = 1;
                    if (isFolderPresent == 0)
                    {
                        int present = 0;
                        while (present == 0)
                        {
                            string name = arrfolderNameForCopy[i];
                            if (arrfolderNameForCopy[i].Length >= 248)
                            {
                                name = arrfolderNameForCopy[i].Remove(arrfolderNameForCopy[i].Length - (arrfolderNameForCopy[i].Length - 238));
                            }

                            arrfolderNameForCopy[i] = string.Format("{0}({1})", name, count++);
                            present = checkNameForPasteWithSameName(objectIdForPaste, lineageForPaste, userId, arrfolderNameForCopy[i]);

                        }

                    }

                    string lineageForCopy = arrlineageForCopy[i];
                    int objectIdForCopy = Convert.ToInt32(arrobjectIdForCopy[i]);
                    lineageForCopy = lineageForCopy + GenUtil.LINEAGE_SPLITTER + objectIdForCopy;
                    string resultantLineage = lineageForCopy + GenUtil.LINEAGE_SPLITTER;
                    var mainfolder = uow.TenantContext.ObjectMaster.Find(objectIdForCopy);

                    if (mainfolder != null)
                    {
                            var SourcechildFolders = uow.TenantContext.ObjectMaster.Where(o => (o.Lineage.StartsWith(resultantLineage) || o.Lineage == lineageForCopy))

                                                    .ToList();
                            #region AddingFirstMainFolder

                            var foldercopy = new ObjectMaster();
                            foldercopy = new ObjectMaster()
                            {
                                Extn = mainfolder.Extn,
                                Lineage = lineageForPaste,
                                Name = arrfolderNameForCopy[i],

                                Type = mainfolder.Type,
                                ParentId = objectIdForPaste,
                                Size = mainfolder.Size,

                                Path = mainfolder.Path

                            };

                          
                            var foldercopyUserMapping = new ObjectUserMapping()
                            {
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = userId
                            };
                            var foldercopyUserPermission = new ObjUserPermission()
                            {
                                ModifiedDate = DateTime.UtcNow,
                                Permission = (byte)ObjectPermission.Moderator

                            };
                            foldercopyUserMapping.ObjUserPermission.Add(foldercopyUserPermission);
                            foldercopy.ObjectUserMapping.Add(foldercopyUserMapping);
                            uow.TenantContext.ObjectMaster.Add(foldercopy);

                            uow.TenantContext.SaveChanges();
                        status = 1;
                            #endregion

                            int foldercopyId = foldercopy.Id;

                            string resultedLineage = "0";
                            int newParentId = 0;
                            string[] splitLineage;
                            int objectIdLineage = 0;
                            string FolderName;
                            bool validInsert = false;

                            foreach (var item in SourcechildFolders)
                            {

                                if (item.ParentId == objectIdForCopy) //first level childs
                                {
                                    resultedLineage = lineageForPaste + GenUtil.LINEAGE_SPLITTER + foldercopyId;
                                    newParentId = foldercopyId;
                                    validInsert = true;

                                }
                                else
                                {
                                    splitLineage = item.Lineage.Split(GenUtil.LINEAGE_SPLITTER);
                                    objectIdLineage = Convert.ToInt32(splitLineage.Last());
                                    FolderName = SourcechildFolders.Where(u => u.Id == objectIdLineage).Select(u => u.Name).FirstOrDefault();//Find(objectIdLineage).Name;
                                    string resultantLine = lineageForPaste + GenUtil.LINEAGE_SPLITTER;
                                    var parent = uow.TenantContext.ObjectMaster
                                                      .Where(u => u.Name == FolderName
                                                      && (u.Lineage.StartsWith(resultantLine) || u.Lineage == lineageForPaste))
                                                      .OrderByDescending(u => u.Id).FirstOrDefault();
                                    newParentId = parent.Id;
                                    resultedLineage = parent.Lineage + GenUtil.LINEAGE_SPLITTER + Convert.ToString(newParentId);


                                    validInsert = true;
                                }

                            if (validInsert)
                            {
                                if (item.Type == (int)ObjectType.File)
                                {
                                    int result = UploadDocsInDb(userId, item, resultedLineage, newParentId);
                                    status = result;
                                }
                                else
                                {
                                    int result = AddFolder(newParentId, item.Name, userId);
                                    status = result;
                                }


                            }


                        }
                        
                    }
                    else
                    {
                        status =2;
                        break;
                    }
                }
               
                return status;
            }
            catch (Exception e)
            {
                return 0;
            }
            
    }

        public int checkNameForPasteWithSameName(int objectIdForPaste, string lineageForPaste, int userId, string arrayOfNamesForCopy)
        {
                bool isFolderPresent = false;
                try
                {
                   
                    var subFolderList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == lineageForPaste).Select(o => o.Name)
                                            .ToList();

                    var arrOfName = arrayOfNamesForCopy.Split('|');
                    for (int i = 0; i < arrOfName.Length; i++)
                    {
                        foreach (var item in subFolderList)
                        {
                            if (item == arrOfName[i])
                            {
                                isFolderPresent = true;
                                break;
                            }

                        }
                    }
                    if (isFolderPresent == true)
                    {
                        return 0;

                    }
                    return 1;
                }
                catch (Exception e)
                {
                    return 2;
                }


            

        }

        public int checkNameForPaste(int objectIdForPaste, string lineageForPaste, int tenantId, int userId, string arrayOfNamesForCopy)
        {
                bool isFolderPresent = false;
                try
                {
                    if (lineageForPaste == "0")
                    {
                        lineageForPaste = Convert.ToString(objectIdForPaste);
                    }
                    else
                    {
                        lineageForPaste = lineageForPaste + GenUtil.LINEAGE_SPLITTER + objectIdForPaste;
                    }



                    var subFolderList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == lineageForPaste).Select(o => o.Name)
                                            .ToList();

                    var arrOfName=arrayOfNamesForCopy.Split('|');
                    for (int i = 0; i < arrOfName.Length; i++)
                    {
                        foreach (var item in subFolderList)
                        {
                            if (item == arrOfName[i])
                            {
                                isFolderPresent = true;
                                break;
                            }

                        }
                    }
                    if (isFolderPresent == true)
                    {
                        return 0;

                    }
                    return 1;
                }
                catch (Exception e)
                {
                    return 2;
                }


            

        }
        public int AddFolder(int parentId, string ChildName, int userid)
        {
            
            int subparentId;
            string lineage = string.Empty;


            string msg = string.Empty;
            //int result = 0;
            

                try
                {
                    //result = ContextUtil.ValidatePermission(userid,(int) Activity.CreateFolder, parentId, context);
                    var id = uow.TenantContext.ObjectMaster.Where(u => u.Id == parentId).FirstOrDefault();
                    subparentId = Convert.ToInt16(id.Id);
                    //  parentLineage = ;
                    lineage = id.Lineage;

                    if (lineage == "0")
                    {
                        lineage = Convert.ToString(parentId);
                    }
                    else
                    {
                        lineage = lineage + GenUtil.LINEAGE_SPLITTER + parentId;
                    }
                    
                    var objectMasterCheck = uow.TenantContext.ObjectMaster.Where(u => u.ParentId == parentId && u.Name == ChildName).FirstOrDefault();

                    if (objectMasterCheck == null)
                    {
                        var objmasters = new ObjectMaster
                        {


                            ParentId = subparentId,
                            Name = ChildName.Trim(),
                            Type = (int)ObjectType.SubFolder,
                            //  Extn = 1,
                            Lineage = lineage,
                            Size = 2
                        };
                                              
                        ObjectUserMapping objuser = new ObjectUserMapping
                        {

                            isGroup = false,
                            ShareById = userid,
                            ShareWithId = userid,
                            // CreationDate = DateTime.Now
                            CreationDate = DateTime.UtcNow
                        };
                       
                        ObjUserPermission objpermsn = new ObjUserPermission
                        {
                            //ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl
                        };


                        objuser.ObjUserPermission.Add(objpermsn);
                        objmasters.ObjectUserMapping.Add(objuser);
                    uow.TenantContext.ObjectMaster.Add(objmasters);
                        string message = "New folder created";
                        // int result = ContextUtil.addActivityDetails((int)Activity.CreateFolder, objmasters.Id, DateTime.Now, context, userid, message);
                        int result = ContextUtil.addActivityDetails((int)Activity.CreateFolder, objmasters.Id, DateTime.UtcNow, uow.TenantContext, userid, message);
                        if (result == 1)
                        {
                        uow.TenantContext.SaveChanges();
                            
                        }

                        #region forPrevUserFullControl
                        string resultantLineage = lineage + GenUtil.LINEAGE_SPLITTER + objmasters.Id;
                        //string[] splitLineage = resultantLineage.Split(GenUtil.LINEAGE_SPLITTER);
                        string[] splitLineage = lineage.Split(GenUtil.LINEAGE_SPLITTER);


                        int projId = Convert.ToInt32(splitLineage.FirstOrDefault());
                        var BDLLeadDealChamp = uow.TenantContext.DealDetails.Where(op=>op.ObjectID==projId).OrderByDescending(o => o.CreatedDate).                                              
                                              Select(o=> new {
                                                  BDLId=o.BDL_Lead,
                                                  DealChampId=o.DealChampion,
                                                  Owner=o.Owner
                                              })                                                        
                                             .FirstOrDefault();


                        foreach (var item in splitLineage)
                        {
                            int splitId = Convert.ToInt32(item);
                        }


                            #region MyRegion
                        int parentObjId= Convert.ToInt32(splitLineage.LastOrDefault());
                        var ProjCreator = uow.TenantContext.ObjectUserMapping.Where(o=>o.ObjectId== parentObjId)
                                              .Select(oum => new
                                              {
                                                  sharedWith = oum.ShareWithId,
                                                  Permission = oum.ObjUserPermission
                                                              .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                                                              {
                                                                  perm = oup.Permission
                                                              }).FirstOrDefault()
                                          }).ToList();

                        #endregion

                        #region Implementation
                        foreach (var creator in ProjCreator)
                        {
                            if (creator.Permission.perm != (int)ObjectPermission.NoAccess && creator.Permission.perm != (int)ObjectPermission.ContetFileShare)
                            {
                                if (creator.sharedWith != BDLLeadDealChamp.BDLId && creator.sharedWith != BDLLeadDealChamp.DealChampId && creator.sharedWith != BDLLeadDealChamp.Owner)
                                {
                                    ObjectUserMapping alreadyShare = new ObjectUserMapping
                                    {
                                        ObjectId = objmasters.Id,
                                        isGroup = false,
                                        ShareById = userid,
                                        ShareWithId = creator.sharedWith,
                                        CreationDate = DateTime.UtcNow
                                    };

                                    ObjUserPermission AddPerms = new ObjUserPermission
                                    {
                                        ModifiedDate = DateTime.UtcNow,
                                        Permission = (byte)creator.Permission.perm
                                    };

                                    alreadyShare.ObjUserPermission.Add(AddPerms);
                                uow.TenantContext.ObjectUserMapping.Add(alreadyShare);  
                                }
                            }
                        }
                    uow.TenantContext.SaveChanges();
                        //////////for full control users 
                        #endregion

                        return result; //success
                        #endregion

                        //return 0;
                    }
                    else
                    {
                        return 2; //already present

                    }
                }
                catch (Exception e)
                {
                    return 0; //system error
                }
        }


        public bool validatePermission(ObjectMaster obj,int objectId,string lineage,int userId, Activity operation = (Activity)1)
        {
            try
            {
                if (roleId == 3 || allFetch == 1)
                {
                    return true;
                }
                else
                {
                    byte addedPerm = obj.ObjectUserMapping
                                   .Where(om => om.ShareWithId == userId).FirstOrDefault()
                                   .ObjUserPermission
                                   .OrderByDescending(ou => ou.ModifiedDate).FirstOrDefault().Permission;

                    if (addedPerm == (byte)ObjectPermission.FullControl || addedPerm == (byte)ObjectPermission.Moderator || addedPerm == (byte)ObjectFilePermission.Share || addedPerm == (byte)ObjectFilePermission.Download)
                    {
                        return true;
                    }

                }

            }
            catch (Exception ex)
            {

              
            }
          

            return false;
        }

        public int renameObject(int objectId, string newName, int tenantId, int userId)
        {
            int result = 0;
            

                try
                {
                    bool isExist = true;
                    var id = uow.TenantContext.ObjectMaster.Find(objectId);
                if (id != null)
                {
                    int selectedObjectType = id.Type;
                    string ParentLineage = id.Lineage;

                    bool isValidPermission = validatePermission(id,objectId, ParentLineage, userId, Activity.Rename);
                   
                    if(isValidPermission == true)
                    { 
                    

                        var existingContentList = uow.TenantContext.ObjectMaster
                                                  .Where(om => om.Lineage == ParentLineage
                                                  && om.Type == selectedObjectType
                                                  )
                                                  .Select(om => om.Name).ToList();

                        foreach (var item in existingContentList)
                        {
                            if (newName.ToLower() == item.ToLower())
                            {
                                isExist = true;
                                break;
                            }
                            else
                            {
                                isExist = false;
                            }

                        }
                        if (isExist == false)
                        {
                            string oldName = id.Name;
                            id.Name = newName;
                            int type = id.Type;
                            if (type == (int)ObjectType.SubFolder || type == (int)ObjectType.RootFolder)
                            {
                                string message = oldName + " folder is renamed to " + newName;
                                result = ContextUtil.addActivityDetails((int)Activity.Rename, objectId, DateTime.UtcNow, uow.TenantContext, userId, message);

                            }
                            if (type == (int)ObjectType.File)
                            {
                                string message = oldName + " file is renamed to " + newName;
                                result = ContextUtil.addActivityDetails((int)Activity.Rename, objectId, DateTime.UtcNow, uow.TenantContext, userId, message);

                            }
                            uow.TenantContext.SaveChanges();
                            result = 1;
                        }
                        else
                        {
                            result = 3;
                        }
                    }
                    else
                    {
                        result = 5;
                        return result;
                    }
                    return result;
                }
                else
                {
                    result = 4;
                    return result;
                }
                }
                catch (Exception e)
                {
                    return result; //system error

                }

            


        }

        public int deleteUsingStoredProc_Old(int objectIdForDelete, string lineageForDelete)
        {
            int result = 1;
            
                try
                {                    
                    SqlParameter SearchString = new SqlParameter("@ID", SqlDbType.Int);
                    SearchString.Direction = ParameterDirection.Input;
                    SearchString.Value = objectIdForDelete;

                    SqlParameter SearchParameter = new SqlParameter("@Lineage", SqlDbType.NVarChar, 500);
                    SearchParameter.Direction = ParameterDirection.Input;
                    SearchParameter.Value = lineageForDelete;

                result = uow.TenantContext.Database.SqlQuery<int>("exec dbo.uspDeleteUserWorkspaceData @ID, @Lineage", SearchString, SearchParameter).SingleOrDefault().SafeToNum();

                }
                catch (Exception e)
                {

                }


            
            return result;
        }

        public int deleteUsingStoredProc(int[] objectIdForDelete, string[] lineageForDelete)
        {
            int result = 1;
            
                try
                {

                    DataTable dtDeleteData = new DataTable();

                    dtDeleteData.Columns.Add("Id");
                    DataRow dr;

                    for (int i = 0; i < objectIdForDelete.Count(); i++)
                    {
                        dr = dtDeleteData.NewRow();
                        dr["id"] = objectIdForDelete[i];
                        dtDeleteData.Rows.Add(dr);                      
                    }

                    var objIds = new SqlParameter("@DeleteData", dtDeleteData);
                      objIds.TypeName = "dbo.DeleteUserWorkSpaceTableType";
                     objIds.SqlDbType = SqlDbType.Structured;

                    var resultParameter = new SqlParameter("@Result", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };

                    uow.TenantContext.Database.ExecuteSqlCommand("exec [dbo].[uspDeleteUserWorkspaceData] @DeleteData, @Result OUT", objIds, resultParameter);
                    result =(int)resultParameter.Value;
                }
                catch (Exception e)
                {

                }
            
            return result;
        }
        public int delete(string objectIdStringForDelete, string lineageStringForDelete, int userid)
        {
            var arrOfObjectId1 = objectIdStringForDelete.Split('|');
            int[] arrOfObjectId = arrOfObjectId1.Select(int.Parse).ToArray();
            var arrOfLineage = lineageStringForDelete.Split(',');
            int result = 1;


            string[] arrlineageForNotification = arrOfLineage;


            string lineageForNotification ="";
            int objectIdForNotification =0;
            ArrayList list = new ArrayList();
            string[] arrOfSelectedName= new string[arrOfObjectId.Length] ;
            int[] arrOftype =new int[arrOfObjectId.Length];
            int[] arrOfparentid =new int[arrOfObjectId.Length];
            string[] arrOfparentName =new string[arrOfObjectId.Length];
            
                try
                {
                for (int i = 0; i < arrOfObjectId.Length; i++)
                {
                    int type = 0;
                    int parentid = 0;
                    string SelectedName = "";

                    string parentName = "";
                    int objectIdForDelete = arrOfObjectId[i];
                    string lineageForDelete = arrOfLineage[i];

                    lineageForNotification = arrOfLineage[i];
                    objectIdForNotification = arrOfObjectId[i];
                    var objSelList = uow.TenantContext.ObjectMaster.Where(o => o.Id == objectIdForDelete).FirstOrDefault();//self
                    if (objSelList != null)

                    {
                        type = objSelList.Type;
                        arrOftype[i] = type;
                        parentid = (int)objSelList.ParentId;
                        arrOfparentid[i] = parentid;
                        SelectedName = objSelList.Name;
                        arrOfSelectedName[i] = SelectedName;
                        parentName = uow.TenantContext.ObjectMaster.Where(o => o.Id == parentid)
                                    .Select(o => o.Name).FirstOrDefault();
                        arrOfparentName[i] = parentName;
                        if (arrlineageForNotification[i] == "0")
                        {

                            var mylist = uow.TenantContext.DealDetails.Where(o => o.ObjectID == objectIdForNotification)
                                         .OrderByDescending(o => o.CreatedDate)
                                         .FirstOrDefault();

                            var assigneduserlist = uow.TenantContext.ObjectUserMapping.Where(p => p.ObjectId == objectIdForNotification
                                                    )
                                                    .Select(oum => new
                                                    {
                                                        type = (int)oum.ObjectMaster.Type,
                                                        sharedwithid = oum.ShareWithId,
                                                        permission = oum.ObjUserPermission
                                                        .Where(op => op.Permission != (byte)ObjectPermission.NoAccess)
                                                        .OrderByDescending(oup => oup.ModifiedDate)
                                                        .FirstOrDefault()
                                                    }).ToList();


                            list.Add(mylist.BDL_Lead);
                            if (mylist.BDL_Lead != mylist.DealChampion)
                            {
                                list.Add(mylist.DealChampion);
                            }

                            if (assigneduserlist != null)
                            {

                                foreach (var item in assigneduserlist)
                                {
                                    if (!list.Contains(item.sharedwithid) && item.sharedwithid != userid)
                                    {
                                        list.Add(item.sharedwithid);
                                    }
                                }

                            }
                        }
                    }
                    }
                    UserWorkspace userFolders = new UserWorkspace(uow);
                    result = userFolders.deleteUsingStoredProc(arrOfObjectId, arrOfLineage);

                    if (result==2)
                    {
                        for (int i = 0; i < arrOfObjectId.Length; i++)
                        {
                            if (arrlineageForNotification[i] != "0")
                            {

                                if (arrOftype[i] == (int)ObjectType.SubFolder)
                                {
                                    string message = arrOfSelectedName[i] + " folder is deleted from " + arrOfparentName[i];
                                    //int actresult = contextutil.addactivitydetails((int)activity.delete, parentid, datetime.now, context, userid, message);
                                    int actresult = ContextUtil.addActivityDetails((int)Activity.delete, arrOfparentid[i], DateTime.UtcNow, uow.TenantContext, userid, message);

                                }
                                if (arrOftype[i] == (int)ObjectType.File)
                                {
                                    string message = arrOfSelectedName[i] + " file is deleted from " + arrOfparentName[i];

                                    // int actresult = contextutil.addactivitydetails((int)activity.delete, parentid, datetime.now, context, userid, message);
                                    int actresult = ContextUtil.addActivityDetails((int)Activity.delete, arrOfparentid[i], DateTime.UtcNow, uow.TenantContext, userid, message);

                                }

                            }

                        
                          else
                         {
                            foreach (var item in list)
                            {
                                TenantUserNotifications notification = new TenantUserNotifications
                                {
                                    UserId = (int)item,
                                    Descriptions = "Project " + arrOfSelectedName[i] + " is deleted",
                                    UserKey = Guid.NewGuid().ToString(),
                                    //CreatedDate = DateTime.Now,
                                    CreatedDate = DateTime.UtcNow,
                                    IsRead = false

                                };
                                uow.TenantContext.UserNotifications.Add(notification);

                            }

                        }
                    }
                    uow.TenantContext.SaveChanges();
                  }



                    }
                catch (Exception e)
                {
                    return result; //system error

                }



            
           
            return result;
        }


        public string GetFilePath(int objectId, int userId = 0)
        {
            string FilePath = string.Empty;
            int result = 1;
            
                // result= ContextUtil.ValidatePermission(userId,(int)Activity.DownoadFile,objectId,context);

                if (result == 1)
                {
                    ObjectMaster obj = uow.TenantContext.ObjectMaster.Find(objectId);
                    FilePath = obj.Path;
                }

            
            return FilePath;
        }

        public string GetFileName(int objectId, int userid)
        {
            string FileName = string.Empty;


            ObjectMaster obj = uow.TenantContext.ObjectMaster.Find(objectId);
            FileName = obj.Name + "." + Convert.ToString((Extension)obj.Extn).ToLower();

            if (FileName != null)
            {
                //ContextUtil.addActivityDetails((int)Activity.DownoadFile, objectId, DateTime.Now, context, userid, FileName+" file downloaded successfully");
                ContextUtil.addActivityDetails((int)Activity.DownoadFile, objectId, DateTime.UtcNow, uow.TenantContext, userid, FileName + " file downloaded successfully");
                uow.TenantContext.SaveChanges();
            }

            return FileName;
        }

        public IEnumerable<StageMaster> GetStages()
        {
            List<StageMaster> stages = new List<StageMaster>();
            
                stages = uow.TenantContext.StageMaster.ToList();
            

            return stages;
        }

        public IEnumerable<ActivityMaster> GetActivities()
        {
            List<ActivityMaster> activities = new List<ActivityMaster>();
            
                activities = uow.TenantContext.ActivityMasters.ToList();

            

            return activities;
        }

        public int CreateProject(int userId, DealData dt)
        {
            int result = 0;

            try
            {
                var objUserMapping2 = new ObjectUserMapping();
                var objUserMapping1 = new ObjectUserMapping();

                bool isMultiObjRecords;
                var objMaster = new ObjectMaster
                {
                    //Extn = 1,
                    Lineage = "0",
                    Name = (dt.Name).TrimEnd(),
                    ParentId = 0,
                    Size = 2,
                    Type = (int)ObjectType.RootFolder
                };
                var dealDetail = new DealDetail
                {
                    ActivityID = dt.ActivityID,
                    BDL_Lead = dt.BDL_Lead,
                    Name = (dt.Name).TrimEnd(),
                    Owner = userId,
                    DealChampion = dt.DealChampion,
                    StageID = dt.StageID,
                    Value = dt.Value,
                    Objective = (dt.Objective).TrimEnd(),
                    Currency = dt.Currency,
                    Priority = dt.Priority,
                    ProjectType=dt.ProjectType,
                    //CreatedDate = DateTime.Now
                    CreatedDate = DateTime.UtcNow
                };
                var objUserMapping = new ObjectUserMapping
                {
                    // CreationDate = DateTime.Now,
                    CreationDate = DateTime.UtcNow,
                    isGroup = false,
                    ShareById = userId,
                    ShareWithId = userId
                };

                var objPermission = new ObjUserPermission
                {
                    //ModifiedDate = DateTime.Now,
                    ModifiedDate = DateTime.UtcNow,
                    // Permission = (byte)ObjectPermission.FullControl
                    Permission = (byte)ObjectPermission.FullControl
                };

                if (dt.BDL_Lead != userId && dt.DealChampion != userId && dt.BDL_Lead != dt.DealChampion)
                {
                    isMultiObjRecords = true;

                    objUserMapping1 = new ObjectUserMapping
                    {
                        //CreationDate = DateTime.Now,
                        CreationDate = DateTime.UtcNow,
                        isGroup = false,
                        ShareById = dt.BDL_Lead,
                        ShareWithId = dt.BDL_Lead
                    };
                    objUserMapping2 = new ObjectUserMapping
                    {
                        //CreationDate = DateTime.Now,
                        CreationDate = DateTime.UtcNow,
                        isGroup = false,
                        ShareById = dt.DealChampion,
                        ShareWithId = dt.DealChampion
                    };

                    var objPermission1 = new ObjUserPermission /// NEED TO DEFINE THRICE FOR EACH OBJECTMASTER RECORD
                    {
                        // ModifiedDate = DateTime.Now,
                        ModifiedDate = DateTime.UtcNow,
                        Permission = (byte)ObjectPermission.FullControl
                    };
                    var objPermission2 = new ObjUserPermission
                    {
                        //ModifiedDate = DateTime.Now,
                        ModifiedDate = DateTime.UtcNow,
                        Permission = (byte)ObjectPermission.FullControl
                    };

                    objUserMapping.ObjUserPermission.Add(objPermission);
                    objMaster.ObjectUserMapping.Add(objUserMapping);

                    objUserMapping1.ObjUserPermission.Add(objPermission1);
                    objMaster.ObjectUserMapping.Add(objUserMapping1);

                    objUserMapping2.ObjUserPermission.Add(objPermission2);

                    objMaster.ObjectUserMapping.Add(objUserMapping2);

                    objMaster.DealDetails.Add(dealDetail);
                    uow.TenantContext.ObjectMaster.Add(objMaster);

                }

                if (dt.BDL_Lead == userId || dt.DealChampion == userId || dt.BDL_Lead == dt.DealChampion)
                {
                    isMultiObjRecords = true;
                    if (dt.BDL_Lead == userId)
                    {
                        objUserMapping1 = new ObjectUserMapping
                        {
                            //CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = dt.DealChampion,
                            ShareWithId = dt.DealChampion
                        };
                    }
                    else if (dt.BDL_Lead == dt.DealChampion)
                    {
                        objUserMapping1 = new ObjectUserMapping
                        {
                            //CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = dt.DealChampion, // Assign any bdl/dealchap as both are same.
                            ShareWithId = dt.DealChampion
                        };

                    }
                    if (dt.DealChampion == userId)
                    {
                        objUserMapping1 = new ObjectUserMapping
                        {
                            //CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = dt.BDL_Lead,
                            ShareWithId = dt.BDL_Lead
                        };
                    }

                    var objPermission1 = new ObjUserPermission
                    {
                        // ModifiedDate = DateTime.Now,
                        ModifiedDate = DateTime.UtcNow,
                        Permission = (byte)ObjectPermission.FullControl
                    };

                    objUserMapping.ObjUserPermission.Add(objPermission);
                    objMaster.ObjectUserMapping.Add(objUserMapping);

                    objUserMapping1.ObjUserPermission.Add(objPermission1);
                    objMaster.ObjectUserMapping.Add(objUserMapping1);

                    objMaster.DealDetails.Add(dealDetail);
                    uow.TenantContext.ObjectMaster.Add(objMaster);
                }

                else
                {
                    isMultiObjRecords = false;
                }

                if (isMultiObjRecords == false)
                {
                    objUserMapping.ObjUserPermission.Add(objPermission);
                    objMaster.ObjectUserMapping.Add(objUserMapping);
                    objMaster.DealDetails.Add(dealDetail);
                    uow.TenantContext.ObjectMaster.Add(objMaster);
                }
                string msg = "New project created successfully";
                // result = ContextUtil.addActivityDetails((int)Activity.CreateProject, objMaster.Id, DateTime.Now, context, userId, msg);
                result = ContextUtil.addActivityDetails((int)Activity.CreateProject, objMaster.Id, DateTime.UtcNow, uow.TenantContext, userId, msg);
                if (result == 1)
                {
                    uow.TenantContext.SaveChanges();
                    AddDefalutProjectFolders(objMaster.Id, objMaster.Lineage, userId);
                    return result;
                }
            }
            catch (Exception e)
            {
            }

            return result;

        }


        public int CreateProject_old(int userId, int currency, string name, decimal deal, string performance, int status, int bdl, int dealchamp, int activity, int priority)
        {
            int result = 0;
            
                try
                {
                    var objUserMapping2 = new ObjectUserMapping();
                    var objUserMapping1 = new ObjectUserMapping();

                    bool isMultiObjRecords;
                    var objMaster = new ObjectMaster
                    {
                        //Extn = 1,
                        Lineage = "0",
                        Name = name.TrimEnd(),
                        ParentId = 0,
                        Size = 2,
                        Type = (int)ObjectType.RootFolder
                    };
                    var dealDetail = new DealDetail
                    {
                        ActivityID = activity,
                        BDL_Lead = bdl,
                        Name = name.TrimEnd(),
                        Owner = userId,
                        DealChampion = dealchamp,
                        StageID = status,
                        Value = deal,
                        Objective = performance.TrimEnd(),
                        Currency = currency,
                        Priority=priority,
                        //CreatedDate = DateTime.Now
                        CreatedDate = DateTime.UtcNow
                    };
                    var objUserMapping = new ObjectUserMapping
                    {
                        // CreationDate = DateTime.Now,
                        CreationDate = DateTime.UtcNow,
                        isGroup = false,
                        ShareById = userId,
                        ShareWithId = userId
                    };

                    var objPermission = new ObjUserPermission
                    {
                        //ModifiedDate = DateTime.Now,
                        ModifiedDate = DateTime.UtcNow,
                        // Permission = (byte)ObjectPermission.FullControl
                        Permission = (byte)ObjectPermission.FullControl
                    };

                    if (bdl != userId && dealchamp != userId && bdl != dealchamp)
                    {
                        isMultiObjRecords = true;

                        objUserMapping1 = new ObjectUserMapping
                        {
                            //CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = bdl,
                            ShareWithId = bdl
                        };
                        objUserMapping2 = new ObjectUserMapping
                        {
                            //CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = dealchamp,
                            ShareWithId = dealchamp
                        };

                        var objPermission1 = new ObjUserPermission /// NEED TO DEFINE THRICE FOR EACH OBJECTMASTER RECORD
                        {
                           // ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl
                        };
                        var objPermission2 = new ObjUserPermission
                        {
                            //ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl
                        };

                        objUserMapping.ObjUserPermission.Add(objPermission);
                        objMaster.ObjectUserMapping.Add(objUserMapping);

                        objUserMapping1.ObjUserPermission.Add(objPermission1);
                        objMaster.ObjectUserMapping.Add(objUserMapping1);

                        objUserMapping2.ObjUserPermission.Add(objPermission2);

                        objMaster.ObjectUserMapping.Add(objUserMapping2);

                        objMaster.DealDetails.Add(dealDetail);
                    uow.TenantContext.ObjectMaster.Add(objMaster);

                    }

                    if (bdl == userId || dealchamp == userId || bdl == dealchamp)
                    {
                        isMultiObjRecords = true;
                        if (bdl == userId)
                        {
                            objUserMapping1 = new ObjectUserMapping
                            {
                                //CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = dealchamp,
                                ShareWithId = dealchamp
                            };
                        }
                        else if (bdl == dealchamp)
                        {
                            objUserMapping1 = new ObjectUserMapping
                            {
                                //CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = dealchamp, // Assign any bdl/dealchap as both are same.
                                ShareWithId = dealchamp
                            };

                        }
                        if (dealchamp == userId)
                        {
                            objUserMapping1 = new ObjectUserMapping
                            {
                                //CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = bdl,
                                ShareWithId = bdl
                            };
                        }

                        var objPermission1 = new ObjUserPermission
                        {
                            // ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl
                        };

                        objUserMapping.ObjUserPermission.Add(objPermission);
                        objMaster.ObjectUserMapping.Add(objUserMapping);

                        objUserMapping1.ObjUserPermission.Add(objPermission1);
                        objMaster.ObjectUserMapping.Add(objUserMapping1);

                        objMaster.DealDetails.Add(dealDetail);
                    uow.TenantContext.ObjectMaster.Add(objMaster);
                    }

                    else
                    {
                        isMultiObjRecords = false;
                    }

                    if (isMultiObjRecords == false)
                    {
                        objUserMapping.ObjUserPermission.Add(objPermission);
                        objMaster.ObjectUserMapping.Add(objUserMapping);
                        objMaster.DealDetails.Add(dealDetail);
                    uow.TenantContext.ObjectMaster.Add(objMaster);
                    }
                    string msg = "New project created successfully";
                    // result = ContextUtil.addActivityDetails((int)Activity.CreateProject, objMaster.Id, DateTime.Now, context, userId, msg);
                    result = ContextUtil.addActivityDetails((int)Activity.CreateProject, objMaster.Id, DateTime.UtcNow, uow.TenantContext, userId, msg);
                    if (result == 1)
                    {
                    uow.TenantContext.SaveChanges();
                        AddDefalutProjectFolders(objMaster.Id, objMaster.Lineage, userId);
                        return result;
                    }
                }
                catch (Exception e)
                {
            }
            
            return result;

        }

        public int AddDefalutProjectFolders(int objectId, string pLineage, int ownerId)
        {
            int result = 0;
            ObjectMaster insertedObjMaster = new ObjectMaster();
            
                try
                {
                    var DefaultFolderList = uow.TenantContext.ProjectFolderList.ToList();
                    string resultedLineage = "0";
                    int newParentId = 0;
                    string[] splitLineage;
                    int objectIdLineage = 0;
                    string FolderName;
                    bool validInsert = false;

                    foreach (var item in DefaultFolderList)
                    {
                        if (item.Lineage == "1")
                        {
                            resultedLineage = objectId.ToString();
                            newParentId = objectId;
                            validInsert = true;

                        }
                        else if (item.Lineage != "1" && item.Lineage != "0")
                        {

                            // splitLineage=item.Lineage.Split(new string[] { GenUtil.LINEAGE_SPLITTER }, StringSplitOptions.None);
                            splitLineage = item.Lineage.Split(GenUtil.LINEAGE_SPLITTER);

                            objectIdLineage = Convert.ToInt32(splitLineage.Last());

                            FolderName = DefaultFolderList.Where(u => u.Id == objectIdLineage).Select(u => u.Name).FirstOrDefault();//Find(objectIdLineage).Name;

                            var parent = uow.TenantContext.ObjectMaster
                                              .Where(u => u.Name == FolderName && u.ParentId == objectId).FirstOrDefault();

                            newParentId = parent.Id;
                            resultedLineage = parent.Lineage + GenUtil.LINEAGE_SPLITTER + Convert.ToString(newParentId);
                            validInsert = true;


                        }
                        if (validInsert)
                        {
                            var objMaster = new ObjectMaster
                            {
                                //Extn = item.Extn,
                                Lineage = resultedLineage,
                                Name = item.Name,
                                ParentId = newParentId,
                                Size = item.Size,
                                Type = (int)ObjectType.SubFolder
                            };

                            var objUserMapping = new ObjectUserMapping
                            {
                                //CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = ownerId,
                                ShareWithId = ownerId
                            };

                            var objPermission = new ObjUserPermission
                            {
                                //ModifiedDate = DateTime.Now,
                                ModifiedDate = DateTime.UtcNow,
                                // Permission = (byte)ObjectPermission.FullControl
                                Permission = (byte)ObjectPermission.FullControl
                            };

                            objUserMapping.ObjUserPermission.Add(objPermission);
                            objMaster.ObjectUserMapping.Add(objUserMapping);

                        uow.TenantContext.ObjectMaster.Add(objMaster);
                        uow.TenantContext.SaveChanges();
                        }
                    }

                }
                catch (Exception e)
                {

                    throw e;
                }
            
            return result;
        }

        public int ModifyProject(int userId, DealData dt)
        {
            try
            {
                int ownerId = dt.Owner.SafeToNum();

                var dealObject = new DealDetail()
                {
                    Name = dt.Name,
                    ActivityID = dt.ActivityID,
                    BDL_Lead = dt.BDL_Lead,
                    Objective = dt.Objective,
                    StageID = dt.StageID,
                    Value = dt.Value,
                    DealChampion = dt.DealChampion,
                    Priority = dt.Priority,
                    ProjectType=dt.ProjectType,
                    Currency = dt.Currency,
                    CreatedDate = DateTime.UtcNow,
                    Owner = dt.Owner,
                    ObjectID = dt.projectId
                };
                // ContextUtil.addActivityDetails((int)Activity.ModifyProject, projectId, DateTime.Now, context, userId, "Project data has been modified.");
                if (dt.ModifiedField != null)
                {
                    ContextUtil.addActivityDetails((int)Activity.ModifyProject, dt.projectId, DateTime.UtcNow, uow.TenantContext, userId, dt.ModifiedField);
                }
                uow.TenantContext.DealDetails.Add(dealObject);

                if (dt.BDL_Lead == dt.DealChampion)
                {
                    var objUserMapList = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == dt.projectId && oum.ShareWithId == dt.BDL_Lead)
                        .Select(o => o.ShareWithId).FirstOrDefault();
                    if (objUserMapList == 0)
                    {
                        var objusermap = new ObjectUserMapping()
                        {
                            //CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = userId,
                            ShareWithId = dt.BDL_Lead,
                            ObjectId = dt.projectId

                        };
                        var objuserperm = new ObjUserPermission()
                        {
                            //ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl

                        };
                    }

                }
                else if (dt.BDL_Lead != dt.DealChampion)
                {
                    var objUserMapForBDL = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == dt.projectId && oum.ShareWithId == dt.BDL_Lead)
                       .Select(o => o.ShareWithId).FirstOrDefault();
                    if (objUserMapForBDL == 0)
                    {
                        var objusermapforbdl = new ObjectUserMapping()
                        {
                            // CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = userId,
                            ShareWithId = dt.BDL_Lead,
                            ObjectId = dt.projectId

                        };
                        var objuserpermforbdl = new ObjUserPermission()
                        {
                            //ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl

                        };

                        objusermapforbdl.ObjUserPermission.Add(objuserpermforbdl);
                        uow.TenantContext.ObjectUserMapping.Add(objusermapforbdl);
                    }


                    var objUserMapForDealChamp = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == dt.projectId && oum.ShareWithId == dt.DealChampion)
                       .Select(o => o.ShareWithId).FirstOrDefault();
                    if (objUserMapForDealChamp == 0)
                    {
                        var objusermapfordealchamp = new ObjectUserMapping()
                        {
                            // CreationDate = DateTime.Now,
                            CreationDate = DateTime.UtcNow,
                            isGroup = false,
                            ShareById = userId,
                            ShareWithId = dt.DealChampion,
                            ObjectId = dt.projectId


                        };
                        var objuserpermfordealchamp = new ObjUserPermission()
                        {
                            // ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)ObjectPermission.FullControl

                        };

                        objusermapfordealchamp.ObjUserPermission.Add(objuserpermfordealchamp);
                        uow.TenantContext.ObjectUserMapping.Add(objusermapfordealchamp);
                    }
                }

                uow.TenantContext.SaveChanges();


            }
            catch (Exception e)

            { }




            return 1;

        }


        public int ModifyProject_old(int userId, int currency, string name, decimal deal, string performance, int status, int bdl, int dealchamp, int activity, int priority, int projectId,string owner)
        {
                try
                {
                    int ownerId = owner.SafeToNum();
                   
                    var dealObject = new DealDetail()
                    {
                        Name = name,
                        ActivityID = activity,
                        BDL_Lead = bdl,
                        Objective = performance,
                        StageID = status,
                        Value = deal,
                        DealChampion = dealchamp,
                        Priority = priority,
                        Currency = currency,
                        CreatedDate = DateTime.UtcNow,
                        Owner = ownerId,
                        ObjectID = projectId
                    };
                   // ContextUtil.addActivityDetails((int)Activity.ModifyProject, projectId, DateTime.Now, context, userId, "Project data has been modified.");
                    ContextUtil.addActivityDetails((int)Activity.ModifyProject, projectId, DateTime.UtcNow, uow.TenantContext, userId, "Project data has been modified.");

                uow.TenantContext.DealDetails.Add(dealObject);

                    if (bdl == dealchamp)
                    {
                        var objUserMapList = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == projectId && oum.ShareWithId == bdl)
                            .Select(o => o.ShareWithId).FirstOrDefault();
                        if (objUserMapList == 0)
                        {
                            var objusermap = new ObjectUserMapping()
                            {
                                //CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = bdl,
                                ObjectId = projectId

                            };
                            var objuserperm = new ObjUserPermission()
                            {
                                //ModifiedDate = DateTime.Now,
                                ModifiedDate = DateTime.UtcNow,
                                Permission = (byte)ObjectPermission.FullControl

                            };
                        }

                    }
                    else if (bdl != dealchamp)
                    {
                        var objUserMapForBDL = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == projectId && oum.ShareWithId == bdl)
                           .Select(o => o.ShareWithId).FirstOrDefault();
                        if (objUserMapForBDL == 0)
                        {
                            var objusermapforbdl = new ObjectUserMapping()
                            {
                               // CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = bdl,
                                ObjectId = projectId

                            };
                            var objuserpermforbdl = new ObjUserPermission()
                            {
                                //ModifiedDate = DateTime.Now,
                                ModifiedDate = DateTime.UtcNow,
                                Permission = (byte)ObjectPermission.FullControl

                            };

                            objusermapforbdl.ObjUserPermission.Add(objuserpermforbdl);
                        uow.TenantContext.ObjectUserMapping.Add(objusermapforbdl);
                        }


                        var objUserMapForDealChamp = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == projectId && oum.ShareWithId == dealchamp)
                           .Select(o => o.ShareWithId).FirstOrDefault();
                        if (objUserMapForDealChamp == 0)
                        {
                            var objusermapfordealchamp = new ObjectUserMapping()
                            {
                               // CreationDate = DateTime.Now,
                                CreationDate = DateTime.UtcNow,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = dealchamp,
                                ObjectId = projectId


                            };
                            var objuserpermfordealchamp = new ObjUserPermission()
                            {
                               // ModifiedDate = DateTime.Now,
                                ModifiedDate = DateTime.UtcNow,
                                Permission = (byte)ObjectPermission.FullControl

                            };

                            objusermapfordealchamp.ObjUserPermission.Add(objuserpermfordealchamp);
                        uow.TenantContext.ObjectUserMapping.Add(objusermapfordealchamp);
                        }
                    }

                uow.TenantContext.SaveChanges();


                }
                catch (Exception e)

                { }
            



            return 1;

        }

        public int UploadDocuments(int tenantId, int userId, string parentLineage, HttpFileCollectionBase files)
        {
            int result = 0;
            int uploadedFileCount = 0;
            
                try
                {

                    var parentId = 0;
                    if (parentLineage.Contains(GenUtil.LINEAGE_SPLITTER))
                    {
                        string[] parentIDs = parentLineage.Split(GenUtil.LINEAGE_SPLITTER);
                        parentId = Convert.ToInt32(parentIDs.LastOrDefault());
                    }
                    else
                    {
                        parentId = Convert.ToInt32(parentLineage);
                    }

                var isPresent = uow.TenantContext.ObjectUserMapping
                            .Where(o => o.ShareWithId == userId && o.ObjectMaster.Id == parentId)
                            .OrderByDescending(oum => oum.CreationDate).FirstOrDefault();
                int assignedPerm = (int)ObjectPermission.NoAccess;

                if (isPresent != null)
                {
                     assignedPerm = uow.TenantContext.ObjectUserMapping
                                .Where(o => o.ShareWithId == userId && o.ObjectMaster.Id == parentId)
                                .OrderByDescending(oum => oum.CreationDate).FirstOrDefault().ObjUserPermission
                                .OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault().Permission;
                }

                if (isPresent == null) //creator
                {
                    assignedPerm = (int)ObjectPermission.FullControl;
                }
                    if (isPresent==null ||( assignedPerm != (int)ObjectPermission.NoAccess && assignedPerm != (int)ObjectPermission.ContetFileShare))          
                    {
                        for (int i = 0; i < files.Count; i++)
                        {
                            HttpPostedFileBase file = files[i];

                            if (file != null && file.ContentLength > 0)
                            {

                                var fileName = Path.GetFileName(file.FileName);

                                string key = tenantId.ToString();

                                //var res = GenUtil.UploadImageInBlob(string.Empty, file, StorageContext.WorkSpace);
                                ///////////////////////////////////////////////////////////////////////////////////////////

                                StorageTypeFactory factory = new ConcreteStorageFactory();
                                StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                                string path = storagefactory.Upload(uow, key, file, StorageContext.WorkSpace);
                                //path = "";

                                //////////////////////////////////////////////////////////////////////////////////////////


                                if (!String.IsNullOrEmpty(path))
                                {
                                    var strExt = Path.GetExtension(fileName).Remove(0, 1);
                                    var fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);


                                    Extension enumExt;
                                    Enum.TryParse(strExt, true, out enumExt);
                                    // var prevAssignedUserList=
                                    var objMaster = new ObjectMaster
                                    {
                                        Extn = (int)enumExt,
                                        Lineage = parentLineage,
                                        Name = fileNameWithoutExtension,
                                        ParentId = parentId,
                                        Path = path,
                                        Type = (byte)ObjectType.File,
                                        Size = file.ContentLength
                                    };

                                    int isSuccess = UploadDocsInDb(userId, objMaster, parentLineage, parentId);
                                    if (isSuccess == 1)
                                    {
                                        uploadedFileCount = uploadedFileCount + 1;
                                    }



                                }
                                else
                                    uploadedFileCount = -1;
                            }
                        }
                    }
                //}
                                        
                }
                catch (Exception ex)
            {
                throw ex;
            }

                return uploadedFileCount;
            
        }

        public DealData projectDetails(int userId, int objectId)
        {
            DealDetail dt = new DealDetail();
            DealData dealdata = new DealData();
            
                try
                {
                    dt = uow.TenantContext.DealDetails.Where(u => u.ObjectID == objectId).OrderByDescending(o => o.CreatedDate).FirstOrDefault();
                    dealdata = new DealData()
                    {
                        ID = dt.ID,
                        Name = dt.Name,
                        ActivityID = dt.ActivityID,
                        BDL_Lead = dt.BDL_Lead,
                        ObjectID = dt.ObjectID,
                        Objective = dt.Objective,
                        DealChampion = dt.DealChampion,
                        Owner = dt.Owner,
                        StageID = dt.StageID,
                        ProjectType=dt.ProjectType,
                        Value = dt.Value,
                        Priority = dt.Priority,
                        Currency = dt.Currency,
                        projectId = objectId
                    };
                }
                catch (Exception e)
                {
                }
                return dealdata;
            
        }

        public decimal getPrices(string stage,int userId)
        {
            decimal price = 0;
            
                try
                {
                    var projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                       .Select(oum => new
                       {
                           DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                           ShareWith = oum.ObjectUserMapping.Where(s => s.ShareWithId == userId)
                           .Select
                           (d => new {
                               Permission = d.ObjUserPermission.OrderByDescending(m => m.ModifiedDate)
                                           .Select(p => p.Permission)
                                          .FirstOrDefault()

                           }).FirstOrDefault(),
                       }
                       ).ToList();

                if (roleId==3 || allFetch==1)
                {
                     projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                       .Select(oum => new
                       {
                           DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                           ShareWith = oum.ObjectUserMapping
                           .Select
                           (d => new {
                               Permission = (byte)ObjectPermission.FullControl

                           }).FirstOrDefault(),
                       }
                       ).ToList();
                }

                    if (stage != "onHoldWithdrwal" && stage != "Total")
                    {
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                if (item.DealDetails.StageMaster.Name == stage)
                                {
                                    price = price + item.DealDetails.Value;
                                }
                            }

                        }
                        
                    }
                    else if (stage == "Total")
                    {
                        
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {  
                                    price = price + item.DealDetails.Value;
                               
                            }

                        }
                        
                    }
                    else
                    {
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                if (item.DealDetails.StageMaster.Name == "On Hold" || item.DealDetails.StageMaster.Name == "Complete/ Withdrawn")
                                {
                                    price = price + item.DealDetails.Value;
                                }
                            }

                        }
                        
                    }
                }
                catch (Exception e)
                { }
            
            
            return price;
        }

        public int getCounts(string stage,int userId)
        {
            int count = 0;
            
                try
                {

                    var projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                        .Select(oum => new
                        {
                            DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                            ShareWith=oum.ObjectUserMapping.Where(s=>s.ShareWithId==userId)
                            .Select
                            (d=>new{
                                Permission=d.ObjUserPermission.OrderByDescending(m=>m.ModifiedDate)
                                            .Select(p=>p.Permission)
                                           .FirstOrDefault()

                            }).FirstOrDefault(),           
                        }
                        ).ToList();




                if (roleId==3 || allFetch==2)
                {
                    projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                        .Select(oum => new
                        {
                            DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                            ShareWith = oum.ObjectUserMapping
                            .Select
                            (d => new {
                                Permission = (byte)ObjectPermission.FullControl

                            }).FirstOrDefault(),
                        }
                        ).ToList();
                }
                    if (stage != "onHoldWithdrwal")
                    {
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                if(item.DealDetails.StageMaster.Name== stage)
                                {
                                    count = count + 1;
                                }
                            }

                        }
                        
                    }
                    else
                    {
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                if (item.DealDetails.StageMaster.Name == "On Hold" || item.DealDetails.StageMaster.Name == "Complete/ Withdrawn")
                                {
                                    count = count + 1;
                                }
                            }

                        }
                       

                    }
                }
                catch (Exception e)
                { }
            
            
            return count;
        }

        public List<ActivityListData> GetActivitiesList(int userId)
        {
            List<ActivityListData> activityListData = new List<ActivityListData>();

            try
            {
                List<int> ProjectIds = new List<int>();

                var projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                    .Select(oum => new
                    {
                        DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                        ShareWith = oum.ObjectUserMapping.Where(s => s.ShareWithId == userId)
                        .Select
                        (d => new
                        {
                            Permission = d.ObjUserPermission.OrderByDescending(m => m.ModifiedDate)
                                        .Select(p => p.Permission)
                                       .FirstOrDefault()

                        }).FirstOrDefault(),
                    }
                    ).ToList();

                if (roleId == 3 || allFetch == 1)
                {
                    projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                      .Select(oum => new
                      {
                          DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                          ShareWith = oum.ObjectUserMapping
                          .Select
                          (d => new
                          {
                              Permission = (byte)ObjectPermission.FullControl

                          }).FirstOrDefault(),
                      }
                      ).ToList();
                }


                var activityMasterList = uow.TenantContext.ActivityMasters.ToList();
                foreach (var act in activityMasterList)
                {
                    int count = 0;

                    foreach (var item in projList)
                    {
                        if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                        {
                            if (item.DealDetails.ActivityID == act.Id)
                            {
                                count = count + 1;
                                ProjectIds.Add(item.DealDetails.ObjectID);
                            }
                        }

                    }
                    string result = string.Join(",", ProjectIds);

                    ActivityListData activity = new ActivityListData
                    {
                        ID = act.Id,
                        Name = act.Name,
                        projCounts = count,
                        ProjIds = result
                    };

                    activityListData.Add(activity);
                    result = string.Empty;
                    ProjectIds.Clear();

                }

            }
            catch (Exception e)
            { }


            return activityListData;

        }

        public List<DealData> GetActivityWiseProjList(int activityId, int userId, string projIds)
        {
            List<DealData> Dealdata = new List<DealData>();
            UserManager um = new UserManager(uow);
            UserLoginDetails UserBDL = new UserLoginDetails();
            UserLoginDetails UserDealChamp = new UserLoginDetails();
            DealData dealdata = new DealData();

            try
            {
                List<int> ProjectIds = projIds.Split(',').Select(Int32.Parse).ToList();

                var projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0" && ProjectIds.Contains(o.Id))
                        .Select(oum => new
                        {
                            DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                            ShareWith = oum.ObjectUserMapping.Where(s => s.ShareWithId == userId)
                            .Select
                            (d => new
                            {
                                Permission = d.ObjUserPermission.OrderByDescending(m => m.ModifiedDate)
                                            .Select(p => p.Permission)
                                           .FirstOrDefault()

                            }).FirstOrDefault(),
                        }
                        ).ToList();

                if (roleId == 3 || allFetch == 1)
                {
                    projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0" && ProjectIds.Contains(o.Id))
                      .Select(oum => new
                      {
                          DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                          ShareWith = oum.ObjectUserMapping
                          .Select
                          (d => new
                          {
                              Permission = (byte)ObjectPermission.FullControl

                          }).FirstOrDefault(),
                      }
                      ).ToList();
                }

                foreach (var item in projList)
                {
                    if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                    {
                        if (item.DealDetails.ActivityID == activityId)
                        {
                            UserBDL = um.GetUserInformationByUserId((int)item.DealDetails.BDL_Lead);
                            UserDealChamp = um.GetUserInformationByUserId((int)item.DealDetails.DealChampion);

                            DealData dl = new DealData
                            {
                                ID = item.DealDetails.ID,
                                Name = item.DealDetails.Name,
                                ActivityID = item.DealDetails.ActivityID,
                                BDL_Lead = item.DealDetails.BDL_Lead,
                                ObjectID = item.DealDetails.ObjectID,
                                Objective = item.DealDetails.Objective,
                                Owner = item.DealDetails.Owner,
                                DealChampion = item.DealDetails.DealChampion,
                                StageID = item.DealDetails.StageID,
                                Value = item.DealDetails.Value,
                                Priority = item.DealDetails.Priority,

                                BDLUserName = UserBDL.userInfo.FirstName + " " + UserBDL.userInfo.LastName,
                                ActivityName = item.DealDetails.ActivityMaster.Name,
                                StageName = item.DealDetails.StageMaster.Name,
                                DealChampUserName = UserDealChamp.userInfo.FirstName + " " + UserDealChamp.userInfo.LastName
                            };

                            Dealdata.Add(dl);
                        }
                    }

                }


            }
            catch (Exception e)
            {
            }
            return Dealdata;


        }

        public List<DealData> GetStageWiseProjList(string stageName,int userId)
        {
            List<DealDetail> Deals = new List<DealDetail>();
            List<DealData> Dealdata = new List<DealData>();
            UserManager um = new UserManager(uow);
            UserLoginDetails UserBDL = new UserLoginDetails();
            UserLoginDetails UserDealChamp = new UserLoginDetails();
            
                try
                {
                    var projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                        .Select(oum => new
                        {
                            DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                            ShareWith = oum.ObjectUserMapping.Where(s => s.ShareWithId == userId)
                            .Select
                            (d => new {
                                Permission = d.ObjUserPermission.OrderByDescending(m => m.ModifiedDate)
                                            .Select(p => p.Permission)
                                           .FirstOrDefault()

                            }).FirstOrDefault(),
                        }
                        ).ToList();

                if (roleId == 3 || allFetch == 1)
                {
                    projList = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == "0")
                      .Select(oum => new
                      {
                          DealDetails = oum.DealDetails.OrderByDescending(dd => dd.CreatedDate).FirstOrDefault(),
                          ShareWith = oum.ObjectUserMapping
                          .Select
                          (d => new {
                              Permission = (byte)ObjectPermission.FullControl

                          }).FirstOrDefault(),
                      }
                      ).ToList();
                }

                if (stageName == "Screen / Profile" || stageName == "Diligence" || stageName == "Negotiation")
                    {
                        //Deals = context.DealDetails.Where(u => u.StageMaster.Name == stageName).ToList();
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                if (item.DealDetails.StageMaster.Name == stageName)
                                {
                                    UserBDL = um.GetUserInformationByUserId((int)item.DealDetails.BDL_Lead);
                                    UserDealChamp = um.GetUserInformationByUserId((int)item.DealDetails.DealChampion);
                                    DealData dl = new DealData
                                    {
                                        ID = item.DealDetails.ID,
                                        Name = item.DealDetails.Name,
                                        ActivityID = item.DealDetails.ActivityID,
                                        BDL_Lead = item.DealDetails.BDL_Lead,
                                        ObjectID = item.DealDetails.ObjectID,
                                        Objective = item.DealDetails.Objective,
                                        Owner = item.DealDetails.Owner,
                                        DealChampion = item.DealDetails.DealChampion,
                                        StageID = item.DealDetails.StageID,
                                        Value = item.DealDetails.Value,
                                        Priority = item.DealDetails.Priority,

                                        BDLUserName = UserBDL.userInfo.FirstName + " " + UserBDL.userInfo.LastName,
                                        ActivityName = item.DealDetails.ActivityMaster.Name,
                                        StageName = item.DealDetails.StageMaster.Name,
                                        DealChampUserName = UserDealChamp.userInfo.FirstName + " " + UserDealChamp.userInfo.LastName
                                    };

                                    Dealdata.Add(dl);
                                }
                            }

                        }
                        
                    }
                    else if (stageName == "onHoldWithdrwal")
                    {
                        // Deals = context.DealDetails.Where(u => u.StageMaster.Name == "On Hold" || u.StageMaster.Name == "Complete Withdrawal").ToList();
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                if (item.DealDetails.StageMaster.Name == "On Hold" || item.DealDetails.StageMaster.Name == "Complete/ Withdrawn")
                                {
                                    UserBDL = um.GetUserInformationByUserId((int)item.DealDetails.BDL_Lead);
                                    UserDealChamp = um.GetUserInformationByUserId((int)item.DealDetails.DealChampion);
                                    DealData dl = new DealData
                                    {
                                        ID = item.DealDetails.ID,
                                        Name = item.DealDetails.Name,
                                        ActivityID = item.DealDetails.ActivityID,
                                        BDL_Lead = item.DealDetails.BDL_Lead,
                                        ObjectID = item.DealDetails.ObjectID,
                                        Objective = item.DealDetails.Objective,
                                        Owner = item.DealDetails.Owner,
                                        DealChampion = item.DealDetails.DealChampion,
                                        StageID = item.DealDetails.StageID,
                                        Value = item.DealDetails.Value,
                                        Priority = item.DealDetails.Priority,

                                        BDLUserName = UserBDL.userInfo.FirstName + " " + UserBDL.userInfo.LastName,
                                        ActivityName = item.DealDetails.ActivityMaster.Name,
                                        StageName = item.DealDetails.StageMaster.Name,
                                        DealChampUserName = UserDealChamp.userInfo.FirstName + " " + UserDealChamp.userInfo.LastName
                                    };

                                    Dealdata.Add(dl);
                                }
                            }

                        }
                        
                    }
                    else
                    {
                        // Deals = context.DealDetails.ToList();
                        foreach (var item in projList)
                        {
                            if (item.ShareWith != null && item.ShareWith.Permission != 0 && item.ShareWith.Permission != (int)ObjectPermission.NoAccess)
                            {
                                UserBDL = um.GetUserInformationByUserId((int)item.DealDetails.BDL_Lead);
                                UserDealChamp = um.GetUserInformationByUserId((int)item.DealDetails.DealChampion);
                                DealData dl = new DealData
                                {
                                    ID = item.DealDetails.ID,
                                    Name = item.DealDetails.Name,
                                    ActivityID = item.DealDetails.ActivityID,
                                    BDL_Lead = item.DealDetails.BDL_Lead,
                                    ObjectID = item.DealDetails.ObjectID,
                                    Objective = item.DealDetails.Objective,
                                    Owner = item.DealDetails.Owner,
                                    DealChampion = item.DealDetails.DealChampion,
                                    StageID = item.DealDetails.StageID,
                                    Value = item.DealDetails.Value,
                                    Priority = item.DealDetails.Priority,

                                    BDLUserName = UserBDL.userInfo.FirstName + " " + UserBDL.userInfo.LastName,
                                    ActivityName = item.DealDetails.ActivityMaster.Name,
                                    StageName = item.DealDetails.StageMaster.Name,
                                    DealChampUserName = UserDealChamp.userInfo.FirstName + " " + UserDealChamp.userInfo.LastName
                                };

                                Dealdata.Add(dl);
                            }

                        }
                       
                        
                    }

                    
                }
                catch (Exception e)
                {
                }
                return Dealdata;
            

        }

        //public List<UWObject> AdvSearch_Old(int tenantId, string SelFileTypeList, int userId, string listLineage, string contentKeyWord, string StartDt, string EndDt, string listSelUserIds,bool isFullTextSearch)
        //{
        //    List<UWObject> uwList = new List<UWObject>();
        //    UserLoginDetails UserInfo = new UserLoginDetails();
        //    UserManager um = new UserManager(uow);
        //    string[] extn;
        //    string[] UserIds;
        //    int[] shareWithUserIds = new int[0];
        //    int ShareWithId, hasExtn = 0;
        //    int[] extns = new int[0];
        //    DateTime StartDate = new DateTime();
        //    DateTime EndDate = new DateTime();
        //    string[] lineage;
        //    int isProjSelected = 0;
        //    if (!string.IsNullOrEmpty(SelFileTypeList))
        //    {
        //        extn = SelFileTypeList.Split(',');
        //        if (extn.Count() > 0)
        //        {
        //            extns = new int[extn.Count()];
        //            extns = Array.ConvertAll(extn, s => int.Parse(s));
        //            hasExtn = 1;
        //        }
        //        else
        //        {
        //            extns[0] = 0;
        //            hasExtn = 0;
        //        }
        //    }
        //    else
        //    {
        //        hasExtn = 0;
        //    }

        //    if (!string.IsNullOrEmpty(listSelUserIds))
        //    {
        //        UserIds = listSelUserIds.Split(',');
        //        if (UserIds.Count() > 0)
        //        {
        //            shareWithUserIds = new int[UserIds.Count()];
        //            shareWithUserIds = Array.ConvertAll(UserIds, s => int.Parse(s));
        //            ShareWithId = 1;
        //        }
        //        else
        //        {
        //            shareWithUserIds[0] = 0;
        //            ShareWithId = 0;
        //        }
        //    }
        //    else
        //    {
        //        ShareWithId = 0;
        //    }
        //    if (!string.IsNullOrEmpty(StartDt))
        //    {
        //        string[] str = StartDt.Split('-');
        //        StartDate = Convert.ToDateTime(str[1] + "-" + str[0] + "-" + str[2]);
        //        str = EndDt.Split('-');
        //        EndDate = Convert.ToDateTime(str[1] + "-" + str[0] + "-" + str[2]);
        //    }

        //    Extension fileExtn;
        //    string IndexingPath = string.Empty;
        //    string sharedWith = string.Empty;

        //    if (listLineage !=string.Empty && listLineage!="null")
        //    {
        //        isProjSelected = 1;
        //        lineage = new string[listLineage.Split(',').Count()];
        //        lineage = listLineage.Split(',');
        //    }
        //    else
        //    {
        //        isProjSelected = 0;
        //        lineage = new string[0];
        //    }

        //    using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
        //    {
        //        try
        //        {
        //            int type = (int)ObjectType.File;

        //            #region IfHaveExtn

        //            var anonymousObjectList = context.ObjectMaster
        //               .Where(om => (isProjSelected ==0 || lineage.Any(x => (om.Lineage.StartsWith(x)))) && (hasExtn == 0 || extns.Contains((int)om.Extn))
        //           && om.Type == type)
        //          .Select(om => new
        //          {
        //              Id = om.Id,
        //              Extn = (Extension)om.Extn,
        //              Type = om.Type,
        //              Size = om.Size,
        //              Lineage = om.Lineage,
        //              Name = om.Name,
        //              Path = om.Path,
        //              Details = om.ObjectUserMapping
        //           .Where(oum => (string.IsNullOrEmpty(StartDt) || oum.CreationDate > StartDate) && (ShareWithId == 0 || shareWithUserIds.Contains(oum.ShareWithId)))

        //           .Select(oum => new
        //           {
        //               CreationDate = oum.CreationDate,
        //               Desc = oum.Description,
        //               Permission = oum.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
        //               {
        //                   Perm = oup.Permission,
        //                   ModDate = oup.ModifiedDate
        //               }).FirstOrDefault()
        //           }).FirstOrDefault()
        //          }).ToList();

        //            foreach (var item in anonymousObjectList)
        //            {
        //                fileExtn = (Extension)item.Extn;
        //                sharedWith = string.Empty;
        //                IndexingPath = string.Empty;
        //                if (item.Lineage.Trim()!="0")
        //                {
        //                    string[] indexes = item.Lineage.Split(GenUtil.LINEAGE_SPLITTER);
        //                    for (int i = 0; i < indexes.Count(); i++)
        //                    {
        //                        if (IndexingPath == "")
        //                        {
        //                            if (context.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name !=null)
        //                            {
        //                                IndexingPath = context.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name;
        //                            }                                    
        //                        }
        //                        else
        //                        {
        //                            if (context.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name != null)
        //                            {
        //                                IndexingPath = IndexingPath + ">" + context.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name;
        //                            }                                  
        //                        }
        //                    }


        //                    var sharedUsers = context.ObjectUserMapping.Where(p => p.ObjectId == item.Id && p.ShareWithId != userId)
        //                                  .Select(oum => new
        //                                  {
        //                                      UserId = oum.ShareWithId,
        //                                      Permission = oum.ObjUserPermission
        //                                      .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
        //                                      {
        //                                      }).FirstOrDefault()
        //                                  }).ToList();

        //                    foreach (var user in sharedUsers)
        //                    {
        //                        UserInfo = um.GetUserInformationByUserId((int)user.UserId);
        //                        if (sharedWith == "")
        //                        {
        //                            sharedWith = sharedWith + UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName;

        //                        }
        //                        else
        //                        {
        //                            sharedWith = sharedWith + " , " + UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName;

        //                        }

        //                    }
        //                    if (sharedWith == "")
        //                    {
        //                        sharedWith = "-";
        //                    }


        //                    UWObject file = new UWFile
        //                    {
        //                        ObjectId = item.Id,
        //                        Extn = fileExtn.ToString(),
        //                        Name = item.Name,
        //                        creationDate = item.Details.CreationDate,
        //                        Desc = item.Details.Desc,
        //                        Lineage = item.Lineage,
        //                        Moddate = item.Details.Permission.ModDate,
        //                        permission = (ObjectPermission)item.Details.Permission.Perm,
        //                        Size = Math.Round((decimal)item.Size / 1024),
        //                        Type = ObjectType.File,
        //                        Path = item.Path,
        //                        IndexPath = IndexingPath,
        //                        SharedWithUsers = sharedWith
        //                    };

        //                    uwList.Add(file);

        //                }

        //            }
        //            #endregion
        //        }

        //        catch (Exception e)
        //        {
        //        }
        //        return uwList;
        //    }

        //}

        public List<UWObject> ContentFilterForAllProj(int[] fileIds, string SelFileTypeList, int userId, string listLineage, string StartDt, string EndDt, string listSelUserIds)
        {
            List<UWObject> uwList = new List<UWObject>();
            UserLoginDetails UserInfo = new UserLoginDetails();
            UserManager um = new UserManager(uow);
            string[] extn;
            string[] UserIds;
            int[] shareWithUserIds = new int[0];
            int ShareWithId, hasExtn = 0;
            int[] extns = new int[0];
            DateTime StartDate = new DateTime();
            DateTime EndDate = new DateTime();
            string[] lineage;
            int isProjSelected = 0;
            if (!string.IsNullOrEmpty(SelFileTypeList))
            {
                extn = SelFileTypeList.Split(',');
                if (extn.Count() > 0)
                {
                    extns = new int[extn.Count()];
                    extns = Array.ConvertAll(extn, s => int.Parse(s));
                    hasExtn = 1;
                }
                else
                {
                    extns[0] = 0;
                    hasExtn = 0;
                }
            }
            else
            {
                hasExtn = 0;
            }

            if (!string.IsNullOrEmpty(listSelUserIds))
            {
                UserIds = listSelUserIds.Split(',');
                if (UserIds.Count() > 0)
                {
                    shareWithUserIds = new int[UserIds.Count()];
                    shareWithUserIds = Array.ConvertAll(UserIds, s => int.Parse(s));
                    ShareWithId = 1;
                }
                else
                {
                    shareWithUserIds[0] = 0;
                    ShareWithId = 0;
                }
            }
            else
            {
                ShareWithId = 0;
            }
            if (!string.IsNullOrEmpty(StartDt))
            {
                string[] str = StartDt.Split('-');
                StartDate = Convert.ToDateTime(str[1] + "-" + str[0] + "-" + str[2]);
                str = EndDt.Split('-');
                EndDate = Convert.ToDateTime(str[1] + "-" + str[0] + "-" + str[2]);
            }

            Extension fileExtn;
            string IndexingPath = string.Empty;
            string sharedWith = string.Empty;

            if (listLineage != string.Empty && listLineage != "null")
            {
                isProjSelected = 1;
                lineage = new string[listLineage.Split(',').Count()];
                lineage = listLineage.Split(',');
            }
            else
            {
                isProjSelected = 0;
                lineage = new string[0];
            }
            
                try
                {
                    int type = (int)ObjectType.File;

                    #region IfHaveExtn

                    var anonymousObjectList = uow.TenantContext.ObjectMaster
                       .Where(om =>(fileIds.Contains(om.Id)) && (isProjSelected == 0 || lineage.Any(x => (om.Lineage.StartsWith(x)))) && (hasExtn == 0 || extns.Contains((int)om.Extn))
                   && om.Type == type)
                  .Select(om => new
                  {
                      Id = om.Id,
                      Extn = (Extension)om.Extn,
                      Type = om.Type,
                      Size = om.Size,
                      Lineage = om.Lineage,
                      Name = om.Name,
                      Path = om.Path,
                      Details = om.ObjectUserMapping
                   .Where(oum => (string.IsNullOrEmpty(StartDt) || oum.CreationDate > StartDate) && (ShareWithId == 0 || shareWithUserIds.Contains(oum.ShareWithId)))

                   .Select(oum => new
                   {
                       CreationDate = oum.CreationDate,
                       Desc = oum.Description,
                       Permission = oum.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                       {
                           Perm = oup.Permission,
                           ModDate = oup.ModifiedDate
                       }).FirstOrDefault()
                   }).FirstOrDefault()
                  }).ToList();

                    foreach (var item in anonymousObjectList)
                    {
                        fileExtn = (Extension)item.Extn;
                        sharedWith = string.Empty;
                        IndexingPath = string.Empty;
                        if (item.Lineage.Trim() != "0")
                        {
                            string[] indexes = item.Lineage.Split(GenUtil.LINEAGE_SPLITTER);
                            for (int i = 0; i < indexes.Count(); i++)
                            {
                                if (IndexingPath == "")
                                {
                                    if (uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name != null)
                                    {
                                        IndexingPath = uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name;
                                    }
                                }
                                else
                                {
                                    if (uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name != null)
                                    {
                                        IndexingPath = IndexingPath + ">" + uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(indexes[i])).Name;
                                    }
                                }
                            }


                            var sharedUsers = uow.TenantContext.ObjectUserMapping.Where(p => p.ObjectId == item.Id && p.ShareWithId != userId)
                                          .Select(oum => new
                                          {
                                              UserId = oum.ShareWithId,
                                              Permission = oum.ObjUserPermission
                                              .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                                              {
                                              }).FirstOrDefault()
                                          }).ToList();

                            foreach (var user in sharedUsers)
                            {
                                UserInfo = um.GetUserInformationByUserId((int)user.UserId);
                                if (sharedWith == "")
                                {
                                    sharedWith = sharedWith + UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName;

                                }
                                else
                                {
                                    sharedWith = sharedWith + " , " + UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName;

                                }

                            }
                            if (sharedWith == "")
                            {
                                sharedWith = "-";
                            }


                            UWObject file = new UWFile
                            {
                                
                                ObjectId = item.Id,
                                Extn = fileExtn.ToString(),
                                Name = item.Name,
                                creationDate = item.Details.CreationDate,
                                Desc = item.Details.Desc,
                                Lineage = item.Lineage,
                                Moddate = item.Details.Permission.ModDate,
                                permission = (ObjectPermission)item.Details.Permission.Perm,
                                Size = Math.Round((decimal)item.Size / 1024),
                                Type = ObjectType.File,
                                Path = item.Path,
                                IndexPath = IndexingPath,
                                SharedWithUsers = sharedWith
                            };
                            file.Extension = (Extension)item.Extn;
                            uwList.Add(file);
                            
                           // uwList[0].e

                        }

                    }
                    #endregion
                }

                catch (Exception e)
                {
                }
                return uwList;
            

        }

        public List<FullTextSearch> ContentFilterSearch(int tenantId, int userId, string filterKeyword, bool isFullTextSearch, string selectedFolder)
        {
            int searchParameter = 0;
            FullTextSearch flt = new FullTextSearch();
            List<FullTextSearch> flts = new List<FullTextSearch>();
            using (var conn = new SqlConnection(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {                  
                    if (isFullTextSearch)
                    {
                        searchParameter = 1;
                    }

                    DataTable files = new DataTable();
                    SqlCommand cmd = new SqlCommand("dbo.uspSearchUserWorkSpace", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter SearchString = cmd.Parameters.Add("@SearchString", SqlDbType.NVarChar, 4000);
                    SearchString.Direction = ParameterDirection.Input;
                    SearchString.Value = filterKeyword;

                    SqlParameter SearchParameter = cmd.Parameters.Add("@SearchParameter", SqlDbType.TinyInt);
                    SearchParameter.Direction = ParameterDirection.Input;
                    SearchParameter.Value = searchParameter;

                    if (selectedFolder != "null")
                    {
                        SqlParameter Lineage = cmd.Parameters.Add("@Lineage", SqlDbType.NVarChar, 4000);
                        Lineage.Direction = ParameterDirection.Input;
                        Lineage.Value = selectedFolder;
                    }

                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adp.Fill(ds);
                    if (ds.HasData())
                        files = ds.Tables[0];
                    if (selectedFolder=="null")
                    {                        
                        int[] fileIds= files.AsEnumerable().Select(r => r.Field<int>("ID")).ToArray();                        
                        List<UWObject> ul = new List<UWObject>();
                       var  uls= ContentFilterForAllProj(fileIds, "", userId, "", "", "", "");
                        UWFile uwf = new UWFile();
                        foreach (var item in uls)
                        {                            
                            flt = new FullTextSearch()
                            {
                                
                            ObjectId = item.ObjectId,
                            Extn = ((Extension)item.Extension).ToString(),
                            Name = item.Name,
                            creationDate = item.creationDate,
                            Desc = item.Desc,
                            Lineage = item.Lineage,
                            Moddate = item.Moddate,
                            permission = (ObjectPermission)item.permission,
                            Size = Math.Round((decimal)item.Size / 1024),
                            Type = ObjectType.File,
                            Path = item.Path,
                            IndexPath = item.IndexPath,
                            SharedWithUsers = item.SharedWithUsers                            
                        };
                            flts.Add(flt);                          
                        }

                        //flt.objectIds = new int[files.Rows.Count];
                        //flt.SearchedText = new string[files.Rows.Count];
                        //flt.Extns = new int[files.Rows.Count];

                        //for (int i = 0; i < files.Rows.Count; i++)
                        //{
                        //    flt.objectIds[i] = Convert.ToInt32(Convert.ToString(files.Rows[i][0]));
                        //    if (isFullTextSearch)
                        //    {
                        //        flt.Extns[i] = Convert.ToInt32(Convert.ToString(files.Rows[i][1]));

                        //        Extension fetchedExtn = (Extension)flt.Extn[i];

                        //        if (fetchedExtn.ToString().ToLower().Last() == 'x')
                        //        {

                        //            ParserTypeFactory factory = new ConcreteParserContentFactory();
                        //            ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.XMLType);

                        //            string contentLine = parserFactory.Parsing((byte[])(files.Rows[i][3]), filterKeyword);
                        //            flt.SearchedText[i] = contentLine;

                        //        }
                        //        else if (fetchedExtn.ToString().ToLower() == "pdf")
                        //        {
                        //            ParserTypeFactory factory = new ConcreteParserContentFactory();
                        //            ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.PDFType);

                        //            string contentLine = parserFactory.Parsing((byte[])(files.Rows[i][3]), filterKeyword);
                        //            flt.SearchedText[i] = contentLine;
                        //        }
                        //        else
                        //        {
                        //            ParserTypeFactory factory = new ConcreteParserContentFactory();
                        //            ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.TextType);

                        //            string contentLine = parserFactory.Parsing((byte[])(files.Rows[i][3]), filterKeyword);
                        //            flt.SearchedText[i] = contentLine;

                        //            //flt.SearchedText[i] = System.Text.Encoding.Default.GetString((byte[])(files.Rows[i][2]));
                        //            //flts.SearchedText[i] = flts.SearchedText[i].Replace("\0", string.Empty);
                        //        }

                        //    }
                        //}

                    }
                    else
                    {
                        flt.objectIds = new int[files.Rows.Count];
                        flt.SearchedText = new string[files.Rows.Count];
                        flt.Extns = new int[files.Rows.Count];

                        for (int i = 0; i < files.Rows.Count; i++)
                        {
                            flt.objectIds[i] = Convert.ToInt32(Convert.ToString(files.Rows[i][0]));
                            if (isFullTextSearch)
                            {
                                flt.Extns[i] = Convert.ToInt32(Convert.ToString(files.Rows[i][1]));

                                Extension fetchedExtn = (Extension)flt.Extn[i];

                                if (fetchedExtn.ToString().ToLower().Last() == 'x')
                                {

                                    ParserTypeFactory factory = new ConcreteParserContentFactory();
                                    ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.XMLType);

                                    string contentLine = parserFactory.Parsing((byte[])(files.Rows[i][3]), filterKeyword);
                                    flt.SearchedText[i] = contentLine;

                                }
                                else if (fetchedExtn.ToString().ToLower() == "pdf")
                                {
                                    ParserTypeFactory factory = new ConcreteParserContentFactory();
                                    ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.PDFType);

                                    string contentLine = parserFactory.Parsing((byte[])(files.Rows[i][3]), filterKeyword);
                                    flt.SearchedText[i] = contentLine;
                                }
                                else
                                {
                                    ParserTypeFactory factory = new ConcreteParserContentFactory();
                                    ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.TextType);

                                    string contentLine = parserFactory.Parsing((byte[])(files.Rows[i][3]), filterKeyword);
                                    flt.SearchedText[i] = contentLine;

                                    //flt.SearchedText[i] = System.Text.Encoding.Default.GetString((byte[])(files.Rows[i][2]));
                                    //flts.SearchedText[i] = flts.SearchedText[i].Replace("\0", string.Empty);
                                }

                            }
                        }
                        flts.Add(flt);
                    }
                    
                   
                }
                catch (Exception e)
                {
                }
                return flts;
            }

        }

        //public int Share_Old(List<ShareModel> userForShare, int shareById, int tenantId)
        //{
        //    int result = 0;

        //        try
        //        {
        //            int objectId = userForShare[0].ObjectId;
        //            ObjectMaster oum = new ObjectMaster();

        //            string parentLineage = uow.TenantContext.ObjectMaster.Find(objectId).Lineage.ToString();

        //            List <string> splitLineage = parentLineage.Split(GenUtil.LINEAGE_SPLITTER).ToList();
        //            List<int> objIds;

        //            if (parentLineage.Trim()=="0")
        //            {
        //                 objIds = uow.TenantContext.ObjectMaster.Where(o => (o.Lineage.StartsWith(objectId.ToString()) || o.Lineage == objectId.ToString()))
        //                    .Select(o=>o.Id).ToList();
        //                splitLineage= objIds.ConvertAll<string>(delegate (int i) { return i.ToString(); });

        //            }                  

        //            foreach (var item in userForShare)
        //            {
        //                #region splitted in splitLineage
        //                foreach (var splitted in splitLineage)
        //                {
        //                    int objEntry = uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(splitted))
        //                                    .ObjectUserMapping.Where(o => o.ShareWithId == item.UserId)
        //                                    .OrderByDescending(o => o.CreationDate)
        //                                    //&& o.ObjUserPermission
        //                                    //.OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault()
        //                                    //.Permission != (byte)ObjectPermission.NoAccess)
        //                                    .Select(o => o.ShareWithId).
        //                                    FirstOrDefault();

        //                    //          var anonymousSharedList = context.ObjectUserMapping
        //                    //  .Where(oum => oum.ObjectId == ObjectId && oum.ShareWithId != oum.ObjectMaster.DealDetails
        //                    //                            .OrderByDescending(d => d.CreatedDate).Select(d => d.DealChampion)
        //                    //                            .FirstOrDefault()
        //                    //                            && oum.ShareWithId != oum.ObjectMaster.DealDetails
        //                    //                            .OrderByDescending(d => d.CreatedDate).Select(d => d.BDL_Lead).FirstOrDefault()
        //                    //                            && oum.ShareWithId != oum.ObjectMaster.DealDetails.Select(d => d.Owner).FirstOrDefault()
        //                    //                            && oum.ShareWithId != UserId)
        //                    //.Select(om => new
        //                    //{
        //                    //    UserId = om.ShareWithId,
        //                    //    Permission = om.ObjUserPermission
        //                    //        .OrderByDescending(oup => oup.ModifiedDate)
        //                    //        .Select(oup => new
        //                    //        {
        //                    //            Perm = oup.Permission,
        //                    //            ModDate = oup.ModifiedDate
        //                    //        }).FirstOrDefault()

        //                    //}).ToList();

        //                    #region MyRegion
        //                    if (objEntry == 0) //if upperlineage not add
        //                    {
        //                        var shareuserMaping = new ObjectUserMapping
        //                        {
        //                            //  CreationDate = DateTime.Now,
        //                            CreationDate = DateTime.UtcNow,
        //                            Description = "",
        //                            isGroup = false,
        //                            ShareById = shareById,
        //                            ShareWithId = item.UserId,
        //                            ObjectId = Convert.ToInt32(splitted)
        //                        };
        //                        var shareuserPerm = new ObjUserPermission
        //                        {
        //                            //ModifiedDate = DateTime.Now,
        //                            ModifiedDate = DateTime.UtcNow,
        //                            Permission = (byte)ObjectFolderPermission.Moderator
        //                        };
        //                        shareuserMaping.ObjUserPermission.Add(shareuserPerm);
        //                    uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);
        //                    }

        //                    else // if upperlineage already add
        //                    {
        //                        int tempId = Convert.ToInt32(splitted);
        //                        var ObjectUserMapped = uow.TenantContext.ObjectUserMapping.Where(o => o.ObjectId == tempId
        //                                 && o.ShareWithId == item.UserId).FirstOrDefault();

        //                        var oumCange = new ObjUserPermission()
        //                        {
        //                            ObjUserId = ObjectUserMapped.Id,
        //                            //ModifiedDate = DateTime.Now,
        //                            ModifiedDate = DateTime.UtcNow,
        //                            Permission = (int)ObjectFolderPermission.Moderator
        //                        };
        //                    uow.TenantContext.ObjUserPermission.Add(oumCange);
        //                    }
        //                    #endregion

        //                }
        //                #endregion

        //                List<ShareModel> sharedwithUser = new List<ShareModel>();
        //                sharedwithUser = FecthAlreadyShared(objectId, shareById);
        //                Boolean isALreadyAdd = false;
        //                #region sharedwithUser.Count > 0
        //                if (sharedwithUser.Count > 0)
        //                {
        //                    foreach (var itemId in sharedwithUser)
        //                    {
        //                        if (itemId.UserId == item.UserId)
        //                        {
        //                            isALreadyAdd = true;
        //                            break;
        //                        }
        //                    }

        //                    if (isALreadyAdd==true)
        //                    {
        //                        var ObjectUserMapped = uow.TenantContext.ObjectUserMapping.Where(o => o.ObjectId == objectId
        //                                && o.ShareWithId == item.UserId).OrderByDescending(o => o.CreationDate).FirstOrDefault();

        //                        var alreadyInserted = ObjectUserMapped
        //                            .ObjUserPermission.OrderByDescending(o => o.ModifiedDate).FirstOrDefault();
        //                        int alreadyAssigned = alreadyInserted.Permission;

        //                        if (alreadyAssigned!= (byte)item.Permission)
        //                        {
        //                            var oumCange = new ObjUserPermission()
        //                            {
        //                                ObjUserId = ObjectUserMapped.Id,
        //                                //ModifiedDate = DateTime.Now,
        //                                ModifiedDate = DateTime.UtcNow,
        //                                Permission = (byte)item.Permission
        //                            };
        //                        uow.TenantContext.ObjUserPermission.Add(oumCange);
        //                        }                                
        //                    }
        //                    else
        //                    {
        //                        var objuserMaping = new ObjectUserMapping
        //                        {
        //                            // CreationDate = DateTime.Now,
        //                            CreationDate = DateTime.UtcNow,
        //                            Description = "",
        //                            isGroup = false,
        //                            ShareById = shareById,
        //                            ShareWithId = item.UserId,
        //                            ObjectId = objectId
        //                        };

        //                        var objuserPerm = new ObjUserPermission
        //                        {
        //                            // ModifiedDate = DateTime.Now,
        //                            ModifiedDate = DateTime.UtcNow,
        //                            Permission = (byte)item.Permission
        //                        };

        //                        objuserMaping.ObjUserPermission.Add(objuserPerm);
        //                    uow.TenantContext.ObjectUserMapping.Add(objuserMaping);
        //                        string name = objuserMaping.ObjectMaster.Name;

        //                        // ContextUtil.addActivityDetails((int)Activity.Share, objectId, DateTime.Now, context, item.UserId, "Item : " + name + " is shared.");
        //                        ContextUtil.addActivityDetails((int)Activity.Share, objectId, DateTime.UtcNow, uow.TenantContext, item.UserId, "Item : " + name + " is shared.");

        //                    }

        //                }

        //                #endregion

        //                #region no prev shared with
        //                else
        //                {
        //                    var objuserMaping = new ObjectUserMapping
        //                    {
        //                        // CreationDate = DateTime.Now,
        //                        CreationDate = DateTime.UtcNow,
        //                        Description = "",
        //                        isGroup = false,
        //                        ShareById = shareById,
        //                        ShareWithId = item.UserId,
        //                        ObjectId = objectId
        //                    };

        //                    var objuserPerm = new ObjUserPermission
        //                    {
        //                        // ModifiedDate = DateTime.Now,
        //                        ModifiedDate = DateTime.UtcNow,
        //                        Permission = (byte)item.Permission
        //                    };

        //                    objuserMaping.ObjUserPermission.Add(objuserPerm);
        //                uow.TenantContext.ObjectUserMapping.Add(objuserMaping);
        //                    string name = objuserMaping.ObjectMaster.Name;

        //                    // ContextUtil.addActivityDetails((int)Activity.Share, objectId, DateTime.Now, context, item.UserId, "Item : " + name + " is shared.");
        //                    ContextUtil.addActivityDetails((int)Activity.Share, objectId, DateTime.UtcNow, uow.TenantContext, item.UserId, "Item : " + name + " is shared.");
        //                }
        //                #endregion
        //            }
        //        uow.TenantContext.SaveChanges();

        //            result = 1;
        //        }
        //        catch (Exception e)
        //        {
        //    }


        //    return result;
        //}

        public SendMailInfo DefineSendMailObj(string receiverEmail, string permission, string prevPermission, bool flagForPermission)
        {
            SendMailInfo sendMailInfoObj = new SendMailInfo();
            sendMailInfoObj.ReceiverEmail = receiverEmail;
            sendMailInfoObj.Permission = permission;
            sendMailInfoObj.PrevPermission = prevPermission;
            sendMailInfoObj.FlagForPermission = flagForPermission;
            return sendMailInfoObj;
        }
        public SendMailUserInfo CheckEachEmailAndSendMail(string loggedinUser, string folderNameForNotification, string pathString, string moduleType, List<SendMailInfo> sendMailInfoObj)
        {
            SendMailUserInfo userinfo = new SendMailUserInfo();
            CommonSendInfo cmi = new CommonSendInfo();
            cmi.IsShare = true; //true=Share and false=unshare
            cmi.SenderName = loggedinUser;
            cmi.ProjectName = folderNameForNotification;
            cmi.ClientName = GenUtil.GetClientNameForSendingMail();
            cmi.PathString = pathString;
            cmi.ModuleType = moduleType;
            userinfo.SendMailInfoValue = sendMailInfoObj;
            userinfo.CommonSendInfoValue = cmi;
            return userinfo;

        }

        public void CheckEachEmailAndSendMail_old(string loggedinUser, string folderNameForNotification, string pathString, string moduleType, List<SendMailInfo> sendMailInfoObj)
        {
           
            CommonSendInfo cmi = new CommonSendInfo();
            cmi.IsShare = true; //true=Share and false=unshare
            cmi.SenderName = loggedinUser;
            cmi.ProjectName = folderNameForNotification;
            cmi.ClientName = GenUtil.GetClientNameForSendingMail();
            cmi.PathString = pathString;
            cmi.ModuleType = moduleType;
            foreach (var item in sendMailInfoObj)
            {
                    string str = "";
                    int rs = GenUtil.CreateMailandSend(item, cmi);
                    if (rs == 1)
                        str = "succesfully sent";
                    else
                        str = "successfully not sent";               
            }
        }

       public string  NameToDisplay(string ContentPerm)
        {
            var str = "";
            switch (ContentPerm)
            {
                case "Share":
                                str = "Full";
                                break;
                case "Download":
                                str = "Share";
                                break;
                case "Open":
                                str = "Download";
                                break;
                case "View":
                                str = "View";
                                break;
                case "FullControl":
                                str = "Full Control";
                                break;
                case "Moderator":
                                str = "Moderator";
                                break;

            }
            return str;
        }
       
        public SendMailInfo ProjectShare(string selectedLineage, int objectId, ShareModel item, int shareById)
        {
            ObjectPermission objPerm = new ObjectPermission();
            ObjectPermission objPrevPerm = new ObjectPermission();
            SendMailInfo sendMailInfoObj1 = new SendMailInfo();
            #region ProjectShareLogic
            string thisLineage = Convert.ToString(objectId);
                string resultantLineage = Convert.ToString(objectId) + GenUtil.LINEAGE_SPLITTER;

                var contents = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == thisLineage
                                         || o.Lineage.StartsWith(resultantLineage)
                                        ).Select(o => new
                                        {
                                            Id = o.Id,
                                            Type = o.Type
                                        }

                                        ).ToList();




                foreach (var cont in contents)
                {
                    byte perm = 0;

                    if (cont.Type == (int)ObjectType.File)
                    {
                        if (item.Permission == (byte)ObjectPermission.FullControl)
                        {
                            perm = (byte)ObjectFilePermission.Share;
                        }
                        else
                            if (item.Permission == (byte)ObjectPermission.Moderator)
                        {
                            perm = (byte)ObjectFilePermission.Download;


                        }

                    }

                    else
                    {
                        perm = (byte)item.Permission;
                    }



                    var objUserMap = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                    && o.ObjectMaster.Id == cont.Id)
                             .FirstOrDefault();

                    if (objUserMap == null)
                    {
                        var shareuserMaping = new ObjectUserMapping
                        {
                            CreationDate = DateTime.UtcNow,
                            Description = "",
                            isGroup = false,
                            ShareById = shareById,
                            ShareWithId = item.UserId,
                            ObjectId = cont.Id
                        };
                        var shareuserPerm = new ObjUserPermission
                        {
                            ModifiedDate = DateTime.UtcNow,
                            Permission = perm
                        };
                        shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                        uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                    }
                    else
                    {
                        var existingPermission = objUserMap.ObjUserPermission
                                                .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;

                        if (perm != existingPermission)
                        {
                            var shareuserPerm = new ObjUserPermission
                            {
                                ObjUserId = objUserMap.Id,
                                ModifiedDate = DateTime.UtcNow,
                                Permission = perm
                            };
                            uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                        }

                    }

                }

                var objUserMap2 = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                    && o.ObjectMaster.Id == objectId)
                                    .FirstOrDefault();

                if (objUserMap2 == null)
                {
                    var shareuserMaping = new ObjectUserMapping
                    {
                        CreationDate = DateTime.UtcNow,
                        Description = "",
                        isGroup = false,
                        ShareById = shareById,
                        ShareWithId = item.UserId,
                        ObjectId = objectId
                    };
                    var shareuserPerm = new ObjUserPermission
                    {
                        ModifiedDate = DateTime.UtcNow,
                        Permission = (byte)item.Permission
                    };
                    shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                    uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                    objPerm = (ObjectPermission)(item.Permission);
                    sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), null, false);
                    //sendMailInfoObj.Add(sendMailInfoObj1);

                }
                else
                {
                    var existingPermission = objUserMap2.ObjUserPermission
                                                .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;
                    if (existingPermission != item.Permission)
                    {
                        var shareuserPerm = new ObjUserPermission
                        {
                            ObjUserId = objUserMap2.Id,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (byte)item.Permission
                        };
                        uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                        if (existingPermission == (byte)ObjectPermission.NoAccess)
                        {
                            objPerm = (ObjectPermission)(item.Permission);
                            sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), null, false);
                           // sendMailInfoObj.Add(sendMailInfoObj1);

                        }
                        if (existingPermission == (byte)ObjectPermission.ContetFileShare)
                        {
                            objPerm = (ObjectPermission)(item.Permission);
                            sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), null, false);
                            //sendMailInfoObj.Add(sendMailInfoObj1);

                        }
                        else
                        {
                            objPerm = (ObjectPermission)(item.Permission);
                            objPrevPerm = (ObjectPermission)(existingPermission);
                            sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), NameToDisplay(objPrevPerm.ToString()), true);
                           // sendMailInfoObj.Add(sendMailInfoObj1);

                        }
                    }

                }
            #endregion            
            return sendMailInfoObj1;

        } 

        public SendMailInfo ContentShare(string thisLineage, string resultantLineage, string[] splittedLineage, ShareModel item, int shareById, int objectId)
        {
            string ContentPerm = string.Empty;
            string ContentPrevPerm = string.Empty;
            SendMailInfo sendMailInfoObj1 = new SendMailInfo();
            #region ContentShareLogic
            foreach (var splitItem in splittedLineage)
            {
                int split = Convert.ToInt32(splitItem);

                var objUserMap2 = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                 && o.ObjectMaster.Id == split)
                                 .FirstOrDefault();

                if (objUserMap2 == null)
                {
                    var shareuserMaping = new ObjectUserMapping
                    {
                        CreationDate = DateTime.UtcNow,
                        Description = "",
                        isGroup = false,
                        ShareById = shareById,
                        ShareWithId = item.UserId,
                        ObjectId = split
                    };
                    var shareuserPerm = new ObjUserPermission
                    {
                        ModifiedDate = DateTime.UtcNow,
                        Permission = (int)ObjectPermission.ContetFileShare
                    };
                    shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                    uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);
                }
                else
                {
                    var existingPermission = objUserMap2.ObjUserPermission
                                          .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;
                    if (existingPermission != item.Permission)
                    {
                        var shareuserPerm = new ObjUserPermission
                        {
                            ObjUserId = objUserMap2.Id,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (int)ObjectPermission.ContetFileShare
                        };
                        uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                    }

                }

            }
            var objUserMap = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                 && o.ObjectMaster.Id == objectId)
                                 .FirstOrDefault();
            var ItemType = uow.TenantContext.ObjectMaster.Find(objectId).Type;
            //////////////////////////////////////////////////////////////////////////////////

            if (ItemType == (int)ObjectType.File)
            {
                ContentPerm = ((ObjectFilePermission)((byte)(item.Permission))).ToString();
            }

            else
            {
                ContentPerm = ((ObjectPermission)((byte)(item.Permission))).ToString();
            }

            //////////////////////////////////////////////////////////////////////////////////


            ContentPerm = NameToDisplay(ContentPerm);


            if (objUserMap == null)
            {

                var shareuserMaping = new ObjectUserMapping
                {
                    CreationDate = DateTime.UtcNow,
                    Description = "",
                    isGroup = false,
                    ShareById = shareById,
                    ShareWithId = item.UserId,
                    ObjectId = objectId
                };
                var shareuserPerm = new ObjUserPermission
                {
                    ModifiedDate = DateTime.UtcNow,
                    Permission = (byte)item.Permission
                };
                shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                // objPerm = (ObjectPermission)(item.Permission);                               
                sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, ContentPerm, null, false);
                //sendMailInfoObj.Add(sendMailInfoObj1);

            }
            else
            {
                var existingPermission = objUserMap.ObjUserPermission
                                                .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;

                if (existingPermission != item.Permission)
                {
                    var shareuserPerm = new ObjUserPermission
                    {
                        ObjUserId = objUserMap.Id,
                        ModifiedDate = DateTime.UtcNow,
                        Permission = (byte)item.Permission
                    };
                    uow.TenantContext.ObjUserPermission.Add(shareuserPerm);

                    if (existingPermission == (byte)ObjectFilePermission.NoAccess || existingPermission == (byte)ObjectPermission.ContetFileShare)
                    {
                        //objFilePerm = (ObjectFilePermission)(item.Permission);                                           
                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, ContentPerm, null, false);
                      //  sendMailInfoObj.Add(sendMailInfoObj1);

                    }
                    else
                    {
                        if (ItemType == (int)ObjectType.File)
                        {
                            ContentPrevPerm = ((ObjectFilePermission)((byte)(existingPermission))).ToString();
                        }

                        else
                        {
                            ContentPrevPerm = ((ObjectPermission)((byte)(existingPermission))).ToString();
                        }
                        ContentPrevPerm = NameToDisplay(ContentPrevPerm);
                        //objFilePrevPerm = (ObjectFilePermission)(existingPermission);
                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, ContentPerm, ContentPrevPerm, true);
                        //sendMailInfoObj.Add(sendMailInfoObj1);
                    }
                }
            }
            #endregion
            return sendMailInfoObj1;
        }

        public void AddSharedUserInNotification(List<ShareModel> userForShare, string folderNameForNotification)
        {
            foreach (var item in userForShare)
            {
                TenantUserNotifications notification = new TenantUserNotifications
                {
                    UserId = item.UserId,
                    Descriptions = folderNameForNotification + " is shared with you",
                    UserKey = Guid.NewGuid().ToString(),
                    //CreatedDate = DateTime.Now,
                    CreatedDate = DateTime.UtcNow,
                    IsRead = false

                };
                uow.TenantContext.UserNotifications.Add(notification);
            }
        }

        public SendMailUserInfo Share(List<ShareModel> userForShare, int shareById, int tenantId, string folderNameForNotification, string LoggedinUser)
        {
           // int result = 0;
            SendMailUserInfo userInfo=new SendMailUserInfo();
            userInfo.ResultUW = 0;
            List<SendMailInfo> sendMailInfoObj = new List<SendMailInfo>();
            try
            {
                if (userForShare != null && userForShare.Count > 0)
                {
                    int objectId = userForShare[0].ObjectId;
                    foreach (var item in userForShare)
                    {

                        string selectedLineage = uow.TenantContext.ObjectMaster.Find(objectId).Lineage;                                             
                        #region ifProjectShare

                        if (selectedLineage.Trim() == "0")
                        {
                            SendMailInfo sendMailInfo=ProjectShare(selectedLineage, objectId, item, shareById);
                            sendMailInfoObj.Add(sendMailInfo);                          
                        }
                        #endregion
                        
                        #region ifcontentShare
                        else
                        {
                            string thisLineage = Convert.ToString(objectId);
                            string resultantLineage = Convert.ToString(objectId) + GenUtil.LINEAGE_SPLITTER;
                            string[] splittedLineage = selectedLineage.Split(GenUtil.LINEAGE_SPLITTER);
                            SendMailInfo sendMailInfoObj1=ContentShare(thisLineage,resultantLineage,splittedLineage,item,shareById,objectId);
                            sendMailInfoObj.Add(sendMailInfoObj1);                           
                        }

                        #endregion

                    }
                }
                AddSharedUserInNotification(userForShare, folderNameForNotification);               
                uow.TenantContext.SaveChanges();

                userInfo= CheckEachEmailAndSendMail(LoggedinUser, folderNameForNotification, userForShare[0].PathString, "Userworkspace", sendMailInfoObj);
                //CheckEachEmailAndSendMail(LoggedinUser, folderNameForNotification, userForShare[0].PathString, "Userworkspace", sendMailInfoObj);
                userInfo.ResultUW = 1;
                //result = 1;
                }
                catch (Exception e)
                {
                }
            //return result;
                return userInfo;
            
        }

        public int Share_Old1(List<ShareModel> userForShare, int shareById, int tenantId, string folderNameForNotification, string LoggedinUser)
        {
            int result = 0;
            string ContentPerm = string.Empty;
            string ContentPrevPerm = string.Empty;
            List<SendMailInfo> sendMailInfoObj = new List<SendMailInfo>();
            ObjectPermission objPerm = new ObjectPermission();
            ObjectPermission objPrevPerm = new ObjectPermission();
            try
            {
                if (userForShare != null && userForShare.Count > 0)
                {
                    int objectId = userForShare[0].ObjectId;
                    foreach (var item in userForShare)
                    {

                        string selectedLineage = uow.TenantContext.ObjectMaster.Find(objectId).Lineage;
                        SendMailInfo sendMailInfoObj1 = new SendMailInfo();
                        #region ifProjectShare

                        if (selectedLineage.Trim() == "0")
                        {
                            string thisLineage = Convert.ToString(objectId);
                            string resultantLineage = Convert.ToString(objectId) + GenUtil.LINEAGE_SPLITTER;

                            var contents = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == thisLineage
                                                     || o.Lineage.StartsWith(resultantLineage)
                                                    ).Select(o => new
                                                    {
                                                        Id = o.Id,
                                                        Type = o.Type
                                                    }

                                                    ).ToList();




                            foreach (var cont in contents)
                            {
                                byte perm = 0;

                                if (cont.Type == (int)ObjectType.File)
                                {
                                    if (item.Permission == (byte)ObjectPermission.FullControl)
                                    {
                                        perm = (byte)ObjectFilePermission.Share;
                                    }
                                    else
                                        if (item.Permission == (byte)ObjectPermission.Moderator)
                                    {
                                        perm = (byte)ObjectFilePermission.Download;


                                    }

                                }

                                else
                                {
                                    perm = (byte)item.Permission;
                                }



                                var objUserMap = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                && o.ObjectMaster.Id == cont.Id)
                                         .FirstOrDefault();

                                if (objUserMap == null)
                                {
                                    var shareuserMaping = new ObjectUserMapping
                                    {
                                        CreationDate = DateTime.UtcNow,
                                        Description = "",
                                        isGroup = false,
                                        ShareById = shareById,
                                        ShareWithId = item.UserId,
                                        ObjectId = cont.Id
                                    };
                                    var shareuserPerm = new ObjUserPermission
                                    {
                                        ModifiedDate = DateTime.UtcNow,
                                        Permission = perm
                                    };
                                    shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                                    uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                                }
                                else
                                {
                                    var existingPermission = objUserMap.ObjUserPermission
                                                            .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;

                                    if (perm != existingPermission)
                                    {
                                        var shareuserPerm = new ObjUserPermission
                                        {
                                            ObjUserId = objUserMap.Id,
                                            ModifiedDate = DateTime.UtcNow,
                                            Permission = perm
                                        };
                                        uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                                    }

                                }

                            }

                            var objUserMap2 = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                                && o.ObjectMaster.Id == objectId)
                                                .FirstOrDefault();

                            if (objUserMap2 == null)
                            {
                                var shareuserMaping = new ObjectUserMapping
                                {
                                    CreationDate = DateTime.UtcNow,
                                    Description = "",
                                    isGroup = false,
                                    ShareById = shareById,
                                    ShareWithId = item.UserId,
                                    ObjectId = objectId
                                };
                                var shareuserPerm = new ObjUserPermission
                                {
                                    ModifiedDate = DateTime.UtcNow,
                                    Permission = (byte)item.Permission
                                };
                                shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                                uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                                objPerm = (ObjectPermission)(item.Permission);
                                sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), null, false);
                                sendMailInfoObj.Add(sendMailInfoObj1);

                            }
                            else
                            {
                                var existingPermission = objUserMap2.ObjUserPermission
                                                            .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;
                                if (existingPermission != item.Permission)
                                {
                                    var shareuserPerm = new ObjUserPermission
                                    {
                                        ObjUserId = objUserMap2.Id,
                                        ModifiedDate = DateTime.UtcNow,
                                        Permission = (byte)item.Permission
                                    };
                                    uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                                    if (existingPermission == (byte)ObjectPermission.NoAccess)
                                    {
                                        objPerm = (ObjectPermission)(item.Permission);
                                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), null, false);
                                        sendMailInfoObj.Add(sendMailInfoObj1);

                                    }
                                    if (existingPermission == (byte)ObjectPermission.ContetFileShare)
                                    {
                                        objPerm = (ObjectPermission)(item.Permission);
                                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), null, false);
                                        sendMailInfoObj.Add(sendMailInfoObj1);

                                    }
                                    else
                                    {
                                        objPerm = (ObjectPermission)(item.Permission);
                                        objPrevPerm = (ObjectPermission)(existingPermission);
                                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, NameToDisplay(objPerm.ToString()), NameToDisplay(objPrevPerm.ToString()), true);
                                        sendMailInfoObj.Add(sendMailInfoObj1);

                                    }
                                }

                            }

                        }
                        #endregion

                        //////////
                        #region ifcontentShare
                        else
                        {
                            string thisLineage = Convert.ToString(objectId);
                            string resultantLineage = Convert.ToString(objectId) + GenUtil.LINEAGE_SPLITTER;
                            string[] splittedLineage = selectedLineage.Split(GenUtil.LINEAGE_SPLITTER);

                            foreach (var splitItem in splittedLineage)
                            {
                                int split = Convert.ToInt32(splitItem);

                                var objUserMap2 = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                                 && o.ObjectMaster.Id == split)
                                                 .FirstOrDefault();

                                if (objUserMap2 == null)
                                {
                                    var shareuserMaping = new ObjectUserMapping
                                    {
                                        CreationDate = DateTime.UtcNow,
                                        Description = "",
                                        isGroup = false,
                                        ShareById = shareById,
                                        ShareWithId = item.UserId,
                                        ObjectId = split
                                    };
                                    var shareuserPerm = new ObjUserPermission
                                    {
                                        ModifiedDate = DateTime.UtcNow,
                                        Permission = (int)ObjectPermission.ContetFileShare
                                    };
                                    shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                                    uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);
                                }
                                else
                                {
                                    var existingPermission = objUserMap2.ObjUserPermission
                                                          .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;
                                    if (existingPermission != item.Permission)
                                    {
                                        var shareuserPerm = new ObjUserPermission
                                        {
                                            ObjUserId = objUserMap2.Id,
                                            ModifiedDate = DateTime.UtcNow,
                                            Permission = (int)ObjectPermission.ContetFileShare
                                        };
                                        uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                                    }

                                }

                            }
                            var objUserMap = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == item.UserId
                                                 && o.ObjectMaster.Id == objectId)
                                                 .FirstOrDefault();
                            var ItemType = uow.TenantContext.ObjectMaster.Find(objectId).Type;
                            //////////////////////////////////////////////////////////////////////////////////

                            if (ItemType == (int)ObjectType.File)
                            {
                                ContentPerm = ((ObjectFilePermission)((byte)(item.Permission))).ToString();
                            }

                            else
                            {
                                ContentPerm = ((ObjectPermission)((byte)(item.Permission))).ToString();
                            }

                            //////////////////////////////////////////////////////////////////////////////////


                            ContentPerm = NameToDisplay(ContentPerm);


                            if (objUserMap == null)
                            {

                                var shareuserMaping = new ObjectUserMapping
                                {
                                    CreationDate = DateTime.UtcNow,
                                    Description = "",
                                    isGroup = false,
                                    ShareById = shareById,
                                    ShareWithId = item.UserId,
                                    ObjectId = objectId
                                };
                                var shareuserPerm = new ObjUserPermission
                                {
                                    ModifiedDate = DateTime.UtcNow,
                                    Permission = (byte)item.Permission
                                };
                                shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                                uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                                // objPerm = (ObjectPermission)(item.Permission);                               
                                sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, ContentPerm, null, false);
                                sendMailInfoObj.Add(sendMailInfoObj1);

                            }
                            else
                            {
                                var existingPermission = objUserMap.ObjUserPermission
                                                                .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;

                                if (existingPermission != item.Permission)
                                {
                                    var shareuserPerm = new ObjUserPermission
                                    {
                                        ObjUserId = objUserMap.Id,
                                        ModifiedDate = DateTime.UtcNow,
                                        Permission = (byte)item.Permission
                                    };
                                    uow.TenantContext.ObjUserPermission.Add(shareuserPerm);

                                    if (existingPermission == (byte)ObjectFilePermission.NoAccess)
                                    {
                                        //objFilePerm = (ObjectFilePermission)(item.Permission);                                           
                                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, ContentPerm, null, false);
                                        sendMailInfoObj.Add(sendMailInfoObj1);

                                    }
                                    else
                                    {
                                        if (ItemType == (int)ObjectType.File)
                                        {
                                            ContentPrevPerm = ((ObjectFilePermission)((byte)(existingPermission))).ToString();
                                        }

                                        else
                                        {
                                            ContentPrevPerm = ((ObjectPermission)((byte)(existingPermission))).ToString();
                                        }
                                        ContentPrevPerm = NameToDisplay(ContentPrevPerm);
                                        //objFilePrevPerm = (ObjectFilePermission)(existingPermission);
                                        sendMailInfoObj1 = DefineSendMailObj(item.UserEmail, ContentPerm, ContentPrevPerm, true);
                                        sendMailInfoObj.Add(sendMailInfoObj1);
                                    }
                                }
                            }
                        }

                        #endregion
                    }
                }

                foreach (var item in userForShare)
                {
                    TenantUserNotifications notification = new TenantUserNotifications
                    {
                        UserId = item.UserId,
                        Descriptions = folderNameForNotification + " is shared with you",
                        UserKey = Guid.NewGuid().ToString(),
                        //CreatedDate = DateTime.Now,
                        CreatedDate = DateTime.UtcNow,
                        IsRead = false

                    };
                    uow.TenantContext.UserNotifications.Add(notification);
                }
                uow.TenantContext.SaveChanges();

                CheckEachEmailAndSendMail(LoggedinUser, folderNameForNotification, userForShare[0].PathString, "Userworkspace", sendMailInfoObj);
                result = 1;
            }
            catch (Exception e)
            {
            }
            return result;

        }

        public int UnShare(int objectId, int userId,string folderNameForNotification)
        {
            int result = 0;
            
                try
                {

                    string parentLineage = uow.TenantContext.ObjectMaster.Find(objectId).Lineage.ToString();

                    if (parentLineage.Trim()=="0")
                    {
                        parentLineage = objectId.ToString();
                    }
                    else
                    {
                        parentLineage = parentLineage + GenUtil.LINEAGE_SPLITTER + objectId;

                    }
                   
                    string resultantLineage = parentLineage + GenUtil.LINEAGE_SPLITTER;
                   // List<string> splitLineage;
                    //= parentLineage.Split(GenUtil.LINEAGE_SPLITTER).ToList();
                    List<int> objIds;


                    var ObjectUserMapped = uow.TenantContext.ObjectUserMapping.Where(o => o.ObjectId == objectId
                                           && o.ShareWithId == userId).OrderByDescending(o => o.CreationDate).FirstOrDefault();
                    if (ObjectUserMapped !=null)
                    {
                        var oum = new ObjUserPermission()
                        {
                            ObjUserId = ObjectUserMapped.Id,
                            //ModifiedDate = DateTime.Now,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = (int)ObjectPermission.NoAccess
                        };

                    uow.TenantContext.ObjUserPermission.Add(oum);

                        objIds = uow.TenantContext.ObjectMaster.Where(o => (o.Lineage.StartsWith(resultantLineage) || o.Lineage == parentLineage.ToString()))
                           .Select(o => o.Id).ToList();
                        //  splitLineage = objIds.ConvertAll<string>(delegate (int i) { return i.ToString(); });

                        if (objIds.Count > 0)
                        {
                            foreach (var item in objIds)
                            {
                                var ObjectUserMappedfirst = uow.TenantContext.ObjectUserMapping.Where(o => o.ObjectId == item
                                             && o.ShareWithId == userId).OrderByDescending(o=>o.CreationDate).FirstOrDefault();
                                if (ObjectUserMappedfirst!=null)
                                {
                                    var oumfirst = new ObjUserPermission()
                                    {
                                        ObjUserId = ObjectUserMappedfirst.Id,
                                        //ModifiedDate = DateTime.Now,
                                        ModifiedDate = DateTime.UtcNow,
                                        Permission = (int)ObjectPermission.NoAccess
                                    };

                                uow.TenantContext.ObjUserPermission.Add(oumfirst);
                                }
                               
                            }
                        }

                    TenantUserNotifications notification = new TenantUserNotifications
                    {
                        UserId = userId,
                        Descriptions = folderNameForNotification + " is unshared from you",
                        UserKey = Guid.NewGuid().ToString(),
                        CreatedDate = DateTime.UtcNow,
                        IsRead = false

                    };
                    uow.TenantContext.UserNotifications.Add(notification);
                    uow.TenantContext.SaveChanges();
                        result = 1;
                    }
                    else
                    {
                        result = 2;
                    }
                    
                }
               
                catch (Exception e)
                {
            }
                return result;
            
        }
        public int FetchProjectCreator(string lineage,int ObjectId,out int Bdl,out int Dealchamp)
        {
            int projectIdForAlreadyShare = 0;
            if (lineage == "0")
            {
                projectIdForAlreadyShare = ObjectId;
            }
            else
            {
                var arrOfLineageForAlreadyShare = lineage.Split('|');
                projectIdForAlreadyShare = Convert.ToInt32(arrOfLineageForAlreadyShare.FirstOrDefault());

            }
            var projCreator = uow.TenantContext.DealDetails.Where(bdo => bdo.ObjectID == projectIdForAlreadyShare)
                         .OrderByDescending(o => o.CreatedDate).Select(bdo => new
                         {
                             Owner = bdo.Owner,
                             BDL_Lead = bdo.BDL_Lead,
                             DealChampion = bdo.DealChampion

                         }).FirstOrDefault();
            Bdl = projCreator.BDL_Lead;
            Dealchamp = projCreator.DealChampion;

            return projCreator.Owner;

        }


        public List<int>FetchProjectCreatorForShare(int ObjectId,string lineage)
        {
            int projectIdForAlreadyShare = 0;
            List<int> listOfProjectCreator = new List<int>();
            if (lineage == "0")
            {
                projectIdForAlreadyShare = ObjectId;
            }
            else
            {
                var arrOfLineageForAlreadyShare = lineage.Split('|');
                projectIdForAlreadyShare = Convert.ToInt32(arrOfLineageForAlreadyShare.FirstOrDefault());

            }
            var projCreator = uow.TenantContext.DealDetails.Where(bdo => bdo.ObjectID == projectIdForAlreadyShare)
                         .OrderByDescending(o => o.CreatedDate).Select(bdo => new
                         {
                             Owner = bdo.Owner,
                             BDL_Lead = bdo.BDL_Lead,
                             DealChampion = bdo.DealChampion

                         }).FirstOrDefault();
            listOfProjectCreator.Add(projCreator.Owner);
            listOfProjectCreator.Add(projCreator.BDL_Lead);
            listOfProjectCreator.Add(projCreator.DealChampion);



          return listOfProjectCreator;

        }

        public List<ShareModel> FecthAlreadyShared(int ObjectId, int UserId,string lineageForAlreadyShare)
        {
            List<ShareModel> SharedWithUsers = new List<ShareModel>();
            
                try
                {
                    UserLoginDetails UserInfo = new UserLoginDetails();
                int Bdl;
                int Dealchamp;
             int Owner=FetchProjectCreator(lineageForAlreadyShare, ObjectId,out Bdl,out Dealchamp);

              var anonymousSharedList = uow.TenantContext.ObjectUserMapping
                    .Where(oum => oum.ObjectId == ObjectId  && oum.ShareWithId != oum.ObjectMaster.DealDetails
                                              .OrderByDescending(d => d.CreatedDate).Select(d => d.DealChampion)
                                              .FirstOrDefault()
                                              && oum.ShareWithId != oum.ObjectMaster.DealDetails
                                              .OrderByDescending(d => d.CreatedDate).Select(d => d.BDL_Lead).FirstOrDefault()
                                              && oum.ShareWithId != oum.ObjectMaster.DealDetails.Select(d => d.Owner).FirstOrDefault()
                                              && oum.ShareWithId != UserId)
                  .Select(om => new
                  {
                      UserId = om.ShareWithId,
                      Permission = om.ObjUserPermission
                          .OrderByDescending(oup => oup.ModifiedDate)
                          .Select(oup => new
                          {
                              Perm = oup.Permission,
                              ModDate = oup.ModifiedDate
                          }).FirstOrDefault()
                      
                  }).ToList();

                    #region PrevQuery (TobChecked)
                    //var anonymousSharedList = context.ObjectUserMapping.Where(oum => oum.ObjectId == ObjectId
                    //                         && oum.ShareWithId != oum.ObjectMaster.DealDetails
                    //                         .OrderByDescending(d => d.CreatedDate).Select(d => d.DealChampion)
                    //                         .FirstOrDefault()
                    //                         && oum.ShareWithId != oum.ObjectMaster.DealDetails
                    //                         .OrderByDescending(d => d.CreatedDate).Select(d => d.BDL_Lead).FirstOrDefault()
                    //                         && oum.ShareWithId != oum.ObjectMaster.DealDetails.Select(d => d.Owner).FirstOrDefault()
                    //                         && oum.ShareWithId != UserId
                    //                         && oum.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate)
                    //                         .FirstOrDefault()
                    //                         .Permission != (byte)ObjectPermission.NoAccess)
                    //   .Select(o => new
                    //   {
                    //       UserId = o.ShareWithId,
                    //       Permission = o.ObjUserPermission
                    //       //.Where(u=>u.Permission!=(int)ObjectPermission.NoAccess)
                    //       .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                    //       {
                    //           Perm = oup.Permission
                    //       }).FirstOrDefault()

                    //   }).ToList();

                    #endregion


                    foreach (var item in anonymousSharedList)
                    {
                        if (item.Permission.Perm!=(int)ObjectPermission.NoAccess&&item.Permission.Perm!=(int)ObjectPermission.ContetFileShare)
                        {
                            UserInfo = new UserManager(uow).GetUserInformationByUserId(item.UserId);

                        if (item.UserId != Bdl && item.UserId != Dealchamp && item.UserId != Owner)
                        {
                            ShareModel sm = new ShareModel()
                            {
                                ObjectId = ObjectId,
                                UserId = item.UserId,
                                Permission = (int)item.Permission.Perm,
                                FullName = UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName,
                                EmailId = UserInfo.userInfo.Email
                            };
                          
                            SharedWithUsers.Add(sm);
                                               
                        }
                        }                      
                    }
                }
                catch (Exception e)
                {
            }
            
            return SharedWithUsers;
        }


        public void UploadDocuments_Old(int userId, int tenantId, string parentLineage, HttpFileCollectionBase files)
        {
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    for (int i = 0; i < files.Count; i++)
                    {
                        HttpPostedFileBase file = files[i];
                        if (file != null && file.ContentLength > 0)
                        {

                            var fileName = Path.GetFileName(file.FileName);

                            var res = GenUtil.UploadImageInBlob(string.Empty, file, StorageContext.WorkSpace);


                            if (!String.IsNullOrEmpty(res.BlobUrl))
                            {
                                var strExt = Path.GetExtension(fileName).Remove(0, 1);
                                var fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
                                string[] parentIDs = parentLineage.Split(GenUtil.LINEAGE_SPLITTER);
                                var parentId = 0;
                                if (parentIDs.Length > 0)
                                    parentId = Convert.ToInt32(parentIDs.ElementAt(parentIDs.Length - 1));


                                Extension enumExt;
                                Enum.TryParse(strExt, true, out enumExt);

                                var objMaster = new ObjectMaster
                                {
                                    Extn = (int)enumExt,
                                    Lineage = parentLineage,
                                    Name = fileNameWithoutExtension,
                                    ParentId = parentId,
                                    Path = res.BlobUrl,
                                    Type = (byte)ObjectType.File,
                                    Size = file.ContentLength


                                };
                                var objUserMapping = new ObjectUserMapping
                                {
                                    // CreationDate = DateTime.Now,
                                    CreationDate = DateTime.UtcNow,
                                    isGroup = false,
                                    ShareById = userId,
                                    ShareWithId = userId
                                };
                                var objPermission = new ObjUserPermission
                                {
                                    //ModifiedDate = DateTime.Now,
                                    ModifiedDate = DateTime.UtcNow,
                                    Permission = (byte)ObjectPermission.FullControl
                                };

                                objUserMapping.ObjUserPermission.Add(objPermission);
                                objMaster.ObjectUserMapping.Add(objUserMapping);
                                context.ObjectMaster.Add(objMaster);
                            }
                        }
                    }

                    context.SaveChanges();
                }
                catch (Exception ex) { }
            }
        }

        public int PrevUserChangePermission(int UserId, int ProjectID, int BDLUserId, int DealChampId, int BDLUserPerm, int DealChampIdPerm)
        {
            int result = 0;

            try
            {


                #region IfBDLChanged
                if (BDLUserPerm != 0 && DealChampIdPerm == 0)
                {
                    var objMappinglist = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == BDLUserId))
                                        .ToList();
                    foreach (var item in objMappinglist)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)BDLUserPerm,
                            ModifiedDate = DateTime.UtcNow
                        };
                        uow.TenantContext.ObjUserPermission.Add(objperm);
                        ProjShareForPrevUserChange(UserId, BDLUserId, ProjectID, BDLUserPerm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.UtcNow, uow.TenantContext, UserId, "Previous BD&L lead permision has been modified.");
                    }
                }
                #endregion

                #region IfDealChampChanged
                if (DealChampIdPerm != 0 && BDLUserPerm == 0)
                {
                    var objMappinglist = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == DealChampId))
                                        .ToList();
                    foreach (var item in objMappinglist)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)DealChampIdPerm,
                            ModifiedDate = DateTime.UtcNow
                        };
                        uow.TenantContext.ObjUserPermission.Add(objperm);
                        ProjShareForPrevUserChange(UserId, BDLUserId, ProjectID, BDLUserPerm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.UtcNow, uow.TenantContext, UserId, "Previous deal champion permision has been modified.");
                    }

                }
                #endregion

                #region IfDealChampAndBDLChanged
                if (BDLUserPerm != 0 && DealChampIdPerm != 0)
                {
                    var objMappinglist = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == BDLUserId))
                                        .ToList();
                    var objMappinglist1 = uow.TenantContext.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == DealChampId))
                                        .ToList();

                    foreach (var item in objMappinglist)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)BDLUserPerm,
                            ModifiedDate = DateTime.UtcNow
                        };
                        uow.TenantContext.ObjUserPermission.Add(objperm);
                        ProjShareForPrevUserChange(UserId, BDLUserId, ProjectID, BDLUserPerm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.UtcNow, uow.TenantContext, UserId, "Previous BD&L lead permision has been modified.");
                    }
                    foreach (var item in objMappinglist1)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)DealChampIdPerm,
                            ModifiedDate = DateTime.UtcNow
                        };
                        uow.TenantContext.ObjUserPermission.Add(objperm);
                        ProjShareForPrevUserChange(UserId, BDLUserId, ProjectID, BDLUserPerm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.UtcNow, uow.TenantContext, UserId, "Previous deal champion permision has been modified.");
                    }
                }
                #endregion

                uow.TenantContext.SaveChanges();

                result = 1;
            }

            catch (Exception e)
            {
                result = 0;
            }

            return result;
        }


        public int ProjShareForPrevUserChange(int shareById, int uId, int objectId, int userPerm)
        {
            int result = 0;
            #region ProjectShareLogic
            string thisLineage = Convert.ToString(objectId);
            string resultantLineage = Convert.ToString(objectId) + GenUtil.LINEAGE_SPLITTER;

            var contents = uow.TenantContext.ObjectMaster.Where(o => o.Lineage == thisLineage
                                     || o.Lineage.StartsWith(resultantLineage)
                                    ).Select(o => new
                                    {
                                        Id = o.Id,
                                        Type = o.Type
                                    }).ToList();


            foreach (var cont in contents)
            {
                byte perm = 0;

                if (cont.Type == (int)ObjectType.File)
                {
                    if (userPerm == (byte)ObjectPermission.FullControl)
                    {
                        perm = (byte)ObjectFilePermission.Share;
                    }
                    else
                        if (userPerm == (byte)ObjectPermission.Moderator)
                    {
                        perm = (byte)ObjectFilePermission.Download;


                    }

                }

                else
                {
                    perm = (byte)userPerm;
                }


                var objUserMap = uow.TenantContext.ObjectUserMapping.Where(o => o.ShareWithId == uId
                && o.ObjectMaster.Id == cont.Id)
                         .FirstOrDefault();

                if (objUserMap == null)
                {
                    var shareuserMaping = new ObjectUserMapping
                    {
                        CreationDate = DateTime.UtcNow,
                        Description = "",
                        isGroup = false,
                        ShareById = shareById,
                        ShareWithId = uId,
                        ObjectId = cont.Id
                    };
                    var shareuserPerm = new ObjUserPermission
                    {
                        ModifiedDate = DateTime.UtcNow,
                        Permission = perm
                    };
                    shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                    uow.TenantContext.ObjectUserMapping.Add(shareuserMaping);

                }
                else
                {
                    var existingPermission = objUserMap.ObjUserPermission
                                            .OrderByDescending(o => o.ModifiedDate).FirstOrDefault().Permission;

                    if (perm != existingPermission)
                    {
                        var shareuserPerm = new ObjUserPermission
                        {
                            ObjUserId = objUserMap.Id,
                            ModifiedDate = DateTime.UtcNow,
                            Permission = perm
                        };
                        uow.TenantContext.ObjUserPermission.Add(shareuserPerm);
                    }

                }

            }


            #endregion



            return result;
        }



        public int CheckSameProjNameExist(string ProjName)
        {
            int result = 0;
            
                try
                {
                    var objectEntry = uow.TenantContext.ObjectMaster
                                           .Where(o => o.Name.ToLower().TrimEnd() == ProjName.ToLower().TrimEnd()
                                           && o.Type == (int)ObjectType.RootFolder
                                           ).FirstOrDefault();
                    if (objectEntry == null)
                    {
                        result = 1;
                    }
                    else
                    {
                        result = 0;
                    }
                }
                catch (Exception e)
                {
            }
                return result;
            
        }

        public bool CheckAlreadyPresentName(string lineage, string fileName)
        {
            bool result = true;
            
                try
                {
                    string fileExtn = Path.GetExtension(fileName).Replace('.',' ').Trim().ToUpper();

                    fileName = Path.GetFileNameWithoutExtension(fileName);
                    int fileExtnNo = (int)((Extension)Enum.Parse(typeof(Extension), fileExtn));

                    var objectEntry = uow.TenantContext.ObjectMaster
                                           .Where(o => o.Name.ToLower().TrimEnd() == fileName.ToLower().TrimEnd()
                                           && o.Lineage == lineage && o.Type == (int)ObjectType.File
                                           && o.Extn== fileExtnNo
                                           ).FirstOrDefault();
                    if (objectEntry == null)
                    {
                        result = false;
                    }
                    else
                    {
                        result = true;
                    }
                }
                catch (Exception e)
                {
            }
                return result;
            
        }

         public string FindIndexPath(string lineage)
        {
            string IndexPath = "";
            
                try
                {
                    string[] indexes = Convert.ToString(lineage).Split(GenUtil.LINEAGE_SPLITTER);
                    for (int j = 0; j < indexes.Count(); j++)
                    {
                        if (IndexPath == "")
                        {
                            IndexPath = uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(indexes[j])).Name;
                        }
                        else
                        {
                            IndexPath = IndexPath + ">" + uow.TenantContext.ObjectMaster.Find(Convert.ToInt32(indexes[j])).Name;
                        }
                    }

                }
                catch (Exception e)
                {
            }               
                 
            return IndexPath;
        }

        public string FindShareWithNames(int id, int userId)
        {
            UserLoginDetails UserInfo = new UserLoginDetails();
            UserManager um = new UserManager(uow);
            string sharedWith = "";
            
                try
                {
                    string assignedLineage = uow.TenantContext.ObjectMaster.
                                          Where(p => p.Id == id).Select(o => o.Lineage).FirstOrDefault();

                    string[] splitLineage = assignedLineage.Split(GenUtil.LINEAGE_SPLITTER);
                    var sharedUsers = uow.TenantContext.ObjectUserMapping.
                    Where(p => p.ObjectId == id && p.ShareWithId != userId && 
                    p.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).FirstOrDefault().Permission!=(int)ObjectPermission.NoAccess)
                                        .Select(oum => new
                                        {
                                            Lineage = oum.ObjectMaster.Lineage,
                                            UserId = oum.ShareWithId,
                                            Permission = oum.ObjUserPermission
                                                        .OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                                                         {
                                                            perm =oup.Permission

                                                         }).FirstOrDefault()
                                                         }).ToList();
                  
                    if (sharedUsers != null && sharedUsers.Count>0)
                    {                        

                        int parentId = Convert.ToInt32(sharedUsers[0].Lineage.Split(GenUtil.LINEAGE_SPLITTER).FirstOrDefault());

                        var parentDealRecord = uow.TenantContext.DealDetails.Where(d => d.ObjectID == parentId)
                                             .OrderByDescending(d => d.CreatedDate).FirstOrDefault();

                     

                        foreach (var user in sharedUsers)
                        {
                            var parentAccessCheck = uow.TenantContext.ObjectUserMapping.Where(d => d.ObjectId == parentId
                            && d.ShareWithId == user.UserId
                            ).Select(o => o.ObjUserPermission.OrderByDescending(op => op.ModifiedDate).Select(or=>or.Permission).FirstOrDefault()).FirstOrDefault();


                            if (parentAccessCheck!=(byte)ObjectPermission.NoAccess)
                            {
                                if (parentDealRecord != null)
                                {
                                    if (user.UserId != parentDealRecord.Owner && user.UserId != parentDealRecord.BDL_Lead && user.UserId != parentDealRecord.DealChampion)
                                    {
                                        if (user.Permission.perm != (int)ObjectPermission.NoAccess)
                                        {
                                            UserInfo = um.GetUserInformationByUserId((int)user.UserId);
                                            if (sharedWith == "")
                                            {
                                                sharedWith = sharedWith + UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName;
                                            }
                                            else if (!sharedWith.Contains(UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName))
                                            {
                                                sharedWith = sharedWith + " , " + UserInfo.userInfo.FirstName + " " + UserInfo.userInfo.LastName;
                                            }
                                        }
                                    }
                                }
                            }                       
                        }
                    }

                    if (sharedWith == "")
                    {
                        sharedWith = "-";
                    }
                }
                catch (Exception e)
                {
            }
            
            return sharedWith;
        }

        public List<UWObject> AdvSearch(int tenantId, int userId,AdvanceSearch ads)
        {
            List<UWObject> uwList = new List<UWObject>();

            int searchParameter = 1;
             try
                {

               SqlParameter SearchString = new SqlParameter("@SearchString", SqlDbType.NVarChar, 4000);
                if (!string.IsNullOrEmpty(ads.ContentKeyWord))
                {
                 
                    SearchString.Direction = ParameterDirection.Input;
                    SearchString.Value = ads.ContentKeyWord;
                }
                else
                {
                    SearchString.Direction = ParameterDirection.Input;
                    SearchString.Value =DBNull.Value;
                }

                SqlParameter SearchParameter =new SqlParameter("@SearchParameter", SqlDbType.TinyInt);
                    SearchParameter.Direction = ParameterDirection.Input;
                    SearchParameter.Value = searchParameter;

                    SqlParameter SearchValue =new SqlParameter("@SearchValue", SqlDbType.TinyInt);
                    SearchValue.Direction = ParameterDirection.Input;
                    SearchValue.Value = ads.SelectedOpt;
                SqlParameter IsCreator = new SqlParameter("@IsCreator", SqlDbType.TinyInt);

                if (roleId == 3 || allFetch == 1)
                {
                    IsCreator.Direction = ParameterDirection.Input;
                    IsCreator.Value = Convert.ToInt32(1);
                }
               else
                {
                    IsCreator.Direction = ParameterDirection.Input;
                    IsCreator.Value = Convert.ToInt32(0);

                }

                SqlParameter Lineage = new SqlParameter("@Lineage", SqlDbType.NVarChar, 4000);
                if (!string.IsNullOrEmpty(ads.ListLineage) && ads.ListLineage != "null")
                {
                        Lineage.Direction = ParameterDirection.Input;
                        Lineage.Value = ads.ListLineage;
                 }
                else
                {
                    Lineage.Direction = ParameterDirection.Input;
                    Lineage.Value =DBNull.Value;
                }

                    SqlParameter File_Type =new SqlParameter("@File_Type", SqlDbType.NVarChar, 4000);
                    File_Type.Direction = ParameterDirection.Input;
                    File_Type.Value = ads.SelFileTypeList;

                    SqlParameter ShareById =new SqlParameter("@ShareById", SqlDbType.Int, 4000);
                    ShareById.Direction = ParameterDirection.Input;
                    ShareById.Value = userId;
                SqlParameter ShareWithId = new SqlParameter("@ShareWithId", SqlDbType.NVarChar, 4000);

                if (ads.isAllUser==1)
                {
                        ShareWithId.Direction = ParameterDirection.Input;
                        ShareWithId.Value = userId;
                }
                else
                {
                    ShareWithId =new SqlParameter("@ShareWithId", SqlDbType.NVarChar, 4000);
                    ShareWithId.Direction = ParameterDirection.Input;
                    ShareWithId.Value = ShareWithId;
                }


                SqlParameter StartDate = new SqlParameter("@StartDate", SqlDbType.Date);
                StartDate.Direction = ParameterDirection.Input;
                StartDate.Value = ads.StartDate;

                SqlParameter EndDate = new SqlParameter("@EndDate", SqlDbType.Date);
                EndDate.Direction = ParameterDirection.Input;
                EndDate.Value = ads.EndDate;

             List<AdvSearchResult> AdsearchResult = uow.TenantContext.Database.SqlQuery<AdvSearchResult>("exec dbo.uspSearchUserWorkSpace @SearchString, @SearchParameter, @Lineage, @File_Type, @StartDate, @EndDate, @ShareWithId, @SearchValue, @ShareById, @IsCreator", SearchString, SearchParameter, Lineage, File_Type, StartDate, EndDate, ShareWithId, SearchValue, ShareById, IsCreator).ToList();

                var UniqueResult = AdsearchResult.GroupBy(s =>s.ObjectId)
                    .Select(g => g.First())
                    .ToList<AdvSearchResult>();

             
                string SearchedText = "";

                for (int i = 0; i < UniqueResult.Count; i++)
                 {
                    Extension fetchedExtn = ((Extension)UniqueResult[i].Extn);
                if (!string.IsNullOrEmpty(ads.ContentKeyWord) && ads.SelectedOpt == 0)
                {
                    if (Convert.ToString((Extension)UniqueResult[i].Extn).ToLower().Last() == 'x')
                    {
                        ParserTypeFactory factory = new ConcreteParserContentFactory();
                        ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.XMLType);

                        string contentLine = parserFactory.Parsing((byte[])(UniqueResult[i].File_Stream), ads.ContentKeyWord);
                        SearchedText = contentLine;

                    }
                    else if (fetchedExtn.ToString().ToLower() == "pdf")
                    {
                        ParserTypeFactory factory = new ConcreteParserContentFactory();
                        ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.PDFType);

                        string contentLine = parserFactory.Parsing((byte[])(UniqueResult[i].File_Stream), ads.ContentKeyWord);
                        SearchedText = contentLine;
                    }
                    else
                    {
                        ParserTypeFactory factory = new ConcreteParserContentFactory();
                        ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.TextType);

                        string contentLine = parserFactory.Parsing((byte[])(UniqueResult[i].File_Stream), ads.ContentKeyWord);
                        SearchedText = contentLine.Replace("\0", string.Empty).Replace("\r", string.Empty);
                    }

                    Regex r = new Regex("(?i)" + ads.ContentKeyWord);
                    var word = r.Match(SearchedText);
                    string containedLine = word.Value;

                    if (!string.IsNullOrEmpty(SearchedText))
                    {
                        string NewContent = string.Empty;

                        string[] Newtokens = Regex.Split(SearchedText, ads.ContentKeyWord, RegexOptions.IgnoreCase);

                        if (Newtokens.Length > 1)
                        {
                            if (!string.IsNullOrEmpty(containedLine))
                            {
                                SearchedText = Newtokens[0] + " <em> " + containedLine + " </em> " + Newtokens[1] + "...";
                            }

                        }
                        if (Newtokens.Length == 1)
                        {
                            if (!string.IsNullOrEmpty(containedLine))
                            {
                                SearchedText = " <em> " + containedLine + " </em> " + Newtokens[0] + "...";
                            }

                        }
                        NewContent = "";
                    }
                }


                UWObject file = new UWFile
                {
                    ObjectId = Convert.ToInt32(UniqueResult[i].ObjectId),
                    Extn = Convert.ToString((Extension)UniqueResult[i].Extn),
                    Name = Convert.ToString(UniqueResult[i].Name),
                    creationDate = (DateTime)UniqueResult[i].CreationDate,
                    Desc = Convert.ToString(UniqueResult[i].Desc),
                    Lineage = Convert.ToString(UniqueResult[i].Lineage),
                    Moddate = (DateTime)UniqueResult[i].ModDate,
                    permission = (ObjectPermission)((Convert.ToInt32(UniqueResult[i].Permission))),
                    permString = Convert.ToString((ObjectFilePermission)(Convert.ToInt32(UniqueResult[i].Permission))),
                    Size = Math.Round((decimal)UniqueResult[i].Size/ 1024),
                    IndexPath = FindIndexPath(Convert.ToString(UniqueResult[i].Lineage)),
                    Type = ObjectType.File,
                    Path = Convert.ToString(UniqueResult[i].path),
                    SharedWithUsers = FindShareWithNames(Convert.ToInt32(UniqueResult[i].ObjectId), userId),
                    ContentSearch = SearchedText

                };

                uwList.Add(file);
            }
            }

            catch (Exception e)
                {
                    //throw;
                }
            

            return uwList;
        }  

       /* public List<UWObject> AdvSearch(int tenantId, string SelFileTypeList, int userId, string listLineage, string contentKeyWord, DateTime StartDt, DateTime EndDt, string listSelUserIds, bool isFullTextSearch)
        {
            List<UWObject> uwList = new List<UWObject>();

            int searchParameter = 1;
            using (var conn = new SqlConnection(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    DataTable files = new DataTable();
                    SqlCommand cmd = new SqlCommand("dbo.uspSearchUserWorkSpace_Copy", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (!string.IsNullOrEmpty(contentKeyWord))
                    {
                        SqlParameter SearchString = cmd.Parameters.Add("@SearchString", SqlDbType.NVarChar, 4000);
                        SearchString.Direction = ParameterDirection.Input;
                        SearchString.Value = contentKeyWord;
                    }

                    SqlParameter SearchParameter = cmd.Parameters.Add("@SearchParameter", SqlDbType.TinyInt);
                    SearchParameter.Direction = ParameterDirection.Input;
                    SearchParameter.Value = searchParameter;

                    if (!string.IsNullOrEmpty(listLineage) && listLineage != "null")
                    {
                        SqlParameter Lineage = cmd.Parameters.Add("@Lineage", SqlDbType.NVarChar, 4000);
                        Lineage.Direction = ParameterDirection.Input;
                        Lineage.Value = listLineage;
                    }

                    SqlParameter File_Type = cmd.Parameters.Add("@File_Type", SqlDbType.NVarChar, 4000);
                    File_Type.Direction = ParameterDirection.Input;
                    File_Type.Value = SelFileTypeList;

                    SqlParameter ShareWithId = cmd.Parameters.Add("@ShareWithId", SqlDbType.NVarChar, 4000);
                    ShareWithId.Direction = ParameterDirection.Input;
                    ShareWithId.Value = listSelUserIds;

                    SqlParameter StartDate = cmd.Parameters.Add("@StartDate", SqlDbType.Date);
                    StartDate.Direction = ParameterDirection.Input;
                    StartDate.Value = StartDt;

                    SqlParameter EndDate = cmd.Parameters.Add("@EndDate", SqlDbType.Date);
                    EndDate.Direction = ParameterDirection.Input;
                    EndDate.Value = EndDt;


                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adp.Fill(ds);
                    if (ds.HasData())

                        files = ds.Tables[0];
                    string SearchedText = "";

                    for (int i = 0; i < files.Rows.Count; i++)
                    {
                        Extension fetchedExtn = ((Extension)files.Rows[i]["Extn"]);
                        if (!string.IsNullOrEmpty(contentKeyWord))
                        {
                            if (Convert.ToString((Extension)files.Rows[i]["Extn"]).ToLower().Last() == 'x')
                            {
                                ParserTypeFactory factory = new ConcreteParserContentFactory();
                                ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.XMLType);

                                string contentLine = parserFactory.Parsing((byte[])(files.Rows[i]["file_stream"]), contentKeyWord);
                                SearchedText = contentLine;

                            }
                            else if (fetchedExtn.ToString().ToLower() == "pdf")
                            {
                                ParserTypeFactory factory = new ConcreteParserContentFactory();
                                ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.PDFType);

                                string contentLine = parserFactory.Parsing((byte[])(files.Rows[i]["file_stream"]), contentKeyWord);
                                SearchedText = contentLine;
                            }
                            else
                            {
                                ParserTypeFactory factory = new ConcreteParserContentFactory();
                                ParserIFactory parserFactory = factory.getParserContentType(ParsersTypes.TextType);

                                string contentLine = parserFactory.Parsing((byte[])(files.Rows[i]["file_stream"]), contentKeyWord);
                                SearchedText = contentLine.Replace("\0", string.Empty).Replace("\r", string.Empty);
                            }

                            Regex r = new Regex("(?i)" + contentKeyWord);
                            var word = r.Match(SearchedText);
                            string containedLine = word.Value;

                            if (!string.IsNullOrEmpty(SearchedText))
                            {
                                string NewContent = string.Empty;

                                string[] Newtokens = Regex.Split(SearchedText, contentKeyWord, RegexOptions.IgnoreCase);

                                if (Newtokens.Length > 1)
                                {
                                    if (!string.IsNullOrEmpty(containedLine))
                                    {
                                        SearchedText = Newtokens[0] + " <em> " + containedLine + " </em> " + Newtokens[1] + "...";
                                    }

                                }
                                if (Newtokens.Length == 1)
                                {
                                    if (!string.IsNullOrEmpty(containedLine))
                                    {
                                        SearchedText = " <em> " + containedLine + " </em> " + Newtokens[0] + "...";
                                    }

                                }
                                NewContent = "";
                            }
                        }


                        UWObject file = new UWFile
                        {
                            ObjectId = Convert.ToInt32(files.Rows[i]["ObjectID"]),
                            Extn = Convert.ToString((Extension)files.Rows[i]["Extn"]),
                            Name = Convert.ToString(files.Rows[i]["Name"]),
                            creationDate = (DateTime)files.Rows[i]["creationDate"],
                            Desc = Convert.ToString(files.Rows[i]["Desc"]),
                            Lineage = Convert.ToString(files.Rows[i]["Lineage"]),
                            Moddate = (DateTime)files.Rows[i]["creationDate"],
                            permission = (ObjectPermission)((Convert.ToInt32(files.Rows[i]["permission"]))),
                            permString = Convert.ToString((ObjectPermission)(Convert.ToInt32(files.Rows[i]["permission"]))),
                            Size = Math.Round((decimal)files.Rows[i]["Size"] / 1024),
                            IndexPath = FindIndexPath(Convert.ToString(files.Rows[i]["Lineage"])),
                            Type = ObjectType.File,
                            Path = Convert.ToString(files.Rows[i]["Path"]),
                            SharedWithUsers = FindShareWithNames(Convert.ToInt32(files.Rows[i]["ObjectID"]), userId),
                            ContentSearch = SearchedText

                        };

                        uwList.Add(file);
                    }
                }

                catch (Exception e)
                {
                    throw;
                }
            }

            return uwList;
        }   */
    }

}