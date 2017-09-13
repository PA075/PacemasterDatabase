namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProductCodeMaster")]
    public partial class ProductCodeMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProductCodeMaster()
        {
            ExclusivityTransaction = new HashSet<ExclusivityTransaction>();
            InlineTransaction = new HashSet<InlineTransaction>();
        }

        [Key]
        public int ProductcodeId { get; set; }

        [Required]
        [StringLength(50)]
        public string ProductCode { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExclusivityTransaction> ExclusivityTransaction { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> InlineTransaction { get; set; }
    }
}
