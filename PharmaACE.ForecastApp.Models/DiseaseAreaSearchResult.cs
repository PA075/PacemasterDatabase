using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class DiseaseAreaSearchResult
    {
        //[Display(Name = "Results Found")]
        //public string ResultCount { get; set; }

        [Display(Name = "Indications")]
        public List<Indications> IndicationsList { get; set; }

        [Display(Name = "Therapy Areas")]
        public List<TherapyAreas> TherapyAreasList { get; set; }
    }
}