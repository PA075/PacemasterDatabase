namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.ExclusivityCodeMaster")]
    public partial class ExclusivityCodeMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ExclusivityCodeMaster()
        {
            ExclusivityTransaction = new HashSet<ExclusivityTransaction>();
        }

        [Key]
        public int ExclusivityCodeId { get; set; }

        [StringLength(50)]
        public string ExclusivityCode { get; set; }

        public string Definition { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExclusivityTransaction> ExclusivityTransaction { get; set; }
    }
}
