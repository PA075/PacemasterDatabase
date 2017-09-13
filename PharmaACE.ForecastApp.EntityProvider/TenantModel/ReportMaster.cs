namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ReportMaster")]
    public partial class ReportMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ReportMaster()
        {
            ReportDashboardMapping = new HashSet<ReportDashboardMapping>();
            ReportUserMapping = new HashSet<ReportUserMapping>();
        }

        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public string Name { get; set; }

        public int ConfigurationId { get; set; }

        [StringLength(1000)]
        public string ReportLink { get; set; }

        [Column(TypeName = "date")]
        public DateTime? CreationDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime? ModificationDate { get; set; }

        public byte? ModuleType { get; set; }

        public virtual ReportConfigurationMaster ReportConfigurationMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ReportDashboardMapping> ReportDashboardMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ReportUserMapping> ReportUserMapping { get; set; }
    }
}
