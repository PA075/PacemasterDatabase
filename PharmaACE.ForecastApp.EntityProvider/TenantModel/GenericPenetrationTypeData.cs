namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.PenetrationTypeData")]
    public partial class GenericPenetrationTypeData
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericPenetrationTypeData()
        {
            ProjectVersion = new HashSet<GenericProjectVersion>();
        }

        public int ID { get; set; }

        public int ProductID { get; set; }

        public int ProjectVersionProductID { get; set; }

        public int? LaunchPriceSelection { get; set; }

        public int? PriceBasedOn { get; set; }

        public int? StartMonth1 { get; set; }

        public int? StartMonth2 { get; set; }

        public int? TrendType { get; set; }

        public int? SelectedTrend { get; set; }

        public int SKU_ID { get; set; }

        public int ScenarioId { get; set; }

        [Column(TypeName = "date")]
        public DateTime PenetrationDate { get; set; }

        public short? PenetrationType { get; set; }

        public decimal? PenetrationValue { get; set; }

        public virtual GenericProductMaster ProductMaster { get; set; }

        public virtual GenericProjectVersionProduct ProjectVersionProduct { get; set; }

        public virtual GenericScenarioMaster ScenarioMaster { get; set; }

        public virtual GenericSKU_Master SKU_Master { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericProjectVersion> ProjectVersion { get; set; }
    }
}
