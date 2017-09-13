namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.IndicationMapping")]
    public partial class IndicationMapping
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int IndicationTransactionId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int IndicationId { get; set; }

        public virtual IndicationMaster IndicationMaster { get; set; }

        public virtual InlineTransaction Transaction1 { get; set; }

        //public virtual InlineTransaction Transaction11 { get; set; }
    }
}
