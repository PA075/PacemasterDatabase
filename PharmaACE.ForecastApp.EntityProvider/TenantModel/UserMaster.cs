namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.UserMaster")]
    public partial class UserMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public UserMaster()
        {
            //SharedByDashboardUserMapping = new HashSet<DashboardUserMapping>();
            //SharedWithDashboardUserMapping = new HashSet<DashboardUserMapping>();
            //SharedByReportUserMapping = new HashSet<ReportUserMapping>();
            //SharedWithReportUserMapping = new HashSet<ReportUserMapping>();
            UserNotifications = new HashSet<TenantUserNotifications>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int GlobalId { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        [StringLength(320)]
        public string UserEmail { get; set; }

        [StringLength(4000)]
        public string UserPassword { get; set; }

        public string SP_Account { get; set; }

        [StringLength(4000)]
        public string SP_Password { get; set; }

        public bool? IsActive { get; set; }

        public int? RoleId { get; set; }

        public int? GeographyId { get; set; }

        public string NewsFeedLink { get; set; }

        public int? NewsFeedCount { get; set; }

        //[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        //public virtual ICollection<DashboardUserMapping> SharedByDashboardUserMapping { get; set; }

        //[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        //public virtual ICollection<DashboardUserMapping> SharedWithDashboardUserMapping { get; set; }

        //[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        //public virtual ICollection<ReportUserMapping> SharedByReportUserMapping { get; set; }

        //[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        //public virtual ICollection<ReportUserMapping> SharedWithReportUserMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TenantUserNotifications> UserNotifications { get; set; }
    }
}
