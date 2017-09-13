using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastFlatFile
    {
        public int treeNodeType { get; set; }
        public int ItemId { get; set; }
        public string url { get; set; }
        public string name { get; set; }
        public string size { get; set; }
        public string dtCreated { get; set; }
        public string dtModified { get; set; }
        public string Author { get; set; }
        public string LastModifiedBy { get; set; }
        public int MajorVersion { get; set; }
        public int MinorVersion { get; set; }
        public string Comment { get; set; }
        public IList<ForecastVersion> versions { get; set; }
        public int AuthorizationForLoggedInUser { get; set; }
    }
}
