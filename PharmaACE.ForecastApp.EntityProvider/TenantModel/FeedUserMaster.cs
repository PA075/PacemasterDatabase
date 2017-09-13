namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("FeedUserMaster")]
    public partial class FeedUserMaster
    {
        public int ID { get; set; }

        public int UserID { get; set; }

        public int FeedItemID { get; set; }

        public int? VisitCount { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; }

        public int DivOrder { get; set; }

        public DateTime TransDateTime { get; set; }

        public virtual FeedItemMaster FeedItemMaster { get; set; }
    }
}
