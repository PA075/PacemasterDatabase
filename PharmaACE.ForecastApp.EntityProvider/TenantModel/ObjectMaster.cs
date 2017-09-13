namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ObjectMaster")]
    public partial class ObjectMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ObjectMaster()
        {
            ActivityDetailsMaster = new HashSet<ActivityDetailsMaster>();
            DealDetails = new HashSet<DealDetail>();
            ObjectUserMapping = new HashSet<ObjectUserMapping>();
        }

        public int Id { get; set; }

        public byte Type { get; set; }

        [Required]
        [StringLength(255)]
        public string Name { get; set; }

        public int? Extn { get; set; }

        [Required]
        public string Lineage { get; set; }

        public decimal? Size { get; set; }

        public int? ParentId { get; set; }

        public string Path { get; set; }


        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DealDetail> DealDetails { get; set; }
        public virtual ICollection<ActivityDetailsMaster> ActivityDetailsMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ObjectUserMapping> ObjectUserMapping { get; set; }


    }
}
