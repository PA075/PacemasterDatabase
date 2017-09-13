namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ROA_Master
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ROA_Master()
        {
            ROA_TransactionMapping = new HashSet<ROA_TransactionMapping>();
            Transaction1 = new HashSet<InlineTransaction>();
        }

        [Key]
        public int ROAId { get; set; }

        [Required]
        [StringLength(1000)]
        public string RouteOfAdministration { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ROA_TransactionMapping> ROA_TransactionMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> Transaction1 { get; set; }
    }
}
