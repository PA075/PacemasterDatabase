namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ForecastData")]
    public partial class GenericForecastData
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericForecastData()
        {
            ProjectVersion = new HashSet<GenericProjectVersion>();
        }

        public int ID { get; set; }

        public int ProjectVersionProductID { get; set; }

        public int ProductID { get; set; }

        public int SKU_ID { get; set; }

        public int ScenarioID { get; set; }

        public int ParameterID { get; set; }

        [Column(TypeName = "date")]
        public DateTime ForecastDate { get; set; }

        public decimal? ForecastValue { get; set; }

        public virtual GenericParameterMaster ParameterMaster { get; set; }

        public virtual GenericProductMaster ProductMaster { get; set; }

        public virtual GenericProjectVersionProduct ProjectVersionProduct { get; set; }

        public virtual GenericScenarioMaster ScenarioMaster { get; set; }

        public virtual GenericSKU_Master SKU_Master { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericProjectVersion> ProjectVersion { get; set; }
    }
}
