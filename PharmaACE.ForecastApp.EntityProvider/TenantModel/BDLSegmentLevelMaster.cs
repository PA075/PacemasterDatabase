namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.SegmentLevelMaster")]
    public partial class BDLSegmentLevelMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BDLSegmentLevelMaster()
        {
            SegmentDetails = new HashSet<BDLSegmentDetails>();
        }

        public int Id { get; set; }

        [Required]
        [StringLength(1000)]
        public string Level { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLSegmentDetails> SegmentDetails { get; set; }
    }
}
