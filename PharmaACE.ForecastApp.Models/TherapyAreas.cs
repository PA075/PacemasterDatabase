using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class TherapyAreas
    {
        [Display(Name = "Therapy Area")]
        public string TherapyArea { get; set; }
    }
}
