namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.MoleculeTransactionMapping")]
    public partial class MoleculeTransactionMapping
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int MoleculeTransactionId { get; set; }

        public int? MoleculeId { get; set; }

        public virtual MoleculeMaster MoleculeMaster { get; set; }

        public virtual PipelineTransaction Transaction2 { get; set; }
    }
}
