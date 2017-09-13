namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DivisionUserMapping")]
    public partial class DivisionUserMapping
    {
        // Device User Mapping for Login notification
        public int Id { get; set; }

        public int? DivisionRegulatoryId { get; set; }

        public int? UserId { get; set; }

        public virtual DivisionRegulatoryMaster DivisionRegulatoryMaster { get; set; }

        public virtual UserMaster UserMaster { get; set; }
       
    }
}
