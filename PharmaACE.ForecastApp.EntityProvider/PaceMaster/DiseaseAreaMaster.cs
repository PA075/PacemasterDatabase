namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DiseaseAreaMaster")]
    public partial class DiseaseAreaMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DiseaseAreaMaster()
        {
            DiseaseAreaMapping = new HashSet<DiseaseAreaMapping>();
            DiseaseIndicationData = new HashSet<DiseaseIndicationData>();
            DiseaseTransaction = new HashSet<DiseaseTransaction>();
            InlineTransaction = new HashSet<InlineTransaction>();
            PipelineTransaction = new HashSet<PipelineTransaction>();

        }

        [Key]
        public int DiseaseId { get; set; }

        [Required]
        [StringLength(500)]
        public string DiseaseArea { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseIndicationData> DiseaseIndicationData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseTransaction> DiseaseTransaction { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> InlineTransaction { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PipelineTransaction> PipelineTransaction { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseAreaMapping> DiseaseAreaMapping { get; set; }
    }
}
