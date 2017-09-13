namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.GenericAvailability")]
    public partial class GenericAvailability
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericAvailability()
        {
            AuthorizedGenericMappings = new HashSet<AuthorizedGenericMapping>();
            CompanyGenericPlayersMappings = new HashSet<CompanyGenericPlayersMapping>();
            FTFHolderGenericMappings = new HashSet<FTFHolderGenericMapping>();
        }

        public int Id { get; set; }

        public int InlineTrasnactionId { get; set; }

        [Column("GenericAvailability")]
        public bool GenericAvailability1 { get; set; }

        [Column(TypeName = "date")]
        public DateTime? FTFfilingDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime? FTFApprovalDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime? FTFLaunchDate { get; set; }

        public virtual InlineTransaction Transaction { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AuthorizedGenericMapping> AuthorizedGenericMappings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CompanyGenericPlayersMapping> CompanyGenericPlayersMappings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FTFHolderGenericMapping> FTFHolderGenericMappings { get; set; }
    }
}
