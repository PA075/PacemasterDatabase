using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ReportForecastVersion
    {
        public string Label { get; set; }
        public List<string> Scenarios { get; set; }
        public List<ReportProduct> Products { get; set; }
    }
}