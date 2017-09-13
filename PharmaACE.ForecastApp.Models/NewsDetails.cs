using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class NewsDetails
    {
        public List<string> Indications { get; set; }

        public List<string> DiseaseAreas { get; set; }

        public string LogoImagePath { get; set; }
        public string PageHeader { get; set; }
    }
}