namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class NADAC_PricingUnitMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NADAC_PricingUnitMaster()
        {
            Transaction1 = new HashSet<InlineTransaction>();
        }

        [Key]
        public int NADACPricingUnitId { get; set; }

        [Required]
        [StringLength(255)]
        public string NADACPricingUnit { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> Transaction1 { get; set; }
    }
}
