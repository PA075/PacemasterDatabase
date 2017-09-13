using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastVersion
    {
        public string Label { get; set; }        
        public string Comment { get; set; }
        public List<ForecastVersion> PreDrafts { get; set; }
        //public List<ForecastVersion> PostDrafts { get; set; }
        public UserAccess Access { get; set; }
        public bool IsMock { get; set; } //used where there is no major (either does not exist or does not have permission to) to a minor
    }

    public class UserAccess
    {
        public UserInfo Creator { get; set; }
        public DateTime CreatedOn { get; set; }        
        public List<SharedAccessInfo> SharedAccess { get; set; }
    }

    public class SharedAccessInfo
    {
        public UserInfo SharedWith { get; set; }
        public UserInfo SharedBy { get; set; }
        public DateTime SharedOn { get; set; }
        public int AuthorizationLevel { get; set; }
    }
}
