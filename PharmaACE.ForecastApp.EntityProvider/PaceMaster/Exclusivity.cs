namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.Exclusivity")]
    public partial class Exclusivity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Exclusivity()
        {
            ExclusivityInfoes = new HashSet<ExclusivityInfo>();
        }

        public int Id { get; set; }

        [Column("Exclusivity")]
        [StringLength(500)]
        public string Exclusivity1 { get; set; }

        [Required]
        public string Description { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExclusivityInfo> ExclusivityInfoes { get; set; }
    }
}
