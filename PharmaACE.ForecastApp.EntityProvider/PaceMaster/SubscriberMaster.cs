namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SubscriberMaster")]
    public partial class SubscriberMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SubscriberMaster()
        {
            DivisionMaster = new HashSet<DivisionMaster>();
            UserMaster = new HashSet<UserMaster>();
        }

        [Key]
        public int SubscriberId { get; set; }

        [Required]
        [StringLength(500)]
        public string SubscriberName { get; set; }

        public bool IsActive { get; set; }

        public DateTime SubscriptionStartDate { get; set; }

        public DateTime SubscriptionEndDate { get; set; }

        public int MaxUserNo { get; set; }

        [Required]
        [StringLength(50)]
        public string DataBaseName { get; set; }

        [Required]
        [StringLength(50)]
        public string DBServer { get; set; }

        [Required]
        [StringLength(50)]
        public string DBUser { get; set; }

        [Required]
        [StringLength(50)]
        public string DBPassword { get; set; }

        public int? AdminId { get; set; }

        public int? RegisteredUserNo { get; set; }

        [Required]
        [StringLength(500)]
        public string FeedKeyword { get; set; }

        [Required]
        [StringLength(500)]
        public string Archive { get; set; }

        [Required]
        [StringLength(4000)]
        public string SPPassword { get; set; }

        [Required]
        public string SPAccount { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DivisionMaster> DivisionMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserMaster> UserMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GroupMaster> GroupMaster { get; set; }
    }
}
