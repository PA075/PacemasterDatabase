using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ReportProduct
    {
        public string Name { get; set; }
    }
    public class GenericReportProduct:ReportProduct
    {
        public List<string> SKUs { get; set; }
    }
    public class BDLReportProduct:ReportProduct
    {
        public List<string> Segments { get; set; }
    }
}