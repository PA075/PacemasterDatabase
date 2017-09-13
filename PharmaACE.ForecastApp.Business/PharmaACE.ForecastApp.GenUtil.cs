using Microsoft.Azure;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.StorageClient;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace PharmaACE.ForecastApp.Business
{
    public static class GenUtil
    {
        public static string reportType = "";
        public static void  GetReportType()
        {
          
            try
            {
                reportType =(ConfigurationManager.AppSettings["StorageType"].ToString());
               
            }
            catch (Exception ex)
            {
                throw new Exception("Fetching Storage Type failed ");
            }

            //return  reportType;
        }

        public static bool IsMajor(string label, out int majorVersionNumber)
        {
            majorVersionNumber = 0;
            if (String.IsNullOrEmpty(label)) //null or empty should mean all versions together
                return true;
            var splitV = label.Split(new char[] { 'V' });
            if (splitV.Count() == 2)
            {
                var splitDot = splitV[1].Split(new char[] { '.' });
                if (splitDot.Count() == 2)
                {
                    majorVersionNumber = splitDot[0].SafeToNum();
                    return splitDot[1].SafeToNum() == 0;
                }
                else
                    return false;
            }

            return true;
        }

        public static string GetVersionLabelFromVersionKey(string versionKey)
        {
            if (String.IsNullOrEmpty(versionKey))
                return String.Empty;
            var splitV = versionKey.Split(new char[] { 'V' });
            var spliVLength = splitV.Length;
            if (spliVLength < 2) //version format incorrect
                return String.Empty;
            return "V" + splitV[spliVLength - 1];
        }

        public static string GetForecastNameFromVersionKey(string versionKey)
        {
            if (String.IsNullOrEmpty(versionKey))
                return String.Empty;
            var splitV = versionKey.Split(new char[] { 'V' });
            Stack<string> splitStack = new Stack<string>(splitV);
            var spliVLength = splitV.Length;
            if (spliVLength < 2) //version format incorrect
                return String.Empty;
            splitStack.Pop();
            return String.Join("V", splitStack.Reverse());
        }

        public static string GetPostMajorKey(string forecastVersionLabel)
        {
            string postMajorVersionLabel = String.Empty;
            if (!String.IsNullOrEmpty(forecastVersionLabel)) //null or empty should mean all versions together
            {
                var splitV = forecastVersionLabel.Split(new char[] { 'V' });
                if (splitV.Count() > 1)
                {
                    string versionLabel = "V" + splitV.Last();
                    int major, minor;
                    GenUtil.GetMajorMinorFromLabel(versionLabel, out major, out minor);
                    if (major >= 0)
                    {
                        splitV[splitV.Length - 1] = (major + 1).ToString();
                        return String.Join("V", splitV);
                    }
                }
                return null;
            }
            return null;
        }

        public static DateTime GetVersionDateTime(ForecastVersion v, int loggedInUserId)
        {
            if (v.IsMock || v.Access.Creator != null)
                return v.Access.CreatedOn;
            if (v.Access.SharedAccess != null)
            {
                var sharedWithMe = v.Access.SharedAccess.Where(s => s.SharedWith.UserId == loggedInUserId).ToList();
                if (sharedWithMe != null && sharedWithMe.Count > 0)
                    return sharedWithMe.Select(sm => sm.SharedOn).Max();
            }

            return default(DateTime);
        }


        /// <summary>
        /// </summary>
        public const int DEFAULT_FEED_COUNT = 50;
        public const char LINEAGE_SPLITTER = '|';
        internal const string PDF_CONTENTNO = "3780";
        internal const string PPS_CONTENTNO = "208207";
        internal const string TXT_CONTENTNO = "1310";
        internal const string DOC_CONTENTNO = "208207";
        internal const string DOCX_CONTENTNO = "8075";
        internal const string XLS_CONTENTNO = "60104";
        internal const string XLSX_CONTENTNO = "8075";
        internal const string XLSB_CONTENTNO = "8075";
        internal const string CSV_CONTENTNO = "8382";
        internal const string RTF_CONTENTNO = "12392";
        internal const string ZIP_CONTENTNO = "8075";
        internal const string JPG_CONTENTNO = "255216";
        internal const string JPEG_CONTENTNO = "255216";
        internal const string PNG_CONTENTNO = "13780";
        internal const string GIF_CONTENTNO = "7173";
        internal const string PPT_CONTENTNO = "208207";
        internal const string PPTX_CONTENTNO = "8075";
        internal const string DAT_CONTENTNO = "4954";
        internal const string RAR_CONTENTNO = "8297";
        internal const string BMP_CONTENTNO = "6677";
        
        

        public static string getFileStreamByExtension(string extension)
        {
            string fileStreamNo = string.Empty;
            switch (extension)
            {
                case ".pdf":
                    return PDF_CONTENTNO;
                case ".pps":
                    return PPS_CONTENTNO;
                //case ".txt":
                //    return TXT_CONTENTNO;
                case ".doc":
                    return DOC_CONTENTNO;
                case ".docx":
                   return DOCX_CONTENTNO;
                case ".xls":
                  return XLS_CONTENTNO;
                case ".xlsx":
                    return XLSX_CONTENTNO;
                case ".xlsb":
                    return XLSB_CONTENTNO;
                case ".csv":
                    return CSV_CONTENTNO;
                case ".rtf":
                    return RTF_CONTENTNO;
                case ".zip":
                    return ZIP_CONTENTNO;
                case ".jpg":
                    return JPG_CONTENTNO;
                case ".jpeg":
                    return JPEG_CONTENTNO;
                case ".png":
                    return PNG_CONTENTNO;
                case ".gif":
                    return GIF_CONTENTNO;
                case ".ppt":
                    return PPT_CONTENTNO;
                case ".pptx":
                    return PPTX_CONTENTNO;
                case ".dat":
                    return DAT_CONTENTNO;
                //case ".xlr":
                //    fileStreamNo = "";
                //    break;
                case ".rar":
                    return RAR_CONTENTNO;
                //case ".zipx":
                //    fileStreamNo = "";
                //    break;
                case ".bmp":
                    return BMP_CONTENTNO;
                default:
                    break;
            }

            return fileStreamNo;
        }

        public static bool getActualTypeOfFile(HttpPostedFileBase file,string extension)
        {
            bool isValidExt = false;
            string fileStreamNo = string.Empty;
            fileStreamNo = getFileStreamByExtension(extension);
            MemoryStream ms = new MemoryStream();
            file.InputStream.CopyTo(ms);
            file.InputStream.Position = 0;
            ms.Position = 0;
            System.IO.BinaryReader r = new System.IO.BinaryReader(ms);
            string fileclass = "";
            byte buffer;
            try
            {
                buffer = r.ReadByte();
                fileclass = buffer.ToString();
                buffer = r.ReadByte();
                fileclass += buffer.ToString();
            }
            catch(Exception ex)
            {
                isValidExt = false;
            }
            r.Close();
            if (!string.IsNullOrEmpty(fileclass))
            {
                if (fileStreamNo == fileclass)
                    isValidExt = true;
            }

            return isValidExt;
        }


       

        public static bool  fileFilterExtensions(HttpPostedFileBase file)
        {
            bool isValid = true;
           // string isValidExtension = "";
            string[] AllowedFileExtensions = new string[] { ".pps",".txt",".pdf", ".doc", ".docx", ".xls", ".xlsx",".xlsb", ".csv", ".txt", ".rtf", ".html", ".zip", ".jpg", ".jpeg", ".png", ".gif",".csv",".pps",".ppt",".pptx",".dat",".xml",".xlr", ".htm",".rar",".zipx",".bmp"};
            if (file != null)
            {
                //var fileName = file.FileName;
                //var isValidExtension = AllowedFileExtensions.Any(y => fileName.EndsWith(y));
                //return isValidExtension;
                if (!AllowedFileExtensions.Contains(file.FileName.Substring(file.FileName.LastIndexOf('.'))))
                {
                    isValid = false;
                }
            }
            return isValid;
            
        }

        public static bool fileFilterExtensions(string file)
        {
            bool isValid = true;
            // string isValidExtension = "";
            string[] AllowedFileExtensions = new string[] { ".pps", ".txt", ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".xlsb", ".csv", ".txt", ".rtf", ".html", ".zip", ".jpg", ".jpeg", ".png", ".gif", ".csv", ".pps", ".ppt", ".pptx", ".dat", ".xml", ".xlr", ".htm", ".rar", ".zipx", ".bmp" };
            if (file != null)
            {
                //var fileName = file.FileName;
                //var isValidExtension = AllowedFileExtensions.Any(y => fileName.EndsWith(y));
                //return isValidExtension;
                if (!AllowedFileExtensions.Contains(file.Substring(file.LastIndexOf('.'))))
                {
                    isValid = false;
                }
            }
            return isValid;

        }

        public static string Cypher(string input)
        {
            StringBuilder result = new StringBuilder();
            Regex regex = new Regex("[A-Za-z]");

            foreach (char c in input)
            {
                if (regex.IsMatch(c.ToString()))
                {
                    int charCode = ((c & 223) - 52) % 26 + (c & 32) + 65;
                    result.Append((char)charCode);
                }
                else
                {
                    result.Append(c);
                }
            }

            return result.ToString();
        }

        /// <summary>
        /// </summary>
        public static byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        /// <summary>
        /// </summary>
        public static List<string> ConvertStringToList(string str)
        {
            var lst = new List<string>();

            // normalize delimiters, shoul be ";"
            str = GenUtil.SafeTrim(str).Replace(",", ";");

            if (str.Contains(";"))
            {
                foreach (string cur_str in str.Split(new char[] { ';' }))
                {
                    if (!lst.Any(x => string.Compare(x.Trim(), cur_str.Trim(), true) >= 0))
                    {
                        lst.Add(cur_str.Trim());
                    }
                }
            }
            else
            {
                lst.Add(str);
            }

            return lst;
        }

        /// <summary>
        /// </summary>
        public static string CombineFileSysPaths(object path1, object path2)
        {
            if (IsNull(path1) && IsNull(path2))
            {
                return "";
            }
            else if (IsNull(path1))
            {
                return SafeTrim(path2);
            }
            else if (IsNull(path2))
            {
                return SafeTrim(path1);
            }
            else
            {
                return string.Concat(SafeTrim(path1).TrimEnd(new char[] { '\\' }), "\\", SafeTrim(path2).TrimStart(new char[] { '\\' }));
            }
        }

        /// <summary>
        /// </summary>
        public static string CombinePaths(object path1, object path2)
        {
            if (IsNull(path1) && IsNull(path2))
            {
                return "";
            }
            else if (IsNull(path1))
            {
                return SafeTrim(path2);
            }
            else if (IsNull(path2))
            {
                return SafeTrim(path1);
            }
            else
            {
                return string.Concat(SafeTrim(path1).TrimEnd(new char[] { '/' }), "/", SafeTrim(path2).TrimStart(new char[] { '/' }));
            }
        }


        /// <summary>
        /// </summary>
        public static string NVL(object a, object b)
        {
            if (!IsNull(a))
            {
                return SafeTrim(a);
            }
            else if (!IsNull(b))
            {
                return SafeTrim(b);
            }
            else
            {
                return "";
            }
        }

        /// <summary>
        /// </summary>
        public static string ToNull(object x)
        {
            if ((x == null)
                || (Convert.IsDBNull(x))
                || x.ToString().Trim().Length == 0)
                return null;
            else
                return x.ToString();
        }

        /// <summary>
        /// </summary>
        public static bool IsNull(object x)
        {
            if ((x == null)
                || (Convert.IsDBNull(x))
                || x.ToString().Trim().Length == 0)
                return true;
            else
                return false;
        }

        /// <summary>
        /// </summary>
        public static string SafeTrim(this object x)
        {
            if (IsNull(x))
                return String.Empty;
            else
                return x.ToString().Trim();
        }

        /// <summary>
        /// </summary>
        public static string SafeNoTrim(this object x)
        {
            if (IsNull(x))
                return String.Empty;
            else
                return x.ToString();
        }

        public static string ReplaceLastOccurrence(this string Source, string Find, string Replace)
        {
            int place = Source.LastIndexOf(Find);

            if (place == -1)
                return Source;

            string result = Source.Remove(place, Find.Length).Insert(place, Replace);
            return result;
        }

        /// <summary>
        /// Case insensitive comparison.
        /// </summary>
        public static bool IsEqual(object o1, object o2)
        {
            return SafeToUpper(o1) == SafeToUpper(o2);
        }

        /// <summary>
        /// If not valid returns -1.
        /// </summary>
        public static int SafeToNum(this object o)
        {
            if (IsNull(o))
                return -1;
            else
            {
                if (IsInt(o))
                    return int.Parse(o.ToString());
                else
                    return -1;
            }
        }

        /// <summary>
        /// If not valid returns 0.
        /// </summary>
        public static double SafeToDouble(this object o)
        {
            if (IsNull(o))
                return -1;
            else
            {
                double test;
                if (!double.TryParse(o.ToString(), out test))
                    return -1;
                else
                    return test;
            }
        }

        /// <summary>
        /// If not valid returns false.
        /// </summary>
        public static bool SafeToBool(this object o)
        {
            if (SafeToUpper(o) == "1" ||
                SafeToUpper(o) == "YES" ||
                SafeToUpper(o) == "Y" ||
                SafeToUpper(o) == "TRUE")
                return true;
            else
                return false;
        }

        /// <summary>
        /// </summary>
        public static bool IsBool(object o)
        {
            o = SafeToUpper(o);
            return
                (o.ToString() == "1" || o.ToString() == "0" ||
                o.ToString() == "YES" || o.ToString() == "NO" ||
                o.ToString() == "Y" || o.ToString() == "N" ||
                o.ToString() == "TRUE" || o.ToString() == "FALSE");
        }

        /// <summary>
        /// If not valid returns 01/01/1900 12:00:00 AM.
        /// </summary>
        public static DateTime SafeToDateTime(this object o)
        {
            if (IsNull(o))
                return default(DateTime);
            else
            {
                DateTime dummy;

                if (IsInt(o))
                    return new DateTime(Convert.ToInt64(o)); // use ticks
                else
                {
                    if (DateTime.TryParse(o.ToString(), out dummy))
                        return dummy;
                    else
                        return default(DateTime);
                }
            }
        }

        /// <summary>
        /// </summary>
        public static bool IsInt(object o)
        {
            if (IsNull(o))
                return false;

            Int64 dummy = 0;
            return Int64.TryParse(o.ToString(), out dummy);
        }

        /// <summary>
        /// </summary>
        public static bool IsDouble(object o)
        {
            if (IsNull(o))
                return false;

            Double dummy = 0;
            return Double.TryParse(o.ToString(), out dummy);
        }

        /// <summary>
        /// Trims and converts to upper case.
        /// </summary>
        public static string SafeToUpper(this object o)
        {
            if (IsNull(o))
                return "";
            else
                return SafeTrim(o).ToUpper();
        }

        /// <summary>
        /// </summary>
        public static string SafeToProperCase(this object o)
        {
            if (IsNull(o))
                return "";
            else
            {
                if (o.ToString().Trim().Length == 1)
                    return o.ToString().Trim().ToUpper();
                else
                    return o.ToString().Trim().Substring(0, 1).ToUpper() + o.ToString().Trim().Substring(1).ToLower();
            }
        }

        /// <summary>
        /// </summary>
        public static string SafeGetArrayVal(string[] list, int index)
        {
            return index < list.Length ? SafeTrim(list[index]) : "";
        }

        /// <summary>
        /// </summary>
        public static string SafeGetArrayVal(List<string> list, int index)
        {
            return index < list.Count ? SafeTrim(list[index]) : "";
        }

        /// <summary>
        /// </summary>
        public static Guid? SafeToGuid(this object o)
        {
            if (IsGuid(o))
                return new Guid(SafeTrim(o));
            else
                return null;
        }

        /// <summary>
        /// </summary>
        public static bool IsGuid(object o)
        {
            if (IsNull(o))
                return false;

            try
            {
                var tmp = new Guid(SafeTrim(o));
                return true;
            }
            catch (Exception)
            {

                return false;
            }
        }

        /// <summary>
        /// </summary>
        public static string NormalizeEol(string s)
        {
            return Regex.Replace(SafeTrim(s), @"\r\n|\n\r|\n|\r", "\r\n");
        }

        //public static string HostUrl
        //{
        //    get
        //    {
        //        return System.Configuration.ConfigurationManager.AppSettings["HostUrl"];
        //    }
        //}

        public static string SPHostUrl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["SPHostUrl"];
            }
        }

        public static string SPSiteUrl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["SPSiteUrl"];
            }
        }

        public static string ForecastModelServerRelativeUrl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ForecastModelServerRelativeUrl"];
            }
        }

        public static string ForecastFolder
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ForecastFolder"];
            }
        }

        public static string GenericForecastFolder
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["GenericForecastFolder"];
            }
        }

        public static string BDLForecastFolder
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["BDLForecastFolder"];
            }
        }

        public static string AssumptionAttachmentsFolder
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["AssumptionAttachmentsFolder"];
            }
        }

        public static int SPTimeOut
        {
            get
            {
                int timeout;
                if (Int32.TryParse(System.Configuration.ConfigurationManager.AppSettings["SPTimeOut"], out timeout))
                    return timeout;

                return 180000; //sharepoint default request timeout
            }
        }

        public static string ShowReportViewerPrompt
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ShowReportViewerPrompt"];
            }
        }

        public static string ShowReportViewerToolbar
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ShowReportViewerToolbar"];
            }
        }

        public static string GetSizeLabelFromBytes(long? bytes, int decimalPlaces = 2)
        {
            if (bytes == null)
                return "0.00";
            long value = bytes.Value;
            string[] SizeSuffixes = { "bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" };
            if (value < 0)
            {
                throw new ArgumentException("Bytes should not be negative", "value");
            }
            var mag = (int)Math.Max(0, Math.Log(value, 1024));
            var adjustedSize = Math.Round(value / Math.Pow(1024, mag), decimalPlaces);
            return String.Format("{0} {1}", adjustedSize, SizeSuffixes[mag]);
        }

        public static string ClientID
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ClientID"];
            }
        }

        public static string ClientSecretKey
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ClientSecretKey"];
            }
        }

        public static string RedirectUrl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["RedirectUrl"];
            }
        }


        public static string StartMarketingDateNotAvailable
        {
            get
            {
                return "N/A";
            }
        }

        public static char lineSeperator
        {
            get
            {
                return '|';
            }
        }

        public static string BulletSeperator
        {
            get
            {
                return "|^|";
            }
        }

        public static string MasterModelConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["PaceMasterConnectionString"].ConnectionString;
            }
        }

        public static string GetTenantConnectionString(int tenantId, MasterModel masterContext = null)
        {
            string connectionString = MasterModelConnectionString;
            string tenantConStr = String.Empty;
            try
            {
                using (var context = masterContext ?? new MasterModel(connectionString))
                {
                    var tenantConnectionComponents = context.SubscriberMaster
                        .Where(sm => sm.SubscriberId == tenantId)
                        .Select(sm => new
                        {
                            DBServer = sm.DBServer,
                            DataBaseName = sm.DataBaseName,
                            DBUser = sm.DBUser,
                            DBPassword = sm.DBPassword
                        })
                        .Single();
                    tenantConStr = DALUtility.ConnectionStringBuilder(tenantConnectionComponents.DBServer, tenantConnectionComponents.DataBaseName, tenantConnectionComponents.DBUser, tenantConnectionComponents.DBPassword);
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Could not connect");
            }

            return tenantConStr;
        }

        public static string GetTenantConnectionStringWithoutDispose(int tenantId, MasterModel masterContext)
        {
            string tenantConStr = String.Empty;

            var tenantConnectionComponents = masterContext.SubscriberMaster
                    .Where(sm => sm.SubscriberId == tenantId)
                    .Select(sm => new
                    {
                        DBServer = sm.DBServer,
                        DataBaseName = sm.DataBaseName,
                        DBUser = sm.DBUser,
                        DBPassword = sm.DBPassword
                    })
                    .Single();
            tenantConStr = DALUtility.ConnectionStringBuilder(tenantConnectionComponents.DBServer, tenantConnectionComponents.DataBaseName, tenantConnectionComponents.DBUser, tenantConnectionComponents.DBPassword);
            
            return tenantConStr;
        }

        internal static string FormatDosageStringWithBullet(String originalString, char lineSeperator, String bulletSeperator)
        {
            string outputString = string.Empty;

            string trimmedOriginalString = originalString.Replace(bulletSeperator, "|<Bullet>");

            string[] dataarray = trimmedOriginalString.Split(lineSeperator);

            foreach (string item in dataarray)
            {
                string strPart = item;
                if (String.IsNullOrEmpty(item))
                    continue;
                if (strPart.Contains("<Bullet>"))
                {
                    strPart = strPart.Replace("<Bullet>", string.Empty);
                    outputString += "<ul class='bulletedlist'><li>" + strPart + "</li></ul>";
                }
                else
                    outputString += strPart;
            }

            return outputString;
        }

        internal static string FormatStringWithBullet(String originalString, char lineSeperator, String bulletSeperator)
        {
            string outputString = string.Empty;
            string trimmedOriginalString = originalString.Replace(bulletSeperator, "|<Bullet>");
            string[] dataarray = trimmedOriginalString.Split(lineSeperator);
            bool isBulletStarted = false;

            for (int i = 0; i < dataarray.Length; i++)
            {
                string item = dataarray[i];
                string strPart = item;
                if (String.IsNullOrEmpty(item))
                    continue;
                if (strPart.Contains("<Bullet>"))
                {
                    if (isBulletStarted)
                        outputString += "</li></ul>";
                    strPart = strPart.Replace("<Bullet>", string.Empty);
                    outputString += "<ul><li>" + strPart + "<br/>"; // +"</li></ul>";
                    isBulletStarted = true;
                }
                else
                    outputString += FormatReferences(strPart, "|") + "<br/>";
                if (isBulletStarted && i == dataarray.Length - 1)
                    outputString += "</li></ul>";
            }

            return outputString;
        }

        internal static string FormatReferences(String originalString, String seperator)
        {
            string outputString = string.Empty;
            string[] Referencesarray = originalString.Split('|');
            Referencesarray = Referencesarray.Where(x => !string.IsNullOrEmpty(x)).ToArray();
            foreach (string item in Referencesarray)
            {
                var index = item.IndexOf("https://");
                if (index == -1)
                    index = item.IndexOf("http://");
                if ((item.Contains("https://")) || (item.Contains("http://")))
                {
                    outputString += item.Substring(0, index) + " <a href=" + item.Substring(index) + " target=\"_blank\"> &nbsp;" + item.Substring(index) + "</a>";
                }
                else
                    outputString += item;
            }

            return outputString;
        }

        internal static string FormatDiseaseReferences(String originalString, string seperator)
        {
            string outputString = string.Empty;
            string[] Referencesarray = originalString.Split('|');
            Referencesarray = Referencesarray.Where(x => !string.IsNullOrEmpty(x)).ToArray();
            foreach (string item in Referencesarray)
            {
                var index = item.IndexOf("https://");
                if (index == -1)
                    index = item.IndexOf("http://");
                if ((item.Contains("https://")) || (item.Contains("http://")))
                {
                    outputString += item.Substring(0, index) + " <a href=" + item.Substring(index) + " target=\"_blank\"> &nbsp;" + item.Substring(index) + "</a><br/>";
                }
                else
                    outputString += item;
            }

            return outputString;
        }

        internal static string FormatDiseasePricing(String originalString, string seperator)
        {
            string outputString = string.Empty;
            string[] Pricingarray = originalString.Split('|');
            Pricingarray = Pricingarray.Where(x => !string.IsNullOrEmpty(x)).ToArray();
            foreach (string item in Pricingarray)
            {
                var link = string.Empty;
                if ((!item.Contains("https://")) || (!item.Contains("http://")))
                    link = "https://" + item;
                else
                    link = item;
                var index = link.IndexOf("https://");
                if (index == -1)
                    index = link.IndexOf("http://");

                if ((link.Contains("https://")) || (link.Contains("http://")))
                {
                    outputString += link.Substring(0, index) + " <a href='" + link.Substring(index) + "'  target='_blank'> " + link.Substring(index) + "</a><br/>";
                }
                else
                    outputString += link;
            }

            return outputString;
        }

        public static int CreateMailandSend(SendMailInfo smi, CommonSendInfo csi)
        {
            int result = 0;
            if (csi.ModuleType == "Forecast")
            {
                MailMessage mailMessage = new MailMessage("pharmatestuser@gmail.com", smi.ReceiverEmail);
                // StringBuilder class is present in System.Text namespace
                StringBuilder sbEmailBody = new StringBuilder();
                Guid messageId = Guid.NewGuid();
                if (csi.IsShare)
                {
                    if (smi.FlagForUpdation)
                    {
                        sbEmailBody.Append("Hi ,<br/><br/>");
                        sbEmailBody.Append(csi.SenderName + " has changed your permission of '" + csi.ProjectName + "' " + csi.ForecastVersion + " from " + smi.PrevAuth + " to " + smi.CurrentAuth);
                        sbEmailBody.Append("<br/><br/>");
                        sbEmailBody.Append("<b>" + csi.ClientName + "</b>");
                        bool status = GenUtil.SendEmail(csi.SenderName + " has changed permission of '" + csi.ProjectName+"'", sbEmailBody.ToString(), smi.ReceiverEmail);
                        if (status)
                            result = 1;
                        else
                            result = 0;
                        return result;
                    }
                    else
                    {
                        sbEmailBody.Append("Hi ,<br/><br/>");
                        sbEmailBody.Append(csi.SenderName + " has shared forecast '" + csi.ProjectName + "' " + csi.ForecastVersion + " with you");
                        sbEmailBody.Append("<br/>Permission: "+smi.CurrentAuth);
                        sbEmailBody.Append("<br/><br/>");
                        sbEmailBody.Append("<b>" + csi.ClientName + "</b>");
                        bool status = GenUtil.SendEmail(csi.SenderName + " has shared '" + csi.ProjectName + "' with you", sbEmailBody.ToString(), smi.ReceiverEmail);
                        if (status)
                            result = 1;
                        else
                            result = 0;
                        return result;
                    }
                }
                else
                { //indicates unshare

                    sbEmailBody.Append("Dear " + smi.ReceiverEmail + ",<br/><br/>");
                    sbEmailBody.Append(csi.SenderName + " has unhared '" + csi.ProjectName + "' " + csi.ForecastVersion + " with you.");
                    sbEmailBody.Append("<br/><br/>");
                    sbEmailBody.Append("<b>" + csi.ClientName + "</b>");
                    bool status = GenUtil.SendEmail(csi.SenderName + " has unshared '" + csi.ProjectName + "' with you", sbEmailBody.ToString(), smi.ReceiverEmail);
                    if (status)
                        result = 1;
                    else
                        result = 0;
                    return result;
                }

            }
            if (csi.ModuleType == "Userworkspace")
            {

                MailMessage mailMessage = new MailMessage("pharmatestuser@gmail.com", smi.ReceiverEmail);
                // StringBuilder class is present in System.Text namespace
                StringBuilder sbEmailBody = new StringBuilder();
                Guid messageId = Guid.NewGuid();
                if (csi.IsShare)
                {
                    if (csi.PathString == csi.ProjectName)//to print it once 
                        csi.PathString = "";
                    if (smi.FlagForPermission)
                    {
                        sbEmailBody.Append("Hi,<br/><br/>");
                        sbEmailBody.Append(csi.SenderName + " has changed your permission of '" + csi.ProjectName + "' from " + smi.PrevPermission + " to " + smi.Permission);
                        sbEmailBody.Append("<br/>Path: "+csi.PathString+ csi.ProjectName);
                        sbEmailBody.Append("<br/><br/>");
                        sbEmailBody.Append("<b>" + csi.ClientName + "</b>");
                        bool status = GenUtil.SendEmail(csi.SenderName + " has changed permission of '" + csi.ProjectName+"'", sbEmailBody.ToString(), smi.ReceiverEmail);
                        if (status)
                            result = 1;
                        else
                            result = 0;
                        return result;
                    }
                    else
                    {
                        sbEmailBody.Append("Hi,<br/><br/>");
                        sbEmailBody.Append(csi.SenderName + " has shared '" + csi.ProjectName + "' with you.");
                        sbEmailBody.Append("<br/>Permission: " + smi.Permission);
                        sbEmailBody.Append("<br/>Path: " + csi.PathString + csi.ProjectName);
                        sbEmailBody.Append("<br/><br/>");
                        sbEmailBody.Append("<b>" + csi.ClientName + "</b>");
                        bool status = GenUtil.SendEmail(csi.SenderName + " has shared '" + csi.ProjectName + "' with you", sbEmailBody.ToString(), smi.ReceiverEmail);
                        if (status)
                            result = 1;
                        else
                            result = 0;
                        return result;
                    }

                }
                else
                { //indicates unshare

                    sbEmailBody.Append("Hi,<br/><br/>");
                    sbEmailBody.Append(csi.SenderName + " has unshared '" + csi.ProjectName + "' with you.");
                    sbEmailBody.Append("<br/><br/>");
                    sbEmailBody.Append("<b>" + csi.ClientName + "</b>");
                    bool status = GenUtil.SendEmail(csi.SenderName + " has unshared '" + csi.ProjectName + "' with you", sbEmailBody.ToString(), smi.ReceiverEmail);
                    if (status)
                        result = 1;
                    else
                        result = 0;
                    return result;
                }

            }
            return result;
        }

        internal static bool SendEmail(string subject, string body, string to, List<string> fileNames = null, List<byte[]> fileBytes = null)
        {
            bool status = false;

            // MailMessage class is present is System.Net.Mail namespace
            string mailForm = DALUtility.mailForm;
            MailMessage mailMessage = new MailMessage(mailForm, to);
            mailMessage.IsBodyHtml = true;
            mailMessage.Body = body;
            mailMessage.Subject = subject;
            string SMTPHost = DALUtility.SMTPMailingHost;
            int Port = DALUtility.SMTPMailingPort.SafeToNum();
            System.Net.Mail.SmtpClient smtpClient = new System.Net.Mail.SmtpClient(SMTPHost, Port);
            smtpClient.Credentials = new System.Net.NetworkCredential()
            {
                UserName = mailForm,
                Password = DALUtility.MailSenderPassword
            };

            smtpClient.EnableSsl = true;
            try
            {
                if (fileBytes != null)
                {
                    System.Net.Mail.Attachment attachment;
                    for (int i = 0; i < fileBytes.Count; i++)
                    {
                        Stream stream = new MemoryStream(fileBytes[i]);
                        attachment = new System.Net.Mail.Attachment(stream, fileNames[i]);
                        mailMessage.Attachments.Add(attachment);
                    }
                }

                smtpClient.Send(mailMessage);
                status = true;
            }
            catch (Exception ex)
            {
                status = false;
            }
            return status;

        }

        internal static string GeneratePassword(string FirstName, string LastName, string TenantName)
        {
            Random rand = new Random();

            string passwordString = TenantName + "_" + FirstName.Substring(0, 1) + LastName.Substring(0, 1) + rand.Next(0, 9);

            return passwordString;
        }
        //internal static string GeneratePassword()
        //{
        //    string allowedChars = "";
        //    allowedChars = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,";
        //    allowedChars += "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,";
        //    allowedChars += "1,2,3,4,5,6,7,8,9,0,!,@,#,$,%,&,?";
        //    char[] sep = { ',' };
        //    string[] arr = allowedChars.Split(sep);
        //    string passwordString = "";
        //    string temp = "";
        //    Random rand = new Random();
        //    for (int i = 0; i < 6; i++)
        //    {
        //        temp = arr[rand.Next(0, arr.Length)];
        //        passwordString += temp;
        //    }
        //    return passwordString;
        //}

        internal static string GetStorageContainer(StorageContext context)
        {
            string returnValue = string.Empty;
            switch (context)
            {
                case StorageContext.Indication:
                    returnValue = "indicationimages";
                    break;
                case StorageContext.Forum:
                    returnValue = "forumstorage";
                    break;
                case StorageContext.WorkSpace:
                    returnValue = "workspace";
                    break;
            }
            return returnValue;
        }

        public static object GetReportSettings(DistinctReportSettings reportSettings)
        {
            switch (reportSettings.ReportType)
            {
                case ReportModelType.Generic:
                    return GetReportSettingsGeneric(reportSettings);
                  
                case ReportModelType.BDL:
                    return GetReportSettingsBDL(reportSettings);
                 
                case ReportModelType.Acthar:
                    break;
                default:
                    break;
            }

            return null;       
        }

        private static object GetReportSettingsBDL(DistinctReportSettings reportSettings)
        {
            return new
            {
                ProjectVersionString = String.Join(",", reportSettings.Axes),
                ParameterName = String.Join(",", reportSettings.Parameters),
                Country = String.Join(",", reportSettings.Countrys),
                Frequency = reportSettings.Frequency,
                ChartType = reportSettings.ChartType,
                ColourTheme = reportSettings.ColorTheme,
                ValueType = reportSettings.NumberFormat,
                NumberOfDecimals = reportSettings.DecimalPrecision,
                CurrencySymbol = reportSettings.CurrencySymbol,
                TableData = reportSettings.TableData,
                AxisFontSize = reportSettings.AxisFontSize + "pt",
                AxisFontColour = "#" + reportSettings.AxisFontColor,
                ChartBackgroundColour = "#" + reportSettings.ChartBgColor,
                ChartBorderColour = "#" + reportSettings.ChartBorderColor,
                ChartBorderWidth = reportSettings.ChartBorderWidth + "pt",
                TitleFontSize = reportSettings.TitleFontSize + "pt",
                TitleColour = "#" + reportSettings.TitleColor,
                Shadow = reportSettings.Shadow + "pt",
                StartDate = Convert.ToDateTime(reportSettings.MinStartDate),
                EndDate = Convert.ToDateTime(reportSettings.MaxEndDate),
                ShowHideLegend = reportSettings.ShowLegend,
                VersionFlag = reportSettings.VersionFlag,
                ConsolidatorFlag = reportSettings.ConsolidatorFlag,
                HistoricalData=reportSettings.HistoricalData
            };
        }

        private static object GetReportSettingsGeneric(DistinctReportSettings reportSettings)
        {
            return new
            {
                ProjectVersionString = String.Join(",", reportSettings.Axes),
                ParameterName = String.Join(",", reportSettings.Parameters),
                Frequency = reportSettings.Frequency,
                ChartType = reportSettings.ChartType,
                ColourTheme = reportSettings.ColorTheme,
                ValueType = reportSettings.NumberFormat,
                NumberOfDecimals = reportSettings.DecimalPrecision,
                CurrencySymbol = reportSettings.CurrencySymbol,
                TableData = reportSettings.TableData,
                AxisFontSize = reportSettings.AxisFontSize + "pt",
                AxisFontColour = "#" + reportSettings.AxisFontColor,
                ChartBackgroundColour = "#" + reportSettings.ChartBgColor,
                ChartBorderColour = "#" + reportSettings.ChartBorderColor,
                ChartBorderWidth = reportSettings.ChartBorderWidth + "pt",
                TitleFontSize = reportSettings.TitleFontSize + "pt",
                TitleColour = "#" + reportSettings.TitleColor,
                Shadow = reportSettings.Shadow + "pt",
                StartDate = Convert.ToDateTime(reportSettings.MinStartDate),
                EndDate = Convert.ToDateTime(reportSettings.MaxEndDate),
                ShowHideLegend = reportSettings.ShowLegend,
                VersionFlag = reportSettings.VersionFlag,
                ConsolidatorFlag = reportSettings.ConsolidatorFlag
            };
        }

        public static List<KeyValuePair<string, object>> GetReportSettingsGenericWithMultipleParameter(DistinctReportSettings reportSettings)
        {
            var parametersArray = reportSettings.Parameters.ToArray();
            List<KeyValuePair<string, object>> parameters = new List<KeyValuePair<string, object>>();

            for (int i = 0; i < parametersArray.Length; i++)
            {
                parameters.Add(new KeyValuePair<string, object>(parametersArray[i], getObjectForReport( reportSettings, parametersArray[i])));
            }

            return parameters;
           
        }

        private static object getObjectForReport( DistinctReportSettings reportSettings,  string v2)
        {
            return new
            {
                ProjectVersionString = String.Join(",", reportSettings.Axes),
                ParameterName = v2,
                Frequency = reportSettings.Frequency,
                ChartType = reportSettings.ChartType,
                ColourTheme = reportSettings.ColorTheme,
                ValueType = reportSettings.NumberFormat,
                NumberOfDecimals = reportSettings.DecimalPrecision,
                CurrencySymbol = reportSettings.CurrencySymbol,
                TableData = reportSettings.TableData,
                AxisFontSize = reportSettings.AxisFontSize + "pt",
                AxisFontColour = "#" + reportSettings.AxisFontColor,
                ChartBackgroundColour = "#" + reportSettings.ChartBgColor,
                ChartBorderColour = "#" + reportSettings.ChartBorderColor,
                ChartBorderWidth = reportSettings.ChartBorderWidth + "pt",
                TitleFontSize = reportSettings.TitleFontSize + "pt",
                TitleColour = "#" + reportSettings.TitleColor,
                Shadow = reportSettings.Shadow + "pt",
                StartDate = Convert.ToDateTime(reportSettings.MinStartDate),
                EndDate = Convert.ToDateTime(reportSettings.MaxEndDate),
                ShowHideLegend = reportSettings.ShowLegend
            };
        }

        public static void GetMajorMinorFromLabel(string version, out int majorVersion, out int minorVersion)
        {
            majorVersion = -1;
            minorVersion = -1;
            if (String.IsNullOrEmpty(version)) //version label is empty
                return;
            var splitV = version.Split(new char[] { 'V' });
            if (splitV.Count() != 2) //version label format is not correct
                return;
            var splitMajorMinor = splitV[1].Split(new char[] { '.' });
            if (splitMajorMinor.Count() != 2)
            {
                if (splitMajorMinor.Count() == 1) //e.g. 10 - major, .7 - minor
                {
                    if (String.IsNullOrEmpty(splitMajorMinor[0]))
                        splitMajorMinor[0] = "0";                    
                }
                else
                    return; //version label format is not correct
            }
            if (!Int32.TryParse(splitMajorMinor[0], out majorVersion)) //version label format is not correct
                return;
            if (splitMajorMinor.Count() == 2 && !Int32.TryParse(splitMajorMinor[1], out minorVersion)) //version label format is not correct
                return;
        }

        //Number of Notifications shown 
        public static int MaxNotificationNo
        {
            get
            {
                return 50;
            }
        }

        public static bool HasData(this DataSet ds, int tableIndex = 0)
        {
            return ds.Tables != null && ds.Tables.Count > 0 && ds.Tables[tableIndex].Rows != null && ds.Tables[tableIndex].Rows.Count > 0;
        }


        //extension method to decide which string function to call while searching
        public static bool ApplySearchCondition(this string str, string searchKey, SearchCondition searchCondition)
        {
            bool retVal = false;
            switch (searchCondition)
            {
                case SearchCondition.Contains:
                    retVal = str.Contains(searchKey);
                    break;
                case SearchCondition.StartsWith:
                    retVal = str.StartsWith(searchKey);
                    break;
                case SearchCondition.EndsWith:
                    retVal = str.EndsWith(searchKey);
                    break;
                case SearchCondition.Exact:
                    retVal = String.Compare(str, searchKey, true) == 0;
                    break;
                default:
                    break;
            }

            return retVal;
        }

        public static BlobUploadResult UploadImageInBlob(string GUID, HttpPostedFileBase file, StorageContext context)
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
                    CloudBlockBlob blockBlob = container.GetBlockBlobReference(GUID + file.FileName);

                    blockBlob.UploadFromStream(file.InputStream);
                    result.BlobUrl = blockBlob.Uri.AbsoluteUri;
                    result.Message = "Success";
                }
            }
            catch (Exception ex)
            {
                result.Message = ex.Message;
            }

            return result;
        }
        public static string GetClientNameForSendingMail()
        {
            string nameToDisplay = ConfigurationManager.AppSettings["ClientName"].ToString();
            return nameToDisplay;
        }

        public static StorageType GetStorageType()
        {
            StorageType storagetype;
            try
            {
                int storageTypeID =Convert.ToInt32(ConfigurationManager.AppSettings["StorageType"].ToString());
                storagetype = (StorageType)storageTypeID;
            }
            catch (Exception ex)
            {
                throw new Exception("Fetching Storage Type failed ");
            }

            return storagetype;
        }


        public static string getSPName(StorageContext sc,String operationType)
        {
            string storedProcName = string.Empty;
            if (sc==StorageContext.Forum && operationType=="Upload")
            {

                storedProcName = "dbo.uspInsertCOP_Data";
            }
            if (sc == StorageContext.Forum && operationType == "Download")
            {
                storedProcName = "dbo.uspGetCOP_Data";

            }
            if (sc == StorageContext.Indication && operationType == "Upload")
            {
                storedProcName = "dbo.uspInsertKM_Media";

            }
            if (sc == StorageContext.Indication && operationType == "Download")
            {

                storedProcName = "dbo.uspGetKM_Media_Data";
            }
            if (sc == StorageContext.report && operationType == "Upload")
            {


            }
            if (sc == StorageContext.report && operationType == "Download")
            {


            }
            if (sc == StorageContext.WorkSpace && operationType == "Upload")
            {
                storedProcName = "dbo.uspInsertDataUserWorkSpace";
            }
            if (sc == StorageContext.WorkSpace && operationType == "Download")
            {
                storedProcName = "dbo.uspGetUserWorkSpaceData";
            }
            if (sc == StorageContext.Forecast && operationType == "Upload")
            {
                storedProcName = "dbo.uspInsertForecastFactData";
            }
            if (sc == StorageContext.Forecast && operationType == "Download")
            {
                storedProcName = "dbo.uspGetForecastFiles";
            }

            return storedProcName;

        }

        public static bool IsTransactional(this ActionExecutingContext filterContext)
        {
            return !filterContext.ActionDescriptor.IsDefined(typeof(DisconnectedAttribute), false) &&
                !filterContext.ActionDescriptor.IsDefined(typeof(ReadOnlyAttribute), false);
        }
    }


    /// <summary>
    /// For those requests/actions who do not have any database activity involved
    /// </summary>
    public class DisconnectedAttribute : ActionFilterAttribute { }
    /// <summary>
    /// For those requests/actions who do not have any database write involved
    /// </summary>
    public class ReadOnlyAttribute : ActionFilterAttribute { }

    class FeedSorter
    {
        public FeedSorter(int userId)
        {
            this.UserId = userId;
            feedItems = new NewsFeedItems { Items = new List<NewsFeedItem>() };
        }

        private NewsFeedItems feedItems;
        public int UserId { get; set; }
        public int Rating { get; set; }
        public int MyVisitCount { get; set; }
        public int TotalVisitCount { get; set; }

        void Add(NewsFeedItem item)
        {
            feedItems.Items.Add(item);
        }
    }

    public class ActionStatus
    {
        //public int UserID { get; set; }
        public int UserID { get; set; }
        public int Number { get; set; }
        public string Message { get; set; }
        public SendMailUserInfo UserMailInfo { get; set; }
    }

    public interface IUnitOfWork
    {
        void BeginTransaction();
        void Commit();
        void Rollback();
        MasterModel MasterContext { get; }
        TenantModel TenantContext { get; }
    }

    public class UnitOfWork : IUnitOfWork
    {
        private DbContextTransaction masterTransaction;
        private DbContextTransaction tenantTransaction;

        public MasterModel MasterContext
        {
            get;

            set;
        }

        public TenantModel TenantContext
        {
            get;

            set;
        }

        public UnitOfWork()
        {
            
        }

        private void Init()
        {
            if (MasterContext == null)
                MasterContext = new MasterModel(GenUtil.MasterModelConnectionString);
            if (TenantContext == null)
            {
                int tenantId = HttpContext.Current.Session["CompanyId"].SafeToNum();
                if (tenantId == -1)
                    TenantContext = null;
                else
                    TenantContext = new TenantModel(GenUtil.GetTenantConnectionStringWithoutDispose(tenantId, MasterContext));
            }
        }
        
        public void BeginTransaction()
        {
            Init();
            if (MasterContext != null && MasterContext.Database.CurrentTransaction == null)
                masterTransaction = MasterContext.Database.BeginTransaction();
            if(TenantContext != null && TenantContext.Database.CurrentTransaction == null)
                tenantTransaction = TenantContext.Database.BeginTransaction();
        }

        public void Commit()
        {
            try
            {
                // commit transaction if there is one active                
                if (tenantTransaction != null && TenantContext.Database.CurrentTransaction != null)
                    tenantTransaction.Commit();
                if (masterTransaction != null && MasterContext.Database.CurrentTransaction != null)
                    masterTransaction.Commit();
            }
            catch
            {
                // rollback if there was an exception                
                if (tenantTransaction != null && TenantContext.Database.CurrentTransaction != null)
                    tenantTransaction.Rollback();
                if (masterTransaction != null && MasterContext.Database.CurrentTransaction != null)
                    masterTransaction.Rollback();

                throw;
            }
            finally
            {
                Dispose();
            }
        }

        public void Rollback()
        {
            try
            {
                if (tenantTransaction != null && TenantContext.Database.CurrentTransaction != null)
                    tenantTransaction.Rollback();
                if (masterTransaction != null && MasterContext.Database.CurrentTransaction != null)
                    masterTransaction.Rollback();
            }
            finally
            {
                Dispose();
            }
        }

        private void Dispose()
        {
            if (TenantContext != null)
            {
                TenantContext.Dispose();
                TenantContext = null;
            }
            if (MasterContext != null)
            {
                MasterContext.Dispose();
                MasterContext = null;
            }
        }

    }
    
}