namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.Price")]
    public partial class Price
    {
        public int Id { get; set; }

        public int PatentCodeBrandID { get; set; }

        public int? DosageFormID { get; set; }

        public int? ROA_ID { get; set; }

        public int? StrengthID { get; set; }

        public int? UnitsID { get; set; }

        [Column("Price(CVS Pharmacy)")]
        [StringLength(500)]
        public string Price_CVS_Pharmacy_ { get; set; }

        public virtual DosageForm DosageForm { get; set; }

        public virtual ProductCodeBrand ProductCodeBrand { get; set; }

        public virtual Strength Strength { get; set; }

        public virtual Unit Unit { get; set; }
    }
}
