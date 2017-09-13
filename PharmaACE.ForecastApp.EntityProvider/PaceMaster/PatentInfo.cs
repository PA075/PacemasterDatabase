namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.PatentInfo")]
    public partial class PatentInfo
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PatentInfo()
        {
            RegulatoryStrategies = new HashSet<RegulatoryStrategy>();
        }

        public int Id { get; set; }

        public int InlineTransactionId { get; set; }

        public string PatentNo { get; set; }

        public int? PatentTypeID { get; set; }

        public int? PatentUseCodeID { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Expiry { get; set; }

        public bool PTEGranted { get; set; }

        public string IndependentClaims { get; set; }

        public bool? DelistRequested { get; set; }

        public string PatentLicensingInfo { get; set; }

        public virtual InlineTransaction Transaction { get; set; }

        public virtual PatentType PatentType { get; set; }

        public virtual PatentUseCode PatentUseCode { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RegulatoryStrategy> RegulatoryStrategies { get; set; }
    }
}
