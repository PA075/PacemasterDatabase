namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ProjectDetails")]
    public partial class BDLProjectDetails
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BDLProjectDetails()
        {
            ProjectVersion = new HashSet<BDLProjectVersion>();
        }

        public int Id { get; set; }

        public DateTime ForecastStart { get; set; }

        public DateTime ForecastEnd { get; set; }

        public DateTime HistoricalDataAvailableTill { get; set; }

        public int ShareCalculationType { get; set; }

        public int SegmentationLevel { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLProjectVersion> ProjectVersion { get; set; }
    }
}
