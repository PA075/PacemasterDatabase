using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class DiseaseInfo
    {
        //[Display(Name = "Indication")]
        //public string Indication { get; set; }

        //[Display(Name = "Primary Indication")]
        //public string PrimaryIndication { get; set; }

        //[Display(Name = "Therapy Area")]
        //public string TherapyArea { get; set; }

        //[Display(Name = "Treatment Regimens")]
        //public string TreatmentRegimens { get; set; }

        [Display(Name = "Definition")]
        public string Definition { get; set; }

        [Display(Name = "Quick Facts")]
        public string QuickFacts { get; set; }

        [Display(Name = "Risk Factors")]
        public string RiskFactors { get; set; }

        [Display(Name = "Symptoms")]
        public string Symptoms { get; set; }

        [Display(Name = "Diagnosis")]
        public string Diagnosis { get; set; }

        [Display(Name = "Stages")]
        public string Stages { get; set; }

        [Display(Name = "Classification")]
        public string Classification { get; set; }

        [Display(Name = "References")]
        public string References { get; set; }

        [Display(Name = "DetailedIndication")]
        public string DetailedIndication { get; set; }
        
        //[Display(Name = "Class Summary")]
        //public string ClassSummary { get; set; }

        //[Display(Name = "Approved Molecules")]
        //public string ApprovedMolecules { get; set; }

        public MediaDetails MediaDetails { get; set; }

        [Display(Name = "Compliance")]
        public string Compliance { get; set; }

        [Display(Name = "Dosing And Dot")]
        public string DosingAndDot { get; set; }

        [Display(Name = "Pricing")]
        public string Pricing { get; set; }

        [Display(Name = "Events")]
        public string Events { get; set; }

        [Display(Name = "Probability")]
        public string Probability { get; set; }

     
    }

    public class MediaDetails
    {
        [Display(Name = "ImageUrl")]
        public string ImageUrl { get; set; }

        [Display(Name = "ImageUrl")]
        public byte[] ImageByte { get; set; }

        [Display(Name = "VideoUrl")]
        public string VideoUrl { get; set; }
    }

}
