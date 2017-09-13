using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class Indications
    {
        [Display(Name = "Indication")]
        public string Indication { get; set; }
    }
}
