namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ActivityDetailsMaster")]
    public partial class ActivityDetailsMaster
    {
        public int Id { get; set; }

        public int Activity { get; set; }

        public int ObjectId { get; set; }

        public DateTime ActDate { get; set; }

        public int UserId { get; set; }

        public string CustomMessage { get; set; }

        public virtual ObjectMaster ObjectMaster { get; set; }
    }
}
