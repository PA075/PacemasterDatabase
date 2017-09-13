using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Web;
using Microsoft.Azure;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.StorageClient;
using System.Configuration;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.Models;
using System.Data;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Net;
using System.Runtime.Serialization.Formatters.Binary;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using System.Data.Entity;

namespace PharmaACE.ForecastApp.Business
    //decorator pattrn
{
    public interface StorageIFactory
    {
        string Upload(IUnitOfWork uow, string key, HttpPostedFileBase file, StorageContext context,ForecastModelType fmt=ForecastModelType.Generic,int forecastFolderType =1 , string videoUrl =""); //key guid replace to key //context enum to function
        string Upload(IUnitOfWork uow, string key, string file, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, int forecastFolderType = 1, string videoUrl = "");
        byte[] Download(IUnitOfWork uow, string key, StorageContext context, ForecastModelType fmt= ForecastModelType.Generic, int forecastFolderType=1);
    }    

    public class AzureStorageContext : StorageIFactory
    {
        public string Upload(IUnitOfWork uow, string key, HttpPostedFileBase file, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, int forecastFolderType = 1, string videoUrl = "")
        {
            string msg = string.Empty;
            BlobUploadResult result = new BlobUploadResult();

         
            try
            {
                if (file != null)
                {
                    // Retrieve storage account from connection string.
                    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(CloudConfigurationManager.GetSetting("StorageConnectionString"));

                    // Create the blob client.
                    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

                    // Retrieve reference to a previously created container.
                    //CloudBlobContainer container = blobClient.GetContainerReference("mediastorage");
                    CloudBlobContainer container = blobClient.GetContainerReference(GenUtil.GetStorageContainer(context));

                    // Retrieve reference to a blob named "photo1.jpg".
                    CloudBlockBlob blockBlob = container.GetBlockBlobReference(System.Guid.NewGuid().ToString()+ file.FileName);

                    blockBlob.UploadFromStream(file.InputStream);
                    result.BlobUrl = blockBlob.Uri.AbsoluteUri;
                    
                }
            }
            catch (Exception ex)
            {
                result.Message = ex.Message;
            }

            return result.BlobUrl;

        }

        public byte[] Download(IUnitOfWork uow, string key, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, int forecastFolderType = 1)
        {
            //string[] objTenant = key.Split(GenUtil.lineSeperator);     
            //string path = new UserWorkspace().GetFilePath(Convert.ToInt32(objTenant[0]), Convert.ToInt32(objTenant[1]));

            using (var client = new WebClient())
            {
                //var byteArr = client.DownloadData(path);
                var byteArr = client.DownloadData(key); //key is expected to be path here
                return byteArr;

            }
        }

        public string Upload(IUnitOfWork uow, string key, string file, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, int forecastFolderType = 1, string videoUrl = "")
        {
            throw new NotImplementedException();
        }
    }

    public class SQLFileTableStorageContext : StorageIFactory
    {
        public string Upload(IUnitOfWork uow, string key, HttpPostedFileBase file, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, 
            int forecastFolderType = 1, string videoUrl = "")
        {
            string result = "";
            DbContext dbContext = null;
           
            try
            {
                if (file != null && file.ContentLength > 0)
                {
                    Stream fs = file.InputStream;
                    var fileName = Path.GetFileName(file.FileName);
                    byte[] buf = new byte[file.ContentLength];
                    file.InputStream.Read(buf, 0, file.ContentLength);
                    if (context == StorageContext.Indication || context == StorageContext.Forum)
                    {
                        if(context == StorageContext.Indication)
                            fileName = fileName +"|" + key + "|" + videoUrl;
                         dbContext = uow.MasterContext;
                    }
                    else
                    {
                        dbContext = uow.TenantContext;
                    }
                        SqlParameter name = new SqlParameter("@name", SqlDbType.NVarChar, 1000);
                        name.Direction = ParameterDirection.Input;
                        name.Value = System.Guid.NewGuid().ToString()+ fileName;

                        SqlParameter file_stream = new SqlParameter("@file_stream", SqlDbType.VarBinary);
                        file_stream.Direction = ParameterDirection.Input;
                        file_stream.Value = (System.Data.SqlTypes.SqlBinary)buf;

                        SqlParameter ModuleType = new SqlParameter("@ModuleType", SqlDbType.TinyInt);
                        ModuleType.Direction = ParameterDirection.Input;
                        ModuleType.Value = (int)fmt;

                        SqlParameter FolderType = new SqlParameter("@FolderType", SqlDbType.TinyInt);
                        FolderType.Direction = ParameterDirection.Input;
                        FolderType.Value = forecastFolderType;

                  
                    result = dbContext.Database.SqlQuery<Guid>(string.Format("exec {0} @name, @file_stream, @ModuleType, @FolderType", 
                        GenUtil.getSPName(context, "Upload")), name, file_stream, ModuleType, FolderType).SingleOrDefault().SafeNoTrim();
                    
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }

        public string Upload(IUnitOfWork uow, string key, string file, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, 
            int forecastFolderType = 1, string videoUrl = "")
        {
            string result = "";
            DbContext dbContext = null;

            try
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    using (FileStream fs = File.OpenRead(file))
                    {
                        fs.CopyTo(ms);
                    }
                
                byte[] buf = ms.ToArray();
                if (context == StorageContext.Indication || context == StorageContext.Forum)
                {
                    if (context == StorageContext.Indication)
                        file = file + "|" + key + "|" + videoUrl;
                        dbContext = uow.MasterContext;
                }
                else
                {
                        dbContext = uow.TenantContext;
                }
                
                    SqlParameter name = new SqlParameter("@name", SqlDbType.NVarChar, 1000);
                    name.Direction = ParameterDirection.Input;
                    name.Value = Path.GetFileName(file);

                    SqlParameter file_stream = new SqlParameter("@file_stream", SqlDbType.VarBinary);
                    file_stream.Direction = ParameterDirection.Input;
                    file_stream.Value = (System.Data.SqlTypes.SqlBinary)buf;

                    SqlParameter ModuleType = new SqlParameter("@ModuleType", SqlDbType.TinyInt);
                    ModuleType.Direction = ParameterDirection.Input;
                    ModuleType.Value = (int)fmt;

                    SqlParameter FolderType = new SqlParameter("@FolderType", SqlDbType.TinyInt);
                    FolderType.Direction = ParameterDirection.Input;
                    FolderType.Value = forecastFolderType;

                    Guid uniqueKey = uow.TenantContext.Database.SqlQuery<Guid>(String.Format("exec {0} @name, @file_stream, @ModuleType, @FolderType",
                        GenUtil.getSPName(context, "Upload")), name, file_stream, ModuleType, FolderType).SingleOrDefault();
                    result = uniqueKey != null ? uniqueKey.ToString() : String.Empty;
            }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }

        //public string Upload(DbContext dbcontext, string key, string file, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, int forecastFolderType = 1, string videoUrl = "")
        //{
        //    string result = "";

        //    try
        //    {
        //        using (MemoryStream ms = new MemoryStream())
        //        {
        //            using (FileStream fs = File.OpenRead(file))
        //            {
        //                fs.CopyTo(ms);
        //            }

        //            byte[] buf = ms.ToArray();

        //            SqlParameter name = new SqlParameter("@name", SqlDbType.NVarChar, 1000);
        //            name.Direction = ParameterDirection.Input;
        //            name.Value = Path.GetFileName(file);

        //            SqlParameter file_stream = new SqlParameter("@file_stream", SqlDbType.VarBinary);
        //            file_stream.Direction = ParameterDirection.Input;
        //            file_stream.Value = (System.Data.SqlTypes.SqlBinary)buf;

        //            SqlParameter ModuleType = new SqlParameter("@ModuleType", SqlDbType.TinyInt);
        //            ModuleType.Direction = ParameterDirection.Input;
        //            ModuleType.Value = (int)fmt;

        //            SqlParameter FolderType = new SqlParameter("@FolderType", SqlDbType.TinyInt);
        //            FolderType.Direction = ParameterDirection.Input;
        //            FolderType.Value = forecastFolderType;

        //            result = dbcontext.Database.SqlQuery<string>(GenUtil.getSPName(context, "Upload"), name, file_stream, ModuleType, FolderType).SingleOrDefault();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }

        //    return result;
        //}

        public byte[] Download(IUnitOfWork uow, string key, StorageContext context, ForecastModelType fmt = ForecastModelType.Generic, 
            int forecastFolderType = 1)
        {
            DbContext dbContext = null;
            string[] streamTenant = key.Split(GenUtil.lineSeperator);
            string streamId = streamTenant[0];

            byte[] byteArr = new byte[0];
                DataTable obj = new DataTable();

            var sqlConn = new SqlConnection();
            if (context == StorageContext.Indication || context == StorageContext.Forum)
            {
                dbContext = uow.MasterContext;
            }
            else
            {
                dbContext = uow.TenantContext;
            }

            
                SqlParameter StreamID = new SqlParameter("@StreamID", SqlDbType.NVarChar, 1000);
                StreamID.Direction = ParameterDirection.Input;
                StreamID.Value = streamId;

            string query = String.Format("exec {0} @StreamID", GenUtil.getSPName(context, "Download"));
            byteArr = dbContext.Database.SqlQuery<byte[]>(query, StreamID).SingleOrDefault();

                return byteArr;
        }
    }
    
    public abstract class StorageTypeFactory
    {

        public abstract StorageIFactory getSTorageType(StorageType StorageType);
    }

    public class ConcreteStorageFactory : StorageTypeFactory
    {
        public override StorageIFactory getSTorageType(StorageType StorageType)
        {
            switch (StorageType.ToString())
            {
                case "Azure":
                    return new AzureStorageContext();

                case "SqlFileTable":
                    return new SQLFileTableStorageContext();

                default:
                    return new SQLFileTableStorageContext();
            }
        }

    }
            //StorageTypeFactory factory = new ConcreteStorageFactory();
            //StorageIFactory Azure = factory.getSTorageType("AzureStorageContext");
            //Azure.Download("");

       
    }





