namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("AttachamentMaster")]
    public partial class AttachamentMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public AttachamentMaster()
        {
            ActharAssumptionAttachmentMapping = new HashSet<ActharAssumptionAttachmentMapping>();
            BDLAssumptionAttachmentMapping = new HashSet<BDLAssumptionAttachmentMapping>();
            GenericAssumptionAttachmentMapping = new HashSet<GenericAssumptionAttachmentMapping>();
        }

        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Path { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ActharAssumptionAttachmentMapping> ActharAssumptionAttachmentMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLAssumptionAttachmentMapping> BDLAssumptionAttachmentMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericAssumptionAttachmentMapping> GenericAssumptionAttachmentMapping { get; set; }
    }
}
