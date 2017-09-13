namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DivisionRegulatoryMaster")]
    public partial class DivisionRegulatoryMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DivisionRegulatoryMaster()
        {
            DivisionUserMapping = new HashSet<DivisionUserMapping>();
        }

        public int ID { get; set; }

        public int DivisionID { get; set; }

        [Required]
        [StringLength(500)]
        public string RegulatoryName { get; set; }

        public bool IsDefaultRegulatory { get; set; }

        public virtual DivisionMaster DivisionMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DivisionUserMapping> DivisionUserMapping { get; set; }
    }
}
