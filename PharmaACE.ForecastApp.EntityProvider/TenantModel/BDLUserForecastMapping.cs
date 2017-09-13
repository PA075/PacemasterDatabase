namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.UserForecastMapping")]
    public partial class BDLUserForecastMapping
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BDLUserForecastMapping()
        {
           BDLUserForecastSectionMapping = new HashSet<BDLUserForecastSectionMapping>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public int ShareWithId { get; set; }

        [Required]
        public string ProjectName { get; set; }

        [StringLength(1000)]
        public string Version { get; set; }

        public int Authorization { get; set; }

        public int ShareById { get; set; }
                
        public string Description { get; set; }

        public DateTime CreationDate { get; set; }

        public int FlatFileId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLUserForecastSectionMapping> BDLUserForecastSectionMapping { get; set; }
    }
}
