namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("IndicationMaster")]
    public partial class IndicationMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public IndicationMaster()
        {
            IndicationMapping = new HashSet<IndicationMapping>();
            IndicationTransactionMapping = new HashSet<IndicationTransactionMapping>();
            Transaction = new HashSet<DiseaseTransaction>();
            DiseaseIndicationData = new HashSet<DiseaseIndicationData>();
            DiseaseIndicationData1 = new HashSet<DiseaseIndicationData>();
        }

        [Key]
        public int IndicationId { get; set; }

        [Required]
        [StringLength(500)]
        public string IndicationName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IndicationMapping> IndicationMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IndicationTransactionMapping> IndicationTransactionMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseTransaction> Transaction { get; set; }


        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseIndicationData> DiseaseIndicationData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseIndicationData> DiseaseIndicationData1 { get; set; }
    }
}
