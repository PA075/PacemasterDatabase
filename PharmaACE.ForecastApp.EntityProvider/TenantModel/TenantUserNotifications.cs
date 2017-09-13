namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UserNotifications")]
    public partial class TenantUserNotifications
    {
       
       
        public int Id { get; set; }

        
        public int UserId { get; set; }


        [StringLength(1000)]
        public string Descriptions { get; set; }

        [StringLength(4000)]
        public string UserKey { get; set; }

       
        public DateTime CreatedDate { get; set; }

       
        public bool IsRead { get; set; }

        public virtual UserMaster UserMaster { get; set; }
    }
}
