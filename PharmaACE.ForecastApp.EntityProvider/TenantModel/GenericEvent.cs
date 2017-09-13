namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.Events")]
    public partial class GenericEvent
    {
        public int ID { get; set; }

        public int ProjectVersionProductID { get; set; }

        public int SKU_ID { get; set; }

        public int ScenarioID { get; set; }

        [Required]
        [StringLength(500)]
        public string Name { get; set; }

        public byte EventOrder { get; set; }

        public bool? Status { get; set; }

        public bool? ImpactType { get; set; }

        public decimal? UptakeCurve { get; set; }

        public decimal? StartShare { get; set; }

        public decimal? PeakShare { get; set; }

        [Column(TypeName = "date")]
        public DateTime? LaunchDate { get; set; }

        public byte? MonthsToPeak { get; set; }

        public int Section { get; set; }

        public virtual GenericProjectVersionProduct ProjectVersionProduct { get; set; }

        public virtual GenericScenarioMaster ScenarioMaster { get; set; }

        public virtual GenericSKU_Master SKU_Master { get; set; }
    }
}
