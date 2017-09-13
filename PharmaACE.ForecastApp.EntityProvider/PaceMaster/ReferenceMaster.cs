namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ReferenceMaster")]
    public partial class ReferenceMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ReferenceMaster()
        {
            IndicationReferenceMapping = new HashSet<IndicationReferenceMapping>();
        }

        [Key]
        public int ReferenceId { get; set; }

        [Required]
        public string ReferenceLink { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IndicationReferenceMapping> IndicationReferenceMapping { get; set; }
    }
}
