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


namespace PharmaACE.ForecastApp.Business
{
    public static class ContextUtil
    {

        public static int addActivityDetails(int activity, int objectId, DateTime actDate, TenantModel context, int userid, string customMessage = "")
        {
            int result = 0;
            try
            {
                var ActDetailMaster = new ActivityDetailsMaster()
                {
                    Activity = activity,
                    ObjectId = objectId,
                    ActDate = actDate,
                    UserId = userid,
                    CustomMessage = customMessage

                };
                context.ActivityDetailsMaster.Add(ActDetailMaster);
                result = 1;
            }
            catch (Exception e)
            {


            }

            return result;
        }

        ///////////////////////////
        public static int ValidatePermission(int userId, int activity, int objectId, TenantModel context)
        {
            int result = 1;
            int permission = 0;



            //var SharedBy = context.ObjectUserMapping.Where(o => o.ObjectId == objectId

            //        && (o.ShareById == userId)).ToList();

            //if (SharedBy.Count != 0)
            //{
            //    result = 1;
            //}
            //else
            //{
            //    var anonymousObjectList = context.ObjectMaster.Where(om => om.ObjectUserMapping.Select(oum => oum.ShareWithId).Contains(userId))
            //          .Select(om => new
            //          {
            //              Details = om.ObjectUserMapping.Select(oum => new
            //              {
            //                  Permission = oum.ObjUserPermission.OrderByDescending(oup => oup.ModifiedDate).Select(oup => new
            //                  {
            //                      Perm = oup.Permission,
            //                  }).FirstOrDefault()
            //              }).FirstOrDefault()
            //          }).FirstOrDefault();


            //    if (anonymousObjectList != null)
            //    {
            //        permission = Convert.ToInt32(anonymousObjectList.Details.Permission);

            //    }

            //    if (permission == (int)ObjectPermission.FullControl)
            //    {
            //        result = 1;
            //    }

            //    if (activity == (int)Activity.CreateFolder)
            //    {
            //        if (permission == (int)ObjectPermission.FolderLevelAccess)
            //        {
            //            result = 1;
            //        }
            //        else
            //        {
            //            result = 0;
            //        }
            //    }
            //    if (activity == (int)Activity.UploadFile)
            //    {
            //        if (permission == (int)ObjectPermission.FolderLevelAccess)
            //        {
            //            result = 1;
            //        }
            //        else
            //        {
            //            result = 0;
            //        }
            //    }
            //    if (activity == (int)Activity.DownoadFile)
            //    {
            //        if (permission == (int)ObjectPermission.FileLevelAccess)
            //        {
            //            result = 1;
            //        }
            //        if (permission == (int)ObjectPermission.DownloadFile)
            //        {
            //            result = 1;
            //        }
            //        else
            //        {
            //            result = 0;
            //        }
            //    }
            //    if (activity == (int)Activity.RenameFile)
            //    {
            //        if (permission == (int)ObjectPermission.FileLevelAccess)
            //        {
            //            result = 1;
            //        }
            //        if (permission == (int)ObjectPermission.RenameFile)
            //        {
            //            result = 1;
            //        }
            //        else
            //        {
            //            result = 0;
            //        }
            //    }
            //}

            return result;

        }
    }
}
