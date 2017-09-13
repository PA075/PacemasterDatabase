using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class PipelineProductDetail : ProductDetailBase
    {
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        [Display(Name = "Estimate Launch Date")]
        public DateTime? EstimateLaunchDate { get; set; }

        [Display(Name = "Analyst Estimate")]
        public string AnalystEstimate { get; set; }

        [Display(Name = "Regimen")]
        public string Regimen{ get; set; }

        [Display(Name = "Study Title")]
        public string StudyTitle { get; set; }

        [Display(Name = "Development Phase")]
        public string DevelopmentPhase { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        [Display(Name = "Expected Completion Date")]
        public DateTime? ExpectedCompletionDate { get; set; }

        [Display(Name = "Disease Area")]
        public string DiseaseArea { get; set; }

        [Display(Name = "Detailed Indication")]
        public string DetailedIndication { get; set; }


        [Display(Name = "Latest Development Status")]
        public string LatestDevelopmentStatus { get; set; }

        [Display(Name = "NCT")]
        public string NCT { get; set; }

        [Display(Name = "Product Type")]
        public string ProductType { get; set; }
    }
}
