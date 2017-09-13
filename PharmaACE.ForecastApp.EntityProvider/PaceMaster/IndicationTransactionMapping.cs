namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.IndicationTransactionMapping")]
    public partial class IndicationTransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int IndicationTransactionId { get; set; }

        public int? IndicationId { get; set; }

        public virtual IndicationMaster IndicationMaster { get; set; }

        public virtual PipelineTransaction Transaction2 { get; set; }
    }
}
