using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntityFramework.Extensions;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using System.Data;
using System.IO;
using System.Web;
using PAFE = PharmaACE.ForecastApp.EntityProvider;
using PharmaACE.ForecastApp.Models;
using System.Data.Entity;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Collections.ObjectModel;

namespace PharmaACE.ForecastApp.Business
{
   public class UserWorkspace
    {
        public List<ObjectUserMapping> GetFolderList(int userId,int tenantId)
        {
            List<PAFE.TenantModel.ObjectUserMapping> userFolders = new List<PAFE.TenantModel.ObjectUserMapping>();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {                 
                   
                    var folderList = context.ObjectUserMapping.Include("ObjectMaster").Include("ObjUserPermission").Where(s => (s.ShareById == userId || s.ShareWithId == userId)
                                     && s.ObjUserPermission.LastOrDefault().Permission !=(byte)ObjectPermission.NoAccess
                    ).ToList();
                    var list = folderList.Where(u => u.ObjectMaster.Lineage == "3");                  
                    userFolders = folderList;                    
                }

                catch (Exception ex)
                {

                }

            }

            return userFolders;
        }

        public List<UWObject> GetContentfFolder(int userId, int tenantId,int objectId,string lineage, string parentIndex="")
        {

            UWFolder folder = new UWFolder();
            List<UWObject> UWFileFolder = new List<UWObject>();
            List<UWFile> uwfile = new List<UWFile>();
            List<UWFolder> uwfolder = new List<UWFolder>();
            int CountOfFile = 0;

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    int type = (int)ObjectType.SubFolder;
                    string LineageForFileCount=string.Empty;

                    var ProjectCreatorsList = context.ObjectMaster
                                            .Where(p => p.Id == objectId && ((p.DealDetails
                                            .OrderByDescending(d => d.CreatedDate)
                                            .FirstOrDefault().BDL_Lead == userId) ||
                                            p.DealDetails
                                            .OrderByDescending(d => d.CreatedDate)
                                            .FirstOrDefault().DealChampion == userId)).FirstOrDefault();

                    #region ifProjectCreator

                    var anonymousObjectList = context.ObjectMaster
                       .Where(om => om.ParentId == objectId && om.Type == type)

                     .Select(om => new
                     {
                         Id = om.Id,
                         Extn = (Extension)om.Extn,
                         Type = om.Type,
                         Size = om.Size,
                         Lineage = om.Lineage,
                         Name = om.Name,
                         Path = om.Path,
                         
                         Details = om.ObjectUserMapping.Where(p => p.ShareWithId == userId).Select(oum => new
                         {
                             CreationDate = oum.CreationDate,
                             Desc = oum.Description,
                             Permission = oum.ObjUserPermission.Where(op => op.Permission != (byte)ObjectPermission.NoAccess)
                             .OrderByDescending(oup => oup.ModifiedDate)
                             .Select(oup => new
                             {
                                 Perm = oup.Permission,
                                 ModDate = oup.ModifiedDate
                             }).FirstOrDefault()
                         }).FirstOrDefault()
                     }).ToList();



                    #endregion


                    #region ifNotProjectCreator
                    if (ProjectCreatorsList == null)
                    {
                         anonymousObjectList = context.ObjectMaster
                          .Where(om => om.ParentId == objectId && om.Type == type &&
                         om.ObjectUserMapping.Select(oum => oum.ShareWithId).Contains(userId))
                          

                        .Select(om => new
                        {
                            Id = om.Id,
                            Extn = (Extension)om.Extn,
                            Type = om.Type,
                            Size = om.Size,
                            Lineage = om.Lineage,
                            Name = om.Name,
                            Path = om.Path,

                            Details = om.ObjectUserMapping.Select(oum => new
                            {
                                CreationDate = oum.CreationDate,
                                Desc = oum.Description,
                                Permission = oum.ObjUserPermission.Where(op => op.Permission != (byte)ObjectPermission.NoAccess)
                                .OrderByDescending(oup => oup.ModifiedDate)
                                .Select(oup => new
                                {
                                    Perm = oup.Permission,
                                    ModDate = oup.ModifiedDate
                                }).FirstOrDefault()
                            }).FirstOrDefault()
                        }).ToList();
                    }
                    #endregion



                    int IndexCount = 1;

                    foreach (var item in anonymousObjectList)
                    {
                        
                        if(item.Lineage == "0")

                        {
                            LineageForFileCount = Convert.ToString(item.Id);

                        }
                        else
                        {
                            LineageForFileCount = item.Lineage + "/" + item.Id;
                        }
                        

                        var Files = context.ObjectMaster.Where(u => (u.Lineage.StartsWith(LineageForFileCount) || u.Lineage==(LineageForFileCount+GenUtil.LINEAGE_SPLITTER))
                        && u.Type==2).ToList();
                        CountOfFile = Files.Count();


                        UWObject folders = new UWFolder
                        {
                            ObjectId = item.Id,
                            Name = item.Name,
                            creationDate = item.Details.CreationDate,
                            Desc = item.Details.Desc,
                            Lineage = item.Lineage,
                            Moddate = item.Details.Permission.ModDate,
                            permission = (ObjectPermission)item.Details.Permission.Perm,
                            Size = item.Size,
                            Type = ObjectType.SubFolder,
                            FileCounts = CountOfFile,
                            Index = parentIndex + "." + IndexCount                    
                            
                        };

                        UWFileFolder.Add(folders);
                        IndexCount = IndexCount + 1;
                    }


                   
                    return UWFileFolder;

}

                catch (Exception ex) {
                    throw;
                }
            }
           
        }

        public List<UWActivityReporting> GetContentFileForReporting(int userId, int tenantId, int objectId, string lineage)
        {

            UWFolder folder = new UWFolder();
            List<UWActivityReporting> UWReporting = new List<UWActivityReporting>();
            List<UWFile> uwfile = new List<UWFile>();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    int type = (int)ObjectType.File;
                    Extension fileExtn;
                    
                    var anonymousObjectList = context.ActivityDetailsMaster.Where(o => o.ObjectMaster.Lineage.StartsWith(lineage+"/") || o.ObjectMaster.Lineage == lineage || o.ObjectMaster.Id==objectId)
                        .Select(
                        k => new
                        {
                            objectId=k.ObjectId,
                            ActivityDate = k.ActDate,
                            Activity = k.Activity,
                            UserId = k.UserId,
                            Name = k.ObjectMaster.Name,
                            Type = k.ObjectMaster.Type,
                            Lineage = k.ObjectMaster.Lineage,
                            Size = k.ObjectMaster.Size,
                            Extn = k.ObjectMaster.Extn,
                            CustomMessage= k.CustomMessage
                           

                        }).ToList();






                    #region testing

                    foreach (var item in anonymousObjectList)
                    {
                        List<int> userIds = new List<int>();
                        userIds.Add(item.UserId);
                        UserInfo userInfo = new UserInfo();
                        var accessors = new UserManager().GetUserInfoByUserId(userIds);
                        userInfo = accessors[item.UserId];
                      
                        fileExtn = (Extension)item.Extn;
                        string mylineage = item.Lineage;
                     int   idForName =Convert.ToInt32 (mylineage.Split('/').Last());
                       string name= context.ObjectMaster.Where(u => u.Id== idForName)
                                            .Select(u => u.Name).FirstOrDefault();
                        UWActivityReporting file = new UWActivityReporting
                        {

                            Extn = fileExtn.ToString(),
                            Name = item.Name,
                            Lineage = item.Lineage,
                            Size = (decimal)item.Size / 1024,
                            Type = (ObjectType)item.Type,

                            ActivityDate = item.ActivityDate,

                            UserId = item.UserId,
                            ActivityName = ((Activity)item.Activity).ToString(),
                            FullName = userInfo.FirstName+" "+userInfo.LastName,
                            MainFolderName = name,
                            CustomMessage=item.CustomMessage
                            
                           

                    };

                        UWReporting.Add(file);

                        // }
                    }

                    #endregion

                   

                }

                catch (Exception ex)
                {
                  
                }
            }
            return UWReporting;
        }

        public List<UWObject> GetContentfFile(int userId, int tenantId, int objectId, string lineage)
        {

            UWFolder folder = new UWFolder();
            List<UWObject> UWFileFolder = new List<UWObject>();
            List<UWFile> uwfile = new List<UWFile>();
           
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    int type = (int)ObjectType.File;
                    Extension fileExtn;
                    //  var anonymousObjectList = context.ObjectMaster.Where(om => om.ParentId == objectId && om.Lineage.StartsWith(lineage) && om.Type == type &&
                    var anonymousObjectList = context.ObjectMaster.Where(om => (om.Lineage.StartsWith(lineage + GenUtil.LINEAGE_SPLITTER) || om.Lineage == lineage)
                                              && om.Type == type)

                      //.Select(o => new
                      //{
                      //    Id=o.ObjectUserMapping
                      //    .Where(u=>u.ShareWithId==userId)
                      //    .Select(op=>op.CreationDate).FirstOrDefault()
                      //}).ToList();//&&
                      // om.ObjectUserMapping.Where(um=>um.ShareWithId==userId ).Select(um => um.ShareWithId).Contains(userId)).ToList();                                          
                      .Select(om => new
                      {
                          Id = om.Id,
                          Extn = (Extension)om.Extn,
                          Type = om.Type,
                          Size = om.Size,
                          Lineage = om.Lineage,
                          Name = om.Name,
                          Path = om.Path,
                          Details = om.ObjectUserMapping.Where(p => p.ShareWithId == userId || p.ShareById==userId)
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
                        ObjectPermission enumDisplayStatus = (ObjectPermission)item.Details.Permission.Perm;
                        string Perm = enumDisplayStatus.ToString();

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
                            permString=Perm,
                            Size = (decimal)item.Size / 1024,
                            Type = ObjectType.File,
                            Path = item.Path

                        };

                        UWFileFolder.Add(file);

                        // }
                    }

                    return UWFileFolder;

                }

                catch (Exception ex)
                {
                    throw;
                }
            }

        }
       
        public List<UWObject> GetRootFolder(int userId, int tenantId)
        {                               

                    UWFolder folder = new UWFolder();
                    List<UWObject> UWFileFolder = new List<UWObject>();
                  
                    List<UWFolder> uwfolder = new List<UWFolder>();
                    int CountOfFile = 0;


            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    int type = (int)ObjectType.RootFolder;
                    string LineageForFileCount = string.Empty;

                    var anonymousObjectList = context.ObjectMaster.Where(om => om.Type == type && om.ObjectUserMapping.Select(oum => oum.ShareWithId).Contains(userId))
                      .Select(om => new
                      {
                          Id = om.Id,
                          Extn =(Extension) om.Extn,
                          Type = om.Type,
                          Size = om.Size,
                          Lineage = om.Lineage,
                          Name = om.Name,
                          Path = om.Path,


                          Details = om.ObjectUserMapping.Select(oum => new
                          {
                              CreationDate = oum.CreationDate,
                              Desc = oum.Description,
                              Permission = oum.ObjUserPermission.Where(op=>op.Permission!=(byte)ObjectPermission.NoAccess).OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                              {
                                  Perm = oup.Permission,
                                  ModDate = oup.ModifiedDate
                              }).FirstOrDefault()
                          }).FirstOrDefault()
                      }).ToList();

                    foreach (var item in anonymousObjectList)
                    {                        //if ((ObjectType)item.Type == ObjectType.SubFolder)
                        //{
                        if (item.Lineage == "0")

                        {
                            LineageForFileCount = Convert.ToString(item.Id);

                        }
                        else
                        {
                            LineageForFileCount = item.Lineage + "/" + item.Id;
                        }
                        var Files = context.ObjectMaster.Where(u => u.Lineage.StartsWith(LineageForFileCount) && u.Type==2).ToList();

                        CountOfFile = Files.Count();


                        UWObject folders = new UWFolder
                        {
                            ObjectId = item.Id,
                            Name = item.Name,
                            creationDate = item.Details.CreationDate,
                            Desc = item.Details.Desc,
                            Lineage = item.Lineage,
                            Moddate = item.Details.Permission.ModDate,
                            permission = (ObjectPermission)item.Details.Permission.Perm,
                            Size = item.Size,
                            Type = ObjectType.SubFolder,
                            FileCounts = CountOfFile
                        };

                        UWFileFolder.Add(folders);
                    }

                   

                }
                catch (Exception e)
                {


                }

                return UWFileFolder;
                //UWFileFolder = ;


            }
                }
        

        public int paste(int objectIdForCopy, string lineageForCopy, int objectIdForPaste, string lineageForPaste, int tenantId,int userId,string folderNameForCopy)
        {
          
         using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {

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
                    lineageForCopy = lineageForCopy + GenUtil.LINEAGE_SPLITTER + objectIdForCopy;

                    var mainfolder = context.ObjectMaster.Find(objectIdForCopy);
                    var SourcechildFolders = context.ObjectMaster.Where(o => (o.Lineage.StartsWith(lineageForCopy + "/") || o.Lineage == lineageForCopy))

                                            .ToList();



                    var foldercopy=new ObjectMaster();

                    if (folderNameForCopy == null)
                    {
                        foldercopy = new ObjectMaster()
                        {
                            Extn = mainfolder.Extn,
                            Lineage = lineageForPaste,
                            Name = mainfolder.Name,

                            Type = mainfolder.Type,
                            ParentId = objectIdForPaste,
                            Size = mainfolder.Size,

                            Path = mainfolder.Path

                        };
                    }
                    else
                    {
                        foldercopy = new ObjectMaster()
                        {
                            Extn = mainfolder.Extn,
                            Lineage = lineageForPaste,
                            Name = folderNameForCopy,

                            Type = mainfolder.Type,
                            ParentId = objectIdForPaste,
                            Size = mainfolder.Size,

                            Path = mainfolder.Path

                        };

                    }
                    
                    var foldercopyUserMapping = new ObjectUserMapping()
                    {
                        CreationDate = DateTime.Now,
                        isGroup=false,
                        ShareById=userId,
                        ShareWithId=userId
                    };
                    var foldercopyUserPermission = new ObjUserPermission()
                    {
                        ModifiedDate = DateTime.Now,
                        Permission=(byte)ObjectPermission.Creator                        

                    };
                    foldercopyUserMapping.ObjUserPermission.Add(foldercopyUserPermission);
                    foldercopy.ObjectUserMapping.Add(foldercopyUserMapping);                   
                    context.ObjectMaster.Add(foldercopy);

                    context.SaveChanges();
                    int foldercopyId = foldercopy.Id;

                    string resultedLineage = "0";
                    int newParentId = 0;
                    string[] splitLineage;
                    int objectIdLineage = 0;
                    string FolderName;
                    bool validInsert = false;

                     foreach (var item in SourcechildFolders)
                    {
                        
                        if (item.ParentId ==objectIdForCopy)
                        {
                            resultedLineage = lineageForPaste  +  GenUtil.LINEAGE_SPLITTER + foldercopyId;
                            newParentId = foldercopyId;
                            validInsert = true;

                        }
                        else 
                        {

                            splitLineage = item.Lineage.Split(new string[] { GenUtil.LINEAGE_SPLITTER }, StringSplitOptions.None);

                            objectIdLineage = Convert.ToInt32(splitLineage.Last());

                            FolderName = SourcechildFolders.Where(u => u.Id == objectIdLineage).Select(u => u.Name).FirstOrDefault();//Find(objectIdLineage).Name;

                            var parent = context.ObjectMaster
                                              .Where(u => u.Name == FolderName 
                                              && (u.Lineage.StartsWith(lineageForPaste+GenUtil.LINEAGE_SPLITTER) || u.Lineage ==lineageForPaste)).FirstOrDefault();


                            newParentId = parent.Id;
                            resultedLineage = parent.Lineage + GenUtil.LINEAGE_SPLITTER + Convert.ToString(newParentId);
                            

                            validInsert = true;
                         }
                        if (validInsert)
                        {
                            var objMaster = new ObjectMaster
                            {
                                Extn = item.Extn,
                                Lineage = resultedLineage,
                                Name = item.Name,
                                ParentId = newParentId,
                                Size = item.Size,
                                Type = item.Type,
                                Path=item.Path
                                
                            };

                            var objUserMapping = new ObjectUserMapping
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = userId
                            };

                            var objPermission = new ObjUserPermission
                            {
                                ModifiedDate = DateTime.Now,
                                Permission = (byte)ObjectPermission.FullControl
                            };

                            objUserMapping.ObjUserPermission.Add(objPermission);
                            objMaster.ObjectUserMapping.Add(objUserMapping);

                            context.ObjectMaster.Add(objMaster);
                            context.SaveChanges();
                        }


                    }
                        return 1;
                }
                catch(Exception e)
                {
                    return 0;
                }
                
                
                }  
                  
        }


        public int checkNameForPaste(int objectIdForPaste, string lineageForPaste, int tenantId, int userId,string folderNameForCopy)
        {

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
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
                  

                    
                    var subFolderList = context.ObjectMaster.Where(o =>o.Lineage == lineageForPaste).Select(o=>o.Name)
                                            .ToList();

                    foreach (var item in subFolderList)
                    {
                        if(item==folderNameForCopy)
                        {
                            isFolderPresent = true;
                            break;
                        }

                    }
                    if(isFolderPresent==true)
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

        }
        public int AddFolder(int parentId,  string ChildName, int tenantId,int userid)
        {
            //ObjectMaster obj = new ObjectMaster();
           // ObjectUserMapping objuser = new ObjectUserMapping();
           // ObjUserPermission objpermsn = new ObjUserPermission();

            int subparentId;
            string lineage=string.Empty;


            string msg=string.Empty;
            //int result = 0;

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {

                try
                {
                    //result = ContextUtil.ValidatePermission(userid,(int) Activity.CreateFolder, parentId, context);
                   var id = context.ObjectMaster.Where(u => u.Id == parentId).FirstOrDefault();
                   subparentId = Convert.ToInt16(id.Id);
                    //  parentLineage = ;
                    lineage = id.Lineage;

                    if (lineage == "0")
                    {
                       lineage =Convert.ToString(parentId);
                    }
                    else
                    {
                        lineage= lineage + GenUtil.LINEAGE_SPLITTER + parentId;
                    }

                  

                var objectMasterCheck= context.ObjectMaster.Where(u => u.ParentId == parentId && u.Name== ChildName).FirstOrDefault();

                    if (objectMasterCheck == null)
                    {
                        var objmasters = new ObjectMaster
                        {


                            ParentId = subparentId,
                            Name = ChildName.Trim(),
                            Type = (int)ObjectType.SubFolder,
                            Extn = 1,
                            Lineage = lineage,
                            Size = 2
                        };

                        //context.ObjectMaster.Add(objmasters);
                        // context.SaveChanges();
                       //var ObjectEntry = context.ObjectMaster.Where(u => u.Name == ChildName && u.ParentId == subparentId).FirstOrDefault();
                      //int objectId = ObjectEntry.Id;
                        ObjectUserMapping objuser = new ObjectUserMapping
                        {
                           
                            isGroup = false,
                            ShareById = userid,
                            ShareWithId = userid,
                            CreationDate = DateTime.Now
                        };
                        //context.ObjectUserMapping.Add(objuser);
                        // context.SaveChanges();

                        ObjUserPermission objpermsn = new ObjUserPermission
                        {
                            ModifiedDate = DateTime.Now,
                            Permission = (byte)ObjectPermission.FullControl
                        };


                        objuser.ObjUserPermission.Add(objpermsn);
                        objmasters.ObjectUserMapping.Add(objuser);
                        context.ObjectMaster.Add(objmasters);

                       // var ObjectUser = context.ObjectUserMapping.Where(u => u.ObjectId == objectId).FirstOrDefault();
                         //objpermsn.ObjUserId = ObjectUser.Id;
                        //objpermsn.ModifiedDate = DateTime.Now;
                        //objpermsn.Permission = 1;

                        //context.ObjUserPermission.Add(objpermsn);
                        string message = "New Folder Created";
                        int result =ContextUtil.addActivityDetails((int)Activity.CreateFolder,objmasters.Id,DateTime.Now,context,userid, message);
                        if (result == 1)
                        {
                            context.SaveChanges();
                            return 1; //success
                        }
                        return 0;
                    }
                    else
                    {
                        return  0; //already present

                    }


                }
                catch (Exception e)
                {
                    return 2; //system error
                    
                }

            }

            
        }
        public int RenameFolder(int oldFolderId, string newName, int tenantId, int userid)
        {
            int result = 0;

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {

                try
                {
                    //result = ContextUtil.ValidatePermission(userid,(int) Activity.CreateFolder, parentId, context);
                    var id = context.ObjectMaster.Find(oldFolderId);
                    string oldName = id.Name;
                    id.Name = newName;
                    int type = id.Type;
                    if (type == 1 || type == 0)
                    {
                        string message = oldName + " folder is renamed to " + newName;
                        result = ContextUtil.addActivityDetails((int)Activity.CreateProject, oldFolderId, DateTime.Now, context, userid, message);

                    }
                    if (type == 2)
                    {
                        string message = oldName + " file is renamed to " + newName;
                        result = ContextUtil.addActivityDetails((int)Activity.Rename, oldFolderId, DateTime.Now, context, userid, message);

                    }

                    context.SaveChanges();
                    return result;
                }
                catch (Exception e)
                {
                    return result; //system error

                }

            }


        }


        public string GetFilePath(int objectId,int tenantId,int userId=0)
        {
            string FilePath=string.Empty;
            int result=1;
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
               // result= ContextUtil.ValidatePermission(userId,(int)Activity.DownoadFile,objectId,context);

                if (result==1)
                {
                    ObjectMaster obj = context.ObjectMaster.Find(objectId);
                    FilePath = obj.Path;
                }
                
            }
                return FilePath;
        }

        public string GetFileName(int objectId, int tenantId,int userid)
        {
            string FileName = string.Empty;

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                ObjectMaster obj = context.ObjectMaster.Find(objectId);
                FileName = obj.Name + "." + Convert.ToString((Extension)obj.Extn).ToLower();

                if (FileName != null)
                {
                    ContextUtil.addActivityDetails((int)Activity.DownoadFile, objectId, DateTime.Now, context, userid,"file downloaded successfully");
                    context.SaveChanges();
                }
            }
            return FileName;
        }
        
        public IEnumerable<StageMaster> GetStages(int tenantId)
        {         
            List<StageMaster> stages = new List<StageMaster>();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                stages = context.StageMaster.ToList();
            }

            return stages;
        }

        public IEnumerable<ActivityMaster> GetActivities(int tenantId)
        {
            List<ActivityMaster> activities = new List<ActivityMaster>();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                activities = context.ActivityMasters.ToList();
                  
            }

            return activities;
        }     

        public int CreateProject(int tenantId,int userId,int currency,string name, decimal deal, string performance, int status, int bdl, int dealchamp, int activity,int priority)
        {
            int result = 0;
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {                     
                try
                {
                    var objUserMapping2 = new ObjectUserMapping();
                    var objUserMapping1 = new ObjectUserMapping();                                    

                    bool isMultiObjRecords;
                    var objMaster = new ObjectMaster
                    {
                        Extn = 1,
                        Lineage = "0",
                        Name = name,
                        ParentId = 0,
                        Size = 2,
                        Type = (int)ObjectType.RootFolder
                    };
                    var dealDetail = new DealDetail
                    {
                        ActivityID = activity,
                        BDL_Lead = bdl,
                        Name = name,
                        Owner = userId,
                        DealChampion= dealchamp,
                        StageID = status,
                        Value = deal,
                        Objective = performance,
                        Currency=currency,
                        CreatedDate=DateTime.Now
                    };
                    var objUserMapping = new ObjectUserMapping
                    {
                        CreationDate = DateTime.Now,
                        isGroup = false,
                        ShareById = userId,
                        ShareWithId = userId
                    };

                    var objPermission = new ObjUserPermission
                    {
                        ModifiedDate = DateTime.Now,
                       // Permission = (byte)ObjectPermission.FullControl
                        Permission = (byte)ObjectPermission.Creator
                    };

                    if (bdl != userId && dealchamp != userId && bdl!=dealchamp)
                    {
                        isMultiObjRecords = true;

                        objUserMapping1 = new ObjectUserMapping
                        {
                            CreationDate = DateTime.Now,
                            isGroup = false,
                            ShareById = bdl,
                            ShareWithId = bdl
                        };
                        objUserMapping2 = new ObjectUserMapping
                        {
                            CreationDate = DateTime.Now,
                            isGroup = false,
                            ShareById = dealchamp,
                            ShareWithId = dealchamp
                        };

                        var objPermission1 = new ObjUserPermission /// NEED TO DEFINE THRICE FOR EACH OBJECTMASTER RECORD
                        {
                            ModifiedDate = DateTime.Now,
                            Permission = (byte)ObjectPermission.Creator
                        };
                        var objPermission2 = new ObjUserPermission
                        {
                            ModifiedDate = DateTime.Now,
                            Permission = (byte)ObjectPermission.Creator
                        };

                        objUserMapping.ObjUserPermission.Add(objPermission);
                        objMaster.ObjectUserMapping.Add(objUserMapping);

                        objUserMapping1.ObjUserPermission.Add(objPermission1);
                        objMaster.ObjectUserMapping.Add(objUserMapping1);

                        objUserMapping2.ObjUserPermission.Add(objPermission2);

                        objMaster.ObjectUserMapping.Add(objUserMapping2);

                        objMaster.DealDetails.Add(dealDetail);
                        context.ObjectMaster.Add(objMaster);

                    }

                    if (bdl == userId || dealchamp == userId || bdl==dealchamp) 
                    {
                        isMultiObjRecords = true;
                        if (bdl == userId)
                        {
                            objUserMapping1 = new ObjectUserMapping
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = dealchamp,
                                ShareWithId = dealchamp
                            };
                        }
                        else if (bdl == dealchamp)
                        {
                            objUserMapping1 = new ObjectUserMapping
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = dealchamp, // Assign any bdl/dealchap as both are same.
                                ShareWithId = dealchamp
                            };

                        }
                        if (dealchamp == userId)
                        {
                            objUserMapping1 = new ObjectUserMapping
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = bdl,
                                ShareWithId = bdl
                            };
                        }

                        var objPermission1 = new ObjUserPermission 
                        {
                            ModifiedDate = DateTime.Now,
                            Permission = (byte)ObjectPermission.Creator
                        };                       

                        objUserMapping.ObjUserPermission.Add(objPermission);
                        objMaster.ObjectUserMapping.Add(objUserMapping);

                        objUserMapping1.ObjUserPermission.Add(objPermission1);
                        objMaster.ObjectUserMapping.Add(objUserMapping1);
                                                
                        objMaster.DealDetails.Add(dealDetail);
                        context.ObjectMaster.Add(objMaster);
                    }

                    else
                    {
                        isMultiObjRecords = false;
                    } 

                    if(isMultiObjRecords==false)
                    {
                        objUserMapping.ObjUserPermission.Add(objPermission);
                        objMaster.ObjectUserMapping.Add(objUserMapping);
                        objMaster.DealDetails.Add(dealDetail);
                        context.ObjectMaster.Add(objMaster);
                    }
                    string msg = "New project created";
                    result = ContextUtil.addActivityDetails((int)Activity.CreateProject,objMaster.Id,DateTime.Now,context,userId,msg);
                    if (result == 1)
                    {
                        context.SaveChanges();
                        AddDefalutProjectFolders(objMaster.Id, objMaster.Lineage, userId, tenantId);
                        return result;
                    }
                }
                catch (Exception e)
                { }
            }
                    return result;

        }
        
        public int AddDefalutProjectFolders(int objectId,string pLineage,int ownerId,int tenantId)
        { 
            int result = 0;
            ObjectMaster insertedObjMaster = new ObjectMaster();
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    var DefaultFolderList = context.ProjectFolderList.ToList();
                    string resultedLineage="0";
                    int newParentId=0;
                    string[] splitLineage;
                    int objectIdLineage = 0;
                    string FolderName;
                    bool validInsert=false;

                    foreach (var item in DefaultFolderList)
                    {
                        if (item.Lineage=="1")
                        {
                            resultedLineage = objectId.ToString();                                                                                 
                            newParentId = objectId;
                            validInsert = true;

                        }
                        else if (item.Lineage!="1" && item.Lineage != "0")
                        {        

                                splitLineage=item.Lineage.Split(new string[] { GenUtil.LINEAGE_SPLITTER }, StringSplitOptions.None);

                                objectIdLineage = Convert.ToInt32(splitLineage.Last());

                                FolderName = DefaultFolderList.Where(u=>u.Id== objectIdLineage).Select(u => u.Name).FirstOrDefault();//Find(objectIdLineage).Name;

                                var parent = context.ObjectMaster
                                                  .Where(u => u.Name == FolderName && u.ParentId == objectId).FirstOrDefault();                               

                                newParentId = parent.Id;
                                resultedLineage=parent.Lineage+ GenUtil.LINEAGE_SPLITTER + Convert.ToString(newParentId);
                            validInsert = true;

                            
                        }
                        if (validInsert)
                        {
                            var objMaster = new ObjectMaster
                            {
                                Extn = item.Extn,
                                Lineage = resultedLineage,
                                Name = item.Name,
                                ParentId = newParentId,
                                Size = item.Size,
                                Type = (int)ObjectType.SubFolder
                            };

                            var objUserMapping = new ObjectUserMapping
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = ownerId,
                                ShareWithId = ownerId
                            };

                            var objPermission = new ObjUserPermission
                            {
                                ModifiedDate = DateTime.Now,
                               // Permission = (byte)ObjectPermission.FullControl
                                 Permission = (byte)ObjectPermission.Creator
                            };

                            objUserMapping.ObjUserPermission.Add(objPermission);
                            objMaster.ObjectUserMapping.Add(objUserMapping);

                            context.ObjectMaster.Add(objMaster);
                            context.SaveChanges();
                        }
                        



                    }

                }
                catch (Exception e)
                {

                    throw;
                }
            }
            return result;
        }


        public int ModifyProject(int tenantId, int userId,int currency, string name, decimal deal, string performance, int status, int bdl, int dealchamp, int activity, int priority, int projectId)
        {  
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {              
                try
                {
                    //DealDetail dt1 = context.DealDetails.Where(u => u.Name == name && u.ObjectMaster.Type == 0 && u.ObjectMaster.Id==projectId).FirstOrDefault();
                    
                    //DealDetail dt = (from x in context.DealDetails
                    //                 where x.ID== dt1.ID
                    //              select x).First();
                    //dt1.ActivityID = activity;
                    //dt1.BDL_Lead = bdl;
                    //dt1.Objective = performance;
                    //dt1.StageID = status;
                    //dt1.Value = deal;
                    //dt1.DealChampion = dealchamp;
                    //dt1.Priority = priority;
                    //dt1.Currency = currency;
                    //dt1.DealChampion = dealchamp;

                    var dealObject = new DealDetail()
                    {
                    Name=name,                        
                    ActivityID = activity,
                    BDL_Lead = bdl,
                    Objective = performance,
                    StageID = status,
                    Value = deal,
                    DealChampion = dealchamp,
                    Priority = priority,
                    Currency = currency,
                    CreatedDate=DateTime.Now,
                    Owner=userId, 
                    ObjectID= projectId

                    };
                    ContextUtil.addActivityDetails((int)Activity.ModifyProject, projectId,DateTime.Now,context,userId,"Project data has been modified.");

                    context.DealDetails.Add(dealObject);

                    if (bdl == dealchamp)
                    {
                        var objUserMapList = context.ObjectUserMapping.Where(oum => oum.ObjectId == projectId && oum.ShareWithId == bdl)
                            .Select(o => o.ShareWithId).FirstOrDefault();
                        if (objUserMapList == 0)
                        {
                            var objusermap = new ObjectUserMapping()
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = bdl,
                                ObjectId = projectId

                            };
                            var objuserperm = new ObjUserPermission()
                            {
                                ModifiedDate = DateTime.Now,
                                Permission = (byte)ObjectPermission.Creator

                            };
                        }

                    }
                    else if (bdl != dealchamp)
                    {
                        var objUserMapForBDL = context.ObjectUserMapping.Where(oum => oum.ObjectId == projectId && oum.ShareWithId == bdl)
                           .Select(o => o.ShareWithId).FirstOrDefault();
                        if (objUserMapForBDL == 0)
                        {
                            var objusermapforbdl = new ObjectUserMapping()
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = bdl,
                                ObjectId = projectId

                            };
                            var objuserpermforbdl = new ObjUserPermission()
                            {
                                ModifiedDate = DateTime.Now,
                                Permission = (byte)ObjectPermission.Creator

                            };

                            objusermapforbdl.ObjUserPermission.Add(objuserpermforbdl);
                            context.ObjectUserMapping.Add(objusermapforbdl);
                        }


                        var objUserMapForDealChamp = context.ObjectUserMapping.Where(oum => oum.ObjectId == projectId && oum.ShareWithId == dealchamp)
                           .Select(o => o.ShareWithId).FirstOrDefault();
                        if (objUserMapForDealChamp == 0)
                        {
                            var objusermapfordealchamp = new ObjectUserMapping()
                            {
                                CreationDate = DateTime.Now,
                                isGroup = false,
                                ShareById = userId,
                                ShareWithId = dealchamp,
                                 ObjectId=projectId
                                

                            };
                            var objuserpermfordealchamp = new ObjUserPermission()
                            {
                                ModifiedDate = DateTime.Now,
                                Permission = (byte)ObjectPermission.Creator

                            };

                            objusermapfordealchamp.ObjUserPermission.Add(objuserpermfordealchamp);
                            context.ObjectUserMapping.Add(objusermapfordealchamp);
                        }
                    }

                        context.SaveChanges();


                }
                catch (Exception e)

                { }
            }



            return 1;

        }

        public void UploadDocuments(int userId, int tenantId, string parentLineage, HttpFileCollectionBase files)
        {
            int result=0;
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

                            string key =  tenantId.ToString();
                            
                            //var res = GenUtil.UploadImageInBlob(string.Empty, file, StorageContext.WorkSpace);
                            ///////////////////////////////////////////////////////////////////////////////////////////

                            StorageTypeFactory factory = new ConcreteStorageFactory();
                            StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                            string path = storagefactory.Upload(key, file, StorageContext.WorkSpace);
                                

                            //////////////////////////////////////////////////////////////////////////////////////////


                            if (!String.IsNullOrEmpty(path))
                            {
                                var strExt = Path.GetExtension(fileName).Remove(0, 1);
                                var fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
                                string[] parentIDs = parentLineage.Split('/');
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
                                    Path = path,
                                    Type = (byte)ObjectType.File,
                                    Size = file.ContentLength


                                };
                                var objUserMapping = new ObjectUserMapping
                                {
                                    CreationDate = DateTime.Now,
                                    isGroup = false,
                                    ShareById = userId,
                                    ShareWithId = userId
                                };
                                var objPermission = new ObjUserPermission
                                {
                                    ModifiedDate = DateTime.Now,
                                    Permission = (byte)ObjectPermission.FullControl
                                };

                                objUserMapping.ObjUserPermission.Add(objPermission);
                                objMaster.ObjectUserMapping.Add(objUserMapping);
                                context.ObjectMaster.Add(objMaster);
                                result = ContextUtil.addActivityDetails((int)Activity.UploadFile, objMaster.Id, DateTime.Now, context,userId);
                            }
                        }
                    }
                    if (result == 1)
                    {
                        context.SaveChanges();
                    }

                }
                catch (Exception ex) { }
            }
        }        

        public DealData projectDetails(int tenantId, int userId, int objectId)
        {
            DealDetail dt = new DealDetail();
            DealData dealdata=new DealData();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    dt = context.DealDetails.Where(u => u.ObjectID == objectId).OrderByDescending(o=>o.CreatedDate).FirstOrDefault();
                    dealdata = new DealData()
                    {
                        ID = dt.ID,
                        Name = dt.Name,
                        ActivityID = dt.ActivityID,
                        BDL_Lead = dt.BDL_Lead,
                        ObjectID = dt.ObjectID,
                        Objective = dt.Objective,
                        DealChampion=dt.DealChampion,
                        Owner=dt.Owner,
                        StageID = dt.StageID,
                        Value = dt.Value,
                        Priority=dt.Priority,
                        Currency = dt.Currency,
                        projectId=objectId
                    };
                }
                catch (Exception e)
                {
                }
                return dealdata;
            }
        }

        public decimal getPrices(int tenantId, string stage)
        {
            decimal price=0;

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    if (stage != "onHoldWithdrwal" && stage != "Total")
                    {
                        price = context.DealDetails.Where(u => u.StageMaster.Name == stage).Select(u => u.Value).Sum();
                    }
                    else if (stage == "Total")
                    {
                        price = context.DealDetails.Select(u => u.Value).Sum();
                    }
                    else
                    {
                        price = context.DealDetails.Where(u => u.StageMaster.Name == "On Hold" || u.StageMaster.Name == "Complete withdrawal").Select(u => u.Value).Sum();                       
                    }
                }
                catch (Exception e)
                { }                
            }
            return price;
        }

        public double getCounts(int tenantId, string stage)
        {
            int count = 0;
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    if (stage!= "onHoldWithdrwal")
                {
                        count = context.DealDetails.Where(u => u.StageMaster.Name == stage).Select(u => u.ID).Count();
                    }
                    else
                    {
                        count = context.DealDetails.Where(u => u.StageMaster.Name == "On Hold" || u.StageMaster.Name== "Complete withdrawal").Select(u => u.ID).Count();
                    }                      
                }
                catch (Exception e)
                { }
            }
            return count;
        }

        public List<ActivityListData> GetActivitiesList(int tenantId)
        {
            List<ActivityListData> activityListData = new List<ActivityListData>();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    var anonymous = from c in context.ActivityMasters
                                    join o in context.DealDetails on c.Id equals o.ActivityID into  g
                                    select new { c.Name, Count = g.Count() , c.Id};
                 
                    foreach (var item in anonymous)
                    {
                        ActivityListData activity = new ActivityListData
                        {
                           ID = item.Id,
                            Name=item.Name,
                            projCounts=item.Count,
                            
                        };

                        activityListData.Add(activity);

                    }
                        

                }
                catch (Exception e)
                { }


                return activityListData;

            }



        }

        public  List<DealData> GetActivityWiseProjList(int tenantId,int activityId)
        {
            List<DealData> Dealdata = new List<DealData>();        
            UserManager um = new UserManager();
            UserLoginDetails UserBDL = new UserLoginDetails();
            UserLoginDetails UserDealChamp = new UserLoginDetails();
            DealData dealdata = new DealData();

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                  var  Deals = context.DealDetails.Where(u => u.ActivityID == activityId).ToList();
                    
                    foreach (var item in Deals)
                    {

                        UserBDL = um.GetUserInformationByUserId((int)item.BDL_Lead);
                        UserDealChamp = um.GetUserInformationByUserId((int)item.DealChampion);

                        DealData dl = new DealData
                        {
                            ID = item.ID,
                            Name = item.Name,
                            ActivityID = item.ActivityID,
                            BDL_Lead = item.BDL_Lead,
                            ObjectID = item.ObjectID,
                            Objective = item.Objective,
                            Owner = item.Owner,
                            DealChampion=item.DealChampion,
                            StageID = item.StageID,
                            Value = item.Value,
                            Priority = item.Priority,  
                                                   
                            BDLUserName = UserBDL.userInfo.FirstName  + " " + UserBDL.userInfo.LastName,
                            ActivityName=item.ActivityMaster.Name,
                            StageName=item.StageMaster.Name,
                            DealChampUserName= UserDealChamp.userInfo.FirstName + " " + UserDealChamp.userInfo.LastName
                        };

                        Dealdata.Add(dl);
                    }
                }
                catch (Exception e)
                {
                }
                return Dealdata;
            }           

        }

        public List<DealData> GetStageWiseProjList(int tenantId, string stageName)
        {
            List<DealDetail> Deals = new List<DealDetail>();
            List<DealData> Dealdata = new List<DealData>();
            UserManager um = new UserManager();           
            UserLoginDetails UserBDL = new UserLoginDetails();
            UserLoginDetails UserDealChamp = new UserLoginDetails();
           
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    if (stageName== "Screen / Profile" || stageName == "Diligence" || stageName == "Negotiation" )
                    {
                         Deals = context.DealDetails.Where(u => u.StageMaster.Name == stageName).ToList();
                    }
                    else if (stageName == "onHoldWithdrwal")
                    {
                         Deals = context.DealDetails.Where(u => u.StageMaster.Name == "On Hold" || u.StageMaster.Name == "Complete withdrawal").ToList();
                    }
                    else
                    {
                         Deals= context.DealDetails.ToList();
                    }
            
                    foreach (var item in Deals)
                    {
                        UserBDL = um.GetUserInformationByUserId((int)item.BDL_Lead);
                        UserDealChamp= um.GetUserInformationByUserId((int)item.Owner);
                        DealData dl = new DealData
                        {                           
                            ID = item.ID,
                            Name = item.Name,
                            ActivityID = item.ActivityID,
                            BDL_Lead = item.BDL_Lead,
                            ObjectID = item.ObjectID,
                            Objective = item.Objective,
                            Owner = item.Owner,
                            DealChampion=item.DealChampion,
                            StageID = item.StageID,
                            Value = item.Value,
                            Priority = item.Priority,
                            
                            BDLUserName = UserBDL.userInfo.FirstName + " " + UserBDL.userInfo.LastName,
                            ActivityName = item.ActivityMaster.Name,
                            StageName = item.StageMaster.Name,
                            DealChampUserName = UserDealChamp.userInfo.FirstName + " " + UserDealChamp.userInfo.LastName
                        };

                        Dealdata.Add(dl);
                    }
                }
                catch (Exception e)
                {
                }
                return Dealdata;
            }

        }
        
        public List<UWObject> AdvSearch(int tenantId, string SelFileTypeList, int userId, string listLineage,string StartDt,string EndDt,string listSelUserIds)
        {
            List<UWObject> uwList = new List<UWObject>();
            string[] extn;
            string[] UserIds;
            int[] shareWithUserIds = new int[0];
            int ShareWithId,hasExtn=0;
            int[] extns = new int[0];
            DateTime StartDate = new DateTime();
            DateTime EndDate = new DateTime();

            if (!string.IsNullOrEmpty(SelFileTypeList))
            {
                extn = SelFileTypeList.Split(',');
                if (extn.Count()>0)
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
            string[] lineage = listLineage.Split(',');
           
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {                    
                    int type = (int)ObjectType.File;
                    
                        #region IfHaveExtn
                        
                        var anonymousObjectList= context.ObjectMaster
                           .Where(om => lineage.Any(x => (om.Lineage.StartsWith(x))) && (hasExtn == 0 || extns.Contains(om.Extn) ) 
                       && om.Type == type && om.ObjectUserMapping
                       .Where(oum => (string.IsNullOrEmpty(StartDt) || oum.CreationDate > StartDate)  && (ShareWithId == 0 || shareWithUserIds.Contains(oum.ShareWithId)))
                       .Select(oum => oum.ShareById).Contains(userId))
                       
                      .Select(om => new
                      {
                          Id = om.Id,
                          Extn = (Extension)om.Extn,
                          Type = om.Type,
                          Size = om.Size,
                          Lineage = om.Lineage,
                          Name = om.Name,
                          Path = om.Path,
                          Details = om.ObjectUserMapping.Select(oum => new
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
                                Size = (decimal)item.Size / 1024,
                                Type = ObjectType.File,
                                Path = item.Path
                            };

                            uwList.Add(file);
                        }
                        #endregion                 
                }

                catch (Exception e)
                {
                }
                return uwList;
            }

        }
    
        public FullTextSearch ContentFilterSearch(int tenantId,  int userId,string filterKeyword,bool isFullTextSearch)
        {           
            int searchParameter=0;
            FullTextSearch flts = new FullTextSearch();

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

                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adp.Fill(ds);
                    if (ds.HasData())
                    files = ds.Tables[0];
                    flts.objectIds = new int[files.Rows.Count];
                    flts.SearchedText = new string[files.Rows.Count];
                    flts.Extn = new int[files.Rows.Count];

                    for (int i = 0; i < files.Rows.Count; i++)
                    {                     
                        flts.objectIds[i]= Convert.ToInt32(Convert.ToString(files.Rows[i][0]));
                        if (isFullTextSearch)
                        {
                            //System.Text.Encoding enc = System.Text.Encoding.ASCII;
                            //string myString = enc.GetString((byte[])(files.Rows[i][1]));                           
                            //string str;
                            //System.Text.UTF8Encoding encr = new System.Text.UTF8Encoding();
                            //str = encr.GetString((byte[])(files.Rows[i][1]));
                            //flts.SearchedText[i] =Convert.ToBase64String((byte[])(files.Rows[i][1]));
                            //byte[] a  = Convert.FromBase64String(flts.SearchedText[i]);

                            flts.Extn[i] = Convert.ToInt32(Convert.ToString(files.Rows[i][1]));

                            Extension fetchedExtn = (Extension)flts.Extn[i];
                            if (fetchedExtn.ToString().ToLower().Last()=='x' || fetchedExtn.ToString().ToLower() == "pdf" )
                            {
                                flts.SearchedText[i] = "....." + filterKeyword  +"......";
                               string str = System.Text.Encoding.Default.GetString((byte[])(files.Rows[i][2])); 
                            }
                            else
                            {
                                flts.SearchedText[i] = System.Text.Encoding.Default.GetString((byte[])(files.Rows[i][2]));
                                flts.SearchedText[i] = flts.SearchedText[i].Replace("\0", string.Empty);
                            }                         
                            
                        }
                    }   
                }
                catch (Exception e)
                {
                }
                return flts;
            }

        }
            
     public int Share(List<ShareModel> userForShare,int shareById,int tenantId)
        {
            int result = 0;
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    int objectId = userForShare[0].ObjectId;
                    ObjectMaster oum = new ObjectMaster();

                    string parentLineage = context.ObjectMaster.Find(objectId).Lineage.ToString();
                   
                    string[] splitLineage = parentLineage.Split('/');
                    var Users = context.ObjectMaster.Find(Convert.ToInt32(splitLineage.First())).ObjectUserMapping.ToList();


                    foreach (var item in userForShare)
                    {
                        foreach (var splitted in splitLineage)
                        {
                            int objEntry = context.ObjectMaster.Find(Convert.ToInt32(splitted))
                                            .ObjectUserMapping.Where(o => o.ShareWithId == item.UserId 
                                            && o.ObjUserPermission
                                            .OrderByDescending(oup=>oup.ModifiedDate).FirstOrDefault()
                                            .Permission!=(byte)ObjectPermission.NoAccess)
                                            .Select(o=>o.ShareWithId).FirstOrDefault();
                            if (objEntry==0)
                            {
                                var shareuserMaping = new ObjectUserMapping
                                {
                                    CreationDate = DateTime.Now,
                                    Description = "",
                                    isGroup = false,
                                    ShareById = shareById,
                                    ShareWithId = item.UserId,
                                    ObjectId = Convert.ToInt32(splitted)
                                };

                                var shareuserPerm = new ObjUserPermission
                                {
                                    ModifiedDate=DateTime.Now,
                                    Permission=(byte)ObjectFolderPermission.ContetFileShare
                                };

                                shareuserMaping.ObjUserPermission.Add(shareuserPerm);
                                context.ObjectUserMapping.Add(shareuserMaping);                               

                            }
                        }


                        var objuserMaping = new ObjectUserMapping
                        {
                            CreationDate = DateTime.Now,
                            Description = "",
                            isGroup = false,
                            ShareById = shareById,
                            ShareWithId = item.UserId,
                            ObjectId = objectId
                        };

                        var objuserPerm = new ObjUserPermission
                        {
                            ModifiedDate = DateTime.Now,
                            Permission = (byte)item.Permission
                        };

                        objuserMaping.ObjUserPermission.Add(objuserPerm);
                        context.ObjectUserMapping.Add(objuserMaping);

                    }
                    context.SaveChanges();

                    result = 1;
                }
                catch (Exception e)
                {   }
            }      

            return result;
        }

        public int UnShare(int objectId, int userId,int tenantId)
        {
            int result = 0;

            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    var ObjectUserMapped = context.ObjectUserMapping.Where(o => o.ObjectId == objectId 
                                           && o.ShareWithId == userId )
                                           .LastOrDefault();

                    var oum = new ObjUserPermission()
                    {
                        ObjUserId=ObjectUserMapped.Id,
                        ModifiedDate = DateTime.Now,
                        Permission =(byte) ObjectPermission.NoAccess                          
                    };
                    
                    context.ObjUserPermission.Add(oum);
                    context.SaveChanges();

                    result = 1;
                }
                catch (Exception e)
                { }
                return result;
            }
        }


        public List<ShareModel> FecthAlreadyShared(int ObjectId, int UserId, int tenantId)
        {
            List<ShareModel> SharedWithUsers = new List<ShareModel>();
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                try
                {
                    UserLoginDetails UserInfo = new UserLoginDetails();

                    var anonymousSharedList = context.ObjectUserMapping.Where(oum => oum.ObjectId == ObjectId 
                                              && oum.ShareWithId!=oum.ObjectMaster.DealDetails.Select(d=>d.DealChampion).FirstOrDefault()
                                              && oum.ShareWithId != oum.ObjectMaster.DealDetails.Select(d => d.BDL_Lead).FirstOrDefault()
                                              && oum.ShareWithId!=UserId
                                              && oum.ObjUserPermission.OrderByDescending(oup=>oup.ModifiedDate)
                                              .FirstOrDefault().Permission != (byte)ObjectPermission.NoAccess)
                        .Select(o => new
                        {
                            UserId = o.ShareWithId,
                            Permission = o.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
                            {
                                Perm = oup.Permission
                            }).FirstOrDefault()

                        }).ToList();

                    foreach (var item in anonymousSharedList)
                    {
                        UserInfo = new UserManager().GetUserInformationByUserId(item.UserId);
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
                catch (Exception e)
                {  }
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
                                string[] parentIDs = parentLineage.Split('/');
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
                                    CreationDate = DateTime.Now,
                                    isGroup = false,
                                    ShareById = userId,
                                    ShareWithId = userId
                                };
                                var objPermission = new ObjUserPermission
                                {
                                    ModifiedDate = DateTime.Now,
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

        public int PrevUserChangePermission(int UserId,int ProjectID, int BDLUserId, int DealChampId,int BDLUserPerm,int DealChampIdPerm,int tenantId)
        {
            using (var context = new TenantModel(GenUtil.GetTenantConnectionString(tenantId)))
            {
                if (BDLUserPerm != 0 && DealChampIdPerm == 0)
                {
                    var objMappinglist = context.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == BDLUserId))
                                        .ToList();
                    foreach (var item in objMappinglist)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)BDLUserPerm,
                            ModifiedDate = DateTime.Now
                        };
                        context.ObjUserPermission.Add(objperm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.Now, context, UserId, "Previous BD&L Lead Permision has been modified.");
                    }
                   

                }
                if (DealChampIdPerm != 0 && BDLUserPerm == 0)
                {
                    var objMappinglist = context.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == DealChampId))
                                        .ToList();
                    foreach (var item in objMappinglist)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)DealChampIdPerm,
                            ModifiedDate = DateTime.Now
                        };
                        context.ObjUserPermission.Add(objperm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.Now, context, UserId, "Previous DealChampion Permision has been modified.");
                    }
                    
                }
                if (BDLUserPerm != 0 && DealChampIdPerm != 0)
                {
                    var objMappinglist = context.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == BDLUserId))
                                        .ToList();
                    var objMappinglist1 = context.ObjectUserMapping.Where(oum => oum.ObjectId == ProjectID && (oum.ShareWithId == DealChampId))
                                        .ToList();

                    foreach (var item in objMappinglist)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)BDLUserPerm,
                            ModifiedDate = DateTime.Now
                        };
                        context.ObjUserPermission.Add(objperm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.Now, context, UserId, "Previous BD&L Lead Permision has been modified.");
                    }
                    foreach (var item in objMappinglist1)
                    {
                        var objperm = new ObjUserPermission()
                        {
                            ObjUserId = item.Id,
                            Permission = (byte)DealChampIdPerm,
                            ModifiedDate = DateTime.Now
                        };
                        context.ObjUserPermission.Add(objperm);
                        ContextUtil.addActivityDetails((int)Activity.changePermision, ProjectID, DateTime.Now, context, UserId, "Previous DealChampion Permision has been modified.");
                    }
                }
                context.SaveChanges();
            }

                return 1;
        }

    }

}