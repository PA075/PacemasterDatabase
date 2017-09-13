namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.ProductSummary")]
    public partial class ProductSummary
    {
        public int Id { get; set; }

        public int ProductCodeBrandID { get; set; }

        public int? GenericID { get; set; }

        [StringLength(500)]
        public string Mono_FDC { get; set; }

        public int? CompanyID { get; set; }

        [StringLength(500)]
        public string NCEExclusivityExpiry { get; set; }

        [StringLength(500)]
        public string EarliestProductPatentExpiry { get; set; }

        public int? CountOfAvailableGenerics { get; set; }

        public int? NoOfOrangeBooklistedPatents { get; set; }

        public int? CountOfactiveUSDMFHolders { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual GenericName GenericName { get; set; }

        public virtual ProductCodeBrand ProductCodeBrand { get; set; }
    }
}
