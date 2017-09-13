namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UserMaster")]
    public partial class UserMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public UserMaster()
        {
            DivisionUserMapping = new HashSet<DivisionUserMapping>();
            ForumAnswer = new HashSet<ForumAnswer>();
            ForumQuestion = new HashSet<ForumQuestion>();
            UserAccess = new HashSet<UserAccess>();
            UserAccessForecastPlatform = new HashSet<UserAccessForecastPlatform>();
            UserNotifications = new HashSet<UserNotifications>();
            DeviceUserMappings = new HashSet<DeviceUserMapping>();
        }

        public int Id { get; set; }

        [Required]
        public string FirstName { get; set; }

        public string LastName { get; set; }

        [Required]
        [StringLength(320)]
        public string UserEmail { get; set; }

        public string NewsFeedLink { get; set; }

        public int? NewsFeedCount { get; set; }

        public bool IsActive { get; set; }

        public int RoleId { get; set; }

        public int? GeographyId { get; set; }

        public int CompanyId { get; set; }

        //public bool? IsAdmin { get; set; }

        [Required]
        [MaxLength(64)]
        public byte[] LoginPassword { get; set; }

        public Guid LoginKey { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DivisionUserMapping> DivisionUserMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ForumAnswer> ForumAnswer { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ForumQuestion> ForumQuestion { get; set; }

        public virtual SubscriberMaster SubscriberMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserAccess> UserAccess { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserAccessForecastPlatform> UserAccessForecastPlatform { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserNotifications> UserNotifications { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DeviceUserMapping> DeviceUserMappings { get; set; }
	
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GroupUserMapping> GroupUserMapping { get; set; }
    }

}
