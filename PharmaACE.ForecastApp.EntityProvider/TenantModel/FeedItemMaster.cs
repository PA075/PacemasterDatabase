namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("FeedItemMaster")]
    public partial class FeedItemMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public FeedItemMaster()
        {
            FeedItemMapping = new HashSet<FeedItemMapping>();
            FeedUserMaster = new HashSet<FeedUserMaster>();
        }

        public int ID { get; set; }

        [Required]
        public string Link { get; set; }

        public string Thumbnail { get; set; }

        [Required]
        public string Title { get; set; }

        [Required]
        public string Description { get; set; }

        public DateTime DateTime { get; set; }

        public int SourceID { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FeedItemMapping> FeedItemMapping { get; set; }

        public virtual FeedSourceMaster FeedSourceMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FeedUserMaster> FeedUserMaster { get; set; }
    }
}
