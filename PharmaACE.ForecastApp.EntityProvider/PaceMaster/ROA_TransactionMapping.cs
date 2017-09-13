namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.ROA_TransactionMapping")]
    public partial class ROA_TransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ROA_TransactionId { get; set; }

        public int? ROA_Id { get; set; }

        public virtual ROA_Master ROA_Master { get; set; }

        public virtual PipelineTransaction Transaction2 { get; set; }
    }
}
