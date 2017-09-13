namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ProjectVersion")]
    public partial class GenericProjectVersion
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericProjectVersion()
        {
            PackInfo = new HashSet<GenericPackInfo>();
            ProjectVersionProduct = new HashSet<GenericProjectVersionProduct>();
            ScenarioDetails = new HashSet<GenericScenarioDetails>();
            ForecastData = new HashSet<GenericForecastData>();
            HistoricalData = new HashSet<GenericHistoricalData>();
            PenetrationTypeData = new HashSet<GenericPenetrationTypeData>();
        }

        public int id { get; set; }

        public int ProjectID { get; set; }

        [Required]
        [StringLength(500)]
        public string VersionLabel { get; set; }

        public int ProjectVersionDetailsID { get; set; }

        public DateTime CreationDate { get; set; }

        public virtual GenericProjectMaster ProjectMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericPackInfo> PackInfo { get; set; }

        public virtual GenericProjectVersionDetails ProjectVersionDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericProjectVersionProduct> ProjectVersionProduct { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericScenarioDetails> ScenarioDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericForecastData> ForecastData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericHistoricalData> HistoricalData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericPenetrationTypeData> PenetrationTypeData { get; set; }
    }
}
