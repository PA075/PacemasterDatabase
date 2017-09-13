namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ObjectUserMapping")]
    public partial class ObjectUserMapping
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ObjectUserMapping()
        {
            ObjUserPermission = new HashSet<ObjUserPermission>();
        }

        public int Id { get; set; }

        public int ObjectId { get; set; }

        public int ShareById { get; set; }

        public int ShareWithId { get; set; }

        public bool isGroup { get; set; }

        public string Description { get; set; }

        public DateTime CreationDate { get; set; }

        public virtual ObjectMaster ObjectMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        [InverseProperty("ObjectUserMapping")]
        public virtual ICollection<ObjUserPermission> ObjUserPermission { get; set; }
    }
}
