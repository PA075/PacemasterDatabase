namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("GroupUserMapping")]
    public partial class GroupUserMapping
    {
        public int Id { get; set; }

        public int GroupId { get; set; }

        public int UserId { get; set; }

        public int SubscriberId { get; set; }

        public virtual GroupMaster GroupMaster { get; set; }

        public virtual UserMaster UserMaster { get; set; }
    }
}
