namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("FeedItemMapping")]
    public partial class FeedItemMapping
    {
        public int ID { get; set; }

        public int FeedSettingId { get; set; }

        public int FeedItemId { get; set; }

        public virtual FeedItemMaster FeedItemMaster { get; set; }

        public virtual FeedSettingMaster FeedSettingMaster { get; set; }
    }
}
