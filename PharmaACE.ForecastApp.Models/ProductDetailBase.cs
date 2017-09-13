using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class ProductDetailBase
    {
        [Display(Name = "Product")]
        public string ProductName { get; set; }

        [Display(Name = "Molecule")]
        public string MoleculeName { get; set; }

        [Display(Name = "Manufacturer")]
        public string CompanyName { get; set; }

        [Display(Name = "Pharma Class")]
        public string PHARMA_CLASSES { get; set; }

        [Display(Name = " Secondary Pharma Class")]
        public string PHARMA_CLASSES2 { get; set; }

        [Display(Name = "Tertiary Pharma Class")]
        public string PHARMA_CLASSES3 { get; set; }

        [Display(Name = "Indication")]
        public string Indication { get; set; }

        [Display(Name = "Dosage for Adults")]
        public string Dosage_Adult { get; set; }

        [Display(Name = "Route Of Administration")]
        public string ROAType { get; set; }

        [Display(Name = "Mechanism of Action")]
        public string MOA { get; set; }

        [Display(Name = "Category")]
        public string ProductCategory { get; set; }

        
    }
}
