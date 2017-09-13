using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
namespace PharmaACE.ForecastApp.Models
{
    public class BIReportPageModel
    {
        public string AccessToken { get; set; }
        public BIReportPageModel()
        {
            ReportList = new List<BIReport>();
            VersionList = new List<SelectedForecastVersion>();
        }

        [Display(Name = "ReportList")]
        public List<BIReport> ReportList
        {
            get;
            set;
        }

        [Display(Name = "VersionList")]
        public List<SelectedForecastVersion> VersionList
        {
            get;
            set;
        }
    }
}
