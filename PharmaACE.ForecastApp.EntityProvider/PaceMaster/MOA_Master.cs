namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class MOA_Master
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public MOA_Master()
        {
            MOA_TransactionMapping = new HashSet<MOA_TransactionMapping>();
        }

        [Key]
        public int MOA_Id { get; set; }

        [Required]
        [StringLength(1000)]
        public string MOA { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MOA_TransactionMapping> MOA_TransactionMapping { get; set; }
    }
}
