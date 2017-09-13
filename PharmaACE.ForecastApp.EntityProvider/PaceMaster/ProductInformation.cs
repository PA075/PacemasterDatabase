namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.ProductInformation")]
    public partial class ProductInformation
    {
        public int Id { get; set; }

        public int? PatentCodeBrandID { get; set; }

        public string Indication { get; set; }

        public int? GenericID { get; set; }

        public int? DosageFormID { get; set; }

        public int? ROA_ID { get; set; }

        public int? StrengthID { get; set; }

        public string MarketingStatus { get; set; }

        public int? CompanyID { get; set; }

        public string MarketingPartner { get; set; }

        public DateTime? ApprovalDate { get; set; }

        public DateTime? LatestLabelDateandRevisionMade { get; set; }

        public string RLD { get; set; }

        public string TECode { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual DosageForm DosageForm { get; set; }

        public virtual GenericName GenericName { get; set; }

        public virtual ProductCodeBrand ProductCodeBrand { get; set; }

        public virtual Strength Strength { get; set; }
    }
}
