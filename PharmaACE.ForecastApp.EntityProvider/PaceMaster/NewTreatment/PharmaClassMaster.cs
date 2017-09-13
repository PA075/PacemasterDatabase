namespace PharmaACE.ForecastApp.EntityProvider.pacemaster.NewTreatment
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
            TreatmentRegimenDetails = new HashSet<TreatmentRegimenDetail>();
        }

        [Key]
        public int PharmaClassId { get; set; }

        [Required]
        [StringLength(500)]
        public string PharmaClass { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TreatmentRegimenDetail> TreatmentRegimenDetails { get; set; }
    }
}
