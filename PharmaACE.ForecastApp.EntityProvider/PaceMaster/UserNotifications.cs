namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class UserNotifications
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        [Required]
        [StringLength(1000)]
        public string Descriptions { get; set; }

        [Required]
        [StringLength(4000)]
        public string UserKey { get; set; }

        public DateTime CreatedDate { get; set; }

        public bool IsRead { get; set; }

        public virtual UserMaster UserMaster { get; set; }
    }
}
