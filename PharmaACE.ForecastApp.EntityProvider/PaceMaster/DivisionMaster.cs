namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DivisionMaster")]
    public partial class DivisionMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DivisionMaster()
        {
            DivisionCompanyMaster = new HashSet<DivisionCompanyMaster>();
            DivisionRegulatoryMaster = new HashSet<DivisionRegulatoryMaster>();
        }

        public int ID { get; set; }

        public int SubscriberID { get; set; }

        [Required]
        [StringLength(100)]
        public string DivisionName { get; set; }

        public int DivisionOrder { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DivisionCompanyMaster> DivisionCompanyMaster { get; set; }

        public virtual SubscriberMaster SubscriberMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DivisionRegulatoryMaster> DivisionRegulatoryMaster { get; set; }
    }
}
