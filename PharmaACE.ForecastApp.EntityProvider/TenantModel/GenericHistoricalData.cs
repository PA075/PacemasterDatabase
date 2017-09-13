namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.HistoricalData")]
    public partial class GenericHistoricalData
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericHistoricalData()
        {
            ProjectVersion = new HashSet<GenericProjectVersion>();
        }

        public int ID { get; set; }

        public int ProjectVersionProductID { get; set; }

        public int ProductID { get; set; }

        public int SKU_ID { get; set; }

        public int ScenarioID { get; set; }

        public int ParameterID { get; set; }

        public int CompetitorID { get; set; }

        [Column(TypeName = "date")]
        public DateTime HistoricalDate { get; set; }

        public decimal? HistoricalValue { get; set; }

        public virtual GenericCompetitorMaster CompetitorMaster { get; set; }

        public virtual GenericParameterMaster ParameterMaster { get; set; }

        public virtual GenericProductMaster ProductMaster { get; set; }

        public virtual GenericProjectVersionProduct ProjectVersionProduct { get; set; }

        public virtual GenericScenarioMaster ScenarioMaster { get; set; }

        public virtual GenericSKU_Master SKU_Master { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericProjectVersion> ProjectVersion { get; set; }
    }
}
