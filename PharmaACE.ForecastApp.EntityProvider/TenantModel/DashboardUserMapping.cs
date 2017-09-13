namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DashboardUserMapping")]
    public partial class DashboardUserMapping
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int DashboardId { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ShareById { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ShareWithId { get; set; }

        [Key]
        [Column(Order = 4)]
        public byte AuthenticationLevel { get; set; }

        public virtual DashboardMaster DashboardMaster { get; set; }

        //public virtual UserMaster SharedByUser { get; set; }

        //public virtual UserMaster SharedWithUser { get; set; }
    }
}
