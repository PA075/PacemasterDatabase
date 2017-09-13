namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.CompanyTransactionMapping")]
    public partial class CompanyTransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int CompanyTransactionId { get; set; }

        public int? CompanyId { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual PipelineTransaction Transaction2 { get; set; }
    }
}
