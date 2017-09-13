namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Acthar.Assumptions")]
    public partial class ActharAssumptions
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ActharAssumptions()
        {
            AssumptionAttachmentMapping = new HashSet<ActharAssumptionAttachmentMapping>();
        }

        public int ID { get; set; }

        [Required]
        public string PROJECT { get; set; }

        [Required]
        public string VERSION { get; set; }

        public int SECTION { get; set; }

        public string DESCRIPTION { get; set; }

        public int INDICATION { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ActharAssumptionAttachmentMapping> AssumptionAttachmentMapping { get; set; }
    }
}
