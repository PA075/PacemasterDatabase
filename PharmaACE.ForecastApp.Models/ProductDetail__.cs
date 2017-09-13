using System;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class ProductDetail
    {
        [Display(Name = "Product")]
        public string ProductName { get; set; }

        [Display(Name = "Molecule")]
        public string MoleculeName { get; set; }

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

        [Display(Name = "Dosage")]
        public string Dosage_Adult { get; set; }

        [Display(Name = "Dosage for Pediatric")]
        public string Dosage_Pediatric { get; set; }

        [Display(Name = "Indication")]
        public string Indication { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        [Display(Name = "Start Marketing Date")]
        public Nullable<DateTime> StartMarketingDate { get; set; }

        [Display(Name = "Sub-Indication")]
        public string Sub_Indication { get; set; }

        [Display(Name = "Strength Available")]
        public string Strength { get; set; }

        [Display(Name = "Price")]
        public string NADAC_Price { get; set; }

        [Display(Name = "Pricing Unit")]
        public string NADAC_PricingUnit { get; set; }

        [Display(Name = "Dosage Forms")]
        public string FormName { get; set; }

        [Display(Name = "Route Of Administration")]
        public string ROAType { get; set; }

        [Display(Name = "Mechanism of Action")]
        public string MOA { get; set; }

        [Display(Name = "Prescription Information in Detail")]
        public string Detailed_Indication { get; set; }

        [Display(Name = "Category")]
        public string ProductCategory { get; set; }

        [Display(Name = "Exclusivity And Patent Details")]
        public string EPDetails { get; set; }

        [Display(Name = "Module")]
        public int Module { get; set; }

    }
}
