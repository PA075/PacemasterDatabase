namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PriceSourceMaster")]
    public partial class PriceSourceMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PriceSourceMaster()
        {
            Transaction1 = new HashSet<InlineTransaction>();
        }

        [Key]
        public int PriceSourceId { get; set; }

        [Required]
        [StringLength(100)]
        public string PriceSource { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> Transaction1 { get; set; }
    }
}
