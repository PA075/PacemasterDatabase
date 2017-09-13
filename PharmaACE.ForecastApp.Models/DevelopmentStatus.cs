using System;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class DevelopmentStatus
    {
        [Display(Name = "Product")]
        public string ProductName { get; set; }

        [Display(Name = "Pharma Class")]
        public string PHARMA_CLASSES { get; set; }

        [Display(Name = " Secondary Pharma Class")]
        public string PHARMA_CLASSES2 { get; set; }

        [Display(Name = "Tertiary Pharma Class")]
        public string PHARMA_CLASSES3 { get; set; }

        [Display(Name = "IMS Class")]
        public string IMSClass { get; set; }

        [Display(Name = "Manufacturer")]
        public string CompanyName { get; set; }

        [Display(Name = "Dosage Forms")]
        public string FormName { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        [Display(Name = "Start Marketing Date")]
        public DateTime StartMarketingdate { get; set; }

        [Display(Name = "LoE")]
        public string LoE { get; set; }
    }
}