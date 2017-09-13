namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.PatentUseCode")]
    public partial class PatentUseCode
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PatentUseCode()
        {
            PatentInfoes = new HashSet<PatentInfo>();
        }

        public int Id { get; set; }

        [Column("PatentUseCode")]
        [StringLength(500)]
        public string PatentUseCode1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PatentInfo> PatentInfoes { get; set; }
    }
}
