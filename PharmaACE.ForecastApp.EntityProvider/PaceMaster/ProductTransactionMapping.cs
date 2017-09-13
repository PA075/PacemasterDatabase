namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.ProductTransactionMapping")]
    public partial class ProductTransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductTransactionId { get; set; }

        public int? ProductId { get; set; }

        public virtual ProductMaster ProductMaster { get; set; }

        public virtual PipelineTransaction PipelineTransaction { get; set; }
    }
}
