namespace PharmaACE.ForecastApp.EntityProvider.testit
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DiseaseIndicationData")]
    public partial class DiseaseIndicationData
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DiseaseIndicationData()
        {
            IndicationReferenceMapping = new HashSet<IndicationReferenceMapping>();
        }

        public int Id { get; set; }

        public int DiseaseAreaId { get; set; }

        public int PrimaryIndicationId { get; set; }

        public int SecondaryIndicationId { get; set; }

        public string DiseaseOverview { get; set; }

        public string DetailedIndication { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IndicationReferenceMapping> IndicationReferenceMapping { get; set; }
    }
}
