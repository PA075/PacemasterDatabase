namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DashboardMaster")]
    public partial class DashboardMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DashboardMaster()
        {
            DashboardUserMapping = new HashSet<DashboardUserMapping>();
            ReportDashboardMapping = new HashSet<ReportDashboardMapping>();
        }

        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public string Dashboard { get; set; }

        public byte ModuleType { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DashboardUserMapping> DashboardUserMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ReportDashboardMapping> ReportDashboardMapping { get; set; }
    }
}
