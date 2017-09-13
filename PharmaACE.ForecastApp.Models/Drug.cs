using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{

    public class DrugSearchList
    {
         public IEnumerable<Drug> DrugsList { get; set; }
         public int SearchModule { get; set; }
         public DrugSearchSummary Summary { get; set; }
    }
      
    public class Drug
    {
        public int InlineId { get; set; }

        [Display(Name = "Product")]
        public string ProductName { get; set; }

        [Display(Name = "Molecule")]
        public string MoleculeName { get; set; }

        [Display(Name = "Manufacturer")]
        public string CompanyName { get; set; }

        [Display(Name = "Pharma Class")]
        public string PHARMA_CLASSES { get; set; }

        [Display(Name = "Secondary Pharma Class")]
        public string PHARMA_CLASSES2 { get; set; }

        [Display(Name = "Tertiary Pharma Class")]
        public string PHARMA_CLASSES3 { get; set; }
       
        [Display(Name = "Indication")]
        public string Indication { get; set; }

        //Added for  Pipline implimentation
        [Display(Name = "Route Of Administration")]
        public string ROAType { get; set; }

        [Display(Name = "Marketing Date/Phase")]
        public string Phase { get; set; }

        [Display(Name = "Category")]
        public string ProductCategory { get; set; }

        [Display(Name = "Module")]
        public int Module { get; set; }

        public TopHeader Header { get; set; }

        //[DataType(DataType.Date)]
        //[DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        //[Display(Name = "Marketing Date")]
        //public Nullable<DateTime> StartMarketingdate { get; set; }

        [Display(Name = "Dosage Form ")]
        public string FormName { get; set; }

        public string Application_Short_Number{ get; set; }

        public string Product_ID{ get; set; }

        public string Product_NDC{ get; set; }

        public string Product_Code{ get; set; }

        public string Code_and_NDC{ get; set; }

        public string Substance{ get; set; }

        public string Strength{ get; set; }

        public string Disease_Area{ get; set; }

        public string Sub_Indication{ get; set; }

        public string Dosage_Adult{ get; set; }

        public string Dosage_Pediatric{ get; set; }

        public string Price{ get; set; }

        public string Pricing_Unit{ get; set; }

        public string Price_Source{ get; set; }

        public  string MOA { get; set; }

        public  DateTime Approval_Date { get; set; }

        public string Product_Type { get; set; }

        public string Drug_Type { get; set; }


        public string MarketingPartner { get; set; }

        public int MarketingStatus { get; set; }

        public DateTime LatestLabelDate { get; set; }

        public bool RLD { get; set; }

        public string TECode { get; set; }

       

        //[Display(Name = "Strength Available")]
        //public string Strength { get; set; }

        [Display(Name = "IMS Class")]
        public string IMSClass { get; set; }

        //[Display(Name = "LoE")]        //Unused remove after some time
        //public string LoE { get; set; }
    }

    public class DrugComparer : IEqualityComparer<Drug>
    {
        public bool Equals(Drug x, Drug y)
        {
            return String.Compare(x.ProductName, y.ProductName, true) == 0
                && String.Compare(x.CompanyName, y.CompanyName, true) == 0
                && String.Compare(x.MoleculeName, y.MoleculeName, true) == 0
                && String.Compare(x.ProductCategory, y.ProductCategory, true) == 0
                && String.Compare(x.PHARMA_CLASSES, y.PHARMA_CLASSES, true) == 0
                && String.Compare(x.PHARMA_CLASSES2, y.PHARMA_CLASSES2, true) == 0
                && String.Compare(x.PHARMA_CLASSES3, y.PHARMA_CLASSES3, true) == 0
                && String.Compare(x.Indication, y.Indication, true) == 0
                && String.Compare(x.Phase, y.Phase, true) == 0
                 && String.Compare(x.FormName, y.FormName, true) == 0;
        }

        //needed only if used in dictionary
        public int GetHashCode(Drug obj)
        {
            return obj.ProductName.GetHashCode();
        }
    }

    public class DrugSearchSummary
    {
        public List<int> InlineEntries { get; set; }
        public List<int> PipelineEntries { get; set; }
        public List<int> GenericEntries { get; set; }
        public List<int> BrandEntries { get; set; }
    }

    //public class DrugComparer : IEqualityComparer<Drug>
    //{
    //    public bool Equals(Drug x, Drug y)
    //    {
    //        return (
    //            x.ProductName == y.ProductName &&
    //            x.CompanyName == y.CompanyName &&
    //            x.FormName == y.FormName);
    //    }

    //    public int GetHashCode(Drug obj)
    //    {
    //        return (String.Format("{0}|{1}|{2}", obj.ProductName, obj.CompanyName, obj.FormName).GetHashCode();
    //    }
    //}

}