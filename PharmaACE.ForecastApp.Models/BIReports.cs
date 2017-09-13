namespace PharmaACE.ForecastApp.Models
{
    public class BIReports
    {
        public BIReport[] value { get; set; }
    }

    public class BIReport
    {
        public string id { get; set; }

        // the name of this property will change to 'displayName' when the API moves from Beta to V1 namespace
        public string name { get; set; }

        public string webUrl { get; set; }

        public string embedUrl { get; set; }

        //public string reportHTML { get; set; }

    }
}
