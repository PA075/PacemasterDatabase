namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ProjectVersionDetails")]
    public partial class GenericProjectVersionDetails
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericProjectVersionDetails()
        {
            ProjectVersion = new HashSet<GenericProjectVersion>();
        }

        public int ID { get; set; }

        public byte ForecastPeriod { get; set; }

        public byte Category { get; set; }

        [Column(TypeName = "date")]
        public DateTime DataAvailableFrom { get; set; }

        [Column(TypeName = "date")]
        public DateTime DataAvailableTill { get; set; }

        [Column(TypeName = "date")]
        public DateTime ForecastTill { get; set; }

        public byte Type { get; set; }

        public byte NumberOfProducts { get; set; }

        public byte NumberofScenarios { get; set; }

        public DateTime CreatedOn { get; set; }

        public DateTime ModifiedOn { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericProjectVersion> ProjectVersion { get; set; }
    }
}
