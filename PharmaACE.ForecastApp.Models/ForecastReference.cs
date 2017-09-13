using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastReference
    {
         
            [Display(Name = "Epidemiology")]
             public string Epidemiology { get; set; }

            [Display(Name = "Historical Data")]
             public string HistoricalData { get; set; }

            [Display(Name = "Conversion Parameters")]
             public string ConversionParameters { get; set; }

            [Display(Name = "Compliance")]
             public string Compliance { get; set; }

            [Display(Name = "Dosing")]
             public string Dosing { get; set; }

            [Display(Name = "DoT")]
             public string DoT { get; set; }

            [Display(Name = "Pricing")]
             public string Pricing { get; set; }

            [Display(Name = "Market Access")]
             public string MarketAccess { get; set; }

            [Display(Name = "GTN")]
             public string GTN { get; set; }

            [Display(Name = "Patients and ProductShares")]
             public string PatientsandProductShares { get; set; }

            [Display(Name = "Events")]
             public string Events { get; set; }

            [Display(Name = " Treatment Algorithm")]
             public string  TreatmentAlgorithm { get; set; }
    }
}
