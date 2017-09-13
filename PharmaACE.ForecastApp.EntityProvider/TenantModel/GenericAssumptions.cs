namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.Assumptions")]
    public partial class GenericAssumptions
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericAssumptions()
        {
            AssumptionAttachmentMapping = new HashSet<GenericAssumptionAttachmentMapping>();
        }

        public int ID { get; set; }

        [Required]
        public string PROJECT { get; set; }

        [Required]
        public string VERSION { get; set; }

        public int PRODUCT { get; set; }

        public int SKU { get; set; }

        public int SCENARIO { get; set; }

        public int SECTION { get; set; }

        public string DESCRIPTION { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericAssumptionAttachmentMapping> AssumptionAttachmentMapping { get; set; }
    }
}
