namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.SalesInformation")]
    public partial class SalesInformation
    {
        public int Id { get; set; }

        public int InlineTransactionId { get; set; }

      //  [Column(TypeName = "date")]
        public decimal? CurrentYear { get; set; }

      //  [Column(TypeName = "date")]
        public decimal? PreviousYear { get; set; }

        public decimal? PercentChange { get; set; }

        public virtual InlineTransaction Transaction { get; set; }
    }
}
