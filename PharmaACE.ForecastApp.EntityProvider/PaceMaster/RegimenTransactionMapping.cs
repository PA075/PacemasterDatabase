namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.RegimenTransactionMapping")]
    public partial class RegimenTransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int RegimenTransactionId { get; set; }

        public int? RegimenId { get; set; }

        public virtual RegimenMaster RegimenMaster { get; set; }

        public virtual PipelineTransaction Transaction2 { get; set; }
    }
}
