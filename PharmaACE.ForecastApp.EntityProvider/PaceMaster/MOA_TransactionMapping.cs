namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.MOA_TransactionMapping")]
    public partial class MOA_TransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int MOA_TransactionId { get; set; }

        public int? MOA_Id { get; set; }

        public virtual MOA_Master MOA_Master { get; set; }

        public virtual PipelineTransaction Transaction2 { get; set; }
    }
}
