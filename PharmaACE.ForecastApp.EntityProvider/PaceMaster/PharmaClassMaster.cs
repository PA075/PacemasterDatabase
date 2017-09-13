namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PharmaClassMaster")]
    public partial class PharmaClassMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PharmaClassMaster()
        {
            PharmaClassMapping = new HashSet<PharmaClassMapping>();
            PharmaClassMapping1 = new HashSet<PharmaClassMapping>();
            PharmaClassMapping2 = new HashSet<PharmaClassMapping>();
            PharmaClassMapping3 = new HashSet<PharmaClassMapping>();
            Transaction2 = new HashSet<PipelineTransaction>();
            Transaction21 = new HashSet<PipelineTransaction>();
            Transaction22 = new HashSet<PipelineTransaction>();
            TreatmentRegimenDetails = new HashSet<TreatmentRegimenDetail>();
        }

        [Key]
        public int PharmaClassId { get; set; }

        [Required]
        [StringLength(500)]
        public string PharmaClass { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PharmaClassMapping> PharmaClassMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PharmaClassMapping> PharmaClassMapping1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PharmaClassMapping> PharmaClassMapping2 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PharmaClassMapping> PharmaClassMapping3 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PipelineTransaction> Transaction2 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PipelineTransaction> Transaction21 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PipelineTransaction> Transaction22 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TreatmentRegimenDetail> TreatmentRegimenDetails { get; set; }
    }
}
