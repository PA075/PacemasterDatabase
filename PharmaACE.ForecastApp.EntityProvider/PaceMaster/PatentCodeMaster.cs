namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PatentCodeMaster")]
    public partial class PatentCodeMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PatentCodeMaster()
        {
            ExclusivityTransaction = new HashSet<ExclusivityTransaction>();
        }

        [Key]
        public int PatentCodeId { get; set; }

        [Required]
        [StringLength(50)]
        public string PatentCode { get; set; }

        public string Definition { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExclusivityTransaction> ExclusivityTransaction { get; set; }
    }
}
