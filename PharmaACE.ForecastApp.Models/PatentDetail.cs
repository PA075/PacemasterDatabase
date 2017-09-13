using System;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{

    public class PatentDetails
    {
        public PatentDetail[] patentDetails { get; set; }
    }

    public class PatentDetail
    {
        [Display(Name = "Product Code")]
        public string ProductCode { get; set; }

        [Display(Name = "Patent Code")]
        public string PatentCode { get; set; }

        [Display(Name = "Patent Definition")]
        public string PatentDefinition { get; set; }

        [Display(Name = "Exclusivity Code")]
        public string ExclusivityCode { get; set; }

        [Display(Name = "Exclusivity Definition")]
        public string ExclusivityDefinition { get; set; }

        [Display(Name = "Patent No")]
        public string PatentNo { get; set; }

        [Display(Name = "Patent Expire Date")]
        public DateTime? PatentExpireDate { get; set; }


        [Display(Name = "Exclusivity Date")]
        public DateTime? ExclusivityDate { get; set; }
    }
}
