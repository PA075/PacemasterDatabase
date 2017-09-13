using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class DiseaseAreaSearchByTherapyArea
    {
        [Display(Name = "Result Found")]
        public string ResultCount { get; set; }

        [Display(Name = "Indications")]
        public List<Indications> IndicationsList { get; set; }

    }
}
