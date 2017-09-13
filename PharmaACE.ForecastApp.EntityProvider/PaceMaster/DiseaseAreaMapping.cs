namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.DiseaseAreaMapping")]
    public partial class DiseaseAreaMapping
    {
        [Key]
        public int id { get; set; }

        public int DiseaseAreaId { get; set; }

        public int InlineTransactionId { get; set; }

        public virtual DiseaseAreaMaster DiseaseAreaMaster { get; set; }

        public virtual InlineTransaction InlineTransaction { get; set; }
    }
}
