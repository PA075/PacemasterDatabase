namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ReportConfigurationMaster")]
    public partial class ReportConfigurationMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ReportConfigurationMaster()
        {
            ReportMaster = new HashSet<ReportMaster>();
        }

        public int Id { get; set; }

        [Required]
        public string ConfigurationString { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ReportMaster> ReportMaster { get; set; }
    }
}
