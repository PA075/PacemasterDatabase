using System;
using System.Collections.Generic;
using System.Data;

namespace PharmaACE.ForecastApp.Models
{
    public class SharedForecast
    {
        public int ModelType { get; set; }
        public List<UserForecastMapping> UserForecasts { get; set; }
    }

    public class UserForecastMapping
    {
        public string Forecast { get; set; }
        public int FlatFileId { get; set; }
        public List<ForecastVersion> Versions { get; set; }
        public ForecastVersion LatestVersion { get; set; }
        public string UserEmail { get; set; }
        public string LoggedInUserName { get; set; }
    }
    public class UserForecastMappingForUnshare
    {
        public int UnShareUserID { get; set; }
        public string projectName { get; set; }
        public string Version { get; set; }
        public int loggedInUserId { get; set; }
    }

    public class CopyForecast
    {
		public string VersionValue { get; set; }
        public int NoOfVersion { get; set; }
        public int IsEnableMinorVersionCheck { get; set; }
        public string Forecast { get; set; }
        public string CopiedToForecastName { get; set; }
        public string modelLocation { get;set;}
        public ForecastModelType type { get; set; }
    }
}
